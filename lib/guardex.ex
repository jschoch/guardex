defmodule Guardex do
  use Application
  require Logger
  defstruct id: nil
  def for_token(user = %Guardex{}), do: { :ok, "Guardex:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  #def from_token("#{__MODULE__}:" <> id), do: { :ok, %Guardex{id: id} }
  def from_token("Guardex:" <> id), do: { :ok, %Guardex{id: id} }
  def from_token(bad) do
    Logger.warn "bad token resource: " <> inspect bad
   { :error, "Unknown resource type" }
  end


  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Guardex.Endpoint, []),
      # Here you could define other workers and supervisors as children
      # worker(Guardex.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Guardex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Guardex.Endpoint.config_change(changed, removed)
    :ok
  end
end
