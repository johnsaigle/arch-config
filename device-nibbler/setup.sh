#!/usr/bin/env bash
# must be run as root because of pacman
set -e
set -x

# === BLACK ARCH
# Add blackarch to mirror list. Nice to have for general infosec tools.
#curl -O https://blackarch.org/strap.sh
# TODO update this hash
#TARGET='5ea40d49ecd14c2e024deecf90605426db97ea0c' # https://blackarch.org/downloads.html, section: 'Installing on top of Arch Linux'. This is the correct hash; the one in the black arch install instructions is wrong
#HASH=$(sha1sum strap.sh | cut -d ' ' -f 1)
#if [ ! "$TARGET" = "$HASH" ]; then
#	echo 'blackarch script hash does not match'
#	exit 1;
#fi
#chmod +x strap.sh
#./strap.sh

# Update index including blackarch
pacman -Syyu

# Install some essentials
pacman -Syy --needed neovim \
	alacritty \
	base-devel \
	dictd \
	go \
	fish \
	man \
	rustup \
	tig \
	tmux \
	keepassxc \
	qbittorrent \
	ripgrep \
	syncthing \
	ufw \
	xclip \
	vlc
	

# hacking/networking tools
# pacman -Syy --needed wireshark-qt \
# 	perl-image-exiftool \
# 	tcpdump \
# 	hashcat

# === VIRTUALBOX
# vbox version must match kernel version so print it out to help choose the right version
# uname -a
# pacman -Syy --needed virtualbox virtualbox-guest-iso 

# TODO: Add yay or pikaur for AUR packages

# cleanup
pacman -Sc # clean

# === RUST CONFIGURATION
# This installs nightly
rustup default stable
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-unknown --toolchain nightly

# Manjaro kruft
# pacman -R kdeconnect
# pacman -R kpeoplevcard

# === FIREWALL
# Simple configure for ufw: allow only local, limited SSH
# https://wiki.archlinux.org/title/Uncomplicated_Firewall#Basic_configuration
ufw default deny
ufw allow from 192.168.0.0/24 # Verify. May instead be /24 on 192.168.1.0, etc.
ufw limit ssh
# this may be redundant/conflciting with above. taken from `info ufw`. should prevent
# accidentally booting oneself when configuring remotely via ssh
ufw allow proto tcp from any to any port 22
ufw enable

# === CREATE USER
# sudo usermod -aG docker <username>

# === ENABLE SERVICES
#
# https://wiki.archlinux.org/title/Syncthing#Autostarting_Syncthing
#systemctl enable syncthing@user.service

#systemctl enable docker.service docker.socket
