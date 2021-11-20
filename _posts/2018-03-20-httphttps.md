---
layout: post
title: Http/Https
date: 2018-03-20 09:25:06
description: simulate request by curl
tags: 
 - devops
---

**http header**

HTTP/1.1 200 OK
Server: bfe/1.0.8.18
Date: Tue, 20 Mar 2018 13:38:06 GMT
Content-Type: text/html
Content-Length: 277
Last-Modified: Mon, 13 Jun 2016 02:50:23 GMT
Connection: Keep-Alive
ETag: "575e1f6f-115"
Cache-Control: private, no-cache, no-store, proxy-revalidate, no-transform
Pragma: no-cache
Accept-Ranges: bytes

**https header**

HTTP/1.1 200 OK
Server: Apache
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
Accept-Ranges: bytes
X-Content-Type-Options: nosniff
Content-Type: text/html; charset=UTF-8
Cache-Control: max-age=178
Expires: Tue, 20 Mar 2018 13:40:22 GMT
Date: Tue, 20 Mar 2018 13:37:24 GMT
Content-Length: 45736
Connection: keep-alive


**http 2.0 vs http 1.1**

Key differences with http1.1

It is binary, instead of textual
Fully multiplexed, instead of ordered and blocking
Can therefore use one connection for parallelism
Uses header compression to reduce overhead
Allows servers to “push” responses proactively into client caches

[refer](https://www.upwork.com/hiring/development/the-http2-protocol-its-pros-cons-and-how-to-start-using-it/)

**curl**
curl is mostly used for test website working and where is this page deploying

- curl -I : get head info
- curl -X : add method(POST,DELETE,PUT)
- curl -v : Make the operation more talkative
- curl -d "xx" : post

curl --user-agent "[User Agent]" [URL]
curl --header "Content-Type:application/json" http://example.com
curl --head -v https://www.baidu.com
curl -v --trace-time https://www.google.com
curl -w "dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n" -o /dev/null -s "https://sushi.herokuapp.com/"


**HTTP_PROXY**
- SET NO_PROXY for internal services(behind firewall) 
[refer](https://about.gitlab.com/blog/2021/01/27/we-need-to-talk-no-proxy/)

The difference is that http_proxy does not encrypt the data transmission between the client and proxies, while https_proxy does. So https_proxy proxies itself requires a TLS certificate.
