# BatMan

## Install

Run the following command:

```sh
git clone https://github.com/brycetolman54/batman \
~/.config/nvim/pack/plugins/start/batman

cd ~/.config/nvim/pack/plugins/start/batman
```

In order to get things up and running, run this command:

```sh
./setup.sh
```

If you don't want to trust my setup script, you need to do the following:

1. Make a folder called "setup" in the "~/.config/nvim/lua" directory
2. Make a file called "init.lua" in that folder that has the following line:

```lua
require("setup.batman")
```

3. Make a file called "batman.lua" in that folder that has the following text:

```lua
return {
  {"batman", "brycetolman54/batman"},
}
```

## Adding Packages

- To add a new package, add a line to the `batman.lua` file that looks like this:

```lua
  {"packageName", "creator/package"},
```

- The `packageName` and `package` can be different:
    - The `packageName` is what you want to call the package in your setup
    - The `package` is the actual name of the package on github

## Use

- To install new packages, run  the following in NeoVim:

```vim
:BatLoad
```

## Todo

- Add the following fucntionality:
    - Allow adding new packages by adding lines to the lua file
    - Make a script to run when we want to load the plugins
    - Make one for cleaning the plugins
    - Make one for updating the plugins
    - Add commands for all of these
    - Maybe make them lazy load for when tehy are used
    - In the init, maybe run BatLoad everytime
    - Make it print out all neat what happens with every load in its own buffer that is easy to close
    - Maybe make docs
    - Maybe make a checkhealth, though I don't know what I would need to check
