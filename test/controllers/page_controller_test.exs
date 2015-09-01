defmodule Guardex.PageControllerTest do
  use Guardex.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
  test "GET /login" do
    conn = get conn(), "/login"
    assert html_response(conn, 200) =~ "user name:"
  end
  test "POST /login wrong " do
    conn = post conn(),"/login", [username: "foo", pass: "wrong"]
    assert html_response(conn, 200) =~ "authentication error"
  end
  test "POST /login correct" do
    conn = post conn(),"/login", [username: "foo", pass: "the magic word"]
    assert html_response(conn, 302) =~ "You are being"
  end


end
