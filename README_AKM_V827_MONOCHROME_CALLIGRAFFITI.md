AKM TAG v8.27 — full monochrome interface redesign

Implemented in the supplied project:
- Full UI restyle to black, charcoal, gray and white; removed blue/cyan styling from interface panels, buttons, progress bars, focus states and navigation.
- Added low-contrast calligraphic brush texture behind panels/cards, never over text.
- Enlarged navigation symbols and labels, shortcut symbols and labels, wardrobe tabs, task cards and action buttons.
- Character screen is the home/main menu. Customization opens as a separate full-screen mode with its own Back button, launched from the dedicated customization shortcut.
- Territory icons are replaced at runtime with simple monochrome ring/dot marks above the same mapped coordinates; no pictograms or images inside the markers.
- Map artwork, map image assets, territory coordinates, SVG map geometry, and game logic are retained.
- Hosters Latin and the existing readable Cyrillic font declarations/assets are preserved.

Validation: ZIP integrity checked; index.html is structurally parsed and inline classic scripts are syntax-checked where supported. The live Telegram/Cloudflare environment was not available for a full browser interaction test.
