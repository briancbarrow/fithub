defmodule Fithub.Accounts.UserCustomPermission do
  use Ecto.Schema

  schema "user_custom_permissions" do
    belongs_to :user, Fithub.Accounts.User
    belongs_to :permission, Fithub.Accounts.Permission

    timestamps(type: :utc_datetime)
  end
end
