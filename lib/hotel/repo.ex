defmodule Hotel.Repo do
  use Ecto.Repo,
    otp_app: :hotel,
    adapter: Ecto.Adapters.Postgres
end
