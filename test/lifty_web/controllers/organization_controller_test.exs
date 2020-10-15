defmodule LiftyWeb.OrganizationControllerTest do
  use LiftyWeb.ConnCase

  alias Lifty.Organizations
  alias Lifty.Organizations.Organization

  @create_attrs %{
    address: "some address",
    cellphone: "some cellphone",
    confirmed_at: ~N[2010-04-17 14:00:00],
    country: "some country",
    email: "some email",
    is_active: true,
    montly_deliveries: 42,
    name: "some name",
    password: "some password",
    password_hash: "some password_hash",
    taxpayer_id: "some taxpayer_id",
    website: "some website"
  }
  @update_attrs %{
    address: "some updated address",
    cellphone: "some updated cellphone",
    confirmed_at: ~N[2011-05-18 15:01:01],
    country: "some updated country",
    email: "some updated email",
    is_active: false,
    montly_deliveries: 43,
    name: "some updated name",
    password: "some updated password",
    password_hash: "some updated password_hash",
    taxpayer_id: "some updated taxpayer_id",
    website: "some updated website"
  }
  @invalid_attrs %{address: nil, cellphone: nil, confirmed_at: nil, country: nil, email: nil, is_active: nil, montly_deliveries: nil, name: nil, password: nil, password_hash: nil, taxpayer_id: nil, website: nil}

  def fixture(:organization) do
    {:ok, organization} = Organizations.create_organization(@create_attrs)
    organization
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all organizations", %{conn: conn} do
      conn = get(conn, Routes.organization_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create organization" do
    test "renders organization when data is valid", %{conn: conn} do
      conn = post(conn, Routes.organization_path(conn, :create), organization: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.organization_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "cellphone" => "some cellphone",
               "confirmed_at" => "2010-04-17T14:00:00",
               "country" => "some country",
               "email" => "some email",
               "is_active" => true,
               "montly_deliveries" => 42,
               "name" => "some name",
               "password" => "some password",
               "password_hash" => "some password_hash",
               "taxpayer_id" => "some taxpayer_id",
               "website" => "some website"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.organization_path(conn, :create), organization: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update organization" do
    setup [:create_organization]

    test "renders organization when data is valid", %{conn: conn, organization: %Organization{id: id} = organization} do
      conn = put(conn, Routes.organization_path(conn, :update, organization), organization: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.organization_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "cellphone" => "some updated cellphone",
               "confirmed_at" => "2011-05-18T15:01:01",
               "country" => "some updated country",
               "email" => "some updated email",
               "is_active" => false,
               "montly_deliveries" => 43,
               "name" => "some updated name",
               "password" => "some updated password",
               "password_hash" => "some updated password_hash",
               "taxpayer_id" => "some updated taxpayer_id",
               "website" => "some updated website"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, organization: organization} do
      conn = put(conn, Routes.organization_path(conn, :update, organization), organization: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete organization" do
    setup [:create_organization]

    test "deletes chosen organization", %{conn: conn, organization: organization} do
      conn = delete(conn, Routes.organization_path(conn, :delete, organization))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.organization_path(conn, :show, organization))
      end
    end
  end

  defp create_organization(_) do
    organization = fixture(:organization)
    %{organization: organization}
  end
end
