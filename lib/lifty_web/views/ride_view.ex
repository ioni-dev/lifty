defmodule LiftyWeb.RideView do
  use LiftyWeb, :view
  alias LiftyWeb.RideView

  def render("index.json", %{rides: rides}) do
    %{data: render_many(rides, RideView, "ride.json")}
  end

  def render("show.json", %{ride: ride}) do
    %{data: render_one(ride, RideView, "ride.json")}
  end

  def render("ride.json", %{ride: ride}) do
    %{id: ride.id,
      status: ride.status,
      destinations_status: ride.destinations_status}
  end
end
