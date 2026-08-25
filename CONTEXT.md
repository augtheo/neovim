# Neovim Configuration Context

Domain model for augtheo's Neovim configuration built with nix-wrapper-modules and lze.

## Language

**Language Module**:
A declarative module defining a programming language's complete development toolchain (LSP, formatters, linters, debug adapters, test adapters, and filetypes).
_Avoid_: Language config, LSP plugin, filetype script

**Toolchain**:
The set of developer tooling required for a language, comprising language servers, formatters, linters, debuggers, and test runners.
_Avoid_: Dev tools, language pack, plugins

**Language Orchestrator**:
The engine responsible for loading language modules, evaluating enabled categories from Nix, and registering tooling with runtime subsystems (Conform, Nvim-Lint, DAP, Neotest, LSP).
_Avoid_: Manager, loader service, helper

**Nix Category (`cat`)**:
A toggleable feature or language specification defined in `module.nix` and reflected into Lua via `nixInfo`.
_Avoid_: Flake feature, nix flag, config toggle
