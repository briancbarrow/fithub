defmodule Fithub.Track.Exercise do
  use Ecto.Schema
  import Ecto.Query, warn: false
  import Ecto.Changeset
  import Fithub.ChangesetHelpers

  schema "exercises" do
    field :name, :string
    field :target_areas, {:array, :string}, default: []

    timestamps(type: :utc_datetime)
  end

  @target_area_options [
    {"Arms", "arms"},
    {"Back", "back"},
    {"Chest", "chest"},
    {"Core", "core"},
    {"Legs", "legs"}
  ]

  @valid_areas Enum.map(@target_area_options, fn {_text, val} -> val end)

  def target_area_options, do: @target_area_options

  def get_target_area_labels(values) do
    values
    |> Enum.map(&find_label/1)
    |> Enum.join(", ")
  end

  defp find_label(value) do
    Enum.find_value(@target_area_options, fn {label, val} ->
      if val == value, do: label
    end)
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :target_areas])
    |> validate_required([:name, :target_areas])
    |> clean_and_validate_array(:target_areas, @valid_areas)

    # |> validate_length(:target_areas, min: 1)
  end
end
