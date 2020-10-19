defmodule Lifty.RidesTest do
  use Lifty.DataCase

  alias Lifty.Rides

  describe "rides" do
    alias Lifty.Rides.Ride

    @valid_attrs %{destinations_status: [], status: "some status"}
    @update_attrs %{destinations_status: [], status: "some updated status"}
    @invalid_attrs %{destinations_status: nil, status: nil}

    def ride_fixture(attrs \\ %{}) do
      {:ok, ride} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rides.create_ride()

      ride
    end

    test "list_rides/0 returns all rides" do
      ride = ride_fixture()
      assert Rides.list_rides() == [ride]
    end

    test "get_ride!/1 returns the ride with given id" do
      ride = ride_fixture()
      assert Rides.get_ride!(ride.id) == ride
    end

    test "create_ride/1 with valid data creates a ride" do
      assert {:ok, %Ride{} = ride} = Rides.create_ride(@valid_attrs)
      assert ride.destinations_status == []
      assert ride.status == "some status"
    end

    test "create_ride/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rides.create_ride(@invalid_attrs)
    end

    test "update_ride/2 with valid data updates the ride" do
      ride = ride_fixture()
      assert {:ok, %Ride{} = ride} = Rides.update_ride(ride, @update_attrs)
      assert ride.destinations_status == []
      assert ride.status == "some updated status"
    end

    test "update_ride/2 with invalid data returns error changeset" do
      ride = ride_fixture()
      assert {:error, %Ecto.Changeset{}} = Rides.update_ride(ride, @invalid_attrs)
      assert ride == Rides.get_ride!(ride.id)
    end

    test "delete_ride/1 deletes the ride" do
      ride = ride_fixture()
      assert {:ok, %Ride{}} = Rides.delete_ride(ride)
      assert_raise Ecto.NoResultsError, fn -> Rides.get_ride!(ride.id) end
    end

    test "change_ride/1 returns a ride changeset" do
      ride = ride_fixture()
      assert %Ecto.Changeset{} = Rides.change_ride(ride)
    end
  end
end
