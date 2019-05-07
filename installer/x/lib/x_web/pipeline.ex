defmodule XWeb.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :x,
    error_handler: XWeb.FallbackController,
    module: X.Accounts.Guardian

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
