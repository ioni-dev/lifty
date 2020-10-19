defmodule Lifty.Rides.Ride do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rides" do
    field :status, :string
    embeds_many :destinations_status, DestinationsStatus

    timestamps()
  end

  @doc false
  def changeset(ride, attrs) do
    ride
    |> cast(attrs, [:status, :destinations_status])
    |> validate_required([:status])
    |> cast_embed(:destinations_status, required: true)
  end

  defmodule DestinationsStatus do
    use Ecto.Schema
    import Ecto.Changeset
    @derive {Jason.Encoder, only: [:latitude, :longitude, :departed_at, :completed_at]}

    embedded_schema do
      field :latitude, :float
      field :longitude, :float
      field :departed_at, :utc_datetime_usec
      field :completed_at, :utc_datetime_usec
    end

    def changeset(schema, params) do
      schema
      |> cast(params, [:latitude, :longitude, :departed_at, :completed_at])
    end
  end
end
