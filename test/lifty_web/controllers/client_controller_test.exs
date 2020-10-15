defmodule LiftyWeb.ClientControllerTest do
  use LiftyWeb.ConnCase

  alias Lifty.Clients
  alias Lifty.Clients.Client

  @create_attrs %{
    birthday: ~D[2010-04-17],
    cellphone: "some cellphone",
    city: "some city",
    confirmed_at: ~N[2010-04-17 14:00:00],
    country: "some country",
    delivery_destination: "some delivery_destination",
    email: "some email",
    first_name: "some first_name",
    last_name: "some last_name",
    name: "some name",
    password: "some password",
    password_hash: "some password_hash"
  }
  @update_attrs %{
    birthday: ~D[2011-05-18],
    cellphone: "some updated cellphone",
    city: "some updated city",
    confirmed_at: ~N[2011-05-18 15:01:01],
    country: "some updated country",
    delivery_destination: "some updated delivery_destination",
    email: "some updated email",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    name: "some updated name",
    password: "some updated password",
    password_hash: "some updated password_hash"
  }
  @invalid_attrs %{birthday: nil, cellphone: nil, city: nil, confirmed_at: nil, country: nil, delivery_destination: nil, email: nil, first_name: nil, last_name: nil, name: nil, password: nil, password_hash: nil}

  def fixture(:client) do
    {:ok, client} = Clients.create_client(@create_attrs)
    client
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clients", %{conn: conn} do
      conn = get(conn, Routes.client_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create client" do
    test "renders client when data is valid", %{conn: conn} do
      conn = post(conn, Routes.client_path(conn, :create), client: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.client_path(conn, :show, id))

      assert %{
               "id" => id,
               "birthday" => "2010-04-17",
               "cellphone" => "some cellphone",
               "city" => "some city",
               "confirmed_at" => "2010-04-17T14:00:00",
               "country" => "some country",
               "delivery_destination" => "some delivery_destination",
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "name" => "some name",
               "password" => "some password",
               "password_hash" => "some password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.client_path(conn, :create), client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update client" do
    setup [:create_client]

    test "renders client when data is valid", %{conn: conn, client: %Client{id: id} = client} do
      conn = put(conn, Routes.client_path(conn, :update, client), client: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.client_path(conn, :show, id))

      assert %{
               "id" => id,
               "birthday" => "2011-05-18",
               "cellphone" => "some updated cellphone",
               "city" => "some updated city",
               "confirmed_at" => "2011-05-18T15:01:01",
               "country" => "some updated country",
               "delivery_destination" => "some updated delivery_destination",
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "name" => "some updated name",
               "password" => "some updated password",
               "password_hash" => "some updated password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, client: client} do
      conn = put(conn, Routes.client_path(conn, :update, client), client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete client" do
    setup [:create_client]

    test "deletes chosen client", %{conn: conn, client: client} do
      conn = delete(conn, Routes.client_path(conn, :delete, client))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.client_path(conn, :show, client))
      end
    end
  end

  defp create_client(_) do
    client = fixture(:client)
    %{client: client}
  end
end
