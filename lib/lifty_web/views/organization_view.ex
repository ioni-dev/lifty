defmodule LiftyWeb.OrganizationView do
  use LiftyWeb, :view
  alias LiftyWeb.OrganizationView

  def render("index.json", %{organizations: organizations}) do
    %{data: render_many(organizations, OrganizationView, "organization.json")}
  end

  def render("show.json", %{organization: organization}) do
    %{data: render_one(organization, OrganizationView, "organization.json")}
  end

  def render("organization.json", %{organization: organization}) do
    %{id: organization.id,
      email: organization.email,
      password_hash: organization.password_hash,
      password: organization.password,
      full_name: organization.full_name,
      country: organization.country,
      cellphone: organization.cellphone,
      vehicule_quantity: organization.vehicule_quantity,
      organization_name: organization.organization_name,
      is_active: organization.is_active
    }
  end
end
