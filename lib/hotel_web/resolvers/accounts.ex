defmodule HotelWeb.Resolvers.Accounts do
  @moduledoc """
  This module handles user interactions for the accounts context
  """

  alias Hotel.{
      Accounts.User,
      Auth,
      Auth.Guardian,
      Accounts
    }

    @doc """
    The get_users/3 function to resolve all users registered in the system
    """
  @spec get_users(any(), map(), any()) :: {:ok, list(User.t())} |{:error, String.t()}
    def get_users(_, _, _) do
      Accounts.get_users()
  end

  @doc """
   The sign_in/3  function takes a map of username or email and password then proceeds to
    log in the user on the system.
    *parameters*
    - %{username: "WanjikuMac", password: "hash", email: "edwardscaroline32@gmail.com"}
  """
  @spec sign_in(any(), map(), any()) :: {:ok, any()} | {:error, String.t()}
  def sign_in(_, %{input: %{sign_in_param: sign_in_param,password: password}}, _) do
    with {:ok, %User{} = current_user} <-Auth.authenticate(sign_in_param, password),
         {:ok, token, _claims} <- Guardian.encode_and_sign(current_user) do
      {:ok, %{user: current_user, token: token}}
      else
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
 The  sign_up fn takes a map and creates a user on the system
  *parameters*
    %{username: "WanjikuMac", password: "hash", email: "edwardscaroline32@gmail.com"}
 """
  @spec sign_up(any(), map(), any()) :: {:ok, any()} | {:error, String.t()}
  def sign_up(_, %{input: params}, _) do
    Accounts.create_user(params)
   end
end