#!/bin/bash
#ym="1234.lgtmxd.com"

apt-get install socat


mkdir trojan
cd trojan/
wget wget https://github.com/trojan-gfw/trojan/releases/download/v1.12.2/trojan-1.12.2-linux-amd64.tar.xz
tar xvJf trojan-1.12.2-linux-amd64.tar.xz > trojan_tarlog.txt

cd
wget -O - https://get.acme.sh | sh && . ~/.bashrc
acme.sh --issue --standalone -d $ym
acme.sh --install-cert -d $ym --key-file /root/trojan/trojan/private.key --fullchain-file /root/trojan/trojan/fullchain.cer

chmod +x /root/trojan/trojan/*



cd
wget -N --no-check-certificate https://www.moerats.com/usr/shell/Caddy/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh



echo "

$ym:80 
{ 
	root /usr/local/caddy/www 
	index index.html gzip 
}

" > /usr/local/caddy/Caddyfile




cd /usr/local/caddy/
mkdir www/
cd www/
curl -sL https://git.io/fjSJM > index.html
/etc/init.d/caddy start




cd /root/trojan/trojan/
rm config.json
curl -sL https://git.io/fjSJ7 > config.json

./trojan -c config.json -l access.txt


acme.sh --upgrade --auto-upgrade