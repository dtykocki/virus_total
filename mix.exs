defmodule VirusTotal.Mixfile do
  use Mix.Project

  def project do
    [app: :virus_total,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: description,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :httpoison],
      mod: {VirusTotal.Application, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.9.0"},
     {:exvcr, "~> 0.8", only: :test},
     {:jsx, "~> 2.6"}]
  end

  defp description do
    """
    Elixir OTP application for the VirusTotal Public API v2.0
    """
  end

  defp package do
    [
      maintainers: ["Doug Tykocki"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/dtykocki/virus_total"}
    ]
  end
end
