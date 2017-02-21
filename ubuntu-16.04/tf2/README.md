Install Team Fortress 2 server
==============================
```sh
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install steamcmd
```

Run steamcmd to install the server of your choice.

```sh
steamcmd +runscript /home/ubuntu/tf2server-script
```

Install needed i386 packages

```sh
sudo apt-get install libtinfo5:i386 libncurses5:i386 libcurl3-gnutls:i386
```

Install as service
==================
```sh
sudo systemctl daemon-reload
sudo systemctl enable tf2server.service
```

start in screen:
```sh
/home/ubuntu/tf2server.sh
```
