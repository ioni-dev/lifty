defmodule LiftyWeb.ClientView do
  use LiftyWeb, :view
  alias LiftyWeb.ClientView

  def render("index.json", %{clients: clients}) do
    %{data: render_many(clients, ClientView, "client.json")}
  end

  def render("show.json", %{client: client}) do
    %{data: render_one(client, ClientView, "client.json")}
  end

  def render("client.json", %{client: client}) do
    %{id: client.id,
      email: client.email,
      name: client.name,
      first_name: client.first_name,
      last_name: client.last_name,
      cellphone: client.cellphone,
      birthday: client.birthday,
      city: client.city,
      country: client.country,
      password: client.password,
      password_hash: client.password_hash,
      confirmed_at: client.confirmed_at,
      delivery_destination: client.delivery_destination}
  end
end
