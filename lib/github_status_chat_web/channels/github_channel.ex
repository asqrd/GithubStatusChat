defmodule GithubStatusChatWeb.GithubChannel do
  use Phoenix.Channel
  alias GithubStatusChat.Github

  def join("github:updates", _message, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    case Github.get_last_or_nil_status_call do
      {:error, nil} -> broadcast!(socket, "first", %{message: "Pending", status: "Pending"})
      {:ok, status} -> broadcast!(socket, "first", %{message: status.message, status_code: status.status_code})
    end
    {:noreply, socket}
  end

  # Called when github status is updated
  def handle_in("update", %{"message" => message, "status_code" => status_code, "time" => time}, socket) do
     broadcast!(socket, "update", %{message: message, status_code: status_code})

    {:noreply, socket}
  end

end

