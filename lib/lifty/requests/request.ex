defmodule Lifty.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "requests" do
    embeds_many :destinations, Destinations
    field :from_latitude, :float
    field :from_longitude, :float
    field :status, :string
    belongs_to :client, Lifty.Clients.Client
    has_many :pickup, Lifty.Pickups.Pickup

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:status, :from_latitude, :from_longitude])
    |> validate_required([:status, :from_latitude, :from_longitude, :destinations])
    |> cast_embed(:certifications, required: true)
  end

  defmodule Destinations do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:to_latitude, :to_longitude]}
  embedded_schema do
    field :to_latitude, :float
    field :to_longitude, :float
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:to_latitude, :to_longitude])
  end
end
end
