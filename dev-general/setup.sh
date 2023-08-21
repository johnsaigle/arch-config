#!/usr/bin/env bash
# must be run as root because of pacman
set -e
set -x

# Update index including blackarch
pacman -Syyu

# Install some essentials
pacman -Syy --needed neovim \
	base-devel \
	go \
	rustup \
	tmux \
	ripgrep
	# npm \
	# nvm \
	# yarn \

# cleanup
pacman -Sc # clean
