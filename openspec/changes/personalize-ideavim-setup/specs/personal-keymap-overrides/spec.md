## ADDED Requirements

### Requirement: Local leader matches Neovim config

The configuration SHALL set `maplocalleader` to `+` so the localleader matches my Neovim setup, overriding upstream's `\` default. The assignment MUST occur before any localleader-dependent mappings are defined.

#### Scenario: Localleader is plus

- **WHEN** the IdeaVim config is sourced in a JetBrains IDE
- **THEN** `maplocalleader` resolves to `+`
- **AND** any mapping defined with `<localleader>` triggers on the `+` prefix

### Requirement: Editor options match Neovim config

The configuration SHALL set editor options to match my Neovim config: `scrolloff=10`, `whichwrap` including `b,s,h,l,<,>,[,]`, `ideajoin`, `ideamarks`, and `clipboard` including `ideaput`.

#### Scenario: Scrolloff keeps cursor padded

- **WHEN** the cursor moves toward the top or bottom edge of the editor
- **THEN** at least 10 lines of context remain visible above or below it

#### Scenario: Whichwrap allows cross-line movement

- **WHEN** the cursor is at the end of a line and a wrap-enabled key (`l`, `<Right>`, `<Space>`) is pressed
- **THEN** the cursor moves to the start of the next line

### Requirement: U redoes the last undone change

The configuration SHALL map `U` in normal mode to redo (`<C-r>`).

#### Scenario: U redoes

- **WHEN** the user undoes a change with `u` and then presses `U`
- **THEN** the undone change is reapplied

### Requirement: Alt-arrow keys move lines

The configuration SHALL move the current line or selection down on `<A-Down>` and up on `<A-Up>` in normal, visual, and insert modes, mapped alongside upstream's `<A-j>`/`<A-k>` so both key pairs trigger the same line move.

#### Scenario: Move line down in normal mode

- **WHEN** the user presses `<A-Down>` in normal mode
- **THEN** the current line swaps with the line below it

#### Scenario: Move selection up in visual mode

- **WHEN** the user has a visual selection and presses `<A-Up>`
- **THEN** the selected block moves up one line and the selection is preserved

### Requirement: Leader-r runs code

The configuration SHALL map `<leader>r` to the IDE Run action, matching my Neovim `code_runner` binding.

#### Scenario: Leader-r triggers run

- **WHEN** the user presses `<leader>r` in normal mode
- **THEN** the IDE executes the current run configuration

### Requirement: Dash and quote reach the bracket motion prefixes

The configuration SHALL recursively remap `-` to `[` and `'` to `]` in normal mode, so the `]`/`[` motion prefixes are reachable without the bracket layer, matching my Neovim config.

#### Scenario: Dash triggers a previous-motion

- **WHEN** the user presses `-` followed by a `[`-prefixed motion key in normal mode
- **THEN** the corresponding `[` motion fires (e.g. `-d` jumps to the previous diagnostic)
