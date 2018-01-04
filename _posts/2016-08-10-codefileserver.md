---
layout: post
title: "Python-File Server"
date: 2016-08-10 10:50:06
description: File Server based on leveldb, support upload,retrieve,delete file
tags: 
 - code
---

**http_file_server_leveldb.py**
    #!/bin/python2.7
    
    """Simple HTTP Server.

    Support upload files
    Support search files
    Support delete files
    Support force upload files
    """
    
    """Limit.
    Only implement Post request
    """
    
    """Usage.
    For server:
    mkdir -p /var/upload/
    chmod 600 /var/upload
    python http_file_server_leveldb.py
    
    For client:
    Upload:
    import requests
    files ={'file': open('abc.txt')}
    url='http://ip:8000/api/upload'
    r = requests.post(url, files=files)
    print r.text
    print r.status_code
    """
    
    """
    Author:Samuel 
    Date:20171118
    """
    
    import BaseHTTPServer
    import cgi
    import leveldb
    
    class SimpleHTTPRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
        
        def do_GET(self,filename,content):
            """Serve a GET request."""
            self.send_response(200)
            self.send_header("Content-Type", 'application/octet-stream')
            self.send_header("Content-Disposition", 'attachment; filename="%s"' % filename)
            self.send_header("Content-Length", len(content))
            self.end_headers()
    	self.wfile.write(content)
    
        def return_POST(self,r,m):
    	## REPONSE INFO
    	info_code = {0: 'upload success',1: 'upload failed',2: 'exists file',3: 'this file not exist',4: 'delete success',5: 'api not support',6: 'server error'}
    	reponse_code = {1: 200,2: 500}
            
    	self.send_response(reponse_code[r])
    	self.send_header("Content-type", "text/html")
            self.end_headers()
            self.wfile.write("<html><head><title>Response.</title></head>")
            self.wfile.write("<body><p>OK</p>")
            self.wfile.write("<p>%s</p>" % info_code[m])
            self.wfile.write("</body></html>")
            self.wfile.close()
    
        def do_POST(self):
            """Serve a POST request."""
    	form = cgi.FieldStorage(
                        fp=self.rfile,
                        headers=self.headers,
                        environ={'REQUEST_METHOD': 'POST',
                                 'CONTENT_TYPE': self.headers['Content-Type'],
                                 })
    	if "/api/upload" in self.path:
    		self.upload_file(form)
    	elif "/api/retrieve" in self.path:
    		self.retrieve_file(form)
    	elif "/api/delete" in self.path:
    		self.delete_file(form)
    	elif "/api/forceupload" in self.path:
    		self.force_upload(form)
    	else :
    		self.return_POST(2,5)
        def get_dbconn(self):
    	db = leveldb.LevelDB("/var/upload/db", create_if_missing=True)
    	return db
        def search_file(self,filename):
    	try:
    		db = self.get_dbconn()
            	db.Get(filename)
    	except:
    		print "This file "+filename+" not exist."
    		return 0
            return 1
    	
        def upload_file(self,form):
    	filename = form['file'].filename
            filevalue = form['file'].value
    	if self.search_file(filename) == 0:
    		try:
    			db = self.get_dbconn()
    			db.Put(filename,filevalue)
    			self.return_POST(1,0)
    		except:
    			print "Write File "+filename+" Failed."
    			self.return_POST(2,6)
    	else:
    		self.return_POST(1,2)
    
    
        def retrieve_file(self,form):
            filename = form['file'].filename
    	filevalue = form['file'].value
    	if self.search_file(filename) == 0:
    		    self.return_POST(1,3)
    	else:
    		try:
    		    db = self.get_dbconn()
    		    content = db.Get(filename)
    	            self.do_GET(filename,content)		
    		except:
    		    print "Retrieve File "+filename+" Failed."
                        self.return_POST(2,6)
    
        def delete_file(self,form):
            filename = form['file'].filename
    	filevalue = form['file'].value
    	if self.search_file(filename) == 0:
    		    self.return_POST(1,3)
    	else:
    		    try:
    		    	db = self.get_dbconn()
    		    	db.Delete(filename)
    		    	self.return_POST(1,4)
    		    except:
    			print "Delete File "+filename+" Failed."
    			self.return_POST(2,6)
    
        def force_upload(self,form):
    	### Never consider if there is any file has the same filename, just cover
            filename = form['file'].filename
            filevalue = form['file'].value
            try:
                 db = self.get_dbconn()
                 db.Put(filename,filevalue)
                 self.return_POST(1,0)
            except:
                 print "Write File "+filename+" Failed."
                 self.return_POST(2,6)
    
    def run_server(HandlerClass = SimpleHTTPRequestHandler,
             ServerClass = BaseHTTPServer.HTTPServer):
        BaseHTTPServer.test(HandlerClass, ServerClass)
    
    
    if __name__ == '__main__':
        run_server()


**http_file_server_client_test.py**

    #!/bin/python2.7
    import requests
    files = {'file': open('merge.txt')}
    
    files2 = {'file': open('file.txt')}
    files3 = {'file': open('1.txt')}

    #url='http://ip:8000/ttt/mmmm111'
    #r = requests.post(url, files=files2)
    #print r.text
    #print r.status_code
    #
    url='http://ip:8000/api/upload'
    r = requests.post(url, files=files2)
    print r.text
    print r.status_code
    
    url='http://ip:8000/api/forceupload'
    r = requests.post(url, files=files3)
    print r.text
    print r.status_code
    
    url='http://ip:8000/api/retrieve'
    r = requests.post(url, files=files2)
    print r.text
    print r.status_code
    
    url='http://ip:8000/api/retrieve'
    r = requests.post(url, files=files3)
    print r.text
    print r.status_code
    
    
    url='http://ip:8000/api/delete'
    r = requests.post(url, files=files2)
    print r.text
    print r.status_code
    
    url='http://ip:8000/api/delete'
    r = requests.post(url, files=files3)
    print r.text
    print r.status_code
    
    
    url='http://ip:8000/api/retrieve'
    r = requests.post(url, files=files2)
    print r.text
    print r.status_code
    
    url='http://ip:8000/api/retrieve'
    r = requests.post(url, files=files3)
    print r.text
    print r.status_code
