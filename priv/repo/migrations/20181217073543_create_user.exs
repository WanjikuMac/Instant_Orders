defmodule Hotel.Repo.Migrations.CreateUser do
  @moduledoc"""
  This migration holds the database entries for creating a user
  """
  use Ecto.Migration

  def change do
    create table(:users, primary_key: :false) do
      add :id, :binary_id, prinary_key: :true
      add :username, :string
      add :password, :string
      add :email, :string


    timestamps(
      inserted_at: :joined_on,
      updated_at: :modified_on
    )

    end
  end
end
