defmodule GithubStatusChat.Github do
  @moduledoc """
  The Github context.
  """

  import Ecto.Query, warn: false
  alias GithubStatusChat.Repo

  alias GithubStatusChat.Github.StatusCall

  @doc """
  Returns the list of status_calls.

  ## Examples

      iex> list_status_calls()
      [%StatusCall{}, ...]

  """
  def list_status_calls do
    Repo.all(StatusCall)
  end

  @doc """
  Gets the last status_call or nil.

  ## Examples
    
    iex> get_last_or_nil_status_call()
    {:ok, %StatusCall{}}

    iex> get_last_or_nil_status_call()
    {:error, nil}

  """

  def get_last_or_nil_status_call do
    status_call = 
      list_status_calls()
      |> List.last()

    case is_nil(status_call) do
      true -> {:error, nil}
      false -> {:ok, status_call}
    end
  end

  @doc """
  Gets a single status_call.

  Raises `Ecto.NoResultsError` if the Status call does not exist.

  ## Examples

      iex> get_status_call!(123)
      %StatusCall{}

      iex> get_status_call!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status_call!(id), do: Repo.get!(StatusCall, id)

  @doc """
  Creates a status_call.

  ## Examples

      iex> create_status_call(%{field: value})
      {:ok, %StatusCall{}}

      iex> create_status_call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status_call(attrs \\ %{}) do
    %StatusCall{}
    |> StatusCall.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status_call.

  ## Examples

      iex> update_status_call(status_call, %{field: new_value})
      {:ok, %StatusCall{}}

      iex> update_status_call(status_call, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status_call(%StatusCall{} = status_call, attrs) do
    status_call
    |> StatusCall.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StatusCall.

  ## Examples

      iex> delete_status_call(status_call)
      {:ok, %StatusCall{}}

      iex> delete_status_call(status_call)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status_call(%StatusCall{} = status_call) do
    Repo.delete(status_call)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status_call changes.

  ## Examples

      iex> change_status_call(status_call)
      %Ecto.Changeset{source: %StatusCall{}}

  """
  def change_status_call(%StatusCall{} = status_call) do
    StatusCall.changeset(status_call, %{})
  end
end
