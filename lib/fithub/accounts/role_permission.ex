defmodule Fithub.Accounts.RolePermission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "role_permissions" do
    belongs_to :role, Fithub.Accounts.Role, primary_key: true
    belongs_to :permission, Fithub.Accounts.Permission, primary_key: true

    timestamps(type: :utc_datetime)
  end

  # def changeset(role_permission, attrs) do
  #   role_permission
  #   |> cast(attrs, [:role_id, :permission_id])
  #   |> unique_constraint([:role, :permission],
  #     name: "role_permissions_role_id_permission_id_index"
  #   )
  # end
end
