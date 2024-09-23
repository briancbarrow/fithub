defmodule FithubWeb.PermissionLive.FormComponent do
  use FithubWeb, :live_component

  alias Fithub.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage permission records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="permission-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Permission</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{permission: permission} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Accounts.change_permission(permission))
     end)}
  end

  @impl true
  def handle_event("validate", %{"permission" => permission_params}, socket) do
    changeset = Accounts.change_permission(socket.assigns.permission, permission_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"permission" => permission_params}, socket) do
    save_permission(socket, socket.assigns.action, permission_params)
  end

  defp save_permission(socket, :edit, permission_params) do
    case Accounts.update_permission(socket.assigns.permission, permission_params) do
      {:ok, permission} ->
        notify_parent({:saved, permission})

        {:noreply,
         socket
         |> put_flash(:info, "Permission updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_permission(socket, :new, permission_params) do
    case Accounts.create_permission(permission_params) do
      {:ok, permission} ->
        notify_parent({:saved, permission})

        {:noreply,
         socket
         |> put_flash(:info, "permission created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
