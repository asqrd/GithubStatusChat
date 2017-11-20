defmodule GithubStatusChatWeb.GithubChannel do
  use Phoenix.Channel

  def join("github:updates", _message, socket) do
    {:ok, socket}
  end

  # Called when github status is updated
  def handle_in("update", %{"body" => body, "status_code" => status_code, "time" => time}, socket) do
    broadcast!(socket, "update", %{body: body, status: status_code})

    {:noreply, socket}
  end

  def handle_in("first", %{}, socket) do
    broadcast!(socket, "update", %{body: %{message: "blah"}, status_code: 200})

    {:noreply, socket}
  end
end

