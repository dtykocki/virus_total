defmodule VirusTotal do
  use GenServer

  @client Application.get_env(:virus_total, :http_client)

  def start_link(key) do
    GenServer.start_link(__MODULE__, key, [])
  end

  def ip_address_report(pid, ip_address) do
    GenServer.call(pid, {:ip_address_report, ip_address})
  end

  def url_scan(pid, url) do
    GenServer.call(pid, {:url_scan, url})
  end

  def url_report(pid, scan_id) do
    GenServer.call(pid, {:url_report, scan_id})
  end

  def domain_report(pid, domain) do
    GenServer.call(pid, {:domain_report, domain})
  end

  def file_scan(pid, file) do
    GenServer.call(pid, {:file_scan, file})
  end

  def file_rescan(pid, resource) do
    GenServer.call(pid, {:file_rescan, resource})
  end

  def file_report(pid, resource) do
    GenServer.call(pid, {:file_report, resource})
  end

  def comment(pid, resource, comment) do
    GenServer.call(pid, {:comment, resource, comment})
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
end
