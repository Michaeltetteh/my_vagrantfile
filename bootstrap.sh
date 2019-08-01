echo "-------------------- updating package lists"
apt-get update

#install python3.7 pip and venv
sudo apt-get install -y python3.7
sudo apt install -y python3-pip
sudo apt-get install -y python3-venv


# sudo apt install -y python3-pip
# sudo apt-get install -y python3-venv

# gotta put this before the upgrade, b/c it reboots and then all commands are lost
echo "-------------------- installing postgres"
apt-get install postgresql

# fix permissions
echo "-------------------- fixing listen_addresses on postgresql.conf"
sudo sed -i "s/#listen_address.*/listen_addresses '*'/" /etc/postgresql/10/main/postgresql.conf

echo "-------------------- fixing postgres pg_hba.conf file"
# replace the ipv4 host line with the above line
# Accept all IPv4 connections - FOR DEVELOPMENT ONLY!!!
sudo cat >> /etc/postgresql/10/main/pg_hba.conf <<EOF
  host    all         all         0.0.0.0/0             md5
EOF

echo "-------------------- creating postgres vagrant role with password vagrant"
# Create Role and login
sudo su postgres -c 'psql -c "CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'" '

echo "-------------------- creating your_db_name database"
# Create ecommerce database
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant your_db_name"

echo "-------------------- upgrading packages to latest"
apt-get upgrade -y

# to use python3.7 as default python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
sudo update-alternatives --config python3

#create venv env
# python3 -m venv venv

# source venv/bin/activate

# pip install -r requirements.txt
