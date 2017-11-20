defmodule GithubStatusChatWeb.GithubStatusWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    HTTPoison.start
    schedule_work()
    {:ok, state}
  end

  def handle_info(:update, state) do
    resp = HTTPoison.get!("https://api.github.com/status")
    GithubStatusChatWeb.Endpoint.broadcast("github:updates", "update", %{body: "Github called"})
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    time_to_call = :rand.uniform(5) # Erlang module to provide random number
    # Schedule github api call every 1 - 5 minutes
    Process.send_after(self(), :update, time_to_call * 1000)
  end

end
