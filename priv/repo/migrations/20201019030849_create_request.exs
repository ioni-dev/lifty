defmodule Lifty.Repo.Migrations.CreateRequest do
  use Ecto.Migration

  def change do
    create table(:request, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :from, :string

      timestamps()
    end

  end
end
