#!/bin/bash
##############################################################################
# Script that can be placed in /opt and used for renewing certificates from
# Let's Encrypt (https://letsencrypt.org/). Using webroot method.
# The machine needs to listen to port 80 so that let's encrypt callback can
# access the ACME challenge.
#
# Targeted towards CentOS 7 and Apache, but can easily be modified to use
# other web server and init method.
#
# Needs to run as root. Example crontab entry (run every third day):
# 2 15 */3 * * /opt/le-renew-certificates.sh
##############################################################################

WEB_SERVICE='httpd.service'
CONFIG_FILE='/opt/le-cybermoose.org-webroot.ini'
LE_PATH='/opt/certbot'
EXP_LIMIT=30;

if [ $EUID -ne 0 ]; then
  echo "[ERROR] This script must be run as root." 1>&2
  exit 1;
fi

if [ ! -f ${CONFIG_FILE} ]; then
  echo "[ERROR] config file does not exist: $CONFIG_FILE"
  exit 1;
fi

DOMAIN=$(grep "^\s*domains" ${CONFIG_FILE} | sed "s/^\s*domains\s*=\s*//" | sed "s/(\s*)\|,.*$//")
CERT_FILE="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

if [ ! -f ${CERT_FILE} ]; then
  echo "[ERROR] certificate file not found for domain $DOMAIN."
  exit 1;
fi

DATE_NOW=$(date -d "now" +%s)
EXP_DATE=$(date -d "$(openssl x509 -in ${CERT_FILE} -text -noout | grep "Not After" | cut -c 25-)" +%s)
EXP_DAYS=$(echo \( ${EXP_DATE} - ${DATE_NOW} \) / 86400 |bc)

echo "Checking expiration date for $DOMAIN..."

if [ "$EXP_DAYS" -gt "$EXP_LIMIT" ] ; then
  echo "The certificate is up to date, no need for renewal ($EXP_DAYS days left). Expiry limit set to $EXP_LIMIT days."
  exit 0;
else
  echo "The certificate for $DOMAIN is about to expire soon. Starting webroot renewal script..."
  ${LE_PATH}/certbot-auto certonly --renew-by-default --config ${CONFIG_FILE}
  echo "Reloading $WEB_SERVICE"
  systemctl reload ${WEB_SERVICE}
  echo "Renewal process finished for domain $DOMAIN"
  exit 0;
fi
