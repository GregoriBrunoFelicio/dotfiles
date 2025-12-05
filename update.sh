
#!/bin/bash

echo "🔄 Updating dotfiles..."

echo "📦 Saving installed packages..."
pacman -Qqent > pkglist.txt

echo "🌐 Saving AUR packages..."
pacman -Qm > aurlist.txt

echo "⚙️ Saving GNOME settings..."
dconf dump / > gnome-settings.dconf

echo "✅ Dotfiles updated successfully!"
