#!/bin/bash

## Install NZBGet
wget https://nzbget.net/download/nzbget-latest-bin-linux.run
sh nzbget-latest-bin-linux.run

sudo mv nzbget.service /etc/systemd/system/nzbget.service
sudo systemctl enable --now nzbget.service
sudo systemctl start nzbget.service

## Install Sonarr

#Add Mono Repository
sudo apt install -y gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update

#Add Mediainfo Repository
wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-13_all.deb && sudo dpkg -i repo-mediaarea_1.0-13_all.deb && apt-get update

#Add The Sonarr Repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8
echo "deb https://apt.sonarr.tv/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/sonarr.list
sudo apt update

sudo apt install -y sonarr

## Install Radarr

sudo apt install -y mono-devel curl mediainfo
cd ~
mkdir Radarr
cd Radarr
curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
tar -xvzf Radarr.develop.*.linux.tar.gz

sudo mv Radarr.service /etc/systemd/system/radarr.service
sudo systemctl enable --now radarr.service
sudo systemctl start radarr.service

## Install NZBHydra
sudo apt-get update
sudo apt-get install python2.7 git-core -y
sudo git clone https://github.com/theotherp/nzbhydra /opt/nzbhydra
sudo chown -R user:user /opt/nzbhydra

cd ~/media-server-setup
sudo mv nzbhydra.service
sudo systemctl enable nzbhydra.service
sudo systemctl start nzbhydra.service

## Install Plex Media Server

cd ~
wget https://downloads.plex.tv/plex-media-server-new/1.19.3.2852-219a9974e/debian/plexmediaserver_1.19.3.2852-219a9974e_amd64.deb
sudo dpkg -i plexmediaserver_1.19.3.2852-219a9974e_amd64.deb

sudo systemctl enable plexmediaserver.service
sudo systemctl start plexmediaserver.service
