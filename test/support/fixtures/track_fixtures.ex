defmodule Fithub.TrackFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fithub.Track` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        name: "some name",
        target_area: "some target_area"
      })
      |> Fithub.Track.create_exercise()

    exercise
  end

  @doc """
  Generate a target_area.
  """
  def target_area_fixture(attrs \\ %{}) do
    {:ok, target_area} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Fithub.Track.create_target_area()

    target_area
  end
end
