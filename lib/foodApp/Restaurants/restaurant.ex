defmodule FoodApp.Restaurants.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field :name, :string
    field :city, :string
    field :menu, :string

    timestamps()
  end

  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :city, :menu])
    |> validate_required([:name, :city, :menu])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 5, max: 100)
  end
end
