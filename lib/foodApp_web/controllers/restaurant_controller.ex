defmodule FoodAppWeb.RestaurantController do
  use FoodAppWeb, :controller
  alias FoodApp.Restaurants
  alias FoodApp.Restaurants.Restaurant
  action_fallback FoodAppWeb.FallbackController

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    render(conn, "index.json", restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    with {:ok, %Restaurant{} = restaurant} <- Restaurants.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> render("show.json", restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    case Restaurants.get_restaurant(id) do
      nil -> {:error, :not_found}
      restaurant -> render(conn, "show.json", restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Restaurants.get_restaurant(id) do
      nil -> {:error, :not_found}
      restaurant -> delete_restaurant(conn, restaurant)
    end
  end

  defp delete_restaurant(conn, restaurant) do
    with {:ok, %Restaurant{}} <- Restaurants.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end
end
