defmodule Lifty.Repo.Migrations.AddLog do
  use Ecto.Migration
  def change do
    execute("CREATE TYPE feedback AS ENUM ('Excellent', 'Good', 'Bad service', 'No feedback')")

    create table(:logs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :pickup_id, references(:pickups, type: :uuid, column: :id, on_delete: :delete_all), null: false
      add :ride_id, references(:rides, type: :uuid, column: :id, on_delete: :delete_all), null: false
      add :latitude, :float, null: false
      add :longitude, :float, null: false
      add :rate_shipping, :integer, null: true,  default: 0
      add :client_feedback, :feedback, null: true, default: "No feedback"
      add :commentary, :string, null: true , default: ""

      timestamps(type: :utc_datetime)
    end
  end
end
