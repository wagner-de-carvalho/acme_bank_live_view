defmodule AcmeBankLiveView.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AcmeBankLiveViewWeb.Telemetry,
      AcmeBankLiveView.Repo,
      {DNSCluster, query: Application.get_env(:acme_bank_live_view, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AcmeBankLiveView.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AcmeBankLiveView.Finch},
      # Start a worker by calling: AcmeBankLiveView.Worker.start_link(arg)
      # {AcmeBankLiveView.Worker, arg},
      # Start to serve requests, typically the last entry
      AcmeBankLiveViewWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AcmeBankLiveView.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AcmeBankLiveViewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
