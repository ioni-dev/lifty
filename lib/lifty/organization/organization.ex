defmodule Lifty.Organization.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [])
    |> validate_required([])
  end
end
