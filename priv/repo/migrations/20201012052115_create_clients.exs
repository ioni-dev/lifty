defmodule Lifty.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:clients, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :email, :citext, null: false
      add :name, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :cellphone, :string, null: false
      add :birthday, :date, null: false
      add :city, :string, null: false
      add :country, :string, null: false
      add :hashed_password, :string, null: false
      add :is_active, :boolean, default: false
      add :confirmed_at, :naive_datetime
      add :delivery_destination, :string
      timestamps(type: :utc_datetime)
    end

    create unique_index(:clients, [:email])
  end
end
