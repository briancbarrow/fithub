defmodule Fithub.Accounts.Role do
  alias Fithub.Accounts
  alias Fithub.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    field :description, :string
    has_many :users, Fithub.Accounts.User

    many_to_many :permissions, Fithub.Accounts.Permission,
      join_through: Fithub.Accounts.RolePermission,
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    # IO.inspect(attrs, label: "Role changeset attrs")

    role
    |> Repo.preload(:permissions)
    |> cast(attrs, [:name, :description])
    # |> cast_assoc(:permissions, with: &Fithub.Accounts.Permission.changeset/2)
    |> put_assoc(:permissions, fetch_permissions(attrs))
    |> validate_required([:name])
    |> validate_format(:name, ~r/^[a-z]+$/, message: "must be lowercase")
    |> unique_constraint(:name)
  end

  defp fetch_permissions(%{permissions: ids}),
    do: fetch_permissions(%{"permissions" => ids})

  defp fetch_permissions(%{"permissions" => permission_ids}) do
    permissions =
      permission_ids
      |> Enum.reject(&(&1 == ""))
      |> Accounts.get_permissions()

    IO.inspect(permissions, label: "permissions")
    permissions
  end

  defp fetch_permissions(_), do: []
end
