defmodule LiftyWeb.RequestView do
  use LiftyWeb, :view
  alias LiftyWeb.RequestView

  def render("index.json", %{requests: requests}) do
    %{data: render_many(requests, RequestView, "request.json")}
  end

  def render("show.json", %{request: request}) do
    %{data: render_one(request, RequestView, "request.json")}
  end

  def render("request.json", %{request: request}) do
    %{id: request.id,
      status: request.status,
      from_latitude: request.from_latitude,
      from_longitude: request.from_longitude,
      destinations: request.destinations}
  end
end
