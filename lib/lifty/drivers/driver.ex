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
def changeset(driver, attrs) do
  driver
  |> cast(attrs, [:first_name, :last_name, :email, :password, :cellphone, :address, :city, :country, :profile_pic,
    :photos_id, :driver_license, :birthday, :years_of_experience, :email_verified, :active, :last_logged_in,
    :certifications, :emergency_contact, :work_reference, :referred_contact])
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
