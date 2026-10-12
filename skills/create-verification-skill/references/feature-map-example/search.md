# Search items

A user can search by supported fields, open a matching result, distinguish an empty result, and clear the query.

## Sub-features

- `search-open` opens search from every supported entry point.
- `search-match` returns known title or body matches.
- `search-open-result` opens the selected result.
- `search-empty` reports that there are no matches.
- `search-clear` clears the query and restores the default view.

## How to get to it (user POV)

- Select the app's search action.
- Use any documented keyboard shortcut.
- Use a documented CLI search command, if the app provides one.

## Driving it with <harness>

Preconditions:

- The isolated app instance passes its health check.
- The fixture data includes one known match and one known non-match.

- **Open search.** Use the app's visible search action and any supported shortcut. Confirm the search field appears.
- **Find a match.** Search for a unique term in a known fixture. Confirm the expected result appears and the non-match does not.
- **Open a result.** Select the result and confirm the item details match the fixture.
- **Find no matches.** Search for a unique absent term. Confirm the app presents its empty state, not a loading or error state.
- **Clear query.** Clear the search. Confirm the default list or recent view returns.
- **Capture proof.** Save the command output, accessibility snapshot, screenshot, or other appropriate artifact under the verification skill's named artifact directory.

## Gotchas

- Search may be debounced; wait for a result or explicit empty state, not a fixed sleep.
- A shortcut may behave differently when an editable field has focus.
- Reopening a result can change the app state; reset search before the next journey.
