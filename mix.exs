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
    "Official Elixir SDK by Shiko (https://shiko.vet). " <>
      "Multi-channel notification service — send email, SMS, WhatsApp, push, and Telegram " <>
      "notifications through a single API. Built and maintained by the shiko.vet team."
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
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE CHANGELOG.md)
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      homepage_url: "https://shiko.vet",
      extras: [
        "README.md": [title: "Overview"],
        "CHANGELOG.md": [title: "Changelog"]
      ],
      groups_for_modules: [
        "Client": [ShikoNotifications, ShikoNotifications.Client]
      ],
      before_closing_head_tag: fn :html ->
        """
        <style>
          .sidebar-header img { border-radius: 8px; }
        </style>
        """

        _ -> ""
      end
    ]
  end
end
