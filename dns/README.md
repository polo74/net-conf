# DNS

## Installation du serveur DNS

```shell

# Installation de bind 

sudo dnf install bind -y

# Copie de notre fichier de configuration


```

> Atention, bien penser à isntaller bind avant de copier les données. Dans l'autre sens il faut reconfigurer selinux sur certains dossiers (`var/named`)
