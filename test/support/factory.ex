defmodule Hotel.Factory do
  @moduledoc """
  This module holds ex machina factories that are used to seed the database
  usually in the test environment
  """
  use ExMachina.Ecto, repo: Hotel.Repo

  alias Hotel.{
    Accounts.User,
    Menu.Item,
    Menu.Category
    }

    def user_factory do
      %User{
        username: sequence(:username, &"uname-#{&1}"),
        email: sequence(:email, &"email-#{&1}"),
        password: "password"
      }
  end
  def item_factory do
    %Item{
      name: sequence(:name, &"name-#{&1}"),
      description: sequence(:description, &"desc-#{&1}"),
      price: sequence(:price, &"price-#{&1}")
    }
  end
  def category_factory do
    %Category{
      name: sequence(:name, &"name-#{&1}"),
      description: sequence(:description, &"desc-#{&1}")
    }
  end
end