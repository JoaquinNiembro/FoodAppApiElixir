defmodule FoodApp.Repo do
  use Ecto.Repo,
    otp_app: :foodApp,
    adapter: Ecto.Adapters.Postgres
end
