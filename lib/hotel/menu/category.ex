defmodule Hotel.Menu.Category do
  @moduledoc """
    This module holds the category changeset
  """

  use Hotel.Utils.Schema

  alias Hotel.{
    Menu.Category
    }

    schema "categories" do
      field :name, :string
      field :description, :string

      many_to_many(:items, Item,
        join_through: "items_categories",
        join_keys: [category_id: :id, item_id: :id],
        on_replace: :delete
      )

      timestamps(inserted_at: :added_on, updated_at: :modified_on)
  end
  @doc """
    Function to create a category changeset
  """
  @spec changeset(Category.t(), map()) :: {:ok, Category.t()} | {:error, Ecto.Changeset.t()}
    def changeset(%Category{} = cat, params \\ %{}) do
      cat
      |> cast(params, [:name, :description])
      |> validate_required([:name])
      |> validate_length(:description, max: 50)
  end
end