AKM GRAFFITI WARS v8.19 — Hosters font correction

The prior version did not take effect because older, higher-specificity CSS rules still forced AKM TAG Street. This build replaces those legacy font-family references and uses a versioned Hosters font file.

The provided Hosters OTF's Cyrillic Unicode entries pointed to blank glyphs, despite having codepoint entries. The corrected copy maps Cyrillic characters to the closest available Hosters Latin glyph shapes so Russian UI text no longer falls back to the old pixel font. Some Russian letters are visual approximations, because the source OTF does not contain real Cyrillic designs.

The original Hosters OTF is retained as assets/fonts/Hosters-Personal-Use-Only.otf. Map artwork, territory markers, map geometry, and gameplay logic are unchanged.

License note: the supplied font says PERSONAL USE ONLY. Obtain a commercial license before monetization/commercial release.
