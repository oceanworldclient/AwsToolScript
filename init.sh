#/bin/sh
apt-get update -y
apt-get install curl -y
cd ~
mkdir .ssh
cd .ssh
curl https://raw.githubusercontent.com/oceanworldclient/AwsToolScript/main/pub.key > authorized_keys
chmod 700 authorized_keys
cd ../
chmod 600 .ssh

sed -i "/PasswordAuthentication no/c PasswordAuthentication no" /etc/ssh/sshd_config
sed -i "/RSAAuthentication no/c RSAAuthentication yes" /etc/ssh/sshd_config
sed -i "/PubkeyAuthentication no/c PubkeyAuthentication yes" /etc/ssh/sshd_config
sed -i "/PasswordAuthentication yes/c PasswordAuthentication no" /etc/ssh/sshd_config
sed -i "/RSAAuthentication yes/c RSAAuthentication yes" /etc/ssh/sshd_config
sed -i "/PubkeyAuthentication yes/c PubkeyAuthentication yes" /etc/ssh/sshd_config
sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config

systemctl restart sshd
systemctl restart ssh
cd 
