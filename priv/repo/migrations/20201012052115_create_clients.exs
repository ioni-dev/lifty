defmodule Lifty.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:clients, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :citext, null: true, default: ""
      add :name, :string, null: true, default: ""
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :contact_number, :string, null: true, default: ""
      add :address, :string, null: false
      add :is_active, :boolean, default: true

      timestamps(type: :utc_datetime)
    end

    create unique_index(:clients, [:email])
  end
end
