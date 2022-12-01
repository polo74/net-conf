# DNS

## Installation du serveur DNS

```shell

# Installation de bind 

sudo dnf install bind -y

# Copie de notre fichier de configuration

git clone https://github.com/polo74/net-conf.git
cd net-conf/dns/
./import.sh
```

> Atention, bien penser à isntaller bind avant de copier les données. Dans l'autre sens il faut reconfigurer selinux sur certains dossiers (`var/named`)

# Démarrage du serveur

```
systemctl start named # Démarrage du service
systemctl enable named # Démarrage automatique au démarrage de l'ordinateur
systemctl status named # Vérifier que bind fonctionne correctement
```

# Configuration du pare-feu

```
sudo firewall-cmd --add-port=53/tcp
sudo firewall-cmd --add-port=53/udp
sudo firewall-cmd --runtime-to-permanent
```
