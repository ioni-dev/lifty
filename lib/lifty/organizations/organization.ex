defmodule Lifty.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lifty.Organizations.Organization
  alias Lifty.Drivers.Driver.Permissions

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    field :cellphone, :string
    field :full_name, :string
    field :confirmed_at, :naive_datetime
    field :country, :string
    field :email, :string
    field :is_active, :boolean, default: false
    field :vehicule_quantity, :integer
    field :organization_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :taxpayer_id, :string
    field :website, :string
    embeds_one :permissions, Permissions
    has_many :drivers, Lifty.Drivers.Driver
    timestamps()
  end

  @doc false
  def changeset(%Organization{} = organization, attrs) do
    organization
    |> cast(attrs, [:email, :password, :full_name, :confirmed_at, :organization_name, :country, :cellphone, :vehicule_quantity, :is_active, :role])
    |> validate_required([:email, :password, :confirmed_at, :organization_name, :full_name, :country, :cellphone, :vehicule_quantity, :is_active, :role])
    |> cast_embed(:permissions, required: false)
    |> validate_email()
    # |> validate_required([:permissions])
    |> validate_password()
    |> put_password_hash()
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
end
