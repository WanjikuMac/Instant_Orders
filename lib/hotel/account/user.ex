defmodule Hotel.Account.User do
  @moduledoc"""
  This module holds the changeset functions for the user schema
"""
  use Hotel.Utils.Schema

  alias Comeonin.Bcrypt
  alias Hotel.{
    Account.User
    }

    schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string

    timestamps(
      inserted_at: :joined_on,
      updated_at: :modified_on
    )
  end

  @doc """
    This function creates a user changeset from a map of parameters
    *parameters*
      %{ username: "WanjikuMac", password: "ahfuieywieh", email: "edwardscaroline32@gmail.com"}
  """
  @spec changeset(User.t(), map()) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
    def changeset(%User{} = user, params) do
     user
     |> cast(params, [:username, :password, :email])
     |> validate_required([:username, :password, :email])
     |> unique_constraint(:username)
     |> hash_password()
  end

  @spec hash_password(Ecto.Changeset.t()) :: Ecto.Changeset.t()
     defp hash_password(%{valid?: true, changes: %{password: password}} = changeset)do
       change(changeset, password: Bcrypt.hashpwsalt(password))
    end
      defp hash_password(changeset), do: changeset
end