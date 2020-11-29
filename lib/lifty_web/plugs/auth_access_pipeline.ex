defmodule LiftyWeb.Plug.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :lifty

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
  plug Guardian.Plug.Pipeline, module: Lifty.Guardian,
                             error_handler: LiftyWeb.Plug.AuthErrorHandler
  # error_handler: LiftyWeb.Plug.AuthErrorHandler

end
