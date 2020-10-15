defmodule Lifty.Repo.Migrations.CreateDrivers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""
    execute("CREATE TYPE references_type AS ENUM ('Facebook', 'Referred', 'Instagram')")
    create table(:drivers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :first_name, :string, size: 40, null: false
      add :last_name, :string, size: 40, null: false
      add :email, :citext, null: false
      add :password_hash, :string
      add :cellphone, :string, null: false
      add :address, :string, null: false
      add :city, :string, null: false
      add :country, :string, null: false
      add :profile_pic, :string, null: false
      add :photos_id, :map, null: false, default: %{}
      add :driver_license, :map, null: false, default: %{}
      add :date_of_birth, :date, null: false
      add :years_of_experience, :integer, null: false
      add :ways_of_reference, :references_type , null: false
      add :email_verified, :boolean, null: false, default: false
      add :active, :boolean, null: false, default: true
      add :last_logged_in, :utc_datetime, [null: false, default: fragment("current_date")]
      add :certifications, {:array, :map}, null: false, default: []
      add :emergency_contact, :map, null: false, default: %{}
      add :work_reference, {:array, :map}, null: false, default: []
      add :referred_contact, {:array, :map}, null: false, default: []
      add :permissions_type, :map, default: %{}
      timestamps(type: :utc_datetime)
    end

    create unique_index(:drivers, [:email])
  end
end
