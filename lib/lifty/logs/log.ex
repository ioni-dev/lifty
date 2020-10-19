defmodule Lifty.Logs.Log do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "logs" do
    field :latitude, :float
    field :longitude, :float
    belongs_to :pickup, Lifty.Pickups.Pickup
    belongs_to :ride, Lifty.Rides.Ride

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:latitude, :longitude])
    |> validate_required([:latitude, :longitude])
  end
end
