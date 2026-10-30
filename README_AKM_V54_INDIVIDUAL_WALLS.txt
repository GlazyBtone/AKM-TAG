AKM GRAFFITI WARS v5.4 — INDIVIDUAL GRAFFITI WALLS

This release advances the interactive map from territory-only interaction to individual wall targets.

Changes:
- Each of the six graffiti-wall targets has a stable wall ID independent of the district ID.
- Selecting a wall opens its own panel state and shows how many saved tags belong to that wall.
- Draw and gallery actions are scoped to the selected wall. Saved tags retain district + wall metadata.
- Existing tags without wall IDs remain compatible and visible in district galleries.
- Opening the territory from a wall panel navigates to the parent district.
- Existing map panning, zoom, close button, territory selection, character, and local game loop are preserved.

Deploy: upload the ZIP to Netlify Drop and open the new published site. Test by selecting a wall, drawing a tag, saving it, then reopening that same wall gallery.

This is still a local prototype: wall-specific tags and influence are stored in browser localStorage. Online crew-wide sync is not enabled.
