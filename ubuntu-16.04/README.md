Ubuntu 16.04
===================

```sh
sudo apt-get update
sudo apt-get install nginx letsencrypt bc
sudo openssl dhparam -out /etc/nginx/dhparams.pem 4096
sudo mkdir -p /var/www/ec2.muppfarmen.se/html
sudo chown -R "$USER":www-data /var/www/ec2.muppfarmen.se
sudo chmod -R 0755 /var/www/ec2.muppfarmen.se
sudo mkdir -p /var/www/letsencrypt
sudo chown -R "$USER":www-data /var/www/letsencrypt
sudo chmod -R 0755 /var/www/letsencrypt
sudo chown -R $USER:$USER /var/www/ec2.muppfarmen.se/html
```

Put the files in this repo in their places and create a symlink in /etc/nginx/sites-enabled to the new host.

When the letsencrypt stuff works add the following line to crontab:

```sh
7 3,15 * * * /opt/le-renew-certificates.sh
```
Install Team Fortress 2 server
==============================
```sh
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install steamcmd
```

Run steamcd to install the server of your choice.
```sh
sudo apt-get install libtinfo5:i386 libncurses5:i386 libcurl3-gnutls:i386
```
