defmodule HyperliquidUi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {NodeJS.Supervisor, [path: LiveSvelte.SSR.NodeJS.server_path(), pool_size: 4]},
      HyperliquidUiWeb.Telemetry,
      # HyperliquidUi.Repo,
      {DNSCluster, query: Application.get_env(:hyperliquid_ui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HyperliquidUi.PubSub},
      # Start a worker by calling: HyperliquidUi.Worker.start_link(arg)
      # {HyperliquidUi.Worker, arg},
      # Start to serve requests, typically the last entry
      HyperliquidUiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HyperliquidUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HyperliquidUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
