## Why

I want my LazyVim/Neovim workflow to feel like home in JetBrains WebStorm (and the IntelliJ family) via IdeaVim. The `lazy-idea` project already ports the LazyVim default keymap, so this fork exists to (a) bend it to my personal Neovim setup and (b) fix the IDE Action IDs that don't resolve in current JetBrains IDEs. All changes live in this fork directly so I can pull upstream improvements and replay my changes on top.

## What Changes

- **Personalize core options** in `modules/settings.vim` to match my `~/.config/nvim`: `maplocalleader="+"` (upstream uses `\`), `scrolloff=10` (upstream uses 4), and add `whichwrap`, `ideajoin`, `ideamarks`, and `clipboard+=ideaput`.
- **Personalize keymaps**: `U` → redo (`<C-r>`); line-move on `<A-Up>`/`<A-Down>` (upstream uses `<A-j>`/`<A-k>`) in normal/visual/insert; add `<leader>r` → Run (my `code_runner` binding). **BREAKING** for upstream parity: line-move keys change from `<A-j>/<A-k>` to `<A-Up>/<A-Down>`.
- **Fix unverified Action IDs**: empirically verify each `<Action>(...)` mapping in WebStorm using IdeaVim's "Track Action Ids" toggle and correct the ones that don't resolve (candidates flagged in research: `<leader>sw`, `Git.Branches`, hunk markers, inlay-hints, `QuickChangeScheme`).
- **Document intentional gaps**: behaviors from my nvim config with no IdeaVim equivalent (granular insert-mode undo points, flash Colemak labels, Clojure/paredit, conform formatters, rainbow-delimiters, transparency) recorded so future-me knows what is deliberately absent and why.

## Capabilities

### New Capabilities
- `personal-keymap-overrides`: the set of keybindings and editor options that diverge from upstream lazy-idea to match my Neovim configuration.
- `verified-ide-actions`: the requirement that every IDE-action mapping resolves to a real Action ID in the target JetBrains IDE, with a documented verification method.
- `unsupported-behavior-documentation`: an explicit, in-repo record of Neovim behaviors that cannot be reproduced in IdeaVim and the reason for each.

### Modified Capabilities
<!-- No upstream OpenSpec specs exist; this fork introduces specs fresh. -->

## Impact

- **Files**: `modules/settings.vim`, `modules/navigation.vim`, `modules/defaults.vim`, possibly a new run/code module, and a new `MY-CHANGES.md` (or README section) for the gap documentation.
- **Plugins required for full behavior**: IdeaVim-EasyMotion, AceJump, Which-Key (or Which-Key Lazy) from the JetBrains Marketplace.
- **Runtime delivery (out of scope here)**: a later step pulls this fork into `~/.config/ideavim/` (chezmoi external or manual `git pull`) for the IDE to read.
- **Upstream relationship**: `upstream` remote tracks `cufarvid/lazy-idea`; personal changes are kept small and isolated to ease future syncs.
