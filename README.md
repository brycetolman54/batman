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
  {
    name = "batman",
    repo = "brycetolman54/batman",
    setup = true,
  },
}
```

4. Add the following line to your top level "init.lua" file:
```lua
require("batman")
```

## Adding Packages

To add a new package, add a line to the `batman.lua` file that looks like this:

```lua
  {
    name = "packageName",
    repo = "creator/package",
    setup = false,
  },
```

The `packageName` and `package` can be different:
    - The `packageName` is what you want to call the package in your setup
    - The `package` is the actual name of the package on github
    - The `setup` is a bool for whether or not the plugin requires a setup file to use

## Use

To install new packages, run  the following in NeoVim:

```vim
:BatLoad
```

Each package, when added, is given a `package.lua` file in the setup folder. You can modify that file to change the options for each package. It is up
to you to find out what the options for those are and how to set them.

## Options

Here is an example of how to set options for the manager (which you would do in the root `init.lua` file where you require the manager).

Each option shows its default and then is followed by the possible options.

```lua
require("batman").setup({
    start = {
        load = false (true, false)
    },
    delete = "rm -rf",
})
```

- Start: determines if a command should run upon NeoVim startup
    - Load: whether or not to run BatLoad
- Delete: command to use to remove plugin repos

## Todo

- Add the following functionality:
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

<!--
Unicode icons:
  - Green check box: u2705
  - Blue check box: u2611
  - Red X: u274c
-->
