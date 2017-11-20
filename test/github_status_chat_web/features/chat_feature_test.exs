defmodule GithubStatusChatWeb.ChatFeatureTest do
  use GithubStatusChatWeb.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2, css: 1, text_field: 1]

  test "chat page has header for chat", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".chat-header", text: "Welcome to Chat"))
  end

  test "user can enter input", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("#chat-input"))
  end

  test "user input is displayed", %{session: session} do
    session
    |> visit("/")
    |> fill_in(text_field("chat-input"), with: "Hello")
    |> assert_has(css(".message", text: "Hello"))
  end
end
