defmodule FoodApp.Restaurants do
  
  import Ecto.Query, warn: false
  alias FoodApp.Repo
  alias FoodApp.Restaurants.Restaurant

  def list_restaurants do
    Repo.all(Restaurant)
  end

  def create_restaurant(attrs \\ %{}) do
    %Restaurant{}
    |> Restaurant.changeset(attrs)
    |> Repo.insert()
  end

  def get_restaurant(id), do: Repo.get(Restaurant, id)

  def delete_restaurant(%Restaurant{} = restaurant) do
    Repo.delete(restaurant)
  end
end
