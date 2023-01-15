# SECURE WORDPRESS ON UBUNTU CANONICAL

## Repo update

```
sudo apt update
```

## Persistent firewall configuration for HTTPS

```
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 443 -j ACCEPT
sudo netfilter-persistent save
```
## Apache Server install

```
sudo apt -y install apache2
```

## Add corresponding <domain-name>/<public-ip-address> record in Bind server (DNS)

> Check DNS part

## Verify domain to generate SSL certificate (Let's Encrypt works fine)

## Add SSL certificate path in Apache conf (assuming theses files have been uploaded to the server and stored under /etc/ssl/<path>)

Edit `/etc/apache2/sites-available/default-ssl.conf`

In conf file modify these two following lines : 
->  `SSLCertificateFile		/etc/ssl/certs/Certificate.crt`
->  `SSLCertificateKeyFile	/etc/ssl/private/Private.pem`

## Enable SSL for Apache (HTTPS)

```
sudo a2enmod ssl
cd /etc/apache2/sites-available
sudo a2ensite default-ssl.conf
sudo systemctl restart apache2
```

## Install PHP

```
sudo apt -y install php
sudo apt -y install php-mysql php-curl php-gd php-zip
sudo php -v
sudo systemctl restart apache2
```

## MySQL installation and configuration

```
sudo apt -y install mysql-server
sudo mysql

mysql > ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'mynewpassword';
mysql > exit

sudo mysql_secure_installation (use root password set above when prompted)
sudo mysql -p (use root password when prompted)

mysql > GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';
mysql > create database wpdb;
mysql > FLUSH PRIVILEGES;
mysql > exit
```
	
## Wordpress install and configuration

```
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
sudo cp -R ./wordpress/* /var/www/html
cd /var/www/html
sudo mv index.html index.html.backup
sudo mv wp-config-sample.php wp-config.php
sudo nano wp-config.php 
->  Edit database settings to match previously configured MySQL values
->  Edit authentication and salt values to unique phrases (https://api.wordpress.org/secret-key/1.1/salt/)
```

## Apache HTML access writes configuration

```
sudo adduser $USER www-data
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R g+rw /var/www/html
sudo reboot
```

## Run install

```
https://<public-ip-address>/wp-admin/install.php
```
