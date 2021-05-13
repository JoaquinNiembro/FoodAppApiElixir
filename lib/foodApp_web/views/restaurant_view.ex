defmodule FoodAppWeb.RestaurantView do
  use FoodAppWeb, :view
  alias FoodAppWeb.RestaurantView

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{data: render_one(restaurant, RestaurantView, "restaurant.json")}
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{
      id: restaurant.id,
      name: restaurant.name,
      city: restaurant.city,
      menu: restaurant.menu
    }
  end
end
