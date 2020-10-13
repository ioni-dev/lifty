defmodule Lifty.Drivers.Driver do
  use Ecto.Schema
  import Ecto.Changeset


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
    field :birthday, :date
    field :years_of_experience, :integer
    field :ways_of_reference, :string
    field :email_verified, :boolean , default: false
    field :active, :boolean , default: true
    field :last_logged_in, :utc_datetime
    embeds_many :certifications, Certifications
    embeds_one :emergency_contact, EmergencyContact
    embeds_many :work_reference, WorkReference
    embeds_many :referred_contact, ReferredContact
    timestamps(type: :utc_datetime)
  end

    @doc false
def registration_changeset(driver, attrs) do
  driver
  |> cast(attrs, [:first_name, :last_name, :email, :password, :cellphone, :address, :city, :country, :profile_pic,
    :photos_id, :driver_license, :birthday, :years_of_experience, :email_verified, :active, :last_logged_in,
    :certifications, :emergency_contact, :work_reference, :referred_contact])
  |> validate_email()
  |> validate_password()
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
  |> put_password_hash()
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

@doc """
Verifies the password.
If there is no driver or the driver doesn't have a password, we call
`Bcrypt.no_user_verify/0` to avoid timing attacks.
"""
# def valid_password?(%Mon.Accounts.driver{hashed_password: hashed_password}, password)
#     when is_binary(hashed_password) and byte_size(password) > 0 do
#   Bcrypt.verify_pass(password, hashed_password)
# end

# def valid_password?(_, _) do
#   Bcrypt.no_user_verify()
#   false
# end

# # @doc """
# # Validates the current password otherwise adds an error to the changeset.
# # """
#   def validate_current_password(changeset, password) do
#     if valid_password?(changeset.data, password) do
#       changeset
#     else
#       add_error(changeset, :current_password, "is not valid")
#     end
#   end
# end
end
