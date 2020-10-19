defmodule Lifty.RequestsTest do
  use Lifty.DataCase

  alias Lifty.Requests

  describe "requests" do
    alias Lifty.Requests.Request

    @valid_attrs %{destinations: [], from_latitude: 120.5, from_longitude: 120.5, status: "some status"}
    @update_attrs %{destinations: [], from_latitude: 456.7, from_longitude: 456.7, status: "some updated status"}
    @invalid_attrs %{destinations: nil, from_latitude: nil, from_longitude: nil, status: nil}

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Requests.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Requests.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Requests.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = Requests.create_request(@valid_attrs)
      assert request.destinations == []
      assert request.from_latitude == 120.5
      assert request.from_longitude == 120.5
      assert request.status == "some status"
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, %Request{} = request} = Requests.update_request(request, @update_attrs)
      assert request.destinations == []
      assert request.from_latitude == 456.7
      assert request.from_longitude == 456.7
      assert request.status == "some updated status"
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Requests.update_request(request, @invalid_attrs)
      assert request == Requests.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Requests.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Requests.change_request(request)
    end
  end
end
