defmodule PlugMetadataLogger.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_metadata_logger,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:plug, "~> 1.4"}
    ]
  end
end
