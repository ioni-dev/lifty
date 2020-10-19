defmodule Lifty.Clients.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lifty.Clients.Client.Permissions


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients" do
    field :birthday, :date
    field :cellphone, :string
    field :city, :string
    field :confirmed_at, :naive_datetime
    field :country, :string
    field :delivery_destination, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    embeds_one :permissions_type, Permissions
    has_many :request, Lifty.Requests.Request
    has_many :pickup, Lifty.Pickups.Pickup
    has_many :ride, Lifty.Rides.Ride

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:email, :name, :first_name, :last_name, :cellphone, :birthday, :city, :country, :password, :confirmed_at, :delivery_destination])
    |> validate_required([:email, :name, :first_name, :last_name, :cellphone, :birthday, :city, :country, :password, :confirmed_at, :delivery_destination])
    |> validate_email()
    |> validate_password()
    |> cast_embed(:permissions_type, required: false)
    |> put_password_hash()
  end

  defmodule Permissions do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :default, {:array, :string}
    end

    def changeset(schema, params) do
      schema
      |> cast(params, [:default])
    end
  end

  defp put_password_hash(
            %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
          ) do
       change(changeset, Argon2.add_hash(password))
   end

  defp put_password_hash(changeset) do
    changeset
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, Lifty.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 80)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    # |> prepare_changes(&hash_password/1)
    # |> put_password_hash()
  end


  @doc """
  A driver changeset for changing the email.
  It requires the email to change otherwise an error is added.
  """
  def email_changeset(driver, attrs) do
    driver
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A driver changeset for changing the password.
  """
  def password_changeset(driver, attrs) do
    driver
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password()
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(driver) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(driver, confirmed_at: now)
  end

end
