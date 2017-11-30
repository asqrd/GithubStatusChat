# Feedback

## github.ex DONE
  
  - get_last_or_nil_status_call/0 -> Should use limit and order_by to retrieve the most recent entry instead of getting all of them and traversing the entire list. This is really expensive as the data set grows.

## github_status_worker.ex

  - init/1 -> HTTPoison.start() is not necessary. Your application starts it automatically.
  - init/1 -> You probably should have run the worker at the start in order to have data to send to the client.
  - handle_info/2 -> The Github API string should be a module attribute. This would allow you to change it for testing purposes.
  - handle_info/2 -> When you assign the new state, you should start piping with the value (i.e., state |> Map.put(...) |> Map.put(...) |> Map.put(...))

## github_channel.ex DONE

  - handle_in/3 -> You do not need to include an additional "joined" message. This could have been handled in the initial join/3 call.
