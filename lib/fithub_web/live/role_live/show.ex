defmodule FithubWeb.RoleLive.Show do
  use FithubWeb, :live_view

  alias Fithub.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    # target_areas = Track.list_target_areas()
    role = Accounts.get_role!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:role, role)}
  end

  defp page_title(:show), do: "Show Role"
  defp page_title(:edit), do: "Edit Role"
end
