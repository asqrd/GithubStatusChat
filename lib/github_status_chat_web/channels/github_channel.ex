defmodule GithubStatusChatWeb.GithubChannel do
  use Phoenix.Channel

  def join("github:updates", _message, socket) do
    {:ok, socket}
  end

  def handle_in(socket, "update", %{"body" => body}, socket) do
    broadcast!(socket, "update", %{body: body})
    {:noreply, socket}
  end
end

