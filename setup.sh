#!/bin/bash

# make the root folder name
root="$HOME/.config/nvim"

# make the setup folder name
setup="$HOME/.config/nvim/lua/setup"

# make a folder to hold the setups of the different plugins
if [ -d $setup ]; then
    echo -e "✅ \033[1;34msetup\033[0m directory exists"
else
    echo -e "Creating the \033[1;34msetup\033[0m directory in '$setup'"
    mkdir -p $setup
    echo -e "  ✅ Done"
fi

# make a file for the batman config
if [ -f "$setup/batman.lua" ]; then
    echo -e "✅ \033[1;34msetup/\033[0;32mbatman\033[0m config exists"
    if ! grep -Fq "brycetolman54/batman" "$setup/batman.lua"; then
        echo -e "  ❌ please add the batman plugin to the batman config folder"
    fi
else
    echo -e "Creating the \033[1;32mbatman\033[0m config file in the \033[1;34msetup\033[0m directory"
    echo 'return {
  { "batman", "brycetolman54/batman" },
}' > "$setup/batman.lua"
    echo "  ✅ Done"
fi
