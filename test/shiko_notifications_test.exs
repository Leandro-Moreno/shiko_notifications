defmodule ShikoNotificationsTest do
  use ExUnit.Case

  alias ShikoNotifications.Client

  describe "Client.new/3" do
    test "creates client struct" do
      client = Client.new("https://api.example.com/v1", "id", "secret")

      assert client.api_url == "https://api.example.com/v1"
      assert client.client_id == "id"
      assert client.client_secret == "secret"
    end
  end

  describe "Client.from_config/2" do
    test "reads from application config" do
      Application.put_env(:test_app, :shiko_notifications,
        api_url: "https://notifications.shiko.vet/api/v1",
        client_id: "shiko_test",
        client_secret: "sk_test"
      )

      client = Client.from_config(:test_app, :shiko_notifications)

      assert client.api_url == "https://notifications.shiko.vet/api/v1"
      assert client.client_id == "shiko_test"

      Application.delete_env(:test_app, :shiko_notifications)
    end

    test "raises on missing config" do
      assert_raise ArgumentError, fn ->
        Client.from_config(:nonexistent, :key)
      end
    end
  end

  describe "ShikoNotifications delegates" do
    test "client/2 delegates to Client.from_config" do
      Application.put_env(:test_app, :sn,
        api_url: "https://test.com",
        client_id: "id",
        client_secret: "secret"
      )

      client = ShikoNotifications.client(:test_app, :sn)
      assert %Client{} = client

      Application.delete_env(:test_app, :sn)
    end

    test "client/3 delegates to Client.new" do
      client = ShikoNotifications.client("https://api.com", "id", "secret")
      assert %Client{} = client
    end
  end
end
