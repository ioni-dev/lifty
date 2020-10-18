defmodule Lifty.Repo.Migrations.AddPickup do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE pickup_status AS ENUM ('Ongoing', 'Finished')")

    create table(:pickups, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :status, :pickup_status, default: "Ongoing", null: false
      add :latitude, :float, null: false
      add :longitude, :float, null: false
      add :departed_at, :utc_datetime_usec, null: true
      add :arrived_at, :utc_datetime_usec, null: true

      add :client_id, references(:clients, type: :uuid, column: :id, on_delete: :delete_all), null: false
      add :request_id, references(:requests, type: :uuid, column: :id, on_delete: :delete_all), null: false
      add :driver_id, references(:drivers, type: :uuid, column: :id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
