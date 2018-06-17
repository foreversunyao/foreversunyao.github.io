---
layout: post
title: "Puppet"
date: 2018-06-06 20:50:06
description: Puppet
tags: 
 - devops
---

Puppet, from Puppet Labs, is a configuration management tool that helps system administrators automate the provisioning, configuration, and management of a server infrastructure.It is written in Ruby. 
Puppet has been build with 2 modes:
  1) Client Server Mode : Central Server & Agents running on Separate Nodes.
  2) Serverless Mode      : Single process does all the work.

**Puppet Master and Agent**
Puppet Master server, where all of your configuration data will be managed and distributed from, and all your remaining servers will be Puppet Agent nodes, which can be configured by the puppet master server. Default port is 8140.

![img]({{ '/assets/images/devops/puppet.png' | relative_url }}){: .center-image }*(°0°)*

**Puppet Configuration**
puppet master --genconfig >> /etc/puppet/puppet.conf
manifests/site.pp
namespaceauth.conf -- kick
auth.conf -- ACL
autosign.conf
fileserver.conf

[main]
server = master.file
autoflush = fals # flush log
logdir = /var/log/puppet
rundir = /var/run/puppet

[master]
reportdir = /var/lib/puppet/reports
autosign = true
autosign = /etc/puppet/autosign.conf
bindaddress = 0.0.0.0
masterport = 8140
evaltrace = true

[agent]
certname = slave1.file
daemonize = true
allow_duplicate_certs = true
report = true
reports = store, http
report_server = master.file
report_port = 8140
reporturl = http://localhost:3000/reports/upload
runinterval = 20m
splay = true
splaylimit = 10m
configtimeout = 2m
color = ansi
ignorecache = true

[puppet_nginx](https://github.com/voxpupuli/puppet-nginx/blob/master/manifests/service.pp)

**Puppet Command**
apply，agent，master，cert，describe，module，kick(master push)

puppet master --genconfig
puppet agent --noop
puppet agent --test

puppet apply -l /tmp/init.pp init.pp  -- will not connect master

puppet cert list
puppet cert sign agent.domain.com
puppet cert list --all
puppet cert sign --all


**Prerequisties**
Private Network DNS
Firewall Open Ports
NTP

**modules**
[refer](https://forge.puppet.com/)
