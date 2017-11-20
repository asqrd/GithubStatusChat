defmodule GithubStatusChatWeb.PageControllerTest do
  use GithubStatusChatWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Chat"
  end
end
