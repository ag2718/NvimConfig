# NvimConfig

My personal Neovim config, using the native plugin manager (`vim.pack`).

**Requires Neovim >= 0.12** — it uses `vim.pack`, `vim.lsp.config`, and the Treesitter `main` branch, so it will not work on 0.11 or older.

## Dependencies

Install whatever you're missing.

- `git`, a C compiler + `make`, `unzip` (plugin cloning, Treesitter parsers, Mason)
- `ripgrep`, `fd` (Telescope grep/find)
- `node` if using Pyright
- **Optional:** ImageMagick 7 (`magick`) + a kitty-graphics terminal (kitty/WezTerm/Ghostty) for image previews in `mini.files`. Missing either just skips previews.
- **Linux clipboard:** `wl-clipboard` (Wayland) or `xclip`/`xsel` (X11). macOS works out of the box.

Language servers, `stylua`, etc. install automatically via Mason on first launch.

## Install

```sh
git clone https://github.com/ag2718/NvimConfig.git ~/.config/nvim
nvim
```

First launch auto-runs: `vim.pack` clones plugins, Treesitter compiles parsers, Mason installs tooling. Watch the bottom of the screen, then `:qa` and restart once it settles. Run `:checkhealth` to confirm.

Update plugins later with `:lua vim.pack.update()` (`:write` applies, `:quit` cancels).

## Notes

- **Icons look like boxes:** install a [Nerd Font](https://www.nerdfonts.com/), use it in your terminal, and set `vim.g.have_nerd_font = true` in `lua/core/options.lua`.
- **Opening images/PDFs/videos** from a buffer hands off to your OS default app (`open` / `xdg-open`).

## Layout

```
init.lua                 -- entry point: build hooks + module load order
lua/core/                -- options, keymaps, autocmds (no plugins)
lua/plugins/             -- one file per concern: lsp, completion, treesitter,
                            telescope, git, ui, minifiles, formatting, base
colors/custom.lua        -- the active colorscheme
```

Each `lua/plugins/*.lua` declares its plugins with `vim.pack.add` and configures them inline, so any feature reads top-to-bottom in one file.
