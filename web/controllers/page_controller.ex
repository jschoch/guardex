defmodule Guardex.PageController do
  use Guardex.Web, :controller
  require Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, %{"username" => username} = params) do
    Logger.warn "params: #{inspect params}"
    case params["pass"] do
        "the magic word" -> 
          resource = %Guardex{id: username}
          {:ok, jwt, full_claims} = Guardian.encode_and_sign(resource, :token, perms: %{ default: [:read]})
          redirect(conn,to: "/?token=#{URI.encode(jwt)}")
        nil -> 
          Logger.warn "no password: #{inspect params}"
          conn |> put_flash(:error, "please enter a password") 
            |> render conn, "login.html"
        wrong -> 
          Logger.warn "auth error for params: #{inspect params}"
          conn |> put_flash(:error, "authentication error")
            |> render "login.html"
    end 
  end
  def login(conn,_params) do
    render conn, "login.html"
  end
end
