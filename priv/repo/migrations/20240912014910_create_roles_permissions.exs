defmodule Fithub.Repo.Migrations.CreateUserRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end

    create table(:permissions) do
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end

    create table(:role_permissions) do
      add :role_id, references(:roles, on_delete: :delete_all), null: false
      add :permission_id, references(:permissions, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create table(:user_custom_permissions) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :permission_id, references(:permissions, on_delete: :delete_all), null: false
    end
  end
end
