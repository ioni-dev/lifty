defmodule Lifty.Drivers.Driver do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lifty.Drivers.Driver
  alias Lifty.Drivers.Driver.ReferredContact
  alias Lifty.Drivers.Driver.WorkReference
  alias Lifty.Drivers.Driver.Certifications
  alias Lifty.Drivers.Driver.DriverLicense
  alias Lifty.Drivers.Driver.EmergencyContact
  alias Lifty.Drivers.Driver.DriverLicense
  alias Lifty.Drivers.Driver.EmergencyContact
  alias Lifty.Drivers.Driver.PhotosId
  alias Lifty.Drivers.Driver.Permissions
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "drivers" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :cellphone, :string
    field :address, :string
    field :city, :string
    field :country, :string
    field :profile_pic, :string
    embeds_one :photos_id, PhotosId
    embeds_one :driver_license, DriverLicense
    field :date_of_birth, :date
    field :years_of_experience, :integer
    field :ways_of_reference, :string
    field :email_verified, :boolean , default: false
    field :active, :boolean , default: true
    field :last_logged_in, :utc_datetime
    embeds_many :certifications, Certifications
    embeds_one :emergency_contact, EmergencyContact
    embeds_many :work_reference, WorkReference
    embeds_many :referred_contact, ReferredContact
    embeds_one :permissions_type, Permissions
    belongs_to :organization, Lifty.Organizations.Organization, foreign_key: :organization_id, type: :binary_id

    timestamps(type: :utc_datetime)
  end

    @doc false
def changeset(%Driver{} = driver, attrs) do
  driver
  |> cast(attrs, [:first_name, :last_name, :email, :password, :cellphone, :address, :city, :country, :profile_pic,
    :date_of_birth, :years_of_experience, :ways_of_reference, :email_verified, :active, :last_logged_in, :organization_id])
  |> cast_embed(:photos_id, required: true)
  |> cast_embed(:driver_license, required: true)
  |> cast_embed(:certifications, required: true)
  |> cast_embed(:emergency_contact, required: true)
  |> cast_embed(:work_reference, required: true)
  |> cast_embed(:referred_contact, required: true)
  |> cast_embed(:permissions_type, required: false)
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

  embedded_schema do
    field :title, :string
    field :path, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:title, :path])
  end
end

defmodule WorkReference do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :full_name, :string
    field :phone, :string
    field :relation, :string
    field :note, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:full_name, :phone, :relation, :note])
  end
end

defmodule ReferredContact do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :full_name, :string
    field :email, :string
    field :phone, :string
    field :relation, :string
    field :role, :string
    field :note, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:full_name, :email, :phone, :relation, :role, :note])
  end
end

defmodule PhotosId do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :front_path, :string
    field :back_path, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:front_path, :back_path])
  end
end

defmodule DriverLicense do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :front_path, :string
    field :back_path, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:front_path, :back_path])
  end
end

defmodule EmergencyContact do
  use Ecto.Schema
  import Ecto.Changeset

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
