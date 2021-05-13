defmodule FoodAppWeb.PromotionController do
  use FoodAppWeb, :controller

  alias FoodApp.Restaurants
  alias FoodApp.Restaurants.Promotion

  action_fallback FoodAppWeb.FallbackController

  def index(conn, _params) do
    promotions = Restaurants.list_promotions()
    render(conn, "index.json", promotions: promotions)
  end

  def create(conn, %{"promotion" => promotion_params}) do
    with {:ok, %Promotion{} = promotion} <- Restaurants.create_promotion(promotion_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promotion_path(conn, :show, promotion))
      |> render("show.json", promotion: promotion)
    end
  end

  def show(conn, %{"id" => id}) do
    promotion = Restaurants.get_promotion!(id)
    render(conn, "show.json", promotion: promotion)
  end

  def update(conn, %{"id" => id, "promotion" => promotion_params}) do
    promotion = Restaurants.get_promotion!(id)

    with {:ok, %Promotion{} = promotion} <-
           Restaurants.update_promotion(promotion, promotion_params) do
      render(conn, "show.json", promotion: promotion)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Restaurants.get_promotion!(id) do
      nil -> {:error, :not_found}
      promotion -> delete_promotion(conn, promotion)
    end
  end

  defp delete_promotion(conn, promotion) do
    with {:ok, %Promotion{}} <- Restaurants.delete_promotion(promotion) do
      send_resp(conn, :no_content, "")
    end
  end
end
