defmodule FithubWeb.PermissionLive.Show do
  use FithubWeb, :live_view

  alias Fithub.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    # target_areas = Track.list_target_areas()
    permission = Accounts.get_permission!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:permission, permission)}
  end

  defp page_title(:show), do: "Show Permission"
  defp page_title(:edit), do: "Edit Permission"
end
