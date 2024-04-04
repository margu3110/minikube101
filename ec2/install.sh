#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y docker.io
#sudo usermod -aG docker $USER && newgrp docker
sudo usermod -aG docker ubuntu && newgrp docker
sudo apt install -y curl wget apt-transport-https
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x kubectl
sudo mv kubectl /usr/local/bin
kubectl version -o yaml
sudo -u ubuntu minikube start - vm-driver=docker

minikube status
kubectl version
