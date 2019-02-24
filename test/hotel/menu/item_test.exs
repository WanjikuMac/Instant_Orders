defmodule Hotel.Menu.ItemTest do
  @moduledoc """
    This module holds tests for the Items changeset functions
  """
  use Hotel.DataCase

  alias Hotel.{
    Menu.Item
    }
    @valid_item %{name: "beef burger", description: "burger, lettuce and fries", price: "Ksh.450"}
    @invalid_item %{}
    describe "Item changeset" do
      test "valid when required parameters are passed" do
        changeset = Item.changeset(%Item{},@valid_item)
        assert changeset.valid?
      end

      test "invalid when missing the required parameters" do
        changeset = Item.changeset(%Item{}, @invalid_item)
        refute changeset.valid?
      end
      test "associate items to categories" do
        item = insert(:item)
        cat = insert(:category)
        #preload category for item
        loaded_item =
        item
        |> Repo.preload(:categories)
        changeset = Item.add_to_category(loaded_item, cat)
        assert changeset.valid?
        assert changeset.changes.categories
      end
  end
end