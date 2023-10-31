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
	weechat
	whois \
	
# cleanup
pacman -Sc # clean

# === RUST CONFIGURATION
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-unknown --toolchain nightly

