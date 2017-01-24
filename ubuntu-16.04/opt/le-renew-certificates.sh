#!/bin/bash

WEB_SERVICE='nginx'
CONFIG_FILE='/opt/le-ec2.muppfarmen.se-webroot.ini'
EXP_LIMIT=35;

if [ ! -f $CONFIG_FILE ]; then
        echo "[ERROR] config file does not exist: $CONFIG_FILE"
        exit 1;
fi

DOMAIN=`grep "^\s*domains" $CONFIG_FILE | sed "s/^\s*domains\s*=\s*//" | sed 's/(\s*)\|,.*$//'`
CERT_FILE="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

if [ ! -f $CERT_FILE ]; then
	echo "[ERROR] certificate file not found for domain $DOMAIN."
fi

DATE_NOW=$(date -d "now" +%s)
EXP_DATE=$(date -d "`openssl x509 -in $CERT_FILE -text -noout | grep "Not After" | cut -c 25-`" +%s)
EXP_DAYS=$(echo \( $EXP_DATE - $DATE_NOW \) / 86400 |bc)

echo "Checking expiration date for $DOMAIN..."

if [ "$EXP_DAYS" -gt "$EXP_LIMIT" ] ; then
	echo "The certificate is up to date, no need for renewal ($EXP_DAYS days left). Expiry limit set to $EXP_LIMIT days."
	exit 0;
else
	echo "The certificate for $DOMAIN is about to expire soon. Starting webroot renewal script..."
    letsencrypt certonly --renew-by-default --config $CONFIG_FILE
	echo "Reloading $WEB_SERVICE"
	/usr/sbin/service $WEB_SERVICE reload
	echo "Renewal process finished for domain $DOMAIN"
	exit 0;
fi

