# Setting up Wallaby for testing
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, GithubStatusChat.Endpoint.url)

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(GithubStatusChat.Repo, :manual)

