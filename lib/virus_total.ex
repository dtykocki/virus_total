defmodule VirusTotal do
  use GenServer

  @client Application.get_env(:virus_total, :http_client)

  def start(name, key) do
    VirusTotal.Supervisor.start_child(name, key)
  end

  def stop(name) do
    GenServer.call(name, :stop)
  end

  def start_link(name, key) do
    GenServer.start_link(__MODULE__, key, name: name)
  end

  def ip_address_report(name, ip_address) do
    GenServer.call(name, {:ip_address_report, ip_address})
  end

  def url_scan(name, url) do
    GenServer.call(name, {:url_scan, url})
  end

  def url_report(name, scan_id) do
    GenServer.call(name, {:url_report, scan_id})
  end

  def domain_report(name, domain) do
    GenServer.call(name, {:domain_report, domain})
  end

  def file_scan(name, file) do
    GenServer.call(name, {:file_scan, file})
  end

  def file_rescan(name, resource) do
    GenServer.call(name, {:file_rescan, resource})
  end

  def file_report(name, resource) do
    GenServer.call(name, {:file_report, resource})
  end

  def comment(name, resource, comment) do
    GenServer.call(name, {:comment, resource, comment})
  end

  def init(key) do
    {:ok, key}
  end

  def handle_call({:ip_address_report, ip_address}, _from, key) do
    results = @client.ip_address_report(key, ip_address)
    {:reply, results, key}
  end

  def handle_call({:url_scan, url}, _from, key) do
    results = @client.url_scan(key, url)
    {:reply, results, key}
  end

  def handle_call({:url_report, scan_id}, _from, key) do
    results = @client.url_report(key, scan_id)
    {:reply, results, key}
  end

  def handle_call({:domain_report, domain}, _from, key) do
    results = @client.domain_report(key, domain)
    {:reply, results, key}
  end

  def handle_call({:file_scan, file}, _from, key) do
    results = @client.file_scan(key, file)
    {:reply, results, key}
  end

  def handle_call({:file_rescan, resource}, _from, key) do
    results = @client.file_rescan(key, resource)
    {:reply, results, key}
  end

  def handle_call({:file_report, resource}, _from, key) do
    results = @client.file_report(key, resource)
    {:reply, results, key}
  end

  def handle_call({:comment, resource, comment}, _from, key) do
    results = @client.comment(key, resource, comment)
    {:reply, results, key}
  end

  def handle_call(:stop, _from, state) do
    {:stop, :normal, :stopped, state}
  end
end
