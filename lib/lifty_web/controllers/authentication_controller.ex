defmodule LiftyWeb.AuthenticationController do
  @moduledoc """
  Handle authentication requests and oauth2 callbacks
  """
  use LiftyWeb, :controller

  alias Lifty.Drivers
  alias Lifty.Clients
  alias Lifty.Organizations
  plug Ueberauth

  @doc """
  Ueberauth identity (email / password) authentication callback
  """
  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"type" => type}) do

    require Logger
    email = auth.uid
    password = auth.credentials.other.password
    # Logger.debug "param value: #{inspect(type)}"


    query = case type do
       "driver" -> Drivers.get_driver_by_email_and_password(email, password)
       "client" -> Clients.get_client_by_email_and_password(email, password)
       "organization" -> Organizations.get_organization_by_email_and_password(email, password)
       _ -> "Not user type specified"

    end
    handle_user_conn(query, type, conn)
  end

  # handle conn for callbacks above
  defp handle_user_conn(user, type, conn) do
    require Logger
    IO.inspect(user)
    Logger.debug "param value: #{inspect(user)}"
    case user do
      {:ok, user} ->
        {:ok, jwt, _full_claims} =
          Lifty.Guardian.encode_and_sign(user, %{user_type: type}, permissions: user.permissions)

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
