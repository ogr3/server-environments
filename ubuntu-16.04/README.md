Ubuntu 16.04
===================

```sh
sudo apt-get update
sudo apt-get install nginx letsencrypt bc
sudo openssl dhparam -out /etc/nginx/ssl/dhparams.pem 2048
```

Put the files in this repo in their places and create a symlink in /etc/nginx/sites-enabled to the new host.

When the letsencrypt stuff works add the following line to crontab:

```sh
7 3,15 * * * /opt/le-renew-certificates.sh
```
