# Fern.nvim

`fern.nvim` is a plugin that compliments the [Fern]() shell script for notetaking and journal management. It offers enhancements for neovim users to make day-to-day working with Fern Log files easier with features like:
- annotations for quick, rapid Entry creation (`e<?>`) with a standardized set of Unicode markers
- keyboard shortcuts to toggle the status of a TODO entry from open >> done >> cancelled
- folding of header lines (start with "#") to make working with longer files easier and reduce need to scroll
- highlights of Log entry item markers and headers
- special highlight to call out entry items marked as important with "!" or "?"

## Installing Fern.nvim
### Lazy.nvim
```lua
return {
    {
        'bugwhisperer418/fern.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('fern').setup()
        end,
    },
}
```

## Using Fern.nvim
The plugin will be active only when the current buffer is a `.log` file, by default, or for whatever file extensions you've specified in your pluging setup config.

### Annotations
Annotations provide a shortcut to type that will be replaced with the correct Entry unicode marker on the fly. This helps you quickly enter Entries when logging and keeps your entry markers the same across files (read: standardized).
- `et<space>`: **E**ntry **T**ask (ex. "● ")
- `ee<space>`: **E**ntry **E**vent (ex. "○ ")
- `ef<space>`: **E**ntry **F**eeling (ex. "❤ ")

### Shortcuts
- `<TAB>`: Toggles a header's fold state to show/hide its contents.
- `<leader>b`: Toggles the status of a ToDo entry under the cursor from Open >> Done >> Cancelled

## Found a bug? Got an idea for a new feature?
Please open any tickets for bugs found or new feature requests here: [https://todo.sr.ht/~bugwhisperer/Fern-Issues](https://todo.sr.ht/~bugwhisperer/Fern-Issues).
