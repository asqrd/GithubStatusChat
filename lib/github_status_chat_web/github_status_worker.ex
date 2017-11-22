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
    case Github.get_last_or_nil_status_call do
      {:error, nil} -> create_first_status_call(state)
      {:ok, status_call} -> compare_status_code(status_call, state)
    end

    # Reschedule process
    schedule_work()
    {:noreply, state}
  end

  defp create_first_status_call(state) do
    create_status_call(state)
    call_channel(state)
  end

  defp create_status_call(state) do
    Github.create_status_call(%{message: state.message, status_code: state.status_code, time: state.time})
  end

  defp compare_status_code(last, state) do
    if state.status_code != last.status_code do
      call_channel(state)
    end
    create_status_call(state)
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
