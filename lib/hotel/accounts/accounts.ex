defmodule Hotel.Accounts do
  @moduledoc """
    This module holds all the accounts context, to do all
    account related actions
  """

  alias Hotel.{
    Accounts.User,
    Repo,
    }

    @doc """
    This function gets all registered users in the system
  """
  @spec get_users() :: { :ok, list(User.t())} | {:error, String.t()}
    def get_users() do
      with [_|_] = usr  <- Repo.all(User) do
        {:ok, usr}
      else
        [] ->{:error, "No users in the system"}
      end
  end

  @doc """
  This function retrieves a user via id
    *parameters*
     - user id: {id}
  """
  @spec get_user(String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def get_user(id) do
    with %User{} = user <- Repo.get_by(User, id: id) do
      {:ok, user}
    else
      nil -> {:error, "No user with id #{id} found"}
    end
  end

  @doc """
    This function takes in a map with user parameters and creates a user
    record.
    *Parameter*
      %{username: "WanjikuMac", password: "herself@123", email: "edwardscaroline32@gmail.com"}
  """
  @spec create_user(map()):: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(params) do
    %User{}
    |>User.changeset(params)
    |>Repo.insert()
  end

  @doc """
    This function takes an already existing user and deletes that user from the database
  """
  @spec delete_user(User.t()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def delete_user(%User{} = usr) do
    usr
    |> Repo.delete()
  end

  @doc """
  This function takes a user and a map of updated attributes then it goes ahead
  and update the users parameters
  """
  @spec update_user(User.t(), map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def update_user(%User{} = usr, params) do
    usr
    |>User.changeset(params)
    |>Repo.update()
  end
end

