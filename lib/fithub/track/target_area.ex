defmodule Fithub.Track.TargetArea do
  use Ecto.Schema
  import Ecto.Changeset

  schema "target_areas" do
    field :name, :string
    many_to_many :exercises, Fithub.Track.Exercise, join_through: "exercises_target_areas"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(target_area, attrs) do
    target_area
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
