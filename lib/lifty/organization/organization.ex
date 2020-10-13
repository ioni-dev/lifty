defmodule Lifty.Organization.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    field :confirmed_at, :naive_datetime
    field :name, :string
    field :taxpayer_id, :string
    field :country, :string
    field :cellphone, :string
    field :montly_deliveries, :integer
    field :website, :string
    field :is_active, :boolean
    field :address, :string
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:email, :is_active, :password, :name, :taxpayer_id, :cellphone, :country, :montly_deliveries, :country, :confirmed_at, :website, :address])
    |> unique_constraint(:email)
    |> validate_required([])
    |> put_password_hash()
  end

  defp put_password_hash(
      %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
    ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
