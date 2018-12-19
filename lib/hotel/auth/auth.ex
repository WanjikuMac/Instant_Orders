defmodule Hotel.Auth do
  @moduledoc """
  This module is the authentication context boundary, the user provides the log in parameters
  which are then authenticated as per the already saved params
  """
  import Ecto.Query, only: [from: 2]
  alias Comeonin.Bcrypt

  alias Hotel.{
      Accounts.User,
      Repo
    }

  @doc """
      This function takes a user id, a plain text password and matches them to check
      user validity
    """
  def authenticate(email_or_username, plain_passcode) do
    query = from(
      u in User,
      where: u.username == ^email_or_username,
      or_where: u.email == ^email_or_username)

    query
      |> Repo.one()
      |>check_passcode(plain_passcode)
  end

  @spec check_passcode(User.t(), String.t()) :: {:ok, User.t()} | {:error, String.t()}
  defp check_passcode(nil, _), do: {:error, "Access Denied - Invalid username or password"}

    defp check_passcode(user, passcode) do
  with true <- Bcrypt.checkpw(passcode, user.password) do
    {:ok, user}
  else
    false ->{:error, "Access Denied - Invalid username or password"}
    end
  end
end