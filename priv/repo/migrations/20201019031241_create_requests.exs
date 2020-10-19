defmodule Lifty.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :from_latitude, :float
      add :from_longitude, :float
      add :destinations, {:array, :map}

      timestamps()
    end

  end
end
