---
layout: post
title: Cert Chain
date: 2020-09-10 21:25:06
description: Cert Chain, SSL, intermediate certs
tags: 
 - linux
---
**Certificate Chain**
server cert --> intermediate certs --> root cert
A certificate chain is an ordered list of certificates, containing an SSL/TLS Certificate and Certificate Authority (CA) Certificates, that enable the receiver to verify that the sender and all CA's are trustworthy.
Any certificate that sits between the SSL/TLS Certificate and the Root Certificate is called a chain or Intermediate Certificate.Root CA Certificate is the signer/issuer of the Intermediate Certificate, Intermediate Certificate is the signer/issuer of the SSL/TLS Certificate.
A root certificate, also known as the trusted root, is the certificate issued directly by the certificate authority. Unlike the other certificates, the root certificate is self-signed by the CA. The private key of the root certificate is what’s used to sign the other certificates in the hierarchy of the SSL certificates. To protect these certificates, particularly in cases involving certificate revocations, root CAs often use intermediate CAs to put some space between their trusted root certificates and the end server certificates. They never issue leaf (server) certificates from websites directly from their root certificate because it’s too risky.
The intermediate certificate serves as a buffer between the root certificate and the end entity’s server certificate. It’s signed by the private key of the root certificate that issues it. This is how trust of the intermediate certificate is established. The intermediate certificate issuer is the one who signs the SSL/TLS (server) certificate, whereas the subject is the site or organization whose identity is vouched for.
Server Certificate This is what people are talking about when they refer to SSL/TLS certificates.

**Contents**
subject: Server certificate file subject (your FQDN usually)
issuer: Intermediate CA certificate name
subject: Intermediate CA certificate name (this should match with the previous issuer value)
issuer: CA certificate subject

**Verification**
When a user visits your website, your server sends them its certificate. It will check a variety of information, such as:
```
What entity issued the certificate and to whom it was issued.
When it was issued and how long it’s valid for.
If it has a valid digital signature.
Whether the certificate has been revoked.
```
To verify the certificate is legitimate, it needs to validate the chain of trust. Here, the browser will start from the server certificate and validate all the certificates including the root certificate.

**Commands**
```
openssl s_client -connect incomplete-chain.badssl.com:443 -servername incomplete-chain.badssl.com
curl -v https://incomplete-chain.badssl.com
openssl verify cert.pem
openssl x509 -in cert.pem -noout -issuer
openssl x509 -noout -subject -in ca.pem
openssl verify -CAfile ca.pem cert.pem

```
[refer](https://medium.com/@superseb/get-your-certificate-chain-right-4b117a9c0fce)

[refer](https://sectigostore.com/blog/what-is-an-ssl-certificate-chain-how-does-it-work/)
