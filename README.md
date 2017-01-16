 Environments
===================
Bits and pieces for setting up environments. First off is Let's Encrypt certs with auto renewal on CentOS 7.

Certificates from Let's Encrypt are installed using.

```
sudo mkdir /opt/certbot
sudo chown $USER:$USER /opt/certbot
git clone https://github.com/certbot/certbot.git /opt/certbot
sudo servicectl stop httpd.service
/opt/certbot/certbot-auto certonly --standalone
sudo servicectl start httpd.service
```

For auto renewal of certificate, place the files `centos7/opt/le-renew-certificates.sh` and `centos7/opt/le-cybermoose.org-webroot.ini`
in `/opt/`.

Run `le-renew-certificates.sh` as root in a cron job every third day or so to auto renew the cert when it's about to expire.

Example crontab entry:

```
2 15 */3 * * /opt/le-renew-certificates.sh
``` 