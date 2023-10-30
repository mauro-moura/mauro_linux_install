#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <TARGET_KEY>"
    exit 1
fi

TARGET_KEY="$1"

# Get a list of schemas containing keybindings
schemas=$(gsettings list-schemas)

# Loop through schemas and check if the target key is used
for schema in $schemas; do
    keys=$(gsettings list-keys $schema)
    for key in $keys; do
        binding=$(gsettings get $schema $key | grep -o "'$TARGET_KEY'")
        if [ "$binding" == "'$TARGET_KEY'" ]; then
            #gsettings reset $schema $key
	    gsettings set $schema $key "[]"
            echo "Removed key $TARGET_KEY from $schema $key"
        fi
    done
done

