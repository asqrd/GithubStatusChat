defmodule GithubStatusChatWeb.GithubChannel do
  use Phoenix.Channel
  alias GithubStatusChat.Github

  def join("github:updates", _message, socket) do
    {:ok, socket}
  end

  # Called when github status is updated
  def handle_in("update", %{"message" => message, "status_code" => status_code, "time" => time}, socket) do
     broadcast!(socket, "update", %{message: message, status_code: status_code})

    {:noreply, socket}
  end

  # Called when channel joined
  def handle_in("joined", %{}, socket) do
    if is_nil(List.last(Github.list_status_calls())) do
     broadcast!(socket, "first", %{message: "Pending", status: "Pending"})
    else
      last_status = List.last(Github.list_status_calls())
      broadcast!(socket, "first", %{message: last_status.message, status_code: last_status.status_code})
    end

    {:noreply, socket}
  end
end

