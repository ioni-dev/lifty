defmodule Lifty.Repo.Migrations.CreateDrivers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""
    create table(:drivers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :first_name, :string, size: 40, null: false
      add :last_name, :string, size: 40, null: false
      add :email, :citext, null: true, default: ""
      add :password_hash, :string
      add :cellphone, :string, null: false
      add :profile_pic, :string, null: true, default: ""
      add :years_of_experience, :integer, null: false
      add :active, :boolean, null: false, default: true
      add :last_logged_in, :utc_datetime, [null: false, default: fragment("current_date")]
      add :certifications, {:array, :map}, null: true, default: []
      add :emergency_contact, :map, null: true, default: %{}
      add :permissions, :map, default: %{}

      timestamps(type: :utc_datetime)
    end

    create unique_index(:drivers, [:cellphone])
  end
end
