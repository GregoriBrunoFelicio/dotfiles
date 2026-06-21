#!/bin/bash

cd "$(dirname "$0")"

echo "Updating dotfiles..."

echo "Saving installed packages..."
pacman -Qqent > pkglist.txt

echo "Saving AUR packages..."
pacman -Qm > aurlist.txt

echo "Saving GNOME settings..."
dconf dump / > gnome-settings.dconf

echo "Saving ZSH config..."
cp ~/.zshrc .zshrc

echo "Saving Git config..."
cp ~/.gitconfig .gitconfig

echo "Dotfiles updated successfully!"
