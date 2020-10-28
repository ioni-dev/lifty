defmodule Lifty.Clients.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lifty.Clients.Client.Permissions


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients" do
    field :contact_number, :string
    field :address, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :company_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :is_active, :boolean
    embeds_one :permissions_type, Permissions
    has_many :request, Lifty.Requests.Request
    has_many :pickup, Lifty.Pickups.Pickup
    has_many :ride, Lifty.Rides.Ride

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:contact_number, :address, :email, :first_name, :last_name, :company_name, :password, :is_active])
    |> validate_required([:contact_number, :address, :email, :first_name, :last_name, :company_name, :password, :is_active])
  end
end
