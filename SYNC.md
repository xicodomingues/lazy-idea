# Sync baseline

This fork mirrors my Neovim config into IdeaVim. The source of truth lives in
chezmoi at `exact_dot_config/exact_nvim` (`~/.config/nvim`). This file records
the last point that config was **reviewed** against this fork — "reviewed", not
necessarily ported into `modules/` yet (pending changes live in
`openspec/changes/`).

Scope is intentionally **nvim-only**: this fork ignores my zsh/git/etc. config.
A recheck looks at the `exact_nvim` path alone.

**Last reviewed:** chezmoi `df942a3` — 2026-06-20

## Recheck

List nvim-config commits since the baseline:

```bash
git -C ~/.local/share/chezmoi log df942a3..HEAD -- exact_dot_config/exact_nvim
```

Read the diff, fold anything portable into `openspec/changes/` (or `modules/`),
then bump **Last reviewed** above to the new chezmoi HEAD:

```bash
git -C ~/.local/share/chezmoi rev-parse --short HEAD
```
