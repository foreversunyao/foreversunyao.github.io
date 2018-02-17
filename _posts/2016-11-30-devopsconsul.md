---
layout: post
title: Elasticsearch(Ongoing)"
date: 2018-01-20 09:25:06
description: a search engine
tags: 
 - database
---

**Lucene**
Apache LuceneTM is a high-performance, full-featured text search engine library written entirely in Java. It is a technology suitable for nearly any application that requires full-text search, especially cross-platform.

Reverse_index:
![img]({{ '/assets/images/devops/lucene_reverse_index.png' | relative_url }}){: .center-image }*(°0°)*
![img]({{ '/assets/images/devops/lucene_query.png' | relative_url }}){: .center-image }*(°0°)*

**Elasticsearch Architecture**

![img]({{ '/assets/images/devops/es_shard.png' | relative_url }}){: .center-image }*(°0°)*
![img]({{ '/assets/images/devops/es_post.png' | relative_url }}){: .center-image }*(°0°)*
![img]({{ '/assets/images/devops/es_get.png' | relative_url }}){: .center-image }*(°0°)*


**Configuration**

 - Cluster:
node.master 
node.data
cluster.name
discovery.zen.ping.multicast.enabled
discovery.zen.ping.unicast.hosts
discovery.zen.minimum_master_nodes
 - Shards:
index.number_of_shards
cluster.routing.allocation.same_shard.host
 - Replicas:
index.number_of_replicas
 - Durable:
gateway.type
 - Transport:
transport.tcp.port
http.port
 - Recovery:
gateway.recover_after_nodes
gateway.recover_after_time
gateway.expected_nodes
cluster.routing.allocation.node_initial_primaries_recoveries
cluster.routing.allocation.node_concurrent_recoveries
indices.recovery.max_size_per_sec
indices.recovery.concurrent_streams
 - Memory:
bootstrap.mlockall
 - Path:
path.conf
path.data
path.work
path.logs
path.plugins
 - Memory:
bootstrap.mlockall
 - Network:
network.bind_host
network.publish_host
network.host
http.enabled
http.max_content_length
transport.tcp.compress
 - Cache
index.cache.field.type
index.cache.field.max_size
index.cache.field.expire
 - Translog
index.translog.flush_threshold_ops
index.translog.flush_threshold_size
index.translog.flush_threshold_period
index.translog.interval
index.gateway.local.sync
 - Other:
action.destructive_requires_name

**Tuning**
 - Tips:

es:
datanode: node.master: false;node.data: true;http.enabled: false
masternode: node.master: true;node.data: false; http.enabled: true
bootstrap.mlockall: true
minimum_master_nodes:(based on quorum, node/2+1)
discovery.zen.ping.multicast.enabled: false
action.destructive_requires_name:true
action.auto_create_index: false
indices.fielddata.cache.size: 30%
indices.cache.filter.size: 30%
threadpool.bulk.queue_size: 5000
threadpool:
    index:
        type: fixed
        size: 100
    search:
        type: fixed
        size: 1000
jvm:
-Xmx16g -Xms16g
JAVA_OPTS=”$JAVA_OPTS -XX:+UseG1GC”
JAVA_OPTS=”$JAVA_OPTS -XX:MaxGCPauseMillis=200″

os:
vm.swappiness = 1
ulimit -n 65536
ulimit -l unlimited
ulimit -s unlimited
vm.max_map_count=655300
fs.file-max=518144
net.core.somaxconn=65535

hardware:
SSD raid0
RAM 96G
NIC 10Gb

**Monitor**
[grafana](https://grafana.com/dashboards/878)

**CommandsandTools**
curl -XGET -u elastic:password http://localhost:9200/_cluster/health?pretty
status:green/yellow(replicate has issue)/red(master has issue)
curl -XGET -u elastic:password http://localhost:9200/_nodes/stats?pretty=true
curl -XGET -u elastic:password http://localhost:9200/_cluster/pending_tasks?pretty
curl -XPOST 'http://localhost:9200/_tasks/task_id:175591/_cancel'
curl -XGET -u elastic:password http://localhost:9200/_cat/nodes?help
curl -XPOST 'http://localhost:9200/xx/_optimize'
