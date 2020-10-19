defmodule LiftyWeb.LogController do
  use LiftyWeb, :controller

  alias Lifty.Logs
  alias Lifty.Logs.Log

  action_fallback LiftyWeb.FallbackController

  def index(conn, _params) do
    logs = Logs.list_logs()
    render(conn, "index.json", logs: logs)
  end

  def create(conn, %{"log" => log_params}) do
    with {:ok, %Log{} = log} <- Logs.create_log(log_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.log_path(conn, :show, log))
      |> render("show.json", log: log)
    end
  end

  def show(conn, %{"id" => id}) do
    log = Logs.get_log!(id)
    render(conn, "show.json", log: log)
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    log = Logs.get_log!(id)

    with {:ok, %Log{} = log} <- Logs.update_log(log, log_params) do
      render(conn, "show.json", log: log)
    end
  end

  def delete(conn, %{"id" => id}) do
    log = Logs.get_log!(id)

    with {:ok, %Log{}} <- Logs.delete_log(log) do
      send_resp(conn, :no_content, "")
    end
  end
end
