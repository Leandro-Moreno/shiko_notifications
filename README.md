# ShikoNotifications

Elixir SDK for the [shiko.vet](https://shiko.vet) multi-channel notification service.

Send **email**, **SMS**, **WhatsApp**, **push**, and **Telegram** notifications through a single API.

## Installation

```elixir
def deps do
  [
    {:shiko_notifications, "~> 0.1"}
  ]
end
```

## Configuration

```elixir
# config/config.exs
config :my_app, :shiko_notifications,
  api_url: "https://notifications.shiko.vet/api/v1",
  client_id: "your_client_id",
  client_secret: "your_client_secret"
```

## Usage

```elixir
# Build client from config
client = ShikoNotifications.client(:my_app, :shiko_notifications)

# Or build manually
client = ShikoNotifications.client(
  "https://notifications.shiko.vet/api/v1",
  "client_id",
  "client_secret"
)

# Send email
{:ok, response} = ShikoNotifications.send(client, %{
  channel: "email",
  recipient: "user@example.com",
  template_slug: "welcome_email",
  template_data: %{name: "John"}
})

# Send SMS
{:ok, response} = ShikoNotifications.send(client, %{
  channel: "sms",
  recipient: "+573001234567",
  body: "Your verification code is 1234"
})

# Bulk send (up to 10,000 recipients)
{:ok, job} = ShikoNotifications.send_bulk(client, %{
  channel: "email",
  template_slug: "monthly_newsletter",
  recipients: [
    %{recipient: "a@example.com", template_data: %{name: "Ana"}},
    %{recipient: "b@example.com", template_data: %{name: "Bob"}}
  ]
})

# Check status
{:ok, status} = ShikoNotifications.get_status(client, notification_id)
{:ok, progress} = ShikoNotifications.get_bulk_status(client, job_id)

# Analytics
{:ok, data} = ShikoNotifications.get_analytics(client, "overview")
```

## Supported Channels

| Channel | Providers |
|---------|-----------|
| Email | Brevo, SendGrid, Mailgun, Resend, SMTP |
| SMS | Twilio, Telnyx, Vonage |
| WhatsApp | Twilio, Meta Business API, Dialog360, +6 more |
| Push | FCM, APNs, OneSignal, ntfy |
| Telegram | Bot API |

## Links

- [shiko.vet](https://shiko.vet)
- [API Documentation](https://notifications.shiko.vet/api/openapi)
- [GitHub](https://github.com/Leandro-Moreno/shiko_notifications)

## Support

tech@shiko.vet

## License

MIT
