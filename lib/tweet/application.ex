defmodule Tweet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Tweet.Repo,
      # Start the Telemetry supervisor
      TweetWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tweet.PubSub},
      # Start the Endpoint (http/https)
      TweetWeb.Endpoint
      # Start a worker by calling: Tweet.Worker.start_link(arg)
      # {Tweet.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tweet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TweetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
