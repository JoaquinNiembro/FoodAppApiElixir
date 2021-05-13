defmodule FoodAppWeb.UserController do
  use FoodAppWeb, :controller
  alias FoodApp.Users
  alias FoodApp.Users.User
  action_fallback FoodAppWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params),
         {:ok, token, _claims} = FoodApp.Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end

  def signin(conn, %{"user" => %{"email" => email, "password_hash" => password}}) do
    with {:ok, user} <- Users.token_sign_in(email, password),
         {:ok, token, _claims} = FoodApp.Guardian.encode_and_sign(user) do
      conn |> render("user.json", %{user: user, token: token})
    else
      _ -> {:error, :unauthorized}
    end
  end
end
