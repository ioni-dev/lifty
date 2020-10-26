defmodule Lifty.Repo.Migrations.AddRideRequest do
  use Ecto.Migration

  def change do

    create table(:requests, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :from_latitude, :float
      add :from_longitude, :float
      # add :to_latitude, :float
      # add :to_longitude, :float
      add :destinations, {:array, :map}, null: false, default: []
      add :notes, :string, null: true, default: ""
      add :organization_id, references(:organizations, type: :uuid, column: :id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
