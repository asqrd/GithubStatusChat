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
    # Get Github Status
    resp = HTTPoison.get!("https://api.github.com/status")
    time = Time.utc_now()

    # Parse response
    {body, status_code} = parse_response(resp)

    state = Map.put(state, :status_code, status_code)
    state = Map.put(state, :body, body)
    state = Map.put(state, :time, time)
    call_channel(state)


    # Reschedule process
    schedule_work()
    {:noreply, state}
  end

  defp parse_response(resp) do
    # decode response body
    {:ok, body} = Poison.decode(resp.body)

     status_code = resp.status_code

    {body, status_code}
  end

  defp call_channel(state) do

    # Broadcast decoded response to channel
    GithubStatusChatWeb.Endpoint.broadcast("github:updates", "update", %{body: state.body, status_code: state.status_code, time: state.time})
  end

  defp schedule_work() do
    time_to_call = :rand.uniform(5) # Erlang module to provide random number
    # Schedule github api call every 1 - 5 minutes
    Process.send_after(self(), :update, time_to_call * 1000)
  end

end
