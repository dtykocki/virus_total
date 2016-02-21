defmodule VirusTotal.Client do
  def file_scan(key, file) do
    url
    |> build_url("/file/scan")
    |> post({:multipart, [{"apikey", key}, {:file, file}]})
    |> parse_results
  end

  def file_rescan(key, resource) do
    url
    |> build_url("/file/rescan")
    |> post({:form, [apikey: key, resource: resource]})
    |> parse_results
  end

  def file_report(key, resource) do
    url
    |> build_url("/file/report")
    |> post({:form, [apikey: key, resource: resource]})
    |> parse_results
  end

  def url_scan(key, url_to_scan) do
    url
    |> build_url("/url/scan")
    |> post({:form, [apikey: key, url: url_to_scan]})
    |> parse_results
  end

  def url_report(key, url_to_report) do
    url
    |> build_url("/url/report")
    |> post({:form, [apikey: key, resource: url_to_report]})
    |> parse_results
  end

  def ip_address_report(key, ip_address) do
    url
    |> build_url("/ip-address/report")
    |> get(%{apikey: key, ip: ip_address})
    |> parse_results
  end

  def domain_report(key, domain) do
    url
    |> build_url("/domain/report")
    |> get(%{apikey: key, domain: domain})
    |> parse_results
  end

  def comment(key, resource, comment) do
    url
    |> build_url("/comments/put")
    |> post({:form, [apikey: key, resource: resource, comment: comment]})
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
