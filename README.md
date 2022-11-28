# net-conf
Configurations pour le projet de réseau

```shell
sudo dnf install bind
git clone https://github.com/polo74/net-conf
cd net-conf/dns
./export.sh
```

Penser à bien installer bind avant de recopier les données du DNS afin de ne pas avoir de problèmes avec SELinux.
