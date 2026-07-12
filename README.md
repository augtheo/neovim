# Neovim Configuration

This is my personal Neovim configuration—my fifth (and hopefully final) iteration.
It is built using [nix-wrapper-modules](https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/neovim.html) by BirdeeHub.

## Usage

To try out this configuration, run:

```bash
nix run github:augtheo/neovim
```

## Development

Lua files are formatted with [stylua](https://github.com/JohnnyMorganz/StyLua) and linted with
[selene](https://github.com/Kampfkarren/selene). Both are provided by the flake's dev shell:

```bash
nix develop
pre-commit install
```

After that, `pre-commit` runs stylua/selene (plus a few basic hygiene checks) on every commit.
