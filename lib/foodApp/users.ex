defmodule FoodApp.Users do
  import Ecto.Query, warn: false
  alias FoodApp.Repo
  alias FoodApp.Users.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, given_pass) do
    user = Repo.get_by(User, email: email)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unathorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end

  def token_sign_in(email, given_pass) do
    case authenticate_user(email, given_pass) do
      {:ok, user} -> {:ok, user}
      _ -> {:error, :unauthorized}
    end
  end
end
