defmodule Lifty.Repo.Migrations.AddRideRequest do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE status AS ENUM ('Searching', 'Ongoing', 'Finished')")

    create table(:requests, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :status, :status, default: "Searching"
      add :from_latitude, :float
      add :from_longitude, :float
      # add :to_latitude, :float
      # add :to_longitude, :float
      add :destinations, :map, null: false
      add :client_id, references(:clients, type: :uuid, column: :id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
