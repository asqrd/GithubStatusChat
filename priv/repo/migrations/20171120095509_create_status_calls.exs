defmodule GithubStatusChat.Repo.Migrations.CreateStatusCalls do
  use Ecto.Migration

  def change do
    create table(:status_calls) do
      add :message, :text
      add :time, :string
      add :status_code, :integer

      timestamps()
    end

  end
end
