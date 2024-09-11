defmodule FithubWeb.ExerciseLive.Index do
  use FithubWeb, :live_view

  alias Fithub.Track
  alias Fithub.Track.Exercise

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :exercises, Track.list_exercises())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Exercise")
    |> assign(:exercise, Track.get_exercise!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Exercise")
    |> assign(:exercise, %Exercise{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Exercises")
    |> assign(:exercise, nil)
  end

  @impl true
  def handle_info({FithubWeb.ExerciseLive.FormComponent, {:saved, exercise}}, socket) do
    {:noreply, stream_insert(socket, :exercises, exercise)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    exercise = Track.get_exercise!(id)
    {:ok, _} = Track.delete_exercise(exercise)

    {:noreply, stream_delete(socket, :exercises, exercise)}
  end
end
