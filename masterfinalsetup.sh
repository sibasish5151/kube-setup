#Run the following command on the master node to allow Kubernetes to fetch the required images before cluster initialization:
sudo kubeadm config images pull

#Initialize the cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=NumCPU --ignore-preflight-errors=Mem

#Alternatively, if you are the root user, you can run:
export KUBECONFIG=/etc/kubernetes/admin.conf

#Deploy a pod network to our cluster. This is required to interconnect the different Kubernetes components
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

echo "Copy the kubeadm join token and paste it in the worker nodes"

#To display join token, using join token worker node will connects with master node
kubeadm token create --print-join-command

echo "Run 'cat /etc/kubernetes/admin.conf', copy the content and paste it in the opened vi editor of user-node" 

echo "Run the commands like 'kubectl get nodes', 'kubectl get pods --all-namespaces' in the 'USER-NODE' only (Not in master-node) to keep the cluster secured"
