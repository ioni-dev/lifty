defmodule LiftyWeb.PageController do
  use LiftyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
