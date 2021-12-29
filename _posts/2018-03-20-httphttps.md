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


**cookie and session**
1. cookie is a tag which is set by server when return the request to client, in HTTP header
2. session is a DS and is stored at server side, cookie only stores sessionID
3. server side: manager(session expired time, policy, store way), session(be stored at redis/db,handler read session and generate html), provider(hashtable,sid,last access time, LRU..)

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

**HTTP flow**
- DNS Lookup: The client tries to resolve the domain name for the request.
Client sends DNS Query to local ISP DNS server.
DNS server responds with the IP address for hostname.com
- Connect: Client establishes TCP connection with the IP address of hostname.com
Client sends SYN packet.
Web server sends SYN-ACK packet.
Client answers with ACK packet, concluding the three-way TCP connection establishment.
- Send: Client sends the HTTP request to the web server.
- Wait: Client waits for the server to respond to the request.
Web server processes the request, finds the resource, and sends the response to the Client. Client receives the first byte of the first packet from the web server, which contains the HTTP Response headers and content.
- Load: Client loads the content of the response.
Web server sends second TCP segment with the PSH flag set.
Client sends ACK. (Client sends ACK every two segments it receives. from the host)
Web server sends third TCP segment with HTTP_Continue.
- Close: Client sends a a FIN packet to close the TCP connection. FINWAIT_1
Server is in CLOSEWAIT state and send ACK back to client, client becomes FINWAIT_2
Server send FIN to Client and server becomes LAST_ACK.
Client send ACK back to Server and becomes TIMEWAIT(2ms) and then CLOSED
Server becomes CLOSED after receive ACK.

**TLS flow**
- tcp handshake
client -> syn -> server
client <- syn ack <- server
client -> ack -> server
- tls handshake
client -> clienthello -> server
client <- serverhello, cert, ServerKeyExchange, serverhellodone  <- server
client -> clientkeyexchange, change cipher spec, finished -> server
client <- change cipher spec, finished <- server
client -> encrypted tls connectoin  -> server
```
The client sends a "Client hello" message to the server, along with the client's random value and supported cipher suites.
The server responds by sending a "Server hello" message to the client, along with the server's random value.
The server sends its certificate to the client for authentication and may request a certificate from the client. The server sends the "Server hello done" message.
If the server has requested a certificate from the client, the client sends it.
The client creates a random Pre-Master Secret and encrypts it with the public key from the server's certificate, sending the encrypted Pre-Master Secret to the server.
The server receives the Pre-Master Secret. The server and client each generate the Master Secret and session keys based on the Pre-Master Secret.
The client sends "Change cipher spec" notification to server to indicate that the client will start using the new session keys for hashing and encrypting messages. Client also sends "Client finished" message.
Server receives "Change cipher spec" and switches its record layer security state to symmetric encryption using the session keys. Server sends "Server finished" message to the client.
Client and server can now exchange application data over the secured channel they have established. All messages sent from client to server and from server to client are encrypted using session key.
```

[refer](https://support.servicenow.com/kb?id=kb_article_view&sysparm_article=KB0722835)
