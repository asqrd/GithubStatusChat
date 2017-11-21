defmodule GithubStatusChatWeb.GithubStatusWorker do
  use GenServer
  alias GithubStatusChat.Github
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    HTTPoison.start()
    schedule_work()
    {:ok, state}
  end

  def handle_info(:update, state) do
    # Get Github Status
    resp = HTTPoison.get!("https://api.github.com/status")
    time = Time.to_string(Time.utc_now())

    # Parse response
    {body, status_code} = parse_response(resp)

    message = body["message"]


    # Cache response
    state =
      Map.put(state, :status_code, status_code)
    |> Map.put(:message, message)
    |> Map.put(:time, time)

    # Compare state to last response
    # Check if status calls are empty
    if is_nil(List.last(Github.list_status_calls())) do
      Github.create_status_call(%{message: state.message, time: state.time, status_code: state.status_code})
      call_channel(state)
    else
      last_status_call = List.last(Github.list_status_calls())
      if last_status_call.status_code != state.status_code do

        call_channel(state)
      end 
      Github.create_status_call(%{message: state.message, time: state.time, status_code: state.status_code})
    end


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
    GithubStatusChatWeb.Endpoint.broadcast("github:updates", "update", %{message: state.message, status_code: state.status_code, time: state.time})
  end

  defp schedule_work() do
    time_to_call = :rand.uniform(5) # Erlang module to provide random number
    # Schedule github api call every 1 - 5 minutes
    Process.send_after(self(), :update, time_to_call * 60 * 1000)
  end

end
