defmodule LiftyWeb.LogView do
  use LiftyWeb, :view
  alias LiftyWeb.LogView

  def render("index.json", %{logs: logs}) do
    %{data: render_many(logs, LogView, "log.json")}
  end

  def render("show.json", %{log: log}) do
    %{data: render_one(log, LogView, "log.json")}
  end

  def render("log.json", %{log: log}) do
    %{id: log.id,
      latitude: log.latitude,
      longitude: log.longitude}
  end
end
