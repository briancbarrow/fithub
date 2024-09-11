defmodule Fithub.Track do
  @moduledoc """
  The Track context.
  """

  import Ecto.Query, warn: false
  alias Fithub.Repo

  alias Fithub.Track.Exercise

  @doc """
  Returns the list of exercises.

  ## Examples

      iex> list_exercises()
      [%Exercise{}, ...]

  """
  def list_exercises do
    Repo.all(Exercise)
    # |> Repo.preload(:target_areas)
  end

  @doc """
  Gets a single exercise.

  Raises `Ecto.NoResultsError` if the Exercise does not exist.

  ## Examples

      iex> get_exercise!(123)
      %Exercise{}

      iex> get_exercise!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exercise!(id) do
    Repo.get!(Exercise, id)
    # |> Repo.preload(:target_areas)
  end

  @doc """
  Creates a exercise.

  ## Examples

      iex> create_exercise(%{field: value})
      {:ok, %Exercise{}}

      iex> create_exercise(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exercise(attrs \\ %{}) do
    %Exercise{}
    |> Exercise.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a exercise.

  ## Examples

      iex> update_exercise(exercise, %{field: new_value})
      {:ok, %Exercise{}}

      iex> update_exercise(exercise, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exercise(%Exercise{} = exercise, attrs) do
    exercise
    |> Exercise.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a exercise.

  ## Examples

      iex> delete_exercise(exercise)
      {:ok, %Exercise{}}

      iex> delete_exercise(exercise)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exercise(%Exercise{} = exercise) do
    Repo.delete(exercise)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exercise changes.

  ## Examples

      iex> change_exercise(exercise)
      %Ecto.Changeset{data: %Exercise{}}

  """
  def change_exercise(%Exercise{} = exercise, attrs \\ %{}) do
    Exercise.changeset(exercise, attrs)
  end

  alias Fithub.Track.TargetArea

  @doc """
  Returns the list of target_areas.

  ## Examples

      iex> list_target_areas()
      [%TargetArea{}, ...]

  """
  def list_target_areas do
    Repo.all(TargetArea)
  end

  @doc """
  Gets a single target_area.

  Raises `Ecto.NoResultsError` if the Target area does not exist.

  ## Examples

      iex> get_target_area!(123)
      %TargetArea{}

      iex> get_target_area!(456)
      ** (Ecto.NoResultsError)

  """
  def get_target_area!(id), do: Repo.get!(TargetArea, id)

  @doc """
  Creates a target_area.

  ## Examples

      iex> create_target_area(%{field: value})
      {:ok, %TargetArea{}}

      iex> create_target_area(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_target_area(attrs \\ %{}) do
    %TargetArea{}
    |> TargetArea.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a target_area.

  ## Examples

      iex> update_target_area(target_area, %{field: new_value})
      {:ok, %TargetArea{}}

      iex> update_target_area(target_area, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_target_area(%TargetArea{} = target_area, attrs) do
    target_area
    |> TargetArea.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a target_area.

  ## Examples

      iex> delete_target_area(target_area)
      {:ok, %TargetArea{}}

      iex> delete_target_area(target_area)
      {:error, %Ecto.Changeset{}}

  """
  def delete_target_area(%TargetArea{} = target_area) do
    Repo.delete(target_area)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking target_area changes.

  ## Examples

      iex> change_target_area(target_area)
      %Ecto.Changeset{data: %TargetArea{}}

  """
  def change_target_area(%TargetArea{} = target_area, attrs \\ %{}) do
    TargetArea.changeset(target_area, attrs)
  end
end
