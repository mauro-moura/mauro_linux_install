
LOCAL_FOLDER=$1
cd $LOCAL_FOLDER/files

echo "Defining user settings"
cp settings.json /home/$USER/.config/Code/User/settings.json

echo "Defining user keybindings"
cp keybindings.json /home/$USER/.config/Code/User/keybindings.json

echo "Installing VSCode extensions"
# code --install-extension $(cat extensions.json | jq -r '.[] | .publisher + "." + .name')
# cat extensions.json | jq -r '.[] | "code --install-extension \(.publisher).\(.name) --force"' | bash

