defmodule Fithub.Accounts.RolePermission do
  use Ecto.Schema

  schema "role_permissions" do
    belongs_to :role, Fithub.Accounts.Role
    belongs_to :permission, Fithub.Accounts.Permission

    timestamps(type: :utc_datetime)
  end
end
