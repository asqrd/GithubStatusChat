defmodule GithubStatusChat.Github.StatusCall do
  use Ecto.Schema
  import Ecto.Changeset
  alias GithubStatusChat.Github.StatusCall


  schema "status_calls" do
    field :message, :string
    field :status_code, :integer
    field :time, :string

    timestamps()
  end

  @doc false
  def changeset(%StatusCall{} = status_call, attrs) do
    status_call
    |> cast(attrs, [:message, :time, :status_code])
    |> validate_required([:message, :time, :status_code])
  end
end
