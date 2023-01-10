---
layout: post
title: "Linux GPG"
date: 2020-06-30 17:25:06
description: Linux GPG, Gnu Privacy Guard, repository
tags: 
 - linux
---

# GPG key
1. GPG key is a software which provides cryptographic privacy and authentication. it allows users to communicate with public-key crpytography.

# GPG on Repository
1. workflow is linux admin -> package manager -> repository (package metadata, packages and its dependencies)
2. Every repository added its public GPG key to your system's trusted keys. The packages from the repositories are ‘signed’ by this GPG key(private) and thanks to the stored public key, your system verifies that the package is coming from the repository.

# Listing keys
1. Trusted keys
```
/etc/apt/trusted.gpg – Keyring of local trusted keys; new keys will be added here.
/etc/apt/trusted.gpg.d/ – File fragments for the trusted keys; additional keyrings can be stored here (by other packages or the administrator).
```
2. apt-key
- list , apt-key list
- remove, sudo apt-key del <last 8 characters of key> and apt-update

3. find missing public key
- from URL: 
```
curl --silent https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | sudo apt-key add -
OK
```
- from keyserver
```
sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/rabbit.gpg --keyserver keyserver.ubuntu.com --recv 6B73A36E6026DFCA
```

# fingerprint
1.  a public key fingerprint is a short sequence of bytes used to identify a longer public key

# retrevie and add to trusted set of keys
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --keyserver-options http-proxy=xxx  --recv-keys xxx

# Commands
[refer](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/)
