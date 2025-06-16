#!/bin/bash

# make the setup folder name
setup="$HOME/.config/nvim/lua/setup"

# make a folder to hold the setups of the different plugins
echo -e "Creating the \033[1;34msetup\033[0m directory in '$setup'"
mkdir -p $setup

# create the init file
echo -e "Creating the \033[1;32minit\033[0m file in the \033[1;34msetup\033[0m directory"
echo "require(\"setup.batman\")" > "$setup/init.lua"

# make a file for the batman config
echo -e "Creating the \033[1;32mbatman\033[0m config file in the \033[1;34msetup\033[0m directory"
echo 'return {
  { "batman", "/brycetolman54/batman" },
}' > "$setup/batman.lua"
