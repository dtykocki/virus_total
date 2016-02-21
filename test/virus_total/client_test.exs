defmodule VirusTotal.ClientTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "file_scan/2 with ok status" do
    use_cassette "file_scan_ok" do
      file_path = fixture_path("file_scan.txt")
      key = "valid_key"

      {:ok, %{"scan_id" => scan_id}} = VirusTotal.Client.file_scan(key, file_path)

      assert scan_id == "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31-1455970042"
    end
  end

  test "file_scan/2 with not_authenticated status" do
    use_cassette "file_scan_not_authenticated" do
      file_path = fixture_path("file_scan.txt")
      key = "invalid_key"

      assert {:error, :not_authenticated} == VirusTotal.Client.file_scan(key, file_path)
    end
  end

  test "file_rescan/2 with ok status" do
    use_cassette "file_rescan_ok" do
      file_path = fixture_path("file_scan.txt")
      key = "valid_key"
      {:ok, response} = VirusTotal.Client.file_scan(key, file_path)
      
      {:ok, %{"resource" => resource}} = VirusTotal.Client.file_rescan(key, response["scan_id"])

      assert resource == "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31-1455970042"
    end
  end

  test "file_report/2 with ok status" do
    use_cassette "file_report_ok" do
      file_path = fixture_path("file_scan.txt")
      key = "valid_key"
      {:ok, response} = VirusTotal.Client.file_scan(key, file_path)

      {:ok, %{"resource" => resource}} = VirusTotal.Client.file_report(key, response["scan_id"])

      assert resource == "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31-1455970042"
    end
  end

  test "url_scan/2 with ok status" do
    use_cassette "url_scan_ok" do
      key = "valid_key"
      url = "http://www.google.com/"

      {:ok, %{"resource" => resource}} = VirusTotal.Client.url_scan(key, url)

      assert resource == url
    end
  end

  test "url_scan/2 with not_authenticated status" do
    use_cassette "url_scan_not_authenticated" do
      key = "invalid_key"
      url = "www.google.com"

      assert {:error, :not_authenticated} == VirusTotal.Client.url_scan(key, url)
    end
  end

  test "ip_address_report/2 with ok status" do
    use_cassette "ip_address_report_ok" do
      key = "valid_key"
      ip = "90.156.201.27"

      {:ok, %{"as_owner" => as_owner}} = VirusTotal.Client.ip_address_report(key, ip)

      assert as_owner == ".masterhost autonomous system"
    end
  end

  test "ip_address_report/2 with not_authenticated status" do
    use_cassette "ip_address_report_not_authenticated" do
      key = "invalid_key"
      ip = "90.156.201.27"

      assert {:error, :not_authenticated} == VirusTotal.Client.ip_address_report(key, ip)
    end
  end

  test "url_report/2 with ok status" do
    use_cassette "url_report_ok" do
      key = "valid_key"
      url = "www.google.com"

      {:ok, %{"resource" => resource}} = VirusTotal.Client.url_report(key, url)

      assert resource == url
    end
  end

  test "url_report/2 with not_authenticated stats" do
    use_cassette "url_report_not_authenticated" do
      key = "invalid_key"
      url = "www.google.com"

      assert {:error, :not_authenticated} = VirusTotal.Client.url_report(key, url)
    end
  end

  test "domain_report with ok status" do
    use_cassette "domain_report_ok" do
      key = "valid_key"
      domain = "google.com"

      {:ok, response} = VirusTotal.Client.domain_report(key, domain) 

      assert response != nil
    end
  end

  test "domain_report with not_authenticated status" do
    use_cassette "domain_report_not_authenticated" do
      key = "invalid_key"
      domain = "google.com"

      assert {:error, :not_authenticated} == VirusTotal.Client.domain_report(key, domain)
    end
  end

  test "comment with ok status" do
    use_cassette "comment_with_ok_status" do
      key = "valid_key"
      resource = "99017f6eebbac24f351415dd410d522d"

      {:ok, %{"verbose_msg" => message}} = VirusTotal.Client.comment(key, resource, "Hello, World?")

      assert message == "Your comment was successfully posted"
    end
  end

  test "comment with not_authenticated status" do
  end

  defp fixture_path do
    Path.expand("fixtures", __DIR__)
  end

  defp fixture_path(file_path) do
    Path.join fixture_path, file_path
  end
end
