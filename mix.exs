defmodule ShikoNotifications.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/Leandro-Moreno/shiko_notifications"

  def project do
    [
      app: :shiko_notifications,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      docs: docs(),
      source_url: @source_url,
      homepage_url: "https://shiko.vet"
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:req, "~> 0.5"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Elixir SDK for the shiko.vet multi-channel notification service.
    Send email, SMS, WhatsApp, push, and Telegram notifications with a single API.
    """
  end

  defp package do
    [
      name: "shiko_notifications",
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "shiko.vet" => "https://shiko.vet",
        "API Docs" => "https://notifications.shiko.vet/api/openapi"
      },
      maintainers: ["Shiko Tech <tech@shiko.vet>"],
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE)
    ]
  end

  defp docs do
    [
      main: "ShikoNotifications",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end
end
