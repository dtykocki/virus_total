defmodule VirusTotalTest do
  use ExUnit.Case, async: true

  defmodule FakeClient do
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

  setup do
    {:ok, pid} = VirusTotal.start_link("12345")
    {:ok, pid: pid}
  end

  test "ip_address_report/2", %{pid: pid} do
    results = VirusTotal.ip_address_report(pid, "8.8.8.8")
    assert {:ok, %{}} == results
  end

  test "url_scan/2", %{pid: pid} do
    results = VirusTotal.url_scan(pid, "http://www.google.com")
    assert {:ok, %{}} == results
  end

  test "url_report/2", %{pid: pid} do
    results = VirusTotal.url_report(pid, "scan_id")
    assert {:ok, %{}} == results
  end

  test "domain_report/2", %{pid: pid} do
    results = VirusTotal.domain_report(pid, "027.ru")
    assert {:ok, %{}} == results
  end

  test "file_scan/2", %{pid: pid} do
    results = VirusTotal.file_scan(pid, "path/to/a/file")
    assert {:ok, %{}} == results
  end

  test "file_rescan/2", %{pid: pid} do
    resource = "99017f6eebbac24f351415dd410d522d"
    results = VirusTotal.file_rescan(pid, resource)
    assert {:ok, %{}} == results
  end

  test "file_report/2", %{pid: pid} do
    resource = "99017f6eebbac24f351415dd410d522d"
    results = VirusTotal.file_report(pid, resource)
    assert {:ok, %{}} == results
  end

  test "comment/3", %{pid: pid} do
    resource = "99017f6eebbac24f351415dd410d522d"
    comment = "How to disinfect you from this file... #disinfect #zbot"
    results = VirusTotal.comment(pid, resource, comment)
    assert {:ok, %{}} == results
  end
end
