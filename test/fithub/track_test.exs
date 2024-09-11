defmodule Fithub.TrackTest do
  use Fithub.DataCase

  alias Fithub.Track

  describe "exercises" do
    alias Fithub.Track.Exercise

    import Fithub.TrackFixtures

    @invalid_attrs %{name: nil, target_area: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert Track.list_exercises() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert Track.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{name: "some name", target_area: "some target_area"}

      assert {:ok, %Exercise{} = exercise} = Track.create_exercise(valid_attrs)
      assert exercise.name == "some name"
      assert exercise.target_area == "some target_area"
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{name: "some updated name", target_area: "some updated target_area"}

      assert {:ok, %Exercise{} = exercise} = Track.update_exercise(exercise, update_attrs)
      assert exercise.name == "some updated name"
      assert exercise.target_area == "some updated target_area"
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_exercise(exercise, @invalid_attrs)
      assert exercise == Track.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = Track.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> Track.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = Track.change_exercise(exercise)
    end
  end

  describe "target_areas" do
    alias Fithub.Track.TargetArea

    import Fithub.TrackFixtures

    @invalid_attrs %{name: nil}

    test "list_target_areas/0 returns all target_areas" do
      target_area = target_area_fixture()
      assert Track.list_target_areas() == [target_area]
    end

    test "get_target_area!/1 returns the target_area with given id" do
      target_area = target_area_fixture()
      assert Track.get_target_area!(target_area.id) == target_area
    end

    test "create_target_area/1 with valid data creates a target_area" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %TargetArea{} = target_area} = Track.create_target_area(valid_attrs)
      assert target_area.name == "some name"
    end

    test "create_target_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_target_area(@invalid_attrs)
    end

    test "update_target_area/2 with valid data updates the target_area" do
      target_area = target_area_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %TargetArea{} = target_area} = Track.update_target_area(target_area, update_attrs)
      assert target_area.name == "some updated name"
    end

    test "update_target_area/2 with invalid data returns error changeset" do
      target_area = target_area_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_target_area(target_area, @invalid_attrs)
      assert target_area == Track.get_target_area!(target_area.id)
    end

    test "delete_target_area/1 deletes the target_area" do
      target_area = target_area_fixture()
      assert {:ok, %TargetArea{}} = Track.delete_target_area(target_area)
      assert_raise Ecto.NoResultsError, fn -> Track.get_target_area!(target_area.id) end
    end

    test "change_target_area/1 returns a target_area changeset" do
      target_area = target_area_fixture()
      assert %Ecto.Changeset{} = Track.change_target_area(target_area)
    end
  end
end
