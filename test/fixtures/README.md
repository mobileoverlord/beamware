# Generating SSL certificates for use with tests

### Install dependency

On Mac OS:

`brew install cfssl`

On other platforms `cfssl` can be installed from their github repo
https://github.com/cloudflare/cfssl

## Generate positive SSL certificates

### Create certificate authority

 - `cd certs`
 - `cfssl gencert -initca ../cert_config/ca-csr.json | cfssljson -bare ca -`

> If this were a real CA, `ca-key.pem` file should be kept in a safe place (e.g. not on a computer connected to the internet)

### Server certificate

 - `cd certs`
 - `cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../cert_config/ca-config.json -profile=www ../cert_config/server.json | cfssljson -bare server`

### Client certificate(s)

For as many devices as you want.  The `CN` will be passed to the server as the device serial

 - `cd certs`
 - `echo '{"CN":"hub-1234","hosts":[""],"key":{"algo":"ecdsa","size":256}}' | cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../cert_config/ca-config.json -profile=client - | cfssljson -bare hub-1234`

## Generate negative SSL certificates

### Create certificate authority

 - `cd certs`
 - `cfssl gencert -initca ../cert_config/ca-csr.json | cfssljson -bare ca-fake -`

### Client certificate(s)

For as many devices as you want.  The `CN` will be passed to the server as the device serial

 - `cd certs`
 - `echo '{"CN":"hub-fake","hosts":[""],"key":{"algo":"ecdsa","size":256}}' | cfssl gencert -ca=ca-fake.pem -ca-key=ca-fake-key.pem -config=../cert_config/ca-config.json -profile=client - | cfssljson -bare hub-fake`
