defmodule Hotel.Repo.Migrations.CategoryTable do
  use Ecto.Migration
  @doc """
    This module holds entries for the category table
  """
  def change do
    create table(:categories, primary_key: :false) do
      add :id, :binary_id, primary_key: :true
      add :name, :string
      add :description, :string

      timestamps(inserted_at: :added_on, updated_at: :modified_on)
    end
  end
end
