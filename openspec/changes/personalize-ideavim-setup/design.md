## Context

`lazy-idea` (upstream: `cufarvid/lazy-idea`) ports the LazyVim default keymap to IdeaVim via a `lazy-idea.vim` entrypoint that sources modular `.vim` files under `modules/`. This repo is my fork (`xicodomingues/lazy-idea`). I run LazyVim in Neovim and want WebStorm (and the IntelliJ family) to feel the same through IdeaVim.

Two prior research passes (deep-research workflows) established: most LazyVim behavior maps to IdeaVim via emulated plugins + `<Action>(id)` mappings; a handful of upstream Action IDs are unverified against current IDEs; and a few Neovim behaviors have no IdeaVim equivalent at all.

Decision already taken with the user: **all changes live in the fork** (not in a separate chezmoi override file), so personal customizations and upstream structure interleave directly. Runtime delivery to `~/.config/ideavim/` is a separate, later concern.

## Goals / Non-Goals

**Goals:**

- Match my Neovim options and key customizations directly in the fork's module files.
- Ensure every `<Action>(...)` mapping resolves in WebStorm (empirically verified, not assumed).
- Document, in-repo, the Neovim behaviors that cannot be reproduced.
- Keep the fork's diff against upstream small so future `upstream` syncs stay easy.

**Non-Goals:**

- Wiring chezmoi externals or cloning into `~/.config/ideavim/` (separate task).
- Reproducing Clojure/paredit, granular insert-mode undo, or flash Colemak labels (no equivalent).
- Re-architecting upstream's module layout.

## Decisions

**Edit upstream modules in place rather than an overlay file.**
Rationale: the user wants one source of truth and the freedom to PR fixes upstream. Editing `modules/settings.vim` directly also sidesteps the localleader ordering trap — `let maplocalleader="+"` must run before maps are defined, which an after-`source` overlay cannot guarantee. Alternative considered: a separate tracked `ideavimrc` that sources the fork and overrides below; rejected because localleader/scrolloff set after mappings won't retroactively apply and it splits the source of truth.

**Verify Action IDs empirically in WebStorm.**
Rationale: the user's standing rule is to verify assumptions by testing, and research flagged several IDs as shaky. Use IdeaVim's "Track Action Ids" toggle to confirm/correct. Alternative considered: trust upstream IDs; rejected — research found likely-wrong ones.

**Keep personal changes isolated and labelled.**
Rationale: small, well-marked diffs (section comments, a `MY-CHANGES.md`) make `git fetch upstream && merge` low-conflict. Alternative: scatter changes; rejected — raises future merge cost.

## Risks / Trade-offs

- **Action IDs vary by IDE/version** → Guard IDE-specific ones behind detection (`g:is_ide_rider` pattern already in upstream); verify the rest in the actual target IDE.
- **`<C-h/j/k/l>` window-nav conflicts with IDE/insert-mode `<C-k>`** → Use `sethandler` per mode; verify in WebStorm before committing the bindings.
- **Editing upstream modules raises merge conflicts on sync** → Confine edits to as few hunks as possible and document them; accept occasional small conflicts as the cost of "latest from upstream."
- **`set easymotion` silently no-ops without the Marketplace plugins** → Document the required plugins (IdeaVim-EasyMotion, AceJump, Which-Key) as prerequisites.

## Migration Plan

1. Edit `modules/settings.vim`, `modules/navigation.vim`, `modules/defaults.vim` (+ run mapping) for personal options/keymaps.
2. Add `MY-CHANGES.md` documenting personal diffs + unsupported-behavior list.
3. Load the config in WebStorm; use Track Action Ids to verify/fix `<Action>(...)` mappings; iterate.
4. Commit to fork `main`; push to `origin`.
5. (Out of scope) Deliver to `~/.config/ideavim/` via chezmoi external or `git pull`.

Rollback: `git revert` the personal commits, or `git reset` to the upstream-synced point; the fork's `upstream` remote always provides a clean baseline.

## Verification feasibility

No headless or CLI harness exists for an end-user IdeaVim config — the config is interpreted by the running IDE, so the IDE is the only ground truth. Built-in verification, all requiring the IDE open with the config loaded:

- `:actionlist [pattern]` — confirms an `<Action>(id)` resolves to a real action in *this* IDE/version.
- `:set trackactionids` (or "IdeaVim: Track Action Ids") — shows which action a key fired; confirms a mapping triggers the intended action.
- `:map` — confirms the config sourced and the key is bound.

**Keystroke automation rejected.** Driving keys via macOS `osascript`/System Events is possible, but confirming an effect still routes through the IDE's action-id popup — it adds fragility without removing the manual observation step.

**Plugins are scriptable.** `webstorm installPlugins IdeaVIM org.jetbrains.IdeaVim-EasyMotion AceJump eu.theblob42.idea.whichkey` (xmlIds, verified against the Marketplace API) via the Toolbox launcher (`~/Library/Application Support/JetBrains/Toolbox/scripts/webstorm`, not on PATH; IDE must be closed; the launcher wraps `open -na --args`, so confirm it runs headless and exits before scripting it). Verified locally: WebStorm 2026.1.3 installed, none of these plugins present yet, no `~/.ideavimrc`, fork not deployed — the runtime chain is greenfield.

**One automatable check covers the highest risk (dead Action IDs) without keystrokes:** run `:actionlist` once and save it, then grep every `<Action>(id)` from `modules/` and assert each ID appears in the saved list. The behavioral bits (`scrolloff`, `U`, `-`/`'`, line-move) stay a short manual Track-Ids pass — the design's chosen method.

## Open Questions

- Keep vim-style `<C-hjkl>` split navigation, or rely on WebStorm's native split focus? (Resolve during in-IDE verification.)
- Configure AceJump's jump characters toward my Colemak home-row set, or leave default? (Cosmetic; deferred.)
