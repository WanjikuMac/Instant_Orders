defmodule Hotel.Factory do
  @moduledoc """
  This module holds ex machina factories that are used to seed the database
  usually in the test environment
  """
  use ExMachina.Ecto, repo: Hotel.Repo

  alias Hotel.{
    Accounts.User
    }

    def user_factory do
      %User{
        username: sequence(:username, &"uname-#{&1}"),
        email: sequence(:email, &"email-#{&1}"),
        password: "password"
      }
  end
end