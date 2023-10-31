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
	git \
	go \
	less \
	neovim \
	netcat \
	openssh \
	ripgrep \
	rsync \
	rustup \
	tmux \
	ufw \
	weechat \
	whois \
	zsh
	
# cleanup
pacman -Sc # clean


# === SSH
# generate ssh default host key
ssh-keygen -A

# Create lower level user
useradd -m -s /bin/zsh dev 

# === RUST CONFIGURATION
rustup toolchain install stable # is this necessary?
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-unknown --toolchain nightly

# zsh might add a prompt here if no defaults are present
su dev && cd

# === AUR
# Testing out: paru. https://github.com/morganamilo/paru
git clone https://aur.archlinux.org/paru.git /home/dev/
cd /home/dev/paru
makepkg -si # must be run as low level user

rustup default nightly
