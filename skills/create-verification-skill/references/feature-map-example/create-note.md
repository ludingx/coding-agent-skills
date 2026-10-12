# Create an item

A user can create and save an item, cancel an unfinished draft, and confirm that a saved item persists.

## Sub-features

- `create-open` opens a blank editor.
- `create-save` saves the item's fields.
- `create-cancel` discards an unfinished draft.
- `create-persist` confirms the saved item in a second view.

## How to get to it (user POV)

- Select the app's create-item action.
- Use any documented keyboard shortcut.
- Use a documented CLI create command, if the app provides one.

## Driving it with <harness>

Preconditions:

- The isolated app instance passes its health check.
- No item with the chosen unique test title exists.

- **Open editor.** Use the app's create action. Confirm the editor and expected fields are visible.
- **Enter data.** Fill required fields with a unique title and known body. Confirm the save action is enabled.
- **Save.** Submit the item. Confirm the app reports success and shows the expected title.
- **Confirm persistence.** Navigate to a second user-facing list or detail view and confirm the saved values there.
- **Cancel.** Start a separate draft, enter data, cancel, then confirm no item with that unique title exists.
- **Capture proof.** Save the command output, accessibility snapshot, screenshot, or other appropriate artifact under the verification skill's named artifact directory.

## Gotchas

- A success toast alone does not prove persistence.
- Use unique values so seeded data cannot make the check pass accidentally.
- Remove test records during cleanup; preserve the proof artifacts.
