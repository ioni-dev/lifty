defmodule Lifty.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""
    execute("CREATE TYPE role_type AS ENUM ('Super Admin', 'Admin', 'Planner')")
    create table(:organizations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :citext, null: false, default: ""
      add :full_name, :string, null: false, default: ""
      add :password_hash, :string, null: false
      add :confirmed_at, :naive_datetime
      add :organization_name, :string, null: false
      add :country, :string, null: false, default: ""
      add :cellphone, :string, null: false, default: ""
      add :vehicule_quantity, :integer, null: false, default: 0
      add :is_active, :boolean, default: false,  default: false
      add :email_confirmed, :boolean, null: false, default: false
      add :role, :role_type, null: false, default: "Super Admin"
      add :permissions, :map, default: %{}
      timestamps(type: :utc_datetime)
    end

    create unique_index(:organizations, [:email])

    alter table(:drivers) do
      add :organization_id, references(:organizations, type: :uuid, column: :id, on_delete: :delete_all), null: true
    end

    alter table(:vehicles) do
      add :organization_id, references(:organizations, type: :uuid, column: :id, on_delete: :delete_all), null: false
      add :driver_id, references(:drivers, type: :uuid, column: :id, on_delete: :delete_all), null: false

    end

  end
end
