---
layout: post
title: "Netty"
date: 2019-01-03 10:50:06
description: Java Netty, an asynchronous event-driven network application framework 
tags: 
 - code
---

**Netty**
Every IO operation on a Channel in Netty is non-blocking and asynchronous.

**Keywords**
- channel:kinda a connection and is registered for its with a single eventloop.
- bootstrap: bootstrap a channel 
- eventloopgroup: one or more eventloops
- eventloop: handles all the I/O operations for a Channel once registered, and
  all I/O events in an eventloop are handled on its decidated Thread


**Inbound**
works for read-in IO event by adding order of handler
Head-->A-->B--C-->Tail

ChannelHandlerContext.fireChannelRegistered()
ChannelHandlerContext.fireChannelActive()
ChannelHandlerContext.fireChannelRead(Object)
ChannelHandlerContext.fireChannelReadComplete()
ChannelHandlerContext.fireExceptionCaught(Throwable)
ChannelHandlerContext.fireUserEventTriggered(Object)
ChannelHandlerContext.fireChannelWritabilityChanged()
ChannelHandlerContext.fireChannelInactive()
ChannelHandlerContext.fireChannelUnregistered()

**Outbound**

works for write-out IO eent by revert adding order of handler
tail-->C(event start)-->B-->A--head
ChannelHandlerContext.bind(SocketAddress, ChannelPromise)
ChannelHandlerContext.connect(SocketAddress, SocketAddress, ChannelPromise)
ChannelHandlerContext.write(Object, ChannelPromise)
ChannelHandlerContext.flush()
ChannelHandlerContext.read()
ChannelHandlerContext.disconnect(ChannelPromise)
ChannelHandlerContext.close(ChannelPromise)


**Pipeline**
pipeline is a bi-direction queue, and is filled with inbound and outbound
handlers.

**links**
http://tutorials.jenkov.com/netty/netty-tcp-client.html
http://tutorials.jenkov.com/netty/netty-tcp-server.html

**caution**
context.write is not handler.write(call tail)
