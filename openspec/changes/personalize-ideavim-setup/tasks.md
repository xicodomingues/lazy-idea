## 1. Personalize editor options

- [x] 1.1 In `modules/settings.vim`, change `maplocalleader` from `\` to `+`
- [x] 1.2 In `modules/settings.vim`, change `scrolloff` from 4 to 10
- [x] 1.3 In `modules/settings.vim`, add `set whichwrap=b,s,h,l,<,>,[,]`
- [x] 1.4 In `modules/settings.vim`, add `set ideajoin`, `set ideamarks`, and `clipboard+=ideaput`
- [x] 1.5 Confirm these settings precede any mapping definitions in the source order

## 2. Personalize keymaps

- [x] 2.1 In `modules/defaults.vim`, add `nnoremap U <C-r>` (U = redo)
- [x] 2.2 In `modules/navigation.vim`, add `<A-Down>`/`<A-Up>` line-move maps alongside upstream's `<A-j>`/`<A-k>` (both fire MoveLineDown/Up) for normal, visual, and insert modes
- [x] 2.3 Add a `<leader>r` → `<Action>(Run)` mapping (existing or new module) with a WhichKey description
- [x] 2.4 In `modules/navigation.vim`, remap `-` → `[` and `'` → `]` (normal mode, recursive) so the `]`/`[` motion prefixes are reachable without the bracket layer

## 3. Verify IDE Action IDs in WebStorm

- [x] 3.1 Load the config in WebStorm and enable IdeaVim "Track Action Ids" — config sources cleanly (only pre-existing upstream `set` no-ops warn); `:actionlist` captured for the full sweep
- [x] 3.2 Verify the personal mappings resolve: `<leader>r` (Run), `<A-Up>`/`<A-Down>` (MoveLineUp/Down) — all present in `:actionlist` ✓
- [x] 3.3 Verify the research-flagged IDs and fix dead ones — flagged IDs (`Git.Branches`, hunk markers, inlay hints, `QuickChangeScheme`) all resolve; sweep found 4 **other** dead upstream IDs, all resolved: `Format`→`ReformatCode`, `ShowDocumentation`→`QuickJavaDoc`, and `<leader>dp` (`ActivateProfilerToolWindow`) + `<leader>dr` (`JShell.Console`) deleted (no WebStorm equivalent)
- [ ] 3.4 Verify `<C-h/j/k/l>` split navigation behaves correctly with `sethandler`; decide keep-or-drop and adjust
- [x] 3.5 Spot-check core nav (`gd`, `gr`, `gI`) — `GotoDeclaration`, `FindUsages`, `GotoImplementation` all resolve ✓
- [x] 3.6 Install prerequisite plugins via CLI (IDE closed): `webstorm installPlugins IdeaVIM org.jetbrains.IdeaVim-EasyMotion AceJump eu.theblob42.idea.whichkey` (xmlIds) — all 4 installed headlessly, confirmed on disk
- [x] 3.7 Save `:actionlist` output once; add a script that greps `<Action>(id)` from `modules/` and asserts each ID is present (catches dead Action IDs without keystrokes) — script added at `scripts/check-action-ids.sh` (saving the dump is the in-IDE step)

## 4. Document personal changes and gaps

- [x] 4.1 Add `MY-CHANGES.md` listing the personal diffs vs upstream (options + keymaps)
- [x] 4.2 In `MY-CHANGES.md`, document unsupported Neovim behaviors with reasons: granular insert-mode undo, flash Colemak labels, Clojure/paredit, conform formatters, rainbow-delimiters, transparency, repeatable `;`/`,` diagnostic/hunk motion (IdeaVim `GotoNextError` is not repeat-aware)
- [x] 4.3 Note required Marketplace plugins (IdeaVim-EasyMotion, AceJump, Which-Key) as prerequisites

## 5. Commit and push

- [ ] 5.1 Review the diff against `upstream/main` to confirm changes are minimal and isolated
- [ ] 5.2 Commit personal changes to fork `main` (conventional commit, ≤3 bullets) and push to `origin`
