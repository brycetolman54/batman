# BatMan

This is a super simple plugin manager that I am writing to get a bit acquainted with Lua and to mess around with NeoVim. 

This manager is intended more for personal use, but I have made it public in case any young person is looking around at NeoVim and doesn't want to put in the work to understand one of the more complicated plugin managers at the start.

Hopefully everything I have here is simple and straightforward. I try to make my code easy to follow. 

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
require("batman").setup({})
```

## Use

### Adding plugins

To add a new plugin, add a line to the `batman.lua` file that looks like this:

```lua
  {
    name = "<pluginName>",
    repo = "<creator>/<plugin>",
    setup = <bool>,
  },
```

The `pluginName` and `plugin` can be different:
- The `pluginName` is what you want to call the plugin in your setup
- The `plugin` is the actual name of the plugin on github
- The `setup` is a bool for whether or not the plugin requires a setup file to use

### Removing plugins

To remove plugins, simply remove the line corresponding to the plugin in your `batman.lua` file.

## Commands

### Install

To install new plugins, run the following in NeoVim:

```vim
:BatLoad
```

Each plugin, if specified in the `batman.lua` file, is given a `<plugin>.lua` file in the setup folder.

You can modify that file to change the options for each plugin. It is up to you to find out what the options for those are and how to set them.

### Uninstall

To uninstall unused plugins, run the following in NeoVim:

```vim
:BatKill
```

### All

You can run all of the above commands in one with this command:

```vim
:BatFull
```

## Options

Here is an example of how to set options for the manager (which you would do in the root `init.lua` file where you require the manager).

Each option shows its default and then is followed by the possible options.

```lua
require("batman").setup({
    start = {
        load = false, -- true, false
        kill = false, -- true, false
        full = false, -- true, false
    },
    delete = "rm -rf", -- any remove command string
})
```

Here is an explanation of what each of the options do
- Start: determines if a command should run upon NeoVim startup
    - Load: whether or not to run `BatLoad`
    - Kill: whether or not to run `BatKill`
    - Full: whether or not to run `BatFull`
- Delete: command to use to remove plugin repos

## Todo

- Add the following functionality:
    - Make one for updating the plugins
    - Add commands for all of these
    - Maybe make them lazy load for when tehy are used
    - In the init, maybe run BatLoad everytime
    - Maybe make docs
    - Maybe make a checkhealth, though I don't know what I would need to check

<!--
Unicode icons:
  - Green check box: u2705
  - Blue check box: u2611
  - Red X: u274c
-->
