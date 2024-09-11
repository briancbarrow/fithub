defmodule FithubWeb.TargetAreaLive.Index do
  use FithubWeb, :live_view

  alias Fithub.Track
  alias Fithub.Track.TargetArea

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :target_areas, Track.list_target_areas())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Target area")
    |> assign(:target_area, Track.get_target_area!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Target area")
    |> assign(:target_area, %TargetArea{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Target areas")
    |> assign(:target_area, nil)
  end

  @impl true
  def handle_info({FithubWeb.TargetAreaLive.FormComponent, {:saved, target_area}}, socket) do
    {:noreply, stream_insert(socket, :target_areas, target_area)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    target_area = Track.get_target_area!(id)
    {:ok, _} = Track.delete_target_area(target_area)

    {:noreply, stream_delete(socket, :target_areas, target_area)}
  end
end
