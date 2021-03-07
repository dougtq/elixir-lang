defmodule Graphical.Repo do
  use Ecto.Repo,
    otp_app: :graphical,
    adapter: Ecto.Adapters.Postgres
end
