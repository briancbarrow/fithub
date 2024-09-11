defmodule FithubWeb.ExerciseLive.Show do
  use FithubWeb, :live_view

  alias Fithub.Track
  alias Fithub.Track.Exercise

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    # target_areas = Track.list_target_areas()
    exercise = Track.get_exercise!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:target_area_labels, Exercise.get_target_area_labels(exercise.target_areas))
     |> assign(:exercise, exercise)}
  end

  defp page_title(:show), do: "Show Exercise"
  defp page_title(:edit), do: "Edit Exercise"
end
