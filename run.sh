
LOCAL_FOLDER=$(pwd)

echo "$LOCAL_FOLDER"

echo "Creating custom shortcuts"
bash ./src/shortcuts.sh

echo "Installing Basic and Develop Apps"
bash ./src/install_apps.sh

echo "Creating /home/$USER/Apps folder"
bash ./src/create_apps_folder.sh

echo "Setting vscode extensions and shortcuts"
bash ./src/create_vscode_shortcuts.sh "$LOCAL_FOLDER"
