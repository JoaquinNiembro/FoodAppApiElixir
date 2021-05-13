defmodule FoodAppWeb.PromotionView do
  use FoodAppWeb, :view
  alias FoodAppWeb.PromotionView

  def render("index.json", %{promotions: promotions}) do
    %{data: render_many(promotions, PromotionView, "promotion.json")}
  end

  def render("show.json", %{promotion: promotion}) do
    %{data: render_one(promotion, PromotionView, "promotion.json")}
  end

  def render("promotion.json", %{promotion: promotion}) do
    %{id: promotion.id,
      title: promotion.title,
      discount: promotion.discount,
      promotion: promotion.promotion}
  end
end
