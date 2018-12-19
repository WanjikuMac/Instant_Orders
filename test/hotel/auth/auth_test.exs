defmodule Hotel.AuthTest do
  @moduledoc """
   This module holds unit tests for functions in the auth context
  """
  use Hotel.DataCase

  alias Hotel.{
    Auth,
    Accounts.User
    }

    @user_passcode %{username: "wanjiku", email: "edwardscaroline32@gmail.com", password: "hash"}

    describe "Auth Context" do
      test "authenticate/2 returns a user if one exists with the given username & password" do
        {:ok, user} = %User{} |>User.changeset(@user_passcode)|> Repo.insert()
        {:ok, %User{} = usr} =Auth.authenticate(user.username, @user_passcode[:password])
        assert usr.username == @user_passcode[:username]
      end

      test "authenticate/2 returns an error if a corresponding user doesn't exist" do
        assert Repo.aggregate(User, :count, :id) == 0
        assert {:error, "Access Denied - Invalid username or password"}
               = Auth.authenticate("a5f13624-f084-4297-b67f-9e276945cc99", @user_passcode[:password])
    end
  end
end