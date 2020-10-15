defmodule LiftyWeb.AuthenticationController do
  @moduledoc """
  Handle authentication requests and oauth2 callbacks
  """
  use LiftyWeb, :controller

  alias Lifty.Drivers
  plug Ueberauth

  @doc """
  Ueberauth identity (email / password) authentication callback
  """
  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.uid
    password = auth.credentials.other.password

    handle_user_conn(Drivers.get_driver_by_email_and_password(email, password), conn)
  end

  # handle conn for callbacks above
  defp handle_user_conn(driver, conn) do
    case driver do
      {:ok, driver} ->
        {:ok, jwt, _full_claims} =
          Lifty.Guardian.encode_and_sign(driver, %{}, permissions: driver.permissions)

        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> json(%{token: jwt})

      # Handle our own error to keep it generic
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> json(%{message: "user not found"})
    end
  end
end
