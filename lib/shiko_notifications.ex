defmodule ShikoNotifications do
  @moduledoc """
  Elixir SDK for the [shiko.vet](https://shiko.vet) notification service.

  Multi-channel notifications: email, SMS, WhatsApp, push, and Telegram.

  ## Setup

      # mix.exs
      {:shiko_notifications, "~> 0.1"}

      # config/config.exs
      config :my_app, :shiko_notifications,
        api_url: "https://notifications.shiko.vet/api/v1",
        client_id: "your_client_id",
        client_secret: "your_client_secret"

  ## Usage

      client = ShikoNotifications.client(:my_app, :shiko_notifications)

      # Send a single notification
      {:ok, response} = ShikoNotifications.send(client, %{
        channel: "email",
        recipient: "user@example.com",
        template_slug: "welcome_email",
        template_data: %{name: "John"}
      })

      # Bulk send
      {:ok, job} = ShikoNotifications.send_bulk(client, %{
        channel: "email",
        template_slug: "promo",
        recipients: [
          %{recipient: "a@test.com", template_data: %{name: "Ana"}},
          %{recipient: "b@test.com", template_data: %{name: "Bob"}}
        ]
      })

  ## Contact

  - Website: [shiko.vet](https://shiko.vet)
  - Support: tech@shiko.vet
  """

  alias ShikoNotifications.Client

  @doc "Build a client from application config."
  defdelegate client(app, key), to: Client, as: :from_config

  @doc "Build a client manually."
  defdelegate client(api_url, client_id, client_secret), to: Client, as: :new

  @doc "Send a single notification."
  defdelegate send(client, params), to: Client

  @doc "Send bulk notifications (up to 10,000 recipients)."
  defdelegate send_bulk(client, params), to: Client

  @doc "Get notification delivery status."
  defdelegate get_status(client, notification_id), to: Client

  @doc "Get bulk job progress."
  defdelegate get_bulk_status(client, bulk_job_id), to: Client

  @doc "List notifications with optional filters."
  defdelegate list_notifications(client, params \\ %{}), to: Client

  @doc "Get analytics data."
  defdelegate get_analytics(client, endpoint, params \\ %{}), to: Client
end
