## ADDED Requirements

### Requirement: Every IDE-action mapping resolves to a real Action ID

Every `<Action>(...)` mapping in the configuration SHALL reference an Action ID that resolves in the target JetBrains IDE (WebStorm as the primary target). A mapping that references a non-existent Action ID is a defect.

#### Scenario: Mapping resolves to an existing action

- **WHEN** a configured key bound to `<Action>(SomeId)` is pressed in WebStorm
- **THEN** the corresponding IDE action executes
- **AND** no "action not found" or silent no-op occurs

#### Scenario: Unresolved action ID is corrected

- **WHEN** an `<Action>(...)` mapping is found not to resolve in the target IDE
- **THEN** the Action ID is replaced with the verified ID for the intended behavior, or the mapping is documented as having no equivalent

### Requirement: Action IDs are verifiable via a documented method

The configuration SHALL document how Action IDs were verified, naming IdeaVim's "Track Action Ids" toggle (Search Everywhere → "IdeaVim: Track Action Ids") and the `:actionlist` command as the verification tools.

#### Scenario: Maintainer can re-verify an action

- **WHEN** a maintainer wants to confirm or discover an Action ID
- **THEN** the repository documentation describes enabling Track Action Ids and clicking the IDE action to copy its ID

### Requirement: IDE-family-specific actions are guarded

Where an Action ID differs between JetBrains IDEs (e.g., Rider), the configuration SHALL guard the IDE-specific mapping behind an IDE-detection conditional so a single config works across the IntelliJ family.

#### Scenario: Rider-specific action applied only in Rider

- **WHEN** the config is sourced in Rider
- **THEN** the Rider-specific Action ID variant is used
- **AND** in non-Rider IDEs the default variant is used
