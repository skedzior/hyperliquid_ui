defmodule HyperliquidUi.Repo do
  use Ecto.Repo,
    otp_app: :hyperliquid_ui,
    adapter: Ecto.Adapters.Postgres
end
