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
  end
end