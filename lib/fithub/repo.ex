defmodule Fithub.Repo do
  use Ecto.Repo,
    otp_app: :fithub,
    adapter: Ecto.Adapters.Postgres
end
