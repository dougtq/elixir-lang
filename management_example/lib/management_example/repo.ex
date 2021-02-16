defmodule ManagementExample.Repo do
  use Ecto.Repo,
    otp_app: :management_example,
    adapter: Ecto.Adapters.Postgres
end
