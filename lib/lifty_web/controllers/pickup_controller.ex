defmodule LiftyWeb.PickupController do
  use LiftyWeb, :controller

  alias Lifty.Pickups
  alias Lifty.Pickups.Pickup

  action_fallback LiftyWeb.FallbackController

  def index(conn, _params) do
    pickups = Pickups.list_pickups()
    render(conn, "index.json", pickups: pickups)
  end

  def create(conn, %{"pickup" => pickup_params}) do
    with {:ok, %Pickup{} = pickup} <- Pickups.create_pickup(pickup_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.pickup_path(conn, :show, pickup))
      |> render("show.json", pickup: pickup)
    end
  end

  def show(conn, %{"id" => id}) do
    pickup = Pickups.get_pickup!(id)
    render(conn, "show.json", pickup: pickup)
  end

  def update(conn, %{"id" => id, "pickup" => pickup_params}) do
    pickup = Pickups.get_pickup!(id)

    with {:ok, %Pickup{} = pickup} <- Pickups.update_pickup(pickup, pickup_params) do
      render(conn, "show.json", pickup: pickup)
    end
  end

  def delete(conn, %{"id" => id}) do
    pickup = Pickups.get_pickup!(id)

    with {:ok, %Pickup{}} <- Pickups.delete_pickup(pickup) do
      send_resp(conn, :no_content, "")
    end
  end
end
