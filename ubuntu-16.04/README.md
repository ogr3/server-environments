Ubuntu 16.04
===================

```sh
sudo apt-get update
sudo apt-get install nginx letsencrypt bc
sudo openssl dhparam -out /etc/nginx/ssl/dhparams.pem 2048
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
