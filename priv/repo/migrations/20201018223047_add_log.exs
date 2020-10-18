defmodule Lifty.Repo.Migrations.AddLog do
  use Ecto.Migration
  def change do
    create table(:logs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :pickup_id, references(:pickups, type: :uuid, column: :id, on_delete: :delete_all), null: false
      add :ride_id, references(:rides, type: :uuid, column: :id, on_delete: :delete_all), null: false
      add :latitude, :float, null: false
      add :longitude, :float, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
