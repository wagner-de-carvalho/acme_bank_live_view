defmodule AcmeBankLiveView.Repo do
  use Ecto.Repo,
    otp_app: :acme_bank_live_view,
    adapter: Ecto.Adapters.Postgres
end
