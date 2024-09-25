defmodule FithubWeb.RoleLive.Index do
  use FithubWeb, :live_view

  alias Fithub.Accounts
  alias Fithub.Accounts.Role
  alias Fithub.Repo

  @impl true
  def mount(_params, _session, socket) do
    roles =
      Accounts.list_roles()
      |> Repo.preload(:permissions)

    {:ok, stream(socket, :roles, roles)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket =
      socket
      |> assign(:page_title, "Edit Role")
      |> assign(
        :role,
        Accounts.get_role!(id)
        |> Repo.preload(:permissions)
      )

    socket
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Role")
    |> assign(:role, %Role{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Roles")
    |> assign(:role, nil)
  end

  @impl true
  def handle_info({FithubWeb.RoleLive.FormComponent, {:saved, role}}, socket) do
    {:noreply, stream_insert(socket, :roles, role)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    role = Accounts.get_role!(id)
    {:ok, _} = Accounts.delete_role(role)

    {:noreply, stream_delete(socket, :roles, role)}
  end
end
