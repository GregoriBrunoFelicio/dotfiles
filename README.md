#  Greg's Dotfiles

My personal terminal and system configuration files for Linux.  
This repo helps me set up everything quickly if I wipe my system or move to a new machine.

---

##  What's Included

-  `.zshrc`: Zsh config (Manjaro default prompt, aliases, paths)
-  `.gitconfig`: Global Git configuration
-  `pkglist.txt`: List of manually installed packages (`pacman`)
- `aurlist.txt`: List of packages from the AUR (`yay`)
- `gnome-settings.dconf`: GNOME desktop settings (themes, shortcuts, etc)
-  `setup.sh`: Script to install everything and restore configs

---

##  How to Set Everything Up (on a new machine)

```bash
git clone https://github.com/GregoriBrunoFelicio/dotfiles.git
cd dotfiles
chmod +x setup.sh
./setup.sh
