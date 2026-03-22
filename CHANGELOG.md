# Changelog

## v0.1.0 (2026-03-22)

Initial release.

- `ShikoNotifications.send/2` — Send single notification (email, SMS, WhatsApp, push, Telegram)
- `ShikoNotifications.send_bulk/2` — Bulk send up to 10,000 recipients
- `ShikoNotifications.get_status/2` — Check delivery status
- `ShikoNotifications.get_bulk_status/2` — Check bulk job progress
- `ShikoNotifications.list_notifications/2` — List with filters
- `ShikoNotifications.get_analytics/3` — Analytics data (overview, channels, templates, trends)
- Config from Application env or manual `client/3`
- Basic Auth with client_id/client_secret
