defmodule Fithub.Accounts.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
    field :name, :string
    field :description, :string
    many_to_many :users, Fithub.Accounts.User, join_through: "user_permissions"
    many_to_many :roles, Fithub.Accounts.Role, join_through: "role_permissions"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
