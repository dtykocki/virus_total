defmodule VirusTotal.Client do
  def file_scan(key, file) do
    request(:post, "/file/scan", {:multipart, [{"apikey", key}, {:file, file}]})
  end

  def file_rescan(key, resource) do
    request(:post, "/file/rescan", {:form, [apikey: key, resource: resource]})
  end

  def file_report(key, resource) do
    request(:post, "/file/report", {:form, [apikey: key, resource: resource]})
  end

  def url_scan(key, url_to_scan) do
    request(:post, "/url/scan", {:form, [apikey: key, url: url_to_scan]})
  end

  def url_report(key, url_to_report) do
    request(:post, "/url/report", {:form, [apikey: key, resource: url_to_report]})
  end

  def ip_address_report(key, ip_address) do
    request(:get, "/ip-address/report", %{apikey: key, ip: ip_address})
  end

  def domain_report(key, domain) do
    request(:get, "/domain/report", %{apikey: key, domain: domain})
  end

  def comment(key, resource, comment) do
    request(:post, "/comments/put", {:form, [apikey: key, resource: resource, comment: comment]})
  end

  defp request(:get, path, params) do
    url
    |> build_url(path)
    |> get(params)
    |> parse_results
  end

  defp request(:post, path, body) do
    url
    |> build_url(path)
    |> post(body)
    |> parse_results
  end

  defp get(url, params) do
    HTTPoison.get(url, [], params: params)
    |> handle_response
  end

  defp post(url, body) do
    HTTPoison.post(url, body)
    |> handle_response
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 403}}  -> {:error, :not_authenticated}
      {:ok, %HTTPoison.Response{status_code: 204}}  -> {:error, :rate_limited}
      {:error, %HTTPoison.Error{reason: reason}}    -> {:error, reason}
    end
  end

  defp url, do: "https://www.virustotal.com/vtapi/v2"

  defp build_url(url, path), do: url <> path

  defp parse_results({:ok, results}), do: {:ok, :jsx.decode(results)}
  defp parse_results({:error, :not_authenticated}), do: {:error, :not_authenticated}
  defp parse_results({:error, :rate_limited}), do: {:error, :rate_limited}
  defp parse_results({:error, :timeout}), do: {:error, :timeout}
end
