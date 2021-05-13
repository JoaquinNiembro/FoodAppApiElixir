defmodule FoodApp.Repo.Migrations.AddPromotionsTable do
  use Ecto.Migration

  def change do
    create table(:promotions) do
      add :title, :string
      add :discount, :string
      add :promotion, :string

      timestamps()
    end
  end
end
