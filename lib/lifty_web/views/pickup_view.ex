defmodule LiftyWeb.PickupView do
  use LiftyWeb, :view
  alias LiftyWeb.PickupView

  def render("index.json", %{pickups: pickups}) do
    %{data: render_many(pickups, PickupView, "pickup.json")}
  end

  def render("show.json", %{pickup: pickup}) do
    %{data: render_one(pickup, PickupView, "pickup.json")}
  end

  def render("pickup.json", %{pickup: pickup}) do
    %{id: pickup.id,
      status: pickup.status,
      latitude: pickup.latitude,
      longitude: pickup.longitude,
      departed_at: pickup.departed_at,
      arrived_at: pickup.arrived_at}
  end
end
