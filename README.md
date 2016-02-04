Server Environments
===================
Bits and pieces for setting up environments. First off is letsencrypt certs with auto renewal on CentOS 7.

Certificates from Let's encrypt are installed using.

```
sudo mkdir /opt/letsencrypt
sudo chown <user>:<user> letsencrypt
git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
sudo servicectl httpd.service stop
/opt/letsencrypt/letsencrypt-auto certonly --standalone
sudo servicectl httpd.service start
```

For auto renewal of certificate, place the files `centos7/opt/le-renew-certificates.sh` and `centos7/opt/le-cybermoose.org-webroot.ini`
in `/opt/`.

Run `le-renew-certificates.sh` as root in a cron job every third day or so to auto renew the cert when it's about to expire.

Example crontab entry:

```
2 15 */3 * * /opt/le-renew-certificates.sh
``` 