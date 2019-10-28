defmodule PlugMetadataLogger do
  @moduledoc """
  A plug for logging basic request information in the format:

      Got client request.
      Sent reply.

  This plug is based on the original [Plug.Logger](https://github.com/elixir-plug/plug/blob/master/lib/plug/logger.ex)
  but focused on metadata Logging.

  To use it, just plug it into the desired module.

      plug MetadataLoggerPlug, log: :debug

  ## Options

    * `:log` - The log level at which this plug should log its request info.
      Default is `:info`.
  """

  require Logger
  alias Plug.Conn
  @behaviour Plug

  def init(opts) do
    Keyword.get(opts, :log, :info)
  end

  def call(conn, level) do
    Logger.log(level, fn ->
      {"Got client request.",
       method: conn.method, request_path: conn.request_path, tag: "got_client_req"}
    end)

    start = System.monotonic_time()

    Conn.register_before_send(conn, fn conn ->
      Logger.log(level, fn ->
        stop = System.monotonic_time()
        diff = System.convert_time_unit(stop - start, :native, :microsecond)
        status_code = conn.status

        {[connection_type(conn), " reply."],
         status_code: status_code, elapsed: formatted_diff(diff), tag: "sent_reply"}
      end)

      conn
    end)
  end

  defp formatted_diff(diff) when diff > 1000, do: [diff |> div(1000) |> Integer.to_string(), "ms"]
  defp formatted_diff(diff), do: [Integer.to_string(diff), "µs"]

  defp connection_type(%{state: :set_chunked}), do: "Chunked"
  defp connection_type(_), do: "Sent"
end
