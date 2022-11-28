# Monitoring

On utilise Prometheus et Grafanda

## Installation de Prometheus

Téléchargement et extraction

```shell
wget https://github.com/prometheus/prometheus/releases/download/v2.40.3/prometheus-2.40.3.linux-armv7.tar.gz
gzip -d prometheus-2.40.2.linux-amd64.tar.gz
tar -xvf prometheus-2.40.2.linux-amd64.tar
sudo cp prometheus-2.40.2.linux-amd64 /opt/prometheus/
```

Création d'un service 

On édite le fichier `suivant /etc/systemd/system/prometheus.service` et on ajoute le contenu suivant

```
[Unit]
Description=Prometheus Server
Wants=network-online.target
After=network-online.target

[Service]
#User=prometheus
#Group=prometheus
Type=simple
ExecStart= /opt/prometheus/prometheus \
--config.file=/opt/prometheus/prometheus.yml \
--web.console.templates=/opt/prometheus/consoles \
--web.console.libraries=/opt/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

### Ajout d'une nouvelle machine

Ajout d'un node exporter sur le client

```
wget https://github.com/prometheus/node\_exporter/releases/download/v1.4.0/node\_exporter-1.4.0.linux-armv7.tar.gz
tar -xzf node\_exporter-1.4.0.linux-armv7.tar.gz
sudo cp node\_exporter-1.4.0.linux-armv7 /opt/exporter
```

Création du service

On crée le fichier `/etc/systemd/system/exporter.service` et on renseigne le contenu suivant:

```
[Unit]
Description=Prometheus exporter
Wants=network.target network-online.target
After=network.target network-online.target

[Service]
ExecStart=/opt/exporter/node\_exporter

[Install]
WantedBy=multi-user.target
```

Lancement du service

```
sudo systemctl start exporter.service
sudo systemctl enable exporter.service # Pour redémarer automatiquement au reboot
```

Ajout de la machine sur le serveur prometheus

On modifie le fichier `/opt/prometheus/prometheus.yml` et on ajoute dans la section `scrape_configs` le contenu suivant

```yml
- job_name: "<name>"
	static_configs:
	- targets: ["<target ip>:<target port>"]
```

On peut noter que le port par défaut est 9100

## Installation de Grafanda