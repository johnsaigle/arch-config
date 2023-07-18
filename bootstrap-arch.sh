#!/usr/bin/env bash
# must be run as root because of pacman
set -e
set -x

# Add blackarch to mirror list
curl -O https://blackarch.org/strap.sh
TARGET='5ea40d49ecd14c2e024deecf90605426db97ea0c' # https://blackarch.org/downloads.html, section: 'Installing on top of Arch Linux'. This is the correct hash; the one in the black arch install instructions is wrong
HASH=$(sha1sum strap.sh | cut -d ' ' -f 1)
if [ ! "$TARGET" = "$HASH" ]; then
	echo 'blackarch script hash does not match'
	exit 1;
fi
chmod +x strap.sh
./strap.sh

# Update index including blackarch
pacman -Syyu

# Install some essentials
pacman -Syy --needed nvim \
	base-devel \
	go \
	rustup \
	tmux \
	# npm \
	# nvm \
	# yarn \
	keepassxc \
	ripgrep

# hacking/networking tools
# pacman -Syy --needed wireshark-qt \
# 	perl-image-exiftool \
# 	tcpdump \
# 	hashcat

# personal cloud
pacman -Syy --needed nextcloud-client

# vbox version must match kernel version so print it out to help choose the right version
# uname -a
# pacman -Syy --needed virtualbox virtualbox-guest-iso 

# TODO: Add yay for AUR packages

# cleanup
pacman -Sc # clean
