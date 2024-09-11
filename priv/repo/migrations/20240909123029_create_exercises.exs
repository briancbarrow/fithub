defmodule Fithub.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string
      add :target_areas, {:array, :string}, default: []
      timestamps(type: :utc_datetime)
    end
  end
end
