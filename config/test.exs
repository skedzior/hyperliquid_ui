import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :hyperliquid_ui, HyperliquidUi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hyperliquid_ui_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hyperliquid_ui, HyperliquidUiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "fGJZgxr4ovjV9sj2K/HpzG2BhZ9mXZPMEU9XYS+rm+yZDx/5gO/eDN+bAW7AFq2r",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
