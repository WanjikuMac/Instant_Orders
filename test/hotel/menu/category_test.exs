defmodule Hotel.Menu.CategoryTest do
  @moduledoc """
    This module holds tests for the category changeset
  """
  use Hotel.DataCase

  alias Hotel.{
    Menu.Category
    }
    @valid_params %{name: "Brunch", description: "A meal before lunch or late breakfast"}
    @invalid_params %{}
    describe "category changeset" do
      test "valid with correct parameters" do
        changeset = Category.changeset(%Category{}, @valid_params)
        assert changeset.valid?
    end

    test "invalid if parameters are incorrect" do
      changeset = Category.changeset(%Category{}, @invalid_params)
      refute changeset.valid?
    end
  end
end