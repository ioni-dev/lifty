defmodule LiftyWeb.DriverControllerTest do
  use LiftyWeb.ConnCase

  alias Lifty.Drivers
  alias Lifty.Drivers.Driver

  @create_attrs %{
    active: true,
    address: "some address",
    cellphone: "some cellphone",
    certifications: [],
    city: "some city",
    country: "some country",
    date_of_birth: ~D[2010-04-17],
    driver_license: %{},
    email: "some email",
    email_verified: true,
    emergency_contact: %{},
    first_name: "some first_name",
    id_photos: %{},
    last_logged_in: "2010-04-17T14:00:00Z",
    last_name: "some last_name",
    password_hash: "some password_hash",
    profile_pic: "some profile_pic",
    referred_contact: [],
    ways_of_reference: "some ways_of_reference",
    work_reference: [],
    years_of_experience: 42
  }
  @update_attrs %{
    active: false,
    address: "some updated address",
    cellphone: "some updated cellphone",
    certifications: [],
    city: "some updated city",
    country: "some updated country",
    date_of_birth: ~D[2011-05-18],
    driver_license: %{},
    email: "some updated email",
    email_verified: false,
    emergency_contact: %{},
    first_name: "some updated first_name",
    id_photos: %{},
    last_logged_in: "2011-05-18T15:01:01Z",
    last_name: "some updated last_name",
    password_hash: "some updated password_hash",
    profile_pic: "some updated profile_pic",
    referred_contact: [],
    ways_of_reference: "some updated ways_of_reference",
    work_reference: [],
    years_of_experience: 43
  }
  @invalid_attrs %{active: nil, address: nil, cellphone: nil, certifications: nil, city: nil, country: nil, date_of_birth: nil, driver_license: nil, email: nil, email_verified: nil, emergency_contact: nil, first_name: nil, id_photos: nil, last_logged_in: nil, last_name: nil, password_hash: nil, profile_pic: nil, referred_contact: nil, ways_of_reference: nil, work_reference: nil, years_of_experience: nil}

  def fixture(:driver) do
    {:ok, driver} = Drivers.create_driver(@create_attrs)
    driver
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all drivers", %{conn: conn} do
      conn = get(conn, Routes.driver_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create driver" do
    test "renders driver when data is valid", %{conn: conn} do
      conn = post(conn, Routes.driver_path(conn, :create), driver: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.driver_path(conn, :show, id))

      assert %{
               "id" => id,
               "active" => true,
               "address" => "some address",
               "cellphone" => "some cellphone",
               "certifications" => [],
               "city" => "some city",
               "country" => "some country",
               "date_of_birth" => "2010-04-17",
               "driver_license" => %{},
               "email" => "some email",
               "email_verified" => true,
               "emergency_contact" => %{},
               "first_name" => "some first_name",
               "id_photos" => %{},
               "last_logged_in" => "2010-04-17T14:00:00Z",
               "last_name" => "some last_name",
               "profile_pic" => "some profile_pic",
               "referred_contact" => [],
               "ways_of_reference" => "some ways_of_reference",
               "work_reference" => [],
               "years_of_experience" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.driver_path(conn, :create), driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update driver" do
    setup [:create_driver]

    test "renders driver when data is valid", %{conn: conn, driver: %Driver{id: id} = driver} do
      conn = put(conn, Routes.driver_path(conn, :update, driver), driver: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.driver_path(conn, :show, id))

      assert %{
               "id" => id,
               "active" => false,
               "address" => "some updated address",
               "cellphone" => "some updated cellphone",
               "certifications" => [],
               "city" => "some updated city",
               "country" => "some updated country",
               "date_of_birth" => "2011-05-18",
               "driver_license" => %{},
               "email" => "some updated email",
               "email_verified" => false,
               "emergency_contact" => %{},
               "first_name" => "some updated first_name",
               "id_photos" => %{},
               "last_logged_in" => "2011-05-18T15:01:01Z",
               "last_name" => "some updated last_name",
               "profile_pic" => "some updated profile_pic",
               "referred_contact" => [],
               "ways_of_reference" => "some updated ways_of_reference",
               "work_reference" => [],
               "years_of_experience" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, driver: driver} do
      conn = put(conn, Routes.driver_path(conn, :update, driver), driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete driver" do
    setup [:create_driver]

    test "deletes chosen driver", %{conn: conn, driver: driver} do
      conn = delete(conn, Routes.driver_path(conn, :delete, driver))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.driver_path(conn, :show, driver))
      end
    end
  end

  defp create_driver(_) do
    driver = fixture(:driver)
    %{driver: driver}
  end
end
