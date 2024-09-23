defmodule Fithub.Accounts.Permission do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias Fithub.Repo

  schema "permissions" do
    field :name, :string
    field :description, :string
    many_to_many :users, Fithub.Accounts.User, join_through: "user_permissions"
    many_to_many :roles, Fithub.Accounts.Role, join_through: Fithub.Accounts.RolePermission

    timestamps(type: :utc_datetime)
  end

  def get_valid_permissions do
    Repo.all(from p in __MODULE__, select: p.id)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def map_permission_data(permission) do
    %{
      "id" => permission.id,
      "name" => permission.name,
      "description" => permission.description
    }
  end
end
