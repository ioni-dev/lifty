defmodule LiftyWeb.PickupControllerTest do
  use LiftyWeb.ConnCase

  alias Lifty.Pickups
  alias Lifty.Pickups.Pickup

  @create_attrs %{
    arrived_at: "2010-04-17T14:00:00.000000Z",
    departed_at: "2010-04-17T14:00:00.000000Z",
    latitude: 120.5,
    longitude: 120.5,
    status: "some status"
  }
  @update_attrs %{
    arrived_at: "2011-05-18T15:01:01.000000Z",
    departed_at: "2011-05-18T15:01:01.000000Z",
    latitude: 456.7,
    longitude: 456.7,
    status: "some updated status"
  }
  @invalid_attrs %{arrived_at: nil, departed_at: nil, latitude: nil, longitude: nil, status: nil}

  def fixture(:pickup) do
    {:ok, pickup} = Pickups.create_pickup(@create_attrs)
    pickup
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pickups", %{conn: conn} do
      conn = get(conn, Routes.pickup_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pickup" do
    test "renders pickup when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pickup_path(conn, :create), pickup: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pickup_path(conn, :show, id))

      assert %{
               "id" => id,
               "arrived_at" => "2010-04-17T14:00:00.000000Z",
               "departed_at" => "2010-04-17T14:00:00.000000Z",
               "latitude" => 120.5,
               "longitude" => 120.5,
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pickup_path(conn, :create), pickup: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pickup" do
    setup [:create_pickup]

    test "renders pickup when data is valid", %{conn: conn, pickup: %Pickup{id: id} = pickup} do
      conn = put(conn, Routes.pickup_path(conn, :update, pickup), pickup: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pickup_path(conn, :show, id))

      assert %{
               "id" => id,
               "arrived_at" => "2011-05-18T15:01:01.000000Z",
               "departed_at" => "2011-05-18T15:01:01.000000Z",
               "latitude" => 456.7,
               "longitude" => 456.7,
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pickup: pickup} do
      conn = put(conn, Routes.pickup_path(conn, :update, pickup), pickup: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pickup" do
    setup [:create_pickup]

    test "deletes chosen pickup", %{conn: conn, pickup: pickup} do
      conn = delete(conn, Routes.pickup_path(conn, :delete, pickup))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pickup_path(conn, :show, pickup))
      end
    end
  end

  defp create_pickup(_) do
    pickup = fixture(:pickup)
    %{pickup: pickup}
  end
end
