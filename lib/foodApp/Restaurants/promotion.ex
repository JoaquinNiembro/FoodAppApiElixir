defmodule FoodApp.Restaurants.Promotion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promotions" do
    field :discount, :string
    field :promotion, :string
    field :title, :string
    belongs_to :restaurant, FoodApp.Restaurants.Restaurant

    timestamps()
  end

  @doc false
  def changeset(promotion, attrs) do
    promotion
    |> cast(attrs, [:title, :discount, :promotion])
    |> validate_required([:title, :discount, :promotion])
  end
end
