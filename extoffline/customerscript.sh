    sudo dpkg -s mdadm >/dev/null 2>&1
    	
        if [ ${?} -ne 0 ]; then
        		(sudo apt-get -y update || (sleep 15; sudo apt-get -y update)) > /dev/null
        		DEBIAN_FRONTEND=sudo noninteractive apt-get -y install mdadm --fix-missing
    	fi
####################################################################################
	
    sudo apt-get -y purge zookeeperd
	sudo apt-get -y autoremove

	sudo apt-get -y update

	sudo apt-get -y install openjdk-8-jre-headless
    sudo apt-get -y install zookeeperd
	####################################################################################
	
    sudo apt-get -y update
    	sudo apt-get -y install openjdk-8-jre-headless
	
	sudo wget https://archive.apache.org/dist/kafka/0.11.0.2/kafka_2.12-0.11.0.2.tgz

	####################################################################################
	
	sudo apt-get -y purge mongodb-org
	retry sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 91FA4AD5
	sudo echo "deb https://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
	sudo apt-get -y update
	if [ -f /etc/mongod.conf ]; then
        		sudo rm /etc/mongod.conf
    	fi
	sudo apt-get -y install mongodb-org

	####################################################################################
	
	
	sudo apt-get install libjemalloc1
	sudo apt-get install redis-tools
	sudo apt-get install redis-server
	sudo apt-get -y install build-essential
    sudo apt-get -y install hugepages	
	sudo apt-get -y update
	
