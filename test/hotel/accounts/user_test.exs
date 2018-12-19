defmodule Hotel.Accounts.UserTest do
  @moduledoc """
    This module contains unit tests for the user changesets
  """
  use Hotel.DataCase

  alias Hotel.{
    Accounts.User
    }

    @valid_user %{username: "WanjikuMac", password: "herself@123", email: "edwardscaroline32@gmail.com"}
    @user_missing %{password: "herself@123", email: "edwardscaroline32@gmail.com"}
    @pass_missing %{username: "WanjikuMac",email: "edwardscaroline32@gmail.com"}
    @email_missing%{username: "WanjikuMac",password: "herself@123"}

  describe "User changesets" do
    test "validates a user login parameters" do
        changeset = User.changeset(%User{}, @valid_user)
        assert changeset.valid?
      end

      test "invalid if hash is missing" do
        changeset = User.changeset(%User{},@pass_missing)
        refute changeset.valid?
      end

      test "invalid if username is missing" do
        changeset = User.changeset(%User{}, @user_missing)
        refute changeset.valid?
      end

      test "invalid if email is missing" do
        changeset = User.changeset(%User{}, @email_missing)
        refute changeset.valid?
    end
  end
end