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
      confirmed_at: organization.confirmed_at,
      name: organization.name,
      taxpayer_id: organization.taxpayer_id,
      country: organization.country,
      cellphone: organization.cellphone,
      montly_deliveries: organization.montly_deliveries,
      website: organization.website,
      is_active: organization.is_active,
      address: organization.address}
  end
end
