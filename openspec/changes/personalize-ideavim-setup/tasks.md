## 1. Personalize editor options

- [ ] 1.1 In `modules/settings.vim`, change `maplocalleader` from `\` to `+`
- [ ] 1.2 In `modules/settings.vim`, change `scrolloff` from 4 to 10
- [ ] 1.3 In `modules/settings.vim`, add `set whichwrap=b,s,h,l,<,>,[,]`
- [ ] 1.4 In `modules/settings.vim`, add `set ideajoin`, `set ideamarks`, and `clipboard+=ideaput`
- [ ] 1.5 Confirm these settings precede any mapping definitions in the source order

## 2. Personalize keymaps

- [ ] 2.1 In `modules/defaults.vim`, add `nnoremap U <C-r>` (U = redo)
- [ ] 2.2 In `modules/navigation.vim`, replace `<A-j>`/`<A-k>` line-move maps with `<A-Down>`/`<A-Up>` for normal, visual, and insert modes
- [ ] 2.3 Add a `<leader>r` → `<Action>(Run)` mapping (existing or new module) with a WhichKey description

## 3. Verify IDE Action IDs in WebStorm

- [ ] 3.1 Load the config in WebStorm and enable IdeaVim "Track Action Ids" (Search Everywhere → "IdeaVim: Track Action Ids")
- [ ] 3.2 Verify the personal mappings resolve: `<leader>r` (Run), `<A-Up>`/`<A-Down>` (MoveLineUp/Down)
- [ ] 3.3 Verify the research-flagged IDs resolve and fix any that don't: `<leader>sw`, `Git.Branches`, hunk markers (`VcsShowNextChangeMarker`/`VcsShowPrevChangeMarker`), inlay hints, `QuickChangeScheme`
- [ ] 3.4 Verify `<C-h/j/k/l>` split navigation behaves correctly with `sethandler`; decide keep-or-drop and adjust
- [ ] 3.5 Spot-check core nav (`gd`, `gr`, `gI`) and correct any mismatches

## 4. Document personal changes and gaps

- [ ] 4.1 Add `MY-CHANGES.md` listing the personal diffs vs upstream (options + keymaps)
- [ ] 4.2 In `MY-CHANGES.md`, document unsupported Neovim behaviors with reasons: granular insert-mode undo, flash Colemak labels, Clojure/paredit, conform formatters, rainbow-delimiters, transparency
- [ ] 4.3 Note required Marketplace plugins (IdeaVim-EasyMotion, AceJump, Which-Key) as prerequisites

## 5. Commit and push

- [ ] 5.1 Review the diff against `upstream/main` to confirm changes are minimal and isolated
- [ ] 5.2 Commit personal changes to fork `main` (conventional commit, ≤3 bullets) and push to `origin`
