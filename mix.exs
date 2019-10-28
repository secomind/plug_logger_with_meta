defmodule PlugMetadataLogger.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_metadata_logger,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/ispirata/plug_metadata_logger"
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:plug, "~> 1.4"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Plug.Logger replacement focused on metadata logging."
  end

  defp package do
    [
      maintainers: ["Davide Bettio"],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/ispirata/plug_metadata_logger",
        "Documentation" => "http://hexdocs.pm/plug_metadata_logger/"
      }
    ]
  end
end
