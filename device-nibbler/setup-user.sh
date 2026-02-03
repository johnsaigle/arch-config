#!/usr/bin/env bash
# User-level setup script for nibbler
# Run this as a regular user (not root)
set -e
set -x

# === AUR HELPER (paru)
# Install paru if not already installed
if ! command -v paru &> /dev/null; then
	echo "Installing paru..."
	cd /tmp
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si --noconfirm
	cd ..
	rm -rf paru
fi

# === AUR PACKAGES
# Install AUR packages using paru
paru -S --needed --noconfirm opencode-bin tailscale bun-bin

# === RUST CONFIGURATION
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-unknown --toolchain nightly

# === DOTFILES AND CONFIGURATION
# Clone nvim config
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
	echo "Cloning nvim configuration..."
	git clone https://github.com/johnsaigle/nvim.git "$NVIM_CONFIG_DIR"
else
	echo "nvim config already exists at $NVIM_CONFIG_DIR"
fi

# Clone rcs and apply configuration
RCS_DIR="$HOME/rcs"
if [ ! -d "$RCS_DIR" ]; then
	echo "Cloning rcs repository..."
	git clone https://github.com/johnsaigle/rcs.git "$RCS_DIR"
	cd "$RCS_DIR"
	make apply
else
	echo "rcs directory already exists at $RCS_DIR"
	echo "To reapply rcs config, run: cd $RCS_DIR && make apply"
fi

echo "User setup complete!"
