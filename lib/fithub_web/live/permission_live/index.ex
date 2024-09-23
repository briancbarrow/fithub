defmodule FithubWeb.PermissionLive.Index do
  use FithubWeb, :live_view

  alias Fithub.Accounts
  alias Fithub.Accounts.Permission

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :permissions, Accounts.list_permissions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Permission")
    |> assign(:permission, Accounts.get_permission!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Permission")
    |> assign(:permission, %Permission{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Permissions")
    |> assign(:permission, nil)
  end

  @impl true
  def handle_info({FithubWeb.PermissionLive.FormComponent, {:saved, permission}}, socket) do
    {:noreply, stream_insert(socket, :permissions, permission)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    permission = Accounts.get_permission!(id)
    {:ok, _} = Accounts.delete_permission(permission)

    {:noreply, stream_delete(socket, :permissions, permission)}
  end
end
