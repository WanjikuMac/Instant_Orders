defmodule Hotel.Repo.Migrations.AssociateItemsToCategories do
  @moduledoc """
  This module holds the r/shp of many to many between the
  Items and category table
  """
  use Ecto.Migration

  def change do
    create table(:item_categories) do
      add :item_id, references(:categories, on_delete: :nothing, type: :binary_id)
      add :category_id, references(:items, on_delete: :nothing, type: :binary_id)

      timestamps(inserted_at: :added_on, update_at: :modified_on)
    end

    create unique_index(:item_categories, [:item_id, :category_id])
  end
end