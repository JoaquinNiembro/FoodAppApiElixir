defmodule FoodApp.Repo.Migrations.PromotionBelongsToRestaruant do
  use Ecto.Migration

  def change do
    alter table(:promotions) do
      add :restaurant_id, references(:restaurants)
    end
  end
end
