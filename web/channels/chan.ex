defmodule Guardex.UC do
  require Logger
  use Phoenix.Channel
  use Guardian.Channel

  def join("users:" <> id, %{token: token }, socket) do
    Logger.warn "id: #{id} joined room" 
    {:ok, "welcome: id: #{id}",socket}
  end
  def join(room, payload, socket) do
    Logger.error "bad request: room: #{inspect room} payload: #{inspect payload}"
    { :error,  :authentication_required }
  end

end
