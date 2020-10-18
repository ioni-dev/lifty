defmodule LiftyWeb.DriverController do
  use LiftyWeb, :controller

  alias Lifty.Drivers
  alias Lifty.Drivers.Driver

  action_fallback LiftyWeb.FallbackController

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    drivers = Drivers.list_drivers(current_user.id)
    IO.inspect(drivers)
    render(conn, "index.json", drivers: drivers)
  end

  def create(conn, %{"driver" => driver_params}) do
    with {:ok, %Driver{} = driver} <- Drivers.create_driver(driver_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.driver_path(conn, :show, driver))
      |> render("show.json", driver: driver)
    end
  end

  def show(conn, %{"id" => id}) do
    driver = Drivers.get_driver!(id)
    render(conn, "show.json", driver: driver)
  end

  def update(conn, %{"id" => id, "driver" => driver_params}) do
    driver = Drivers.get_driver!(id)

    with {:ok, %Driver{} = driver} <- Drivers.update_driver(driver, driver_params) do
      render(conn, "show.json", driver: driver)
    end
  end

  def delete(conn, %{"id" => id}) do
    driver = Drivers.get_driver!(id)

    with {:ok, %Driver{}} <- Drivers.delete_driver(driver) do
      send_resp(conn, :no_content, "")
    end
  end
end
