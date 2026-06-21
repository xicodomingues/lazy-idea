# My changes vs upstream

This fork (`xicodomingues/lazy-idea`) bends upstream `cufarvid/lazy-idea` to my
personal Neovim/LazyVim setup. Changes are kept small and labelled so
`git fetch upstream && merge` stays low-conflict. The Neovim source of truth is
tracked in chezmoi (`exact_dot_config/exact_nvim`); see [`SYNC.md`](SYNC.md) for
the last-reviewed baseline.

## Required Marketplace plugins

Install before use (or scripted via `webstorm installPlugins <id…>`):

| Plugin | ID | Why |
| --- | --- | --- |
| IdeaVim | `IdeaVIM` | the Vim engine itself |
| IdeaVim-EasyMotion | `org.jetbrains.IdeaVim-EasyMotion` | `set easymotion` no-ops without it |
| AceJump | `AceJump` | backs EasyMotion's jumps |
| Which-Key | `eu.theblob42.idea.whichkey` | the `WhichKeyDesc_*` popups |

## Personal option overrides (`modules/settings.vim`)

| Option | Upstream | Mine | Why |
| --- | --- | --- | --- |
| `maplocalleader` | `\` | `+` | matches my Neovim localleader |
| `scrolloff` | `4` | `10` | more cursor padding |
| `whichwrap` | unset | `b,s,h,l,<,>,[,]` | let motion keys cross line ends |
| `clipboard` | `unnamedplus` | `+ideaput` | IDE-native paste (multi-caret/format) |
| `ideajoin` | off | on | smart `J` line join |
| `ideamarks` | off | on | vim marks ↔ IDE bookmarks |

## Personal keymap overrides

| Key | Action | Where | Why |
| --- | --- | --- | --- |
| `U` (n) | redo (`<C-r>`) | `defaults.vim` | matches my Neovim |
| `<leader>r` (n) | `<Action>(Run)` | `defaults.vim` | mirrors Neovim `code_runner` |
| `<A-Up>` / `<A-Down>` (n/v/i) | move line up/down | `navigation.vim` | added **alongside** upstream `<A-j>`/`<A-k>` (both fire the same action) |
| `-` / `'` (n) | `[` / `]` motion prefixes | `navigation.vim` | reach bracket motions without the bracket layer; marks move to `` ` `` |

## Unsupported Neovim behaviors (no IdeaVim equivalent)

Recorded so future-me knows these are deliberately absent, not forgotten:

- **Granular insert-mode undo points** (`<C-g>u`) — the IDE owns undo
  granularity; IdeaVim can't insert breakpoints mid-insert.
- **Flash custom Colemak jump labels** — EasyMotion emulation can't set the
  label character set; AceJump is configured separately in its own settings,
  not via the ideavimrc.
- **Clojure / paredit structural editing** — needs IntelliJ IDEA Ultimate +
  Cursive; not available in WebStorm.
- **conform external formatters** — formatting is an IDE-settings concern
  (`Reformat Code` / file watchers), not expressible in the ideavimrc.
- **rainbow-delimiters** — a Neovim highlight plugin; the IDE's own bracket
  colouring is the closest equivalent, set in IDE settings.
- **Transparency overrides** — IDE-settings-level (theme/window opacity), not
  expressible in the ideavimrc.
- **Repeatable `;`/`,` diagnostic & hunk motion** — IdeaVim's `GotoNextError`
  isn't repeat-aware, so `]d`/`]h` don't become the "last move" for `;`/`,`.

## Verifying Action IDs

Every `<Action>(id)` must resolve in the target IDE. To check or discover one:

1. In WebStorm, Search Everywhere (`Ctrl+Shift+A`) → toggle **"IdeaVim: Track
   Action Ids"** on, then trigger the action — its ID shows in a popup.
2. Or run `:actionlist <pattern>` to list matching IDs.

For a no-keystroke sweep of every `<Action>(id)` in `modules/`, save a
`:actionlist` dump and run [`scripts/check-action-ids.sh`](scripts/check-action-ids.sh).
