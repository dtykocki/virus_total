# VirusTotal

**VirusTotal** is an Elixir OTP application for the [`VirusTotal Public API v2.0`](https://www.virustotal.com/en/documentation/public-api/v2/).

[![Build Status](https://travis-ci.org/dtykocki/virus_total.svg?branch=master)](https://travis-ci.org/dtykocki/virus_total) [![Hex pm](http://img.shields.io/hexpm/v/virus_total.svg?style=flat)](https://hex.pm/packages/virus_total)

## Things you can do with `VirusTotal`:
1. Start several `gen_servers` representing different applications defined by different VirusTotal API keys.
2. Send and scan files.
3. Retrieve file scan reports.
4. Send and scan URLs.
5. Retrieve URL scan reports.
6. Retrieve IP address reports.
7. Retrieve domain reports.
8. Comment on existing resources.

## Installation

  1. Add virus_total to your list of dependencies in `mix.exs`:

        def deps do
          [{:virus_total, "~> 0.0.2"}]
        end

  2. Ensure virus_total is started before your application:

        def application do
          [applications: [:virus_total]]
        end

## Usage

### How start and stop different GenServers

```
iex> VirusTotal.start(:foo, "key1")
{:ok, #PID<0.179.0>}
iex> VirusTotal.start(:foo2, "key2")
{:ok, #PID<0.181.0>}
iex> VirusTotal.start(:foo3, "key3")
{:ok, #PID<0.183.0>}

iex> VirusTotal.stop(:foo)
:stopped
iex> VirusTotal.stop(:foo2)
:stopped
iex> VirusTotal.stop(:foo3)
:stopped
```

### Send and scan a file

```
iex> VirusTotal.file_scan(:foo, "test/virus_total/fixtures/file_scan.txt")
{:ok,
 %{"md5" => "bea8252ff4e80f41719ea13cdf007273",
   "permalink" => "https://www.virustotal.com/file/c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31/analysis/1456136936/",
   "resource" => "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31",
   "response_code" => 1,
   "scan_id" => "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31-1456136936",
   "sha1" => "60fde9c2310b0d4cad4dab8d126b04387efba289",
   "sha256" => "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31",
   "verbose_msg" => "Scan request successfully queued, come back later for the report"}}
```

### Retrieve file scan reports

```
iex> VirusTotal.file_report(:foo, "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31")
{:ok,
 %{"md5" => "bea8252ff4e80f41719ea13cdf007273",
   "permalink" => "https://www.virustotal.com/file/c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31/analysis/1455970042/",
   "positives" => 0,
   "resource" => "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31",
   "response_code" => 1, "scan_date" => "2016-02-20 12:07:22",
   "scan_id" => "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31-1455970042",
   "scans" => %{}}}
...
```

### Send and scan URLs

```
iex> VirusTotal.url_scan(:foo, "www.reddit.com")
{:ok,
 %{"permalink" => "https://www.virustotal.com/url/8ae111340fa97c74a734da36303788bf790704b841313c337e8c22d251dfd537/analysis/1456137813/",
   "resource" => "http://www.reddit.com", "response_code" => 1,
   "scan_date" => "2016-02-22 10:43:33",
   "scan_id" => "8ae111340fa97c74a734da36303788bf790704b841313c337e8c22d251dfd537-1456137813",
   "url" => "http://www.reddit.com",
   "verbose_msg" => "Scan request successfully queued, come back later for the report"}}
```

### Retrieve URL scan reports

```
iex> VirusTotal.url_report(:foo, "www.reddit.com")                                                             
{:ok,
 %{"filescan_id" => :null,
   "permalink" => "https://www.virustotal.com/url/770549b1f0322967eb1a597348558f51557a81307c752c29b98b478ff2a85505/analysis/1456121750/",
   "positives" => 0, "resource" => "www.reddit.com", "response_code" => 1,
   "scan_date" => "2016-02-22 06:15:50",
   "scan_id" => "770549b1f0322967eb1a597348558f51557a81307c752c29b98b478ff2a85505-1456121750",
   "scans" => %{"Yandex Safebrowsing" => %{"detail" => "http://yandex.com/infected?l10n=en&url=http://www.reddit.com/",
       "detected" => false, "result" => "clean site"}}}
...
```

### Retrieve IP address reports

```
iex> VirusTotal.ip_address_report(:foo, "8.8.8.8")
{:ok,
 %{"as_owner" => "Google Inc.", "asn" => "15169", "country" => "US",
   "detected_communicating_samples" => [%{"date" => "2016-02-17 03:31:27",
      "positives" => 1,
      "sha256" => "2be94f5f8ba8adcf4c044c09c88958c6987f7ab57ab153bc9524e96e32f633fa",
      "total" => 55},
...
```

### Retrieve domain reports

```
iex> VirusTotal.domain_report(:foo, "google.com")
{:ok,
 %{"Alexa category" => "google",
   "Alexa domain info" => "google.com is one of the top 10 sites in the world and is in the Google category",
   "Alexa rank" => 10, "BitDefender category" => "searchengines",
   "BitDefender domain info" => "This URL domain/host was seen to host badware at some point in time",
   "Dr.Web category" => "chats",
   "Opera domain info" => "The URL domain/host was seen to host badware at some point in time",
   "TrendMicro category" => "search engines portals",
   "WOT domain info" => %{"Child safety" => "Excellent",
     "Privacy" => "Excellent", "Trustworthiness" => "Excellent",
...
```

### Leave comments on resources

```
iex> VirusTotal.comment(:foo, "c98c24b677eff44860afea6f493bbaec5bb1c4cbb209c6fc2bbb47f66ff2ad31", "How to disinfect you from this file... #disinfect #zbot")
{:ok,
 %{"response_code" => 1,
   "verbose_msg" => "Your comment was successfully posted"}}
```

## Contribute

For issues, comments, or feedback please [create an issue](http://github.com/dtykocki/virus_total/issues)
