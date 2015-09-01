defmodule MyGTest do
  require Logger
  use ExUnit.Case
  import Phoenix.ChannelTest
  @endpoint Guardex.Endpoint
  test "socket auth works" do
    st = %Guardex{id: 123}
    { :ok, jwt, full_claims } = Guardian.encode_and_sign(st, :token, perms: %{ default: [:read, :write]})
    auth = %{token: jwt}
    s = socket()
    {:ok, s} = Guardex.UserSocket.connect(auth,s)
    assert s != nil
    Logger.info "connect: " <> inspect s, pretty: true

    junk = %{token: "this is junk"}
    {e,reason} = Guardex.UserSocket.connect(junk,socket())
    assert e == :error

  end
  test " join chan works" do
    st = %Guardex{id: 123}
    { :ok, jwt, full_claims } = Guardian.encode_and_sign(st, :token, perms: %{ default: [:read, :write]})
    auth = %{token: jwt}
    s = socket()
    {:ok, s} = Guardex.UserSocket.connect(auth,s)

    {:ok, msg, socket} = subscribe_and_join(s,Guardex.UC, "users:#{st.id}",auth)
    {r,reason} = subscribe_and_join(s,Guardex.UC, "foo:#{st.id}",auth)
    assert r == :error
  end
end
