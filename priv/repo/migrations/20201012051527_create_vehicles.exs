defmodule Lifty.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE vehicle_type AS ENUM ('Motorcycle', 'Sport utility truck', 'Pickup truck', 'Panel van truck', 'Tow truck', 'Box truck',
    'Van', 'Cutaway van', 'Semi-trailer truck', 'Other')")

    # execute("CREATE TYPE bodywork AS ENUM ('Container', 'Closed', 'Open', 'Refrigerated', 'Sliding Canvas', 'Tippers',
    # 'Livestock transport', 'Cutaway van', 'Flatbed truck', 'Stake bed truck')")

    # execute("CREATE TYPE payload_type AS ENUM ('Pharmaceutical and/or Surgical', 'Dangerous substances or Dangerous waste', 'Food products', 'General')")

    # execute("CREATE TYPE operation_type AS ENUM ('Local', 'First mile', 'Last mile', 'Metropolitan', 'National')")

    create table(:vehicles, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false, default: ""
      add :type, :vehicle_type, null: false, default: "Other"
      add :body_frame, :string, null: false, default: ""
      add :plate, :string, null: false, default: ""
      add :tag, :string, null: true, default: ""
      # add :operation_type, :operation_type, null: false
      add :origin_addres, :string, null: false, default: ""
      add :work_schedule, :map, null: true, default: %{}
      add :operational_cost, :string, null: true, default: ""
      add :min_payload, :string, null: false, default: ""
      add :max_payload, :string, null: false, default: ""

      timestamps(type: :utc_datetime)
    end

  end
end
