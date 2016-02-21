defmodule VirusTotal.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :virus_total_supervisor)
  end

  def start_child(name, key) do
    Supervisor.start_child(:virus_total_supervisor, [name, key])
  end

  def init([]) do
    children = [
      worker(VirusTotal, [], restart: :transient)
    ]
    supervise(children, strategy: :simple_one_for_one)
  end
end
