defmodule Lifty.Repo.Migrations.CreatePickups do
  use Ecto.Migration

  def change do
    create table(:pickups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :latitude, :float
      add :longitude, :float
      add :departed_at, :utc_datetime_usec
      add :arrived_at, :utc_datetime_usec

      timestamps()
    end

  end
end
