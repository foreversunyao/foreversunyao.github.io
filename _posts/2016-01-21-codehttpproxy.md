---
layout: post
title: "Python-HTTP PROXY"
date: 2016-01-20 10:50:06
description: HTTP PROXY for Nagios monitor Nginx TCP 
tags: 
 - code
---

**HTTP PROXY for Nginx**

    #!/usr/bin/python
    import subprocess
    import os
    from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler 
    
    class HTTPHandler(BaseHTTPRequestHandler):
    	def do_GET(self):
    		errorcode = {'error':2,'success':0}
    		buf=errorcode['error']
    		## check nginx configuration
    		config_output=subprocess.call(["/etc/init.d/nginx configtest"], shell=True)
    		## check nginx status
    		status_process=subprocess.Popen("ps -ef|grep 'nginx: master process'|grep -v grep|wc -l",shell=True, stdout=subprocess.PIPE)
    		status_output=status_process.stdout.read()
    		if (config_output==0) and (int(status_output)==1):
    			buf= errorcode['success']
    		else:
    			buf= errorcode['error']
    		self.protocal_version = "HTTP/1.1"
            	self.send_response(200)  
            	self.send_header("Welcome","Contect") 
            	self.end_headers()  
    		self.wfile.write(buf)
    http_server = HTTPServer(('0.0.0.0',50000),HTTPHandler) 
    http_server.serve_forever()



**Nagios Plugin**


    #!/usr/bin/python
    # coding=utf-8
    #
    # Check Nginx status and configuration
    # By Samuel
    #

    import sys
    import httplib, subprocess
    
    if __name__ == '__main__':
        FATAL = 2
        SUCCESS = 0
        REMOTE_PORT = 50000
        total = len(sys.argv)
        exit_code=FATAL
        if total != 2:
            print("Usage: python xxx ipaddress")
            sys.exit(exit_code)
        HOST=str(sys.argv[1])
        c = httplib.HTTPConnection(HOST,REMOTE_PORT)
        c.request('GET', '/', '{}')
        exit_code = c.getresponse().read()
        if int(exit_code) == SUCCESS:
            print "Nginx is OK"
        else:
            print "Nginx has issue"
        sys.exit(int(exit_code))
