#!/bin/bash

# Config switch apps only into workspace
gsettings set org.gnome.shell.app-switcher current-workspace-only true

gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"

ALTERED_LIST="'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/'"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[$ALTERED_LIST]"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Flameshot'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'flameshot gui'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super><Shift>s'

# Set shortcut for Super + Enter to open terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Open Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>Return'

# Remove key
for i in {1..5}
do
    echo "Doing for window: $i"
    
    TARGET_KEY="<Super>$i"
    bash ./src/reset_shortcut.sh "$TARGET_KEY"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['$TARGET_KEY']"
    echo "Set $TARGET_KEY to switch workspace"

    TARGET_KEY="<Shift><Super>$i"
    bash ./src/reset_shortcut.sh "$TARGET_KEY"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['$TARGET_KEY']"
    echo "Set $TARGET_KEY to switch workspace"
done
