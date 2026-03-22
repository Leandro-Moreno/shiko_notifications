defmodule ShikoNotifications.Client do
  @moduledoc """
  HTTP client for the shiko.vet notification API.

  Handles authentication, request building, and response parsing.
  """

  defstruct [:api_url, :client_id, :client_secret]

  @type t :: %__MODULE__{
          api_url: String.t(),
          client_id: String.t(),
          client_secret: String.t()
        }

  @doc "Create a client from application config."
  @spec from_config(atom(), atom()) :: t()
  def from_config(app, key) do
    config = Application.fetch_env!(app, key)

    %__MODULE__{
      api_url: Keyword.fetch!(config, :api_url),
      client_id: Keyword.fetch!(config, :client_id),
      client_secret: Keyword.fetch!(config, :client_secret)
    }
  end

  @doc "Create a client with explicit credentials."
  @spec new(String.t(), String.t(), String.t()) :: t()
  def new(api_url, client_id, client_secret) do
    %__MODULE__{api_url: api_url, client_id: client_id, client_secret: client_secret}
  end

  def send(%__MODULE__{} = client, params) do
    post(client, "/notifications", params)
  end

  def send_bulk(%__MODULE__{} = client, params) do
    post(client, "/notifications/bulk", params)
  end

  def get_status(%__MODULE__{} = client, notification_id) do
    get(client, "/notifications/#{notification_id}")
  end

  def get_bulk_status(%__MODULE__{} = client, bulk_job_id) do
    get(client, "/notifications/bulk/#{bulk_job_id}")
  end

  def list_notifications(%__MODULE__{} = client, params \\ %{}) do
    query = URI.encode_query(params)
    path = if query == "", do: "/notifications", else: "/notifications?#{query}"
    get(client, path)
  end

  def get_analytics(%__MODULE__{} = client, endpoint, params \\ %{}) do
    query = URI.encode_query(params)
    path = if query == "", do: "/analytics/#{endpoint}", else: "/analytics/#{endpoint}?#{query}"
    get(client, path)
  end

  # Private

  defp post(client, path, body) do
    url = client.api_url <> path

    case Req.post(url, json: body, headers: headers(client), retry: false) do
      {:ok, %Req.Response{status: status, body: body}} when status in 200..299 ->
        {:ok, body}

      {:ok, %Req.Response{status: status, body: body}} ->
        {:error, %{status: status, body: body}}

      {:error, exception} ->
        {:error, Exception.message(exception)}
    end
  end

  defp get(client, path) do
    url = client.api_url <> path

    case Req.get(url, headers: headers(client), retry: false) do
      {:ok, %Req.Response{status: status, body: body}} when status in 200..299 ->
        {:ok, body}

      {:ok, %Req.Response{status: status, body: body}} ->
        {:error, %{status: status, body: body}}

      {:error, exception} ->
        {:error, Exception.message(exception)}
    end
  end

  defp headers(client) do
    auth = Base.encode64("#{client.client_id}:#{client.client_secret}")

    [
      {"authorization", "Basic #{auth}"},
      {"accept", "application/json"}
    ]
  end
end
