#! /bin/bash

#golang version
echo "============================= Show go env ============================="
go env
echo "============================= go location ============================="
which go
echo "============================= go version ============================="
go version
echo ""

# install nodejs
echo "============================= 8. Install nodejs 10.18.1 ============================="
sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "============================= node version ============================="
node --version
echo "============================= Install npm v5.6.0 ============================="
sudo npm install -g npm@5.6.0
echo ""
sleep .5 # waits 0.5s

# install python 
echo "============================= 8. Install python ============================="
sudo apt-get install -y python
sudo apt-get install -y python-pip
echo ""

# install docker  
echo "============================= 9. Install docker v17.06.2 ^ ============================="
sudo curl -fsSL https://get.docker.com/ | sudo sh
whoami=`whoami` # put $(whoami) result to var
echo $whoami
sudo usermod -aG docker cryptojeju
docker --version
echo ""

# install docker-compose  
echo "============================= 10. Install docker-compose v1.14.0 ^ ============================="
sudo apt-get update
sleep .5 # waits 0.5s
sudo apt-get upgrade
sleep .5 # waits 0.5s
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sleep .5 # waits 0.5s
docker images
docker-compose --version
echo ""

# install Hyperledge fabric-samples 
echo "============================= 11. Install Hyperledge fabric-samples ============================="
sudo curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.0.0 1.4.4 0.4.18
echo ""
echo "============================= Input enviroment variable ~/.bashrc ============================="
echo "export FABRIC_HOME=$GOPATH/src/github.com/hyperledger/fabric" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/src/github.com/hyperledger/fabric/build/bin/" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/src/github.com/hyperledger/fabric-ca/bin" >> ~/.bashrc
# sed p ~/.bashrc
source ~/.bashrc
sleep .5 # waits 0.5s
echo ""

# install fabric 
echo "============================= 12. Install fabric ============================="
sudo mkdir -p $GOPATH/src/github.com/hyperledger
cd $GOPATH/src/github.com/hyperledger
sudo git clone https://github.com/hyperledger/fabric
cd fabric
make
sleep 5
echo ""
