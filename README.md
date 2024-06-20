# SuEdit

This is a neovim plugin that makes it easy to edit privileged files with your
usual editor commands instead of using special tools like `sudoedit`.

If you don't have write access to the file open in the current buffer, the
plugin will automatically ask for elevated privileges and copy the changes to
the original file.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "Grafcube/suedit.nvim",
  dependencies = "akinsho/toggleterm.nvim",
},
```

## Configuration

You can change the command used to ask for permissions. By default, `sudo` is
used.

```lua
{
  "Grafcube/suedit.nvim",
  dependencies = "akinsho/toggleterm.nvim",
  opts = { cmd = "sudo" } -- default
  -- eg: { cmd = "doas" }
  -- eg: { cmd = "run0" }
},
```
