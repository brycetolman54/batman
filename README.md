# BatMan

## Install

- Run the following command:

```sh
git clone https://github.com/brycetolman54/batman \
~/.config/nvim/pack/plugins/start/batman
```

- Then, in your `~/.config/nvim/` folder run:

```sh
echo -e "[\n\t["batman", "/brycetolman54/batman"],\n]" plug-lock.json
```

## Adding Packages

- To add a new package, add a line to the `plug-lock.json` folder that looks like this:

```json
["packageName", "/creator/package"],
```
- The `packageName` and `package` can be different:
    - The `packageName` is what you want to call the package in your setup
    - The `package` is the actual name of the package on github

## Use

- To install new packages, run  the following in NeoVim:

```vim
:BatLoad
```
