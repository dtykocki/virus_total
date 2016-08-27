defmodule VirusTotalTest do
  use ExUnit.Case, async: true

  setup do
    VirusTotal.Supervisor.start_link
    VirusTotal.start(:test_process, "12345")
    :ok
  end

  test "ip_address_report/2" do
    results = VirusTotal.ip_address_report(:test_process, "8.8.8.8")
    assert {:ok, %{}} == results
  end

  test "url_scan/2" do
    results = VirusTotal.url_scan(:test_process, "http://www.google.com")
    assert {:ok, %{}} == results
  end

  test "url_report/2" do
    results = VirusTotal.url_report(:test_process, "scan_id")
    assert {:ok, %{}} == results
  end

  test "domain_report/2" do
    results = VirusTotal.domain_report(:test_process, "027.ru")
    assert {:ok, %{}} == results
  end

  test "file_scan/2" do
    results = VirusTotal.file_scan(:test_process, "path/to/a/file")
    assert {:ok, %{}} == results
  end

  test "file_rescan/2" do
    resource = "99017f6eebbac24f351415dd410d522d"
    results = VirusTotal.file_rescan(:test_process, resource)
    assert {:ok, %{}} == results
  end

  test "file_report/2" do
    resource = "99017f6eebbac24f351415dd410d522d"
    results = VirusTotal.file_report(:test_process, resource)
    assert {:ok, %{}} == results
  end

  test "comment/3" do
    resource = "99017f6eebbac24f351415dd410d522d"
    comment = "How to disinfect you from this file... #disinfect #zbot"
    results = VirusTotal.comment(:test_process, resource, comment)
    assert {:ok, %{}} == results
  end
end
