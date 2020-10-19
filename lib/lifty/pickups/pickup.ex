defmodule Lifty.Pickups.Pickup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pickups" do
    field :arrived_at, :utc_datetime_usec
    field :departed_at, :utc_datetime_usec
    field :latitude, :float
    field :longitude, :float
    field :status, :string
    belongs_to :client, Lifty.Clients.Client
    belongs_to :request, Lifty.Requests.Request
    belongs_to :driver, Lifty.Drivers.Driver
    has_many :ride, Lifty.Rides.Ride
    has_one :log, Lifty.Logs.Log

    timestamps()
  end

  @doc false
  def changeset(pickup, attrs) do
    pickup
    |> cast(attrs, [:status, :latitude, :longitude, :departed_at, :arrived_at])
    |> validate_required([:status, :latitude, :longitude, :departed_at, :arrived_at])
  end
end
