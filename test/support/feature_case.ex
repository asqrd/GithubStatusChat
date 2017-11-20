defmodule GithubStatusChatWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias GithubStatusChat.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import GithubStatusChatWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GithubStatusChat.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(GithubStatusChat.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(GithubStatusChat.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
