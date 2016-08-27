use Mix.Config

config :virus_total, http_client: VirusTotal.FakeClient
config :exvcr, [
  vcr_cassette_library_dir: "test/virus_total/fixtures/vcr_cassettes",
]
