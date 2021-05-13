defmodule FoodAppWeb.UserView do
  use FoodAppWeb, :view

  def render("user.json", %{user: user, token: token}) do
    %{name: user.name, email: user.email, role: user.role, token: token}
  end
end
