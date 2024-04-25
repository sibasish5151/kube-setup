#update package
apt update -y

#Set the appropriate hostname for each machine.
sudo hostnamectl set-hostname ""
exec bash

#Install Docker
apt install docker.io -y

#Step 1. Install containerd 
#Load the br_netfilter module required for networking.
sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

#To allow iptables to see bridged traffic, as required by Kubernetes, we need to set the values of certain fields to 1
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

#Apply the new settings without restarting.
sudo sysctl --system

#Install curl.
sudo apt install curl -y

#Get the apt-key and then add the repository from which we will install containerd
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#Update and then install the containerd package.
sudo apt update -y
sudo apt install -y containerd.io

#Set up the default configuration file
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

echo "Now run 'sudo vi /etc/containerd/config.toml' & change the SystemdCgroup to true "
