defmodule LiftyWeb.RideController do
  use LiftyWeb, :controller

  alias Lifty.Rides
  alias Lifty.Rides.Ride

  action_fallback LiftyWeb.FallbackController

  def index(conn, _params) do
    rides = Rides.list_rides()
    render(conn, "index.json", rides: rides)
  end

  def create(conn, %{"ride" => ride_params}) do
    with {:ok, %Ride{} = ride} <- Rides.create_ride(ride_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.ride_path(conn, :show, ride))
      |> render("show.json", ride: ride)
    end
  end

  def show(conn, %{"id" => id}) do
    ride = Rides.get_ride!(id)
    render(conn, "show.json", ride: ride)
  end

  def update(conn, %{"id" => id, "ride" => ride_params}) do
    ride = Rides.get_ride!(id)

    with {:ok, %Ride{} = ride} <- Rides.update_ride(ride, ride_params) do
      render(conn, "show.json", ride: ride)
    end
  end

  def delete(conn, %{"id" => id}) do
    ride = Rides.get_ride!(id)

    with {:ok, %Ride{}} <- Rides.delete_ride(ride) do
      send_resp(conn, :no_content, "")
    end
  end
end
