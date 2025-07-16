# Fern.nvim

`fern.nvim` is a plugin that compliments the [Fern](https://git.sr.ht/~bugwhisperer/fern) shell script for notetaking and journal management. It offers enhancements for neovim users to make day-to-day working with Fern Log files easier with features like:
- annotations for quick, rapid Entry creation (`e<?>`) with a standardized set of Unicode markers
- keyboard shortcuts to toggle the status of a TODO entry from open >> done >> cancelled
- folding of header lines (start with "#") to make working with longer files easier and reduce need to scroll
- highlights of Log entry item markers and headers
- special highlight to call out entry items marked as important with "!" or "?"

## Installing Fern.nvim
### Lazy.nvim
This is the minimum plugin config for setup. This will accept all of the default values:
```lua
return {
    {
        'bugwhisperer418/fern.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
		require('fern').setup {}
        end,
    },
}
```

To customize your Fern setup, pass a table with any of the followings attributes to set desired values. The default value for all customizable config options are in the table passed to `setup` below. Ommitting any config entries will cause it to fallback to the default value (ie. you only need to pass items you wish to change).
```lua
return {
    {
        'bugwhisperer418/fern.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
		require('fern').setup {
			fold_lvl = 2, -- folds levels to leave open @ start/open
			-- custom colors for headers, entries and markers
			colors = {
				header = { fg = "#575075" },
				todo = { fg = "#3cb371" },
				done = { fg = "#466853" },
				cancelled = { fg = "#98776a" },
				question = { fg = "#daa520" },
				feel = { fg = "#87cefa" },
				emphasis = { fg = "#d1242f", bg = "#ffebe9" },
			},
			-- custom fern keybindings
			keybindings = {
				entry_toggle = "<leader>b",
				fold_toggle = "<TAB>",
			},
		}
        end,
    },
}
```

### Vim-Plug
1. Add fern.nvim to the vim-plug block in your `.vimrc` file:
```vim
call plug#begin('~/.vim/plugged')
  Plug 'bugwhisperer418/fern.nvim'  << add this line!
call plug#end()
```
2. Run the `:PlugInstall` command to install the plugin.

## Using Fern.nvim
The plugin will be active only when the current buffer is a `.log` file, by default, or for whatever file extensions you've specified in your pluging setup config.

### Annotations
Annotations provide a shortcut to type that will be replaced with the correct Entry unicode marker on the fly. This helps you quickly enter Entries when logging and keeps your entry markers the same across files (read: standardized).
- `et<space>`: **E**ntry **T**ask (ex. "● ")
- `ee<space>`: **E**ntry **E**vent (ex. "○ ")
- `ef<space>`: **E**ntry **F**eeling (ex. "❤ ")

### Shortcuts
- `<TAB>`: Toggles a header's fold state to show/hide its contents.
- `<leader>b`: Toggles the Task Entry under the cursor cyclically between Open(●) >> Done(✔) >> Cancelled(✖) statuses

## Found a bug? Got an idea for a new feature?
Please open any tickets for bugs found or new feature requests here: [https://todo.sr.ht/~bugwhisperer/Fern-Issues](https://todo.sr.ht/~bugwhisperer/Fern-Issues).
