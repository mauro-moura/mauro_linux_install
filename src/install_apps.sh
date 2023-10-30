
DISTRIBUTION=$(lsb_release -is)
CODENAME=$(lsb_release -cs)

sudo apt update
sudo apt upgrade -y

cd /temp/

# Install insync
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
echo "deb http://apt.insync.io/$DISTRIBUTION $CODENAME non-free contrib" > /etc/apt/sources.list.d/insync.list
sudo apt update
sudo apt install -y insync

# Install Chrome
wget -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome.deb

# Install VSCode
wget -O code.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo dpkg -i ./code.deb

# Install basic apt softwares
sudo apt install -y flameshot grub-customizer gparted vim git

# Install Syncthing
sudo apt install -y syncthing

systemctl --user enable syncthing.service
systemctl --user start syncthing.service

# Install NeoVIM

# Install LunarVim

# Install Meslo

# Install DevTools

sudo apt install -y virt-manager python3-venv
sudo apt install -y dbus dbus-x11 build-essential
