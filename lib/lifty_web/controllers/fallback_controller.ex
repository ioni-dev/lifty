defmodule LiftyWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use LiftyWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  # def call(conn, {:error, :not_found}) do
  #   conn
  #   |> put_status(:not_found)
  #   |> put_view(LiftyWeb.ErrorView)
  #   |> render(:"404")
  # end
  def call(conn, {:error, %Ecto.Changeset{}}) do
      conn
      |> put_status(:unprocessable_entity)
      |> put_view(LiftyWeb.ErrorView)
      |> render(:"422")
  end

  # def call(conn, {:error, :unauthorized}) do
  #   conn
  #   |> put_status(:unauthorized)
  #   |> put_view(LiftyWeb.ErrorView)
  #   |> render("auth_required.json")
  # end
end
