#! /bin/bash

# install ssh
echo "============================= 1. Install ssh ============================="
sudo apt-get install -y openssh-server
# sudo service --status-all
echo ""

# install curl 
echo "============================= 2. Install curl ============================="
sudo apt-get install -y curl 
echo ""

# install git 
echo "============================= 3. Install git ============================="
sudo apt-get install -y git 
echo ""

# install tree 
echo "============================= 4. Install tree ============================="
sudo apt-get install -y tree 
echo ""

# install libltdl-dev 
echo "============================= 5. Install libltdl-dev ============================="
sudo apt-get install -y libltdl-dev 
echo ""

# install net-tools 
echo "============================= 6. Install net-tools ============================="
sudo apt-get install -y net-tools 
echo ""

# install golang 
echo "============================= 7. Install golang v1.13.4 ============================="
sudo apt-get update
sudo apt-get -y upgrade
wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
sudo tar -xzvf go1.13.4.linux-amd64.tar.gz
sudo mv go /usr/local
echo ""
echo "============================= Input enviroment variable ~/.bashrc ============================="
echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOROOT/bin" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin" >> ~/.bashrc

# sed p ~/.bashrc
source ~/.bashrc
sleep .5 # waits 0.5s