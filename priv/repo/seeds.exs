# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fithub.Repo.insert!(%Fithub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Fithub.Accounts.Permission
alias Fithub.Accounts.User
alias Fithub.Accounts.Role
alias Fithub.Accounts.RolePermission
alias Fithub.Accounts.UserCustomPermission
alias Fithub.Repo

# %Permission{}
# |> Permission.changeset(%{name: "superadmin", description: "Access to all resources and methods."})
# |> Repo.insert!()
#
