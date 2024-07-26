defmodule EasyBills.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Oban.Telemetry.attach_default_logger(encode: false, level: :debug)

    children = [
      # Start the Telemetry supervisor
      EasyBillsWeb.Telemetry,
      # Start the Ecto repository
      EasyBills.Repo,
      {Oban, Application.fetch_env!(:easy_bills, Oban)},
      # Start the PubSub system
      {Phoenix.PubSub, name: EasyBills.PubSub},
      # Start Finch
      {Finch, name: EasyBills.Finch},
      # Start the Endpoint (http/https)
      EasyBillsWeb.Endpoint
      # Start a worker by calling: EasyBills.Worker.start_link(arg)
      # {EasyBills.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EasyBills.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EasyBillsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
