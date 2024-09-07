#!/usr/bin/env bash
# must be run as root because of pacman
set -ex

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
	docker-compose \
	git \
	fd \
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

# Create lower level user
useradd -m -s /bin/zsh dev 
usermod -aG docker dev # Must logout of `dev` for this to take effect

# === ENABLE SERVICES
systemctl enable docker.service docker.socket

# === LOW-LEVEL COMMANDS (non-root)

# zsh might add a prompt here if no defaults are present
su dev && cd

# === RUST CONFIGURATION
rustup default stable
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-unknown --toolchain nightly

# === AUR
# Testing out: paru. https://github.com/morganamilo/paru
# must be run as low level user
git clone https://aur.archlinux.org/paru.git "$HOME"
cd "$HOME/paru"
makepkg -si 
