---
layout: post
title: "HTTP 3"
date: 2022-03-21 12:25:06
description: http, http 1.1, http 2 , http 3
tags: 
 - devops
---
[refer](https://ably.com/topic/http-2-vs-http-3)

# http evolving
1. HTTP/1.0
- HTTP/1.0
- TLS (OPTION)
- TCP
- IP
2. HTTP/1.1
- HTTP/1.1 semantics(method,resp.code, hdr field)
- HTTP/1.1 syntax
- TLS (OPTION)
- TCP (stream, flow-control, prioritization, push)
- IP
3. HTTP/2.0
- HTTP/1.1 semantics(prioritization, push)
- HTTP/2.0 syntax(stream, flow-control)
- TLS (OPTION)
- TCP
- IP
4. HTTP/3.0
- HTTP/1.1 semantics
- HTTP/3.0 syntax
- QUIC
- TLS (must)
- TCP
- IP

# http compare
![img]({{ '/assets/images/devops/http_compare_1_2_3.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/devops/http_compare_2_3.png' | relative_url }}){: .center-image }*(°0°)*
