## ADDED Requirements

### Requirement: Unsupported Neovim behaviors are documented in-repo

The repository SHALL contain an in-repo record (e.g., `MY-CHANGES.md` or a README section) listing the Neovim behaviors from my config that cannot be reproduced in IdeaVim, with a reason for each.

#### Scenario: A reader can find what is intentionally missing

- **WHEN** a reader consults the repository documentation
- **THEN** they find an explicit list of unsupported behaviors with reasons

### Requirement: The unsupported list covers the known gaps

The documented list SHALL include at least: granular insert-mode undo points (no `<C-g>u` equivalent; IDE owns undo granularity), flash custom Colemak labels (EasyMotion cannot set label chars; AceJump configured separately), Clojure/paredit structural editing (requires IntelliJ IDEA Ultimate + Cursive; not available in WebStorm), conform external formatters, rainbow-delimiters, and transparency overrides (IDE-settings-level, not expressible in ideavimrc).

#### Scenario: Each known gap has a reason

- **WHEN** the unsupported-behavior documentation is reviewed
- **THEN** each listed behavior states why it cannot be reproduced and, where applicable, the closest available alternative
