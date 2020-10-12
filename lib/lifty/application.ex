defmodule Lifty.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Lifty.Repo,
      # Start the Telemetry supervisor
      LiftyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lifty.PubSub},
      # Start the Endpoint (http/https)
      LiftyWeb.Endpoint
      # Start a worker by calling: Lifty.Worker.start_link(arg)
      # {Lifty.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lifty.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiftyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
