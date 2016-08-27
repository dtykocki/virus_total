defmodule VirusTotal.FakeClient do
  def ip_address_report(_key, "8.8.8.8") do
    {:ok, %{}}
  end

  def url_scan(_key, "http://www.google.com") do
    {:ok, %{}}
  end

  def url_report(_key, _scan_id) do
    {:ok, %{}}
  end

  def domain_report(_key, _domain) do
    {:ok, %{}}
  end

  def file_scan(_key, _file) do
    {:ok, %{}}
  end

  def file_rescan(_key, _resource) do
    {:ok, %{}}
  end

  def file_report(_key, _resource) do
    {:ok, %{}}
  end

  def comment(_key, _resource, _comment) do
    {:ok, %{}}
  end
end
