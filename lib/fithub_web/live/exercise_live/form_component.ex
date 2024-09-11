defmodule FithubWeb.ExerciseLive.FormComponent do
  use FithubWeb, :live_component

  alias Fithub.Track.TargetArea
  alias Fithub.Track.Exercise
  alias Fithub.Track

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage exercise records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="exercise-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.checkgroup
          field={@form[:target_areas]}
          label="Target Areas"
          options={Exercise.target_area_options()}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Exercise</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{exercise: exercise} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Track.change_exercise(exercise))
     end)}
  end

  @impl true
  def handle_event("validate", %{"exercise" => exercise_params}, socket) do
    changeset = Track.change_exercise(socket.assigns.exercise, exercise_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"exercise" => exercise_params}, socket) do
    save_exercise(socket, socket.assigns.action, exercise_params)
  end

  defp save_exercise(socket, :edit, exercise_params) do
    case Track.update_exercise(socket.assigns.exercise, exercise_params) do
      {:ok, exercise} ->
        notify_parent({:saved, exercise})

        {:noreply,
         socket
         |> put_flash(:info, "Exercise updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_exercise(socket, :new, exercise_params) do
    case Track.create_exercise(exercise_params) do
      {:ok, exercise} ->
        notify_parent({:saved, exercise})

        {:noreply,
         socket
         |> put_flash(:info, "Exercise created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
