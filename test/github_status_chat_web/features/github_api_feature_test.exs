defmodule GithubStatusChatWeb.GithubApiFeatureTest do
  use GithubStatusChatWeb.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "github status has header", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".github-status-header", text: "Github Status"))
  end
end
