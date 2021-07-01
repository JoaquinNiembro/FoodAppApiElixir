defmodule FoodApp.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :description, :string
      add :color, :string

      timestamps()
    end

  end
end
