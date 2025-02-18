#!/bin/bash

echo "Generating Renewal Files..."

sudo certbot certonly --standalone --preferred-chain "ISRG Root X1"

read -p "Enter the full path to the directory containing the certificate files (e.g., /etc/letsencrypt/live/yourdomain.com): " cert_path 

if [[ ! -d "$cert_path" ]]; then
    echo "Error: Directory '$cert_path' does not exist. Please provide a valid path."
    exit 1
fi

echo "Installing certificate files..."

cp $cert_path/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key

chown zimbra:zimbra /opt/zimbra/ssl/zimbra/commercial/commercial.key

wget -O /tmp/ISRG-X1.pem https://letsencrypt.org/certs/isrgrootx1.pem.txt

cat /tmp/ISRG-X1.pem >> $cert_path/chain.pem

cp $cert_path/* /opt/zimbra/ssl/letsencrypt/

chown zimbra:zimbra /opt/zimbra/ssl/letsencrypt/*

ls -la /opt/zimbra/ssl/letsencrypt/

echo "Verifying certificates..."

su - zimbra -c "cd /opt/zimbra/ssl/letsencrypt && \
/opt/zimbra/bin/zmcertmgr verifycrt comm privkey.pem cert.pem chain.pem"

sleep 2

echo "Deploying certificates..."

su - zimbra -c cp /opt/zimbra/ssl/letsencrypt/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key
su - zimbra -c /opt/zimbra/bin/zmcertmgr deploycrt comm cert.pem chain.pem

su - zimbra -c zmcontrol restart

echo "Certificate renewal and deployment completed successfully!"