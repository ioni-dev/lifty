defmodule Lifty.ClientsTest do
  use Lifty.DataCase

  alias Lifty.Clients

  describe "clients" do
    alias Lifty.Clients.Client

    @valid_attrs %{birthday: ~D[2010-04-17], cellphone: "some cellphone", city: "some city", confirmed_at: ~N[2010-04-17 14:00:00], country: "some country", delivery_destination: "some delivery_destination", email: "some email", first_name: "some first_name", last_name: "some last_name", name: "some name", password: "some password", password_hash: "some password_hash"}
    @update_attrs %{birthday: ~D[2011-05-18], cellphone: "some updated cellphone", city: "some updated city", confirmed_at: ~N[2011-05-18 15:01:01], country: "some updated country", delivery_destination: "some updated delivery_destination", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", name: "some updated name", password: "some updated password", password_hash: "some updated password_hash"}
    @invalid_attrs %{birthday: nil, cellphone: nil, city: nil, confirmed_at: nil, country: nil, delivery_destination: nil, email: nil, first_name: nil, last_name: nil, name: nil, password: nil, password_hash: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clients.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Clients.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Clients.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Clients.create_client(@valid_attrs)
      assert client.birthday == ~D[2010-04-17]
      assert client.cellphone == "some cellphone"
      assert client.city == "some city"
      assert client.confirmed_at == ~N[2010-04-17 14:00:00]
      assert client.country == "some country"
      assert client.delivery_destination == "some delivery_destination"
      assert client.email == "some email"
      assert client.first_name == "some first_name"
      assert client.last_name == "some last_name"
      assert client.name == "some name"
      assert client.password == "some password"
      assert client.password_hash == "some password_hash"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Clients.update_client(client, @update_attrs)
      assert client.birthday == ~D[2011-05-18]
      assert client.cellphone == "some updated cellphone"
      assert client.city == "some updated city"
      assert client.confirmed_at == ~N[2011-05-18 15:01:01]
      assert client.country == "some updated country"
      assert client.delivery_destination == "some updated delivery_destination"
      assert client.email == "some updated email"
      assert client.first_name == "some updated first_name"
      assert client.last_name == "some updated last_name"
      assert client.name == "some updated name"
      assert client.password == "some updated password"
      assert client.password_hash == "some updated password_hash"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_client(client, @invalid_attrs)
      assert client == Clients.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Clients.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Clients.change_client(client)
    end
  end
end
