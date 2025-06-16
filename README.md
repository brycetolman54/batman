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
