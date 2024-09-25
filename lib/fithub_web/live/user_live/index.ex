defmodule FithubWeb.UserLive.Index do
  use FithubWeb, :live_view

  alias Fithub.Accounts
  alias Fithub.Repo

  @impl true
  def mount(_params, _session, socket) do
    users =
      Accounts.list_users()
      |> Repo.preload(:role)

    {:ok, stream(socket, :users, users)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket =
      socket
      |> assign(:page_title, "Edit User")
      |> assign(
        :user,
        Accounts.get_user!(id)
        |> Repo.preload(:role)
      )

    socket
  end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New User")
  #   |> assign(:role, %Role{})
  # end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:users, nil)
  end

  @impl true
  def handle_info({FithubWeb.UserLive.FormComponent, {:saved, user}}, socket) do
    {:noreply, stream_insert(socket, :users, user)}
  end

  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   user = Accounts.get_user!(id)
  #   {:ok, _} = Accounts.delete_user(user)

  #   {:noreply, stream_delete(socket, :roles, role)}
  # end
end
