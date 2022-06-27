---
layout: post
title: "cache"
date: 2021-11-15 10:25:06
description: cache, promise, future
tags:
 - system
---
**Cache**
All is well but latency is an issue. The backend you use is slow. To address this, you notice that the vast majority — perhaps 90% — of the requests are the same. One common solution is to introduce a cache: before hitting the backend, you check your cache and use that value if present.

![img]({{ '/assets/images/cloud/cache.png' | relative_url }}){: .center-image }*(°0°)*

**Promise**
A Promise is an object that represents a unit of work producing a result that will be fulfilled at some point in the future. You can “wait” on this promise to be complete, and when it is you can fetch the resulting value. 
At Instagram, when turning up a new cluster we would run into a thundering herd problem as the cluster’s cache was empty. We then used promises to help solve this: instead of caching the actual value, we cached a Promise that will eventually provide the value. When we use our cache atomically and get a miss, instead of going immediately to the backend we create a Promise and insert it into the cache.

![img]({{ '/assets/images/cloud/promise.png' | relative_url }}){: .center-image }*(°0°)* 
