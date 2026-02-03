#!/usr/bin/env bash
# must be run as root because of pacman
set -e
set -x

# Update index
pacman -Syyu

# Install some essentials
pacman -Syy --needed neovim \
	alacritty \
	base-devel \
	go \
	man \
	rustup \
	tig \
	tmux \
	keepassxc \
	qbittorrent \
	ripgrep \
	syncthing \
	ufw \
	vlc \
	git \
	bat \
	fd \
	fzf \
	htop \
	jq \
	tree \
	github-cli \
	docker \
	docker-compose \
	shellcheck \
	strace \
	eza \
	openssh
	# npm \
	# nvm \
	# yarn \
	
# cleanup
pacman -Sc # clean

# === FIREWALL
# Simple configure for ufw: allow only local, limited SSH
# https://wiki.archlinux.org/title/Uncomplicated_Firewall#Basic_configuration
ufw default deny
ufw allow from 192.168.2.0/24
ufw limit ssh
# this may be redundant/conflciting with above. taken from `info ufw`. should prevent
# accidentally booting oneself when configuring remotely via ssh
ufw allow proto tcp from any to any port 22
ufw enable

# === CREATE USER

# === ENABLE SERVICES
# https://wiki.archlinux.org/title/Syncthing#Autostarting_Syncthing
#systemctl enable syncthing@user.service
