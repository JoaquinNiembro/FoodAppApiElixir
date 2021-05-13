defmodule FoodAppWeb.Router do
  use FoodAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug FoodApp.Guardian.AuthPipeline
  end

  scope "/api", FoodAppWeb do
    pipe_through :api

    post "/auth/signup", UserController, :create
    post "/auth/signin", UserController, :signin
    resources "/restaurants", RestaurantController, except: [:new, :edit, :create, :delete]
  end

  scope "/api", FoodAppWeb do
    pipe_through [:api, :jwt_authenticated]

    post "/restaurants", RestaurantController, :create
    delete "/restaurants/:id", RestaurantController, :delete
    resources "/promotions", PromotionController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: FoodAppWeb.Telemetry
    end
  end
end
