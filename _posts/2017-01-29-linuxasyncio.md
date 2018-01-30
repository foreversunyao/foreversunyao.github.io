---
layout: post
title: "Linux AsyncIO and SyncIO"
date: 2017-01-29 11:25:06
description: Linux AsyncIO and SyncIO and select, poll and epoll
tags: 
 - linux
---


**Synchronus I/O**
 - Blocking I/O
![img]({{ '/assets/images/linux/Blocking-IO.png' | relative_url }}){: .center-image }*(°0°)*

 - Non-blocking I/O
![img]({{ '/assets/images/linux/NonBlocking-IO.png' | relative_url }}){: .center-image }*(°0°)*

 - I/O multiplexing
![img]({{ '/assets/images/linux/IO-Multiplexing.png' | relative_url }}){: .center-image }*(°0°)*


 - select 
select(int nfds, fd_set *r, fd_set *w, fd_set *e, struct timeval *timeout)
With select(), your application needs to provide three interest sets, r, w, and e. Each set is represented as a bitmap of your file descriptor. 
The call is blocked, until one or more file descriptors in the interest sets become ready, so you can perform operations on those file descriptors without blocking. Upon return, the kernel overwrites the bitmaps to specify which file descriptors are ready.
 
 - poll
poll(struct pollfd *fds, int nfds, int timeout)
struct pollfd {
    int fd;
    short events;
    short revents;
}
poll() does not rely on bitmap, but array of file descriptors (thus the issue #1 solved). By having separate fields for interest (events) and result (revents).

 - epoll
int epoll_create(int size);
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout);

Here are the steps to using epoll:

Call epoll_create to tell the kernel you’re gong to be epolling! It gives you an id back
Call epoll_ctl to tell the kernel file descriptors you’re interested in updates about. Interestingly, you can give it lots of different kinds of file descriptors (pipes, FIFOs, sockets, POSIX message queues, inotify instances, devices, & more), but not regular files. I think this makes sense – pipes & sockets have a pretty simple API (one process writes to the pipe, and another process reads!), so it makes sense to say “this pipe has new data for reading”. But files are weird! You can write to the middle of a file! So it doesn’t really make sense to say “there’s new data available for reading in this file”.
Call epoll_wait to wait for updates about the list of files you’re interested in.

{% highlight bash %}
# operations  |  poll  |  select   | epoll
10            |   0.61 |    0.73   | 0.41
100           |   2.9  |    3.0    | 0.42
1000          |  35    |   35      | 0.53
10000         | 990    |  930      | 0.66
{% endhighlight %}

**Asynchronus I/O**
 - Asynchronous I/O
![img]({{ '/assets/images/linux/Async-IO.png' | relative_url }}){: .center-image }*(°0°)*
