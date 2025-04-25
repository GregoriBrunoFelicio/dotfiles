#!/bin/bash

echo "📦 Installing pacman packages..."
sudo pacman -S --needed - < pkglist.txt

if [ -f aurlist.txt ]; then
  echo "📦 Installing AUR packages..."
  yay -S --needed - < aurlist.txt
fi

echo "🎨 Importing GNOME settings..."
dconf load / < gnome-settings.dconf

echo "🐚 Copying ZSH config..."
cp .zshrc ~/

echo "✅ Done! Run 'source ~/.zshrc' to apply ZSH config."
