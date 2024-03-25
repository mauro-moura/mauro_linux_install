
DISTRIBUTION=$(lsb_release -is)
CODENAME=$(lsb_release -cs)

# Apt installers
install_virt_manager() {
    sudo apt install -y virt-manager
    sudo apt install -y dbus dbus-x11

    sudo usermod -a -G libvirt $USER
    sudo virsh net-autostart default
    sudo virsh net-start default
}

install_dev_tools() {
    sudo apt install -y git curl wget
    sudo apt install -y build-essential
    sudo apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
    sudo apt install -y libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
    sudo apt install -y python-openssl
    sudo apt install -y python3-venv python3-pip

    sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    sudo apt install -y ninja-build gettext cmake unzip
}

install_base_apps() {
    # Install basic apt softwares
    sudo apt install -y flameshot gparted vim git vpnc

    # Install Syncthing
    sudo apt install -y syncthing

    systemctl --user enable syncthing.service
    systemctl --user start syncthing.service
}

# Install python miniconda
install_miniconda() {
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh

    ~/miniconda3/bin/conda init bash
    ~/miniconda3/bin/conda init zsh

    source ~/.bashrc

    conda config --set auto_activate_base false
}

install_neovim() {
    # Install NeoVIM
    cd /home/$USER
    git clone https://github.com/neovim/neovim
    cd neovim
    git checkout stable
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
    echo "export PATH="$HOME/neovim/bin:$PATH"" >> /home/$USER/.bashrc
    echo "export PATH="$HOME/neovim/bin:$PATH"" >> /home/$USER/.zshrc
}

install_lvim() {
    # Install LunarVim

    # Nodejs dependencies
    sudo apt-get install -y ca-certificates curl gnupg  
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt-get update
    sudo apt-get install nodejs -y

    # Fix node 

    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
    export PATH=~/.npm-global/bin:$PATH # TODO: Add this to .bashrc

    # Rust for dependencies
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"

    # Lunar Vim Script
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

    echo "export PATH=~/.npm-global/bin:$PATH" >> /home/$USER/.bashrc
    echo "export PATH=$HOME/.local/bin:$PATH" >> /home/$USER/.bashrc

    # Install Meslo

    mkdir -p ~/.local/share/fonts
    # cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
    cd ~/.local/share/fonts && curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
}

install_zsh() {
    sudo apt install -y zsh

    chsh -s /usr/bin/zsh $USER

    # Configure zsh History
    echo "HISTFILE=~/.zsh_history" >> /home/$USER/.zshrc
    echo "HISTSIZE=10000" >> /home/$USER/.zshrc
    echo "SAVEHIST=10000" >> /home/$USER/.zshrc
    # powerlevel10k

    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
}

# ASDF-VM

install_asdf() {
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

    echo ". "$HOME/.asdf/asdf.sh"" >> /home/$USER/.bashrc
    echo ". "$HOME/.asdf/completions/asdf.bash"" >> /home/$USER/.bashrc

    source ~/.bashrc

    asdf plugin-add python

    cd /temp/
}

install_third_parties() {
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
}

sudo apt update
sudo apt upgrade -y

install_virt_manager
install_dev_tools
install_base_apps

install_neovim
install_lvim
install_miniconda

install_zsh

# install_asdf
# install_third_parties

echo "alias python=python3" >> /home/$USER/.bashrc
echo "alias python=python3" >> /home/$USER/.zshrc
