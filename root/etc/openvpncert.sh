#!/bin/sh

export EASYRSA_PKI="/etc/easy-rsa/pki"
export EASYRSA_VARS_FILE="/etc/easy-rsa/vars"
export EASYRSA_CLI="easyrsa --batch"

# Cleanup
echo -en "yes\nyes\n" | $EASYRSA_CLI init-pki

# Generate DH
$EASYRSA_CLI gen-dh

# Generate for the CA
$EASYRSA_CLI build-ca nopass

# Generate for the server
$EASYRSA_CLI build-server-full server nopass

# Generate for the client
$EASYRSA_CLI build-client-full client1 nopass

# Copy files
cp /etc/easy-rsa/pki/ca.crt /etc/openvpn/
cp /etc/easy-rsa/pki/dh.pem /etc/openvpn/
cp /etc/easy-rsa/pki/issued/server.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/server.key /etc/openvpn/
cp /etc/easy-rsa/pki/issued/client1.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/client1.key /etc/openvpn/

# Restart openvpn
/etc/init.d/openvpn restart

echo "OpenVPN Cert renew successfully"
