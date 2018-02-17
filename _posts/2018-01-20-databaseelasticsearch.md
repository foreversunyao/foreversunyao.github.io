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

Node type:
Master-eligible node
A node that has node.master set to true (default), which makes it eligible to be elected as the master node, which controls the cluster.
Data node
A node that has node.data set to true (default). Data nodes hold data and perform data related operations such as CRUD, search, and aggregations.
Ingest node
A node that has node.ingest set to true (default). Ingest nodes are able to apply an ingest pipeline to a document in order to transform and enrich the document before indexing. With a heavy ingest load, it makes sense to use dedicated ingest nodes and to mark the master and data nodes as node.ingest: false.
Tribe node
A tribe node, configured via the tribe.* settings, is a special type of coordinating only node that can connect to multiple clusters and perform search and other operations across all connected clusters.

Coordinating node:
Every node is implicitly a coordinating node.A search request, for example, is executed in two phases which are coordinated by the node which receives the client request — the coordinating node.In the scatter phase, the coordinating node forwards the request to the data nodes which hold the data. Each data node executes the request locally and returns its results to the coordinating node. In the gather phase, the coordinating node reduces each data node’s results into a single global resultset.
Every node is implicitly a coordinating node. This means that a node that has all three node.master, node.data and node.ingest set to false will only act as a coordinating node, which cannot be disabled. As a result, such a node needs to have enough memory and CPU in order to deal with the gather phase.

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
