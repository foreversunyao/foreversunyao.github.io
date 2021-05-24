---
layout: post
title: OpenSSL
date: 2018-09-10 21:25:06
description: OpenSSL
tags: 
 - linux
---

OpenSSL:

OpenSSL is a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library.  The default SSL Profile  has a generic Common Name. 

Noun:
 - .pem stands for PEM, Privacy Enhanced Mail; it simply indicates a base64 encoding with header and footer lines. Mail traditionally only handles text, not binary which most cryptographic data is, so some kind of encoding is required to make the contents part of a mail message itself (rather than an encoded attachment). The contents of the PEM are detailed in the header and footer line - PEM itself doesn't specify a data type (just like XML or HTML doesn't, it just specifies a specific encoding structure);
 - .key can be any kind of key, but usually it is the private key - OpenSSL can wrap private keys for all algorithms (RSA, DSA, EC) in a generic and standard PKCS#8 structure, but it also supports a separate 'legacy' structure for each algorithm,
 - .csr stands for Certificate Signing Request, it is what you send to a third party when you require a certificate to be signed (by a third party), the encoding could be PEM or DER (which is a binary encoding of an ASN.1 specified structure);
 - .crt stands simply for certificate, usually an X509v3 certificate, again the encoding could be PEM or DER; a certificate contains the public key, but it contains much more information (most importantly the signature by the Certificate Authority over the data and public key, of course).
 - PKCS#12 (P12) files define an archive file format for storing cryptographic objects as a single file.

Procedure of generate a self-signed SSL certificate:
[refer](https://www.ibm.com/support/knowledgecenter/en/SSWHYP_4.0.0/com.ibm.apimgmt.cmc.doc/task_apionprem_gernerate_self_signed_openSSL.html)


Useful commands:
[refer](https://www.sslshopper.com/article-most-common-openssl-commands.html) 

```
 echo | openssl s_client -connect site:443 -servername api.com
```
