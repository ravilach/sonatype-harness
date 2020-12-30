#Connect to CentOS
ssh -i ~/.ssh/<your_key>.pem centos@<your_instance_public_ip>

#Update Everything
sudo yum update

#Install and Start Docker
#https://docs.docker.com/engine/install/centos/

sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
 
#Install JAVA
sudo yum install java-11-openjdk 

#Install JQ
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install jq

#Install WGET
sudo yum install wget
