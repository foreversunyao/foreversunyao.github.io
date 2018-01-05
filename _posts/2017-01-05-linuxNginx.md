---
layout: post
title: "Nginx"
date: 2016-02-02 10:25:06
description: HTTP(S) TCP of Nginx
tags: 
 - linux
---

![img]({{ '/assets/images/linux/Nginx-internal.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/linux/Nginx.png' | relative_url }}){: .center-image }*(°0°)*


**epoll,poll,select**


**nginx worker,fastcgi,socket**



**LINUX Tuning For NGINX**
net.ipv4.tcp_max_tw_buckets=260000 ---The  maximum number of sockets in TIME_WAIT state allowed in the system.
net.ipv4.tcp_tw_reuse = 1  ---depend on "echo 1 > /proc/sys/net/ipv4/tcp_timestamps"
net.ipv4.tcp_tw_recycle = 0   ---Dangerous:reuse not clean tcp connection
net.ipv4.tcp_fin_timeout = 10 ---This  specifies  how many seconds to wait for a final FIN packet before the socket is forcibly closed.
net.ipv4.ip_local_port_range = 10000 65000 ---more ports can be used
net.core.somaxconn = 65535
net.core.netdev_max_backlog = 65535
sys.fs.file_max = 3252969
nofile = 655350


**Nginx Configuration Tuning**



**HTTP(S) Web Server**

static:
http {
	    server {
			    listen 80;
				server_name test.samuel.com;
				location / {
						root /var/www/test.samuel.com;
						index index.html;
			    }
	    }
}

dynamic:
http {
	    server {
			    listen 80;
				server_name test.samuel.com;
  				location / {
		        fastcgi_pass  localhost:9000;
		        fastcgi_index index.php;
		        fastcgi_param SCRIPT_FILENAME /home/www/scripts/php\$fastcgi_script_name;
		        fastcgi_param QUERY_STRING    \$query_string;
		        fastcgi_param REQUEST_METHOD  \$request_method;
		        fastcgi_param CONTENT_TYPE    \$content_type;
		        fastcgi_param CONTENT_LENGTH  \$content_length;
    			}
		}
}

https:
http {
    ssl_session_cache   shared:SSL:10m;
    ssl_session_timeout 10m;
    server {
	        listen              443 ssl;
	        server_name         www.samuel.com;
	        keepalive_timeout   70;
	        ssl_certificate     www.samuel.com.crt;
	        ssl_certificate_key www.samuel.com.key;
	        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
	        ssl_ciphers         HIGH:!aNULL:!MD5;
	        server_name test.samuel.com;
    		location / {
		    		root /var/www/test.samuel.com;
		   			index index.html;
		   	}
	}
}

**TCP PROXY SERVER**
tcp:
upstream db-mysql1 {
    server ip:3306 max_fails=3 fail_timeout=60 weight=1;
    server ip:3306 max_fails=3 fail_timeout=60 weight=1;
}
server {
    listen 50001;
    proxy_connect_timeout 1s;
    proxy_timeout 1m;
    proxy_pass db-mysql1;
    allow ip1;
}

