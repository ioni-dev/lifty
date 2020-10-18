defmodule Lifty.Repo.Migrations.AddRide do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE ride_status AS ENUM ('Ongoing', 'Finished')")

    create table(:rides, primary_key: false) do
       add :id, :uuid, primary_key: true
       add :status, :ride_status, null: false
      #  add :departed_at, :utc_datetime_usec
      #  add :completed_at, :utc_datetime_usec
      #  add :latitude, :float, null: false
      #  add :longitude, :float, null: false
       add :destinations_status, :map, null: false

       add :pickup_id, references(:pickups, type: :uuid, column: :id, on_delete: :delete_all), null: false
       add :driver_id, references(:drivers, type: :uuid, column: :id, on_delete: :delete_all), null: false
       add :client_id, references(:clients, type: :uuid, column: :id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
