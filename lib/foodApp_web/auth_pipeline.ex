defmodule FoodApp.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :FoodApp,
    module: FoodApp.Guardian,
    error_handler: FoodApp.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
