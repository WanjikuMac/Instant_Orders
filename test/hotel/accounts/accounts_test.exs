defmodule Hotel.AccountsTest do
  @moduledoc """
    This module holds unit tests for functions in the accounts context
  """
  use Hotel.DataCase

  alias Hotel.{
    Accounts,
    Accounts.User,
    Repo
    }

  @id "a7062358-021d-4273-827a-87c38cb213fe"
  @valid_user %{username: "WanjikuMac", password: "herself@123", email: "edwardscaroline32@gmail.com"}
    describe "Account context" do
      test "get_users/0, gets all the users in the system " do
        assert Repo.aggregate(User, :count, :id) == 0
        insert_list(5,:user)
        assert {:ok, users} = Accounts.get_users
        assert Enum.count(users) == 5
    end

      test "get_users/0, errors when there are no users in the system" do
        assert Repo.aggregate(User, :count, :id) == 0
        assert {:error, _} =Accounts.get_users
      end

      test "get_user/1, returns a user with the specified id" do
        user = insert(:user)
        assert Repo.aggregate(User, :count, :id) == 1
        assert {:ok, %User{} = usr} = Accounts.get_user(user.id)
        assert usr.id == user.id
      end

      test "get_user/1, errors when user with specified id is not found " do
        assert Repo.aggregate(User, :count, :id) == 0
        assert {:error, _} = Accounts.get_user(@id)
      end

      test "create_user/1 creates a user with the correct parameters" do
        assert Repo.aggregate(User, :count, :id) == 0
        assert {:ok, %User{} = usr} = Accounts.create_user(@valid_user)
        assert Repo.aggregate(User, :count, :id) == 1
        assert usr.username == @valid_user[:username]
      end

      test "create_user/1 errors with invalid attributes" do
        assert Repo.aggregate(User, :count, :id) == 0
        assert {:error, _changeset} = Accounts.create_user(%{})
        assert Repo.aggregate(User, :count, :id) == 0
      end

      test "delete_user/1 deletes an existing user" do
        user = insert(:user)
        assert Repo.aggregate(User, :count, :id) == 1
        assert {:ok, _usr} = Accounts.delete_user(user)
        assert Repo.aggregate(User, :count, :id) == 0
      end

      test "update_user/1 updates an existing users details" do
        user = insert(:user)
        assert Repo.aggregate(User, :count, :id) == 1
        assert {:ok, %User{} = usr} = Accounts.update_user(user, @valid_user)
        assert usr.id == user.id
        refute usr.username == user.username
      end
  end
end