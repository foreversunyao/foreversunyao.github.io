---
layout: post
title: "Docker security"
date: 2022-02-01 17:25:06
description: Linux, Docker, security
tags: 
 - linux
---

- Keep host and docker up to Date
- Do not expose docker daemon socket
Never make the daemon socket available for remote connections, unless you are using Docker's encrypted HTTPS socket, which supports authentication.
Do not run Docker images with an option like -v /var/run/docker.sock://var/run/docker.sock, which exposes the socket in the resulting container.
- Run docker in rootless mode
- Avoid priviledged containers
Docker provides a privileged mode, which lets a container run as root on the local machine. Running a container in privileged mode provides the capabilities of that host—including:
Root access to all devices
Ability to tamper with Linux security modules like AppArmor and SELinux
Ability to install a new instance of the Docker platform, using the host's kernel capabilities, and run Docker within Docker.
- Limit container resources
- Segregate Container networks
overlay network
not host, not bridge
- Complete lifecycle management
vulnerability scanning
- use minimal base images
alpine
- dont leak sensitive info to docker images
- secure container registries
- watch docker folders
```
/var/lib/docker
/etc/docker
Docker.service
Docker.socket
/etc/default/docker
/etc/docker/daemon.json
/etc/sysconfig/docker
/usr/bin/containerd
/usr/sbin/runc
```
- Use copy instead of add in Dockerfile
add could add malicious files from remote URLs
- Enable Docker Content Trust(DCT)
Docker Content Trust (DCT) uses digital signatures to validate integrity of the images being pulled from the remote Docker registries.

- Capabilities
```
--cap-add
--cap-drop
```

- encrypted container images
- scanning for images, Notary 
- audit
