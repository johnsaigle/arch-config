#!/usr/bin/env bash
# must be run as root because of pacman
set -e
set -x

# Update
pacman -Syyu

# Networking - system resolver and wi-fi if necessary
systemctl enable systemd-resolved iwd

# sshd file
#echo 'Include /etc/ssh/sshd_config.d/*.conf' >> /etc/ssh/sshd_config

# Install some essentials
pacman -Syy --needed \
	base-devel \
	bind \
	docker \
	docker-compose
	git \
	fd \
	#go \
	less \
	neovim \
	netcat \
	openssh \
	ripgrep \
	rsync \
	rustup \
	tmux \
	ufw \
	whois \
	zsh
	
# cleanup
pacman -Sc # clean

# === SSH
# generate ssh default host key
ssh-keygen -A


# === RUST CONFIGURATION
rustup default stable
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-unknown --toolchain nightly

# === ENABLE SERVICES
systemctl enable docker.service docker.socket

# zsh might add a prompt here if no defaults are present
su dev && cd

# Create lower level user
useradd -m -s /bin/zsh dev 
usermod -aG docker dev # Must logout of `dev` for this to take effect

# === AUR
# Testing out: paru. https://github.com/morganamilo/paru
# must be run as low level user
git clone https://aur.archlinux.org/paru.git /home/dev/
cd /home/dev/paru
makepkg -si 

