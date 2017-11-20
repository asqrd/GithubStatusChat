defmodule GithubStatusChatWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:chat", _message, socket) do
    {:ok, socket}
  end

  def handle_in("msg", %{"body" => body}, socket) do
    broadcast!(socket, "msg", %{body: body})
    {:noreply, socket}
  end
end
