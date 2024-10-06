#!/usr/bin/env bash
# must be run as root because of pacman

set -x

# Update
pacman -Syyu

# Networking - system resolver and wi-fi if necessary
systemctl enable systemd-resolved iwd

# sshd file
echo 'Include /etc/ssh/sshd_config.d/*.conf' >> /etc/ssh/sshd_config

# Install some essentials
# NOTE: Add user to docker group; systemctl enable docker.service and docket.socket
pacman -Syy --needed \
	base-devel \
	docker \
	fd \
	go \
	fish \
	neovim \
	rustup \
	tig \
	tmux \
	ripgrep

# cleanup
pacman -Sc # clean

# === RUST CONFIGURATION
rustup default stable
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-unknown --toolchain nightly

# TODO: Download rc and conf files to home
