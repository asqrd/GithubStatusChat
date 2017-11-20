use Mix.Config

# Run a server during testing for wallaby
config :github_status_chat, GithubStatusChatWeb.Endpoint,
  http: [port: 4001],
  server: true

# Enable SQL Sandbox for wallaby tests
config :github_status_chat, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :github_status_chat, GithubStatusChat.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "github_status_chat_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
