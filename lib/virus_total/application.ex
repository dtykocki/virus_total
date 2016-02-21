defmodule VirusTotal.Application do
  use Application

  def start(_, _) do
    VirusTotal.Supervisor.start_link
  end

  def stop(_) do
    :ok
  end
end
