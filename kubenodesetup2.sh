#Finally, to apply these changes, we need to restart containerd.
sudo systemctl restart containerd

#To check that containerd is indeed running, use this command:
ps -ef | grep containerd

#Add the repository key and the repository.
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

#To allow kubelet to work properly, we need to disable swap on both machines
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#Finally, enable the kubelet service on both systems so we can start it.
sudo systemctl enable kubelet

