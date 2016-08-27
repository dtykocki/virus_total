use Mix.Config

config :virus_total, http_client: VirusTotal.Client

import_config "#{Mix.env}.exs"
