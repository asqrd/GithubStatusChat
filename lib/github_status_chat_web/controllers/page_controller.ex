defmodule GithubStatusChatWeb.PageController do
  use GithubStatusChatWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
