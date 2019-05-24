defmodule Hotel.Menu do
  @moduledoc """
    This is a boundary module that holds the menu context functions
    and facilitates all the menu actions
  """
  alias Hotel.{
    Menu.Item,
    Accounts.User,
    Repo
    }

    @doc """
  This function allows an item to be added to the menu. It takes in the item details
  """
  @spec add_item(map()) :: {:ok, Item.t()} | {:error, Ecto.Changeset.t()}
  def add_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end
end