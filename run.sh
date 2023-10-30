
LOCAL_FOLDER=$(pwd)

echo "$LOCAL_FOLDER"

# echo "Creating custom shortcuts"
# ./src/shortcuts.sh

# echo "Installing Basic and Develop Apps"
# ./src/install_apps.sh

# echo "Creating /home/$USER/Apps folder"
# ./src/create_apps_folder.sh

echo "Setting vscode extensions and shortcuts"
./src/create_vscode_shortcuts.sh "$LOCAL_FOLDER"
