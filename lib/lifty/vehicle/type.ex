defmodule Lifty.Vehicle.Type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicle_types" do

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [])
    |> validate_required([])
  end
end
