defmodule FithubWeb.TargetAreaLive.FormComponent do
  use FithubWeb, :live_component

  alias Fithub.Track

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage target_area records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="target_area-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Target area</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{target_area: target_area} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Track.change_target_area(target_area))
     end)}
  end

  @impl true
  def handle_event("validate", %{"target_area" => target_area_params}, socket) do
    changeset = Track.change_target_area(socket.assigns.target_area, target_area_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"target_area" => target_area_params}, socket) do
    save_target_area(socket, socket.assigns.action, target_area_params)
  end

  defp save_target_area(socket, :edit, target_area_params) do
    case Track.update_target_area(socket.assigns.target_area, target_area_params) do
      {:ok, target_area} ->
        notify_parent({:saved, target_area})

        {:noreply,
         socket
         |> put_flash(:info, "Target area updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_target_area(socket, :new, target_area_params) do
    case Track.create_target_area(target_area_params) do
      {:ok, target_area} ->
        notify_parent({:saved, target_area})

        {:noreply,
         socket
         |> put_flash(:info, "Target area created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
