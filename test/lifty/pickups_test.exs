defmodule Lifty.PickupsTest do
  use Lifty.DataCase

  alias Lifty.Pickups

  describe "pickups" do
    alias Lifty.Pickups.Pickup

    @valid_attrs %{arrived_at: "2010-04-17T14:00:00.000000Z", departed_at: "2010-04-17T14:00:00.000000Z", latitude: 120.5, longitude: 120.5, status: "some status"}
    @update_attrs %{arrived_at: "2011-05-18T15:01:01.000000Z", departed_at: "2011-05-18T15:01:01.000000Z", latitude: 456.7, longitude: 456.7, status: "some updated status"}
    @invalid_attrs %{arrived_at: nil, departed_at: nil, latitude: nil, longitude: nil, status: nil}

    def pickup_fixture(attrs \\ %{}) do
      {:ok, pickup} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pickups.create_pickup()

      pickup
    end

    test "list_pickups/0 returns all pickups" do
      pickup = pickup_fixture()
      assert Pickups.list_pickups() == [pickup]
    end

    test "get_pickup!/1 returns the pickup with given id" do
      pickup = pickup_fixture()
      assert Pickups.get_pickup!(pickup.id) == pickup
    end

    test "create_pickup/1 with valid data creates a pickup" do
      assert {:ok, %Pickup{} = pickup} = Pickups.create_pickup(@valid_attrs)
      assert pickup.arrived_at == DateTime.from_naive!(~N[2010-04-17T14:00:00.000000Z], "Etc/UTC")
      assert pickup.departed_at == DateTime.from_naive!(~N[2010-04-17T14:00:00.000000Z], "Etc/UTC")
      assert pickup.latitude == 120.5
      assert pickup.longitude == 120.5
      assert pickup.status == "some status"
    end

    test "create_pickup/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pickups.create_pickup(@invalid_attrs)
    end

    test "update_pickup/2 with valid data updates the pickup" do
      pickup = pickup_fixture()
      assert {:ok, %Pickup{} = pickup} = Pickups.update_pickup(pickup, @update_attrs)
      assert pickup.arrived_at == DateTime.from_naive!(~N[2011-05-18T15:01:01.000000Z], "Etc/UTC")
      assert pickup.departed_at == DateTime.from_naive!(~N[2011-05-18T15:01:01.000000Z], "Etc/UTC")
      assert pickup.latitude == 456.7
      assert pickup.longitude == 456.7
      assert pickup.status == "some updated status"
    end

    test "update_pickup/2 with invalid data returns error changeset" do
      pickup = pickup_fixture()
      assert {:error, %Ecto.Changeset{}} = Pickups.update_pickup(pickup, @invalid_attrs)
      assert pickup == Pickups.get_pickup!(pickup.id)
    end

    test "delete_pickup/1 deletes the pickup" do
      pickup = pickup_fixture()
      assert {:ok, %Pickup{}} = Pickups.delete_pickup(pickup)
      assert_raise Ecto.NoResultsError, fn -> Pickups.get_pickup!(pickup.id) end
    end

    test "change_pickup/1 returns a pickup changeset" do
      pickup = pickup_fixture()
      assert %Ecto.Changeset{} = Pickups.change_pickup(pickup)
    end
  end
end
