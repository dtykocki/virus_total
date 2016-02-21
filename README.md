# VirusTotal

**VirusTotal** is an Elixir OTP application for the [`VirusTotal Public API v2.0`](https://www.virustotal.com/en/documentation/public-api/v2/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add virus_total to your list of dependencies in `mix.exs`:

        def deps do
          [{:virus_total, "~> 0.0.1"}]
        end

  2. Ensure virus_total is started before your application:

        def application do
          [applications: [:virus_total]]
        end

## Contribute

For issues, comments, or feedback please [create an issue](http://github.com/dtykocki/virus_total/issues)
