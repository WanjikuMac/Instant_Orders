defmodule Hotel.Repo.Migrations.CreateProfile do
  use Ecto.Migration
    @moduledoc """
    This module holds the migration details required to create a profile
  """
  def change do
    create table(:profiles, primary_key: :false) do
        add :id, :binary_id, primary_key: true
        add :name, :string
        add :avatar_link, :string
        add :gender, :string
        #add :user_id, references(:users, type: :binary_id)

        timestamps(inserted_at: :created_on, updated_at: :modified_on)
    end

        #create index(:profiles, [:user_id])
        create unique_index(:profiles, [:name])
  end
end
