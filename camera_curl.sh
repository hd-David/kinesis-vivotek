curl 'http://192.168.100.100/teleport/cgi-bin/pair' \
  -X 'PUT' \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'Authorization: Basic cm9vdDpYOWRlaVg5ZGVp' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Cookie: webptzmode=continuous; activatedmode=digital; g_mode=1; viewsizemode=100; 4x3=false; channelsource=0; streamsource=0' \
  -H 'Origin: http://192.168.100.100' \
  -H 'Referer: http://192.168.100.100/teleport/www/index.html' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw '{"StreamName":"thing_stream_f6e4adf","Region":"us-east-1","IoTCredentialEndpoint":"https://c2qoqgl91j3vzz.com","KMSKeyId":"","IoTCredentialRoleAlias":"kvs_iamrole_alias_f6e4adf","IoTCertificate":"-----BEGIN CERTIFICATE-----\nMIIDWjCCAkKgAwIBAgIVALTVgjAZ2DigMtAgd+phTl2YL72fMA0GCSqGSIb3DQEB\nCwUAME0xSzBJBgNVBAsMQkFtYXpvbiBXZWIgU2VydmljZXMgTz1BbWF6b24uY29t\nIEluYy4gTD1TZWF0dGxlIFNUPVdhc2hpbmd0b24gQz1VUzAeFw0yMjA1MDMxMTUx\nMDZaFw00OTEyMzEyMzU5NTlaMB4xHDAaBgNVBAMME0FXUyBJb1QgQ2VydGlmaWNh\ndGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCo9KY7Iy+UoGntynNN\nPKpcbuFrv/tf8NCMIPuND/aROJ9P39HzUgsxEP0IJ6ZMoMOPVeWHRDKf4q7tlEjA\nPlOnP9hyhGgkystUUr4xWy6ffxn7F8DpW5PBfrq7bgtnsIRN2XOYmwCcITO1BGrY\nqRjjpmYPAnGaqDKAZmlb8GgWNj+w9rmxHTQjkIMUfd+qBPSlIzsDT8Z2ordFJjDi\nj59U43FdoReB7bjx1c7QKg2x4taO9Bzo2JM9CxOFo5LRmznb37MX7V6njHxCt8bv\nW1+W2ETGHdBejcqgdmyQK/oJ70+ZsEBVNiBz1+N1PUn0Dqa3lvElyT+idHObVOyI\n7BkjAgMBAAGjYDBeMB8GA1UdIwQYMBaAFIMTTp4enqfVeqJm7U7S2HL92bkLMB0G\nA1UdDgQWBBSOo6hjTpVex54AqrAmuQDkcJVrBjAMBgNVHRMBAf8EAjAAMA4GA1Ud\nDwEB/wQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAXY6csoszwRU4+0qjia5uQokS\ntZh6fbTXHvymT47um1TDvqkgkyAt1pmIZlchc8dmo7xvmI90/O0oY83KTeySowJd\nn4cXtN8HUt7n/IiOzPkoSsYrcNap6xLtw1x1kj8Kd1TRRgD4FZ8MHZrHaDAxXJLh\nZjIVttsgIw7Qn9TGJLIKRtpv2lysEwPVajkAymXZgUfIq+Hcb/66UzqXPZEXGU9/\nE1zf/gr82JhugO/yaC9Z/aF2v9UReXVSCAQwVh7g/zi65Nfph80QOeL7JFzSLC7g\nugDoutQYfvJzm13knQNH7t0rzVMUrV3g87HR5dN0IdvkRqa8FMo0ChjWt1L2lQ==\n-----END CERTIFICATE-----\n","IoTPrivateKey":"-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAqPSmOyMvlKBp7cpzTTyqXG7ha7/7X/DQjCD7jQ/2kTifT9/R\n81ILMRD9CCemTKDDj1Xlh0Qyn+Ku7ZRIwD5Tpz/YcoRoJMrLVFK+MVsun38Z+xfA\n6VuTwX66u24LZ7CETdlzmJsAnCEztQRq2KkY46ZmDwJxmqgygGZpW/BoFjY/sPa5\nsR00I5CDFH3fqgT0pSM7A0/GdqK3RSYw4o+fVONxXaEXge248dXO0CoNseLWjvQc\n6NiTPQsThaOS0Zs529+zF+1ep4x8QrfG71tflthExh3QXo3KoHZskCv6Ce9PmbBA\nVTYgc9fjdT1J9A6mt5bxJck/onRzm1TsiOwZIwIDAQABAoIBABfQK6HIKsui9Gss\njqXDOCvBAQqjy3VRRsOJXosaReFf/qxOWpQV6zfmMhO1Ku4/9nA8ZhZzmUMJuygH\nL13RKw82o3Y4jUkqQBBJfT8Nn/ug+XN3fJwnaSLrjrweHYNm0K78SBupNSPMVjJc\nRgb1hmmHqXjSGlr2++83AACSWMlQb2v3GoU/nOM2jnwKAcYY4IVaxWl3RwzOi5gZ\nkB41A1wDwIjBmoGXs9bDUN8X61M9KaO701GZMySog/EFz1UuBBt6hjsL2rxx2YvT\nbpKOkpar9ydHPgilVwybRb8lES1/zza58zYPsnt3qHRFMGxCnv+MtTCBP2Pudhrn\ndGwrwTECgYEA2EuDSXrfZlrRGpoarFJ9P/39HRk3NF5ltM0bnDa8OJ9dbzsXCOpX\nw1EqPRzEe4KD8VY1Ua0TNF1BgF5ONH7gIMHN3G4GVc8TqA3IndimRGJ+CK6Aqvkf\nqRHRoCpvN7Koh/AJ4j7SvnQkMmMBJ9mFOXZ32Hd161oewR3UNZl+xRkCgYEAx/h9\nfDry/5CAnXrKI0rRmnvg1jXLEPhLaP7B/XdxBruI0ezTE+hsblbx60NaMkm90kSJ\n8M2CAOXWsebnYxAKMAksiShjwaNwCyyCc+QKhMpbPMApygYxQCC/D+YPrCA1N4EL\nHKck7TuIrkYnfowVGfCB/UsDCvjvu+5JKlluO5sCgYEApuD8FkFbA5mmI6QqWDH8\nuNa55y2BTkJWrjxhxRDl/7nVWPB6QUKtG+EPeb8sSS7VpeohkTa7znb1Bpm8NPx+\n6EcfEadB9Aqk29BmrIJvJevn2cLpOwCi0MsStUSIMq0BIoCs34YhCxiIpOeGCLzm\n8QLaTIU+0arid5UQGZqoGGECgYBtlUTe8Ub8uelhY0qmcHfQmpYpjS0MzaQ1k3Yn\nOm8b62Uc9RTu0e2pwceszyn8aOC2+4xEA7p8V3eB4jFm3gFXNY/MUe/oy3G5Ddkn\nPQ5ump3I+t1rsl0G8WsCgWaRQs0m73Zxaz8XKgrKxfMarBVcM6pobdTrDGQDrp81\nr/ByhQKBgQDSYCszR3XXF2+zV9S++L0t4W1C0g8MsRbL0Q5iOyvolnHi+xUf0axn\n5caqFng1nWOXm2nnSRW11S08nJ+GZOvy8eIxsI4axD95sibD+rkLLKKRNZPmPoQM\nkrvqWlashP8iOvIe2ob+ugYImVdnZCgZOfK+7cevutJ75hz3wiyrxQ==\n-----END RSA PRIVATE KEY-----\n","IoTCACert":"-----BEGIN CERTIFICATE-----\nMIID7zCCAtegAwIBAgIBADANBgkqhkiG9w0BAQsFADCBmDELMAkGA1UEBhMCVVMx\nEDAOBgNVBAgTB0FyaXpvbmExEzARBgNVBAcTClNjb3R0c2RhbGUxJTAjBgNVBAoT\nHFN0YXJmaWVsZCBUZWNobm9sb2dpZXMsIEluYy4xOzA5BgNVBAMTMlN0YXJmaWVs\nZCBTZXJ2aWNlcyBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eSAtIEcyMB4XDTA5\nMDkwMTAwMDAwMFoXDTM3MTIzMTIzNTk1OVowgZgxCzAJBgNVBAYTAlVTMRAwDgYD\nVQQIEwdBcml6b25hMRMwEQYDVQQHEwpTY290dHNkYWxlMSUwIwYDVQQKExxTdGFy\nZmllbGQgVGVjaG5vbG9naWVzLCBJbmMuMTswOQYDVQQDEzJTdGFyZmllbGQgU2Vy\ndmljZXMgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgLSBHMjCCASIwDQYJKoZI\nhvcNAQEBBQADggEPADCCAQoCggEBANUMOsQq+U7i9b4Zl1+OiFOxHz/Lz58gE20p\nOsgPfTz3a3Y4Y9k2YKibXlwAgLIvWX/2h/klQ4bnaRtSmpDhcePYLQ1Ob/bISdm2\n8xpWriu2dBTrz/sm4xq6HZYuajtYlIlHVv8loJNwU4PahHQUw2eeBGg6345AWh1K\nTs9DkTvnVtYAcMtS7nt9rjrnvDH5RfbCYM8TWQIrgMw0R9+53pBlbQLPLJGmpufe\nhRhJfGZOozptqbXuNC66DQO4M99H67FrjSXZm86B0UVGMpZwh94CDklDhbZsc7tk\n6mFBrMnUVN+HL8cisibMn1lUaJ/8viovxFUcdUBgF4UCVTmLfwUCAwEAAaNCMEAw\nDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFJxfAN+q\nAdcwKziIorhtSpzyEZGDMA0GCSqGSIb3DQEBCwUAA4IBAQBLNqaEd2ndOxmfZyMI\nbw5hyf2E3F/YNoHN2BtBLZ9g3ccaaNnRbobhiCPPE95Dz+I0swSdHynVv/heyNXB\nve6SbzJ08pGCL72CQnqtKrcgfU28elUSwhXqvfdqlS5sdJ/PHLTyxQGjhdByPq1z\nqwubdQxtRbeOlKyWN7Wg0I8VRw7j6IPdj/3vQQF3zCepYoUz8jcI73HPdwbeyBkd\niEDPfUYd/x7H4c7/I9vG+o1VTqkC50cRRj70/b17KSa7qWFiNyi2LSr2EIZkyXCn\n0q23KXB56jzaYyWf/Wi3MOxw+3WKt21gZ7IeyLnp2KhvAotnDU0mV3HaIPzBSlCN\nsSi6\n-----END CERTIFICATE-----\n"}' \
  --compressed \
  --insecure

  curl 'http://192.168.100.100/cgi-bin/admin/vadpctrl.cgi?cmd=stop&idx=3' \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'Authorization: Basic cm9vdDpYOWRlaVg5ZGVp' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: webptzmode=continuous; activatedmode=digital; g_mode=1; viewsizemode=100; 4x3=false; channelsource=0; streamsource=0' \
  -H 'If-Modified-Since: 0' \
  -H 'Referer: http://192.168.100.100/setup/application/vadp.html' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36' \
  --compressed \
  --insecure

sleep 5

curl 'http://192.168.100.100/cgi-bin/admin/vadpctrl.cgi?cmd=start&idx=3' \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'Authorization: Basic cm9vdDpYOWRlaVg5ZGVp' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: webptzmode=continuous; activatedmode=digital; g_mode=1; viewsizemode=100; 4x3=false; channelsource=0; streamsource=0' \
  -H 'If-Modified-Since: 0' \
  -H 'Referer: http://192.168.100.100/setup/application/vadp.html' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36' \
  --compressed \
  --insecure
