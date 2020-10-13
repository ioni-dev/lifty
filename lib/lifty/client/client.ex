defmodule Lifty.Client.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :email, :string
    field :name, :string
    field :first_name, :string
    field :last_name, :string
    field :cellphone, :string
    field :birthday, :date
    field :city, :string
    field :country, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime
    field :delivery_destination, :string
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:email, :is_active, :password, :first_name, :last_name, :cellphone, :birthday, :city, :country, :confirmed_at, :delivery_destination])
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
