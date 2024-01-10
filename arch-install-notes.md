# Arch Install Notes

Goal: Create an encrypted root partition and get the system set-up minimally

```
# basics
pacstrap -K /mnt base linux linux-firmware neovim iwd grub efibootmgr # AND microcode: intel-ucode OR amd-ucode

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

## chroot
arch-chroot /mnt

# modify /etc/mkinitcpio.conf
# https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Configuring_mkinitcpio
# Regenerate with new settings
mkinitcpio -P

# grub install and config
# https://wiki.archlinux.org/title/GRUB#Installation
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

# IMPORTANT Modify /etc/default/grub. This step is needed so that grub can find
# the encrypted volume. If this isn't here it's possible that the Operating system
# won't be found after a system upgrade
# https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Configuring_the_boot_loader
# https://wiki.archlinux.org/title/Kernel_parameters#GRUB
# add: cryptdevice=UUID=device-UUID:root root=/dev/mapper/root
# Use blkid to get the UUID. NOTE: Use the partition UUID, not the "/dev/mapper/" one

# regenerate grub config with new changes
grub-mkconfig -o /boot/grub/grub.cfg

# Things to install with pacman: system tools
less
sudo
bind
rsync
git
whois
ufw

# bluetooth
bluez bluez-utils
systemctl enable bluetooth.service --now

```
