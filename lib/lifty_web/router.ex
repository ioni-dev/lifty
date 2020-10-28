defmodule LiftyWeb.Router do
  use LiftyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
     plug CORSPlug, origin: "http://localhost:3000"
    plug :accepts, ["json"]
  end

  scope "/", LiftyWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  pipeline :authenticated do
    plug LiftyWeb.Plug.AuthAccessPipeline
  end

  # Other scopes may use custom stacks.
  scope "/api", LiftyWeb do
    pipe_through :api
     scope "/auth" do
      post "/identity/callback", AuthenticationController, :identity_callback
    end
      options   "/organizations", OrganizationController, :options
      resources "/organizations", OrganizationController, except: [:new, :edit]


    # with this line ensure that unautorize user cannot access
    pipe_through :authenticated
      resources "/drivers", DriverController, except: [:new, :edit]
      resources "/clients", ClientController, except: [:new, :edit]
      resources "/requests", RequestController, except: [:new, :edit]
      resources "/pickups", PickupController, except: [:new, :edit]
      resources "/rides", RideController, except: [:new, :edit]
      resources "/logs", LogController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: LiftyWeb.Telemetry
    end
  end

end
