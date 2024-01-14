defmodule EasyBills.Repo do
  use Ecto.Repo,
    otp_app: :easy_bills,
    adapter: Ecto.Adapters.Postgres
end
