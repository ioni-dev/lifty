defmodule Lifty.Repo do
  use Ecto.Repo,
    otp_app: :lifty,
    adapter: Ecto.Adapters.Postgres
end
