defmodule Hotel.Menu.Item do
  @moduledoc """
  This module holds the changeset and schema to the Items table
 """
  use Hotel.Utils.Schema

    alias Hotel.{
    Menu.Item,
    Menu.Category,
    Repo
      }
    schema "items" do
      field :name, :string
      field :description, :string
      field :price, :string

      many_to_many(
      :categories, Category, join_through: "item_categories",
      join_keys: [item_id: :id, category_id: :id],
      on_replace: :delete
      )

      timestamps(inserted_at: :added_on, updated_at: :modified_on)
  end

  @doc """
    This function is the changeset for the items
  """
  @spec changeset(Item.t(), map()) :: {:ok, Item.t()} | {:error, Ecto.Changeset.t()}
  def changeset(%Item{} = items, params \\ %{}) do
    items
    |> cast(params, [:name, :description, :price])
    |> validate_required([:name, :price])
    |> validate_length(:description, max: 50)
  end
  @spec add_to_category(Item.t(), Category.t()) :: {:ok, Item.t()} | {:error, Ecto.Changeset.t()}
  def add_to_category(%Item{categories: categories} = item, %Category{} = cat) do
    item
    |> Repo.preload(:categories)
    |> changeset(%{})
    |> put_assoc(:categories, [cat] ++ categories)
  end
end