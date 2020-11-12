defmodule Lifty.Drivers.Driver do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lifty.Drivers.Driver
  alias Lifty.Drivers.Driver.Certifications
  alias Lifty.Drivers.Driver.EmergencyContact
  alias Lifty.Drivers.Driver.Permissions
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "drivers" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :cellphone, :string
    field :profile_pic, :string
    field :years_of_experience, :integer
    field :is_active, :boolean
    field :last_logged_in, :utc_datetime
    embeds_many :certifications, Certifications
    embeds_one :emergency_contact, EmergencyContact
    embeds_one :permissions, Permissions
    belongs_to :organization, Lifty.Organizations.Organization, foreign_key: :organization_id, type: :binary_id
    has_many :pickup, Lifty.Pickups.Pickup
    has_many :ride, Lifty.Rides.Ride
    # belongs_to :organization, Lifty.Organizations.Organization

    timestamps(type: :utc_datetime)
  end

    @doc false
def changeset(%Driver{} = driver, attrs) do
  driver
  |> cast(attrs, [:first_name, :last_name, :email, :password, :cellphone, :years_of_experience,
      :is_active, :organization_id])
  |> cast_embed(:certifications, required: false)
  |> cast_embed(:emergency_contact, required: false)
  |> cast_embed(:permissions, required: false)
  |> validate_email()
  # |> validate_required([:permissions])
  |> validate_password()
  |> put_password_hash()
end

# defp put_password_hash(changeset) do
#   case changeset do
#     %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
#       put_change(changeset, :password_hash, Argon2.add_hash(password))
#     _ ->
#       changeset
#   end
# end

defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
  change(changeset, Argon2.add_hash(password))
end

defp put_password_hash(changeset), do: changeset

defmodule Permissions do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:default]}
  embedded_schema do
    field :default, {:array, :string}
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:default])
  end
end

defmodule Certifications do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:title, :path]}
  embedded_schema do
    field :title, :string
    field :path, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:title, :path])
  end
end

defmodule EmergencyContact do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:full_name, :relationship, :phone, :email, :address]}

  embedded_schema do
    field :full_name, :string
    field :relationship, :string
    field :phone, :string
    field :email, :string
    field :address, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:full_name, :relationship, :phone, :email, :address])
  end
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
