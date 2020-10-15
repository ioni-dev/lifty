defmodule Lifty.OrganizationsTest do
  use Lifty.DataCase

  alias Lifty.Organizations

  describe "organizations" do
    alias Lifty.Organizations.Organization

    @valid_attrs %{address: "some address", cellphone: "some cellphone", confirmed_at: ~N[2010-04-17 14:00:00], country: "some country", email: "some email", is_active: true, montly_deliveries: 42, name: "some name", password: "some password", password_hash: "some password_hash", taxpayer_id: "some taxpayer_id", website: "some website"}
    @update_attrs %{address: "some updated address", cellphone: "some updated cellphone", confirmed_at: ~N[2011-05-18 15:01:01], country: "some updated country", email: "some updated email", is_active: false, montly_deliveries: 43, name: "some updated name", password: "some updated password", password_hash: "some updated password_hash", taxpayer_id: "some updated taxpayer_id", website: "some updated website"}
    @invalid_attrs %{address: nil, cellphone: nil, confirmed_at: nil, country: nil, email: nil, is_active: nil, montly_deliveries: nil, name: nil, password: nil, password_hash: nil, taxpayer_id: nil, website: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organizations.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Organizations.create_organization(@valid_attrs)
      assert organization.address == "some address"
      assert organization.cellphone == "some cellphone"
      assert organization.confirmed_at == ~N[2010-04-17 14:00:00]
      assert organization.country == "some country"
      assert organization.email == "some email"
      assert organization.is_active == true
      assert organization.montly_deliveries == 42
      assert organization.name == "some name"
      assert organization.password == "some password"
      assert organization.password_hash == "some password_hash"
      assert organization.taxpayer_id == "some taxpayer_id"
      assert organization.website == "some website"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Organizations.update_organization(organization, @update_attrs)
      assert organization.address == "some updated address"
      assert organization.cellphone == "some updated cellphone"
      assert organization.confirmed_at == ~N[2011-05-18 15:01:01]
      assert organization.country == "some updated country"
      assert organization.email == "some updated email"
      assert organization.is_active == false
      assert organization.montly_deliveries == 43
      assert organization.name == "some updated name"
      assert organization.password == "some updated password"
      assert organization.password_hash == "some updated password_hash"
      assert organization.taxpayer_id == "some updated taxpayer_id"
      assert organization.website == "some updated website"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Organizations.update_organization(organization, @invalid_attrs)
      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end
end
