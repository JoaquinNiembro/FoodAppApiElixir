defmodule FoodApp.Repo.Migrations.AddRestaurantsTable do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add :name, :string
      add :city, :string
      add :menu, :string

      timestamps()
    end

    create unique_index(:restaurants, [:name])
  end
end
