defmodule Hotel.Repo.Migrations.AddItem do
  use Ecto.Migration
  @doc """
   Holds database entries for the items table
  """
  def change do
    create table(:items, primary_key: :false) do
      add :id , :binary_id, primary_key: :true
      add :name, :string
      add :description, :string
      add :price, :string

      timestamps(inserted_at: :added_on, updated_at: :modified_on)
    end
  end
end
