defmodule Hotel.MenuTest do
  @moduledoc """
  This module holds the tests to menu context
"""
  use Hotel.DataCase

  alias Hotel.{
      Menu.Item,
      Menu
    }

    describe "menu context" do
      @tag :add
      test "test add_item/2 with the right parameters" do
        item_params = params_for(:item)
        assert Repo.aggregate(Item, :count, :id) == 0
        assert{:ok, %Item{}} = Menu.add_item(item_params)
        assert Repo.aggregate(Item, :count, :id) == 1
      end
  end
end