AKM GRAFFITI WARS v5.6 — NEW PLAYABLE TERRITORIES

This build changes the map logic so that Art-residence Sova and the skatepark under the Viaduct are independent playable territories, not decorative buildings placed inside existing territory borders.

Changes:
- Added a dedicated purple territory polygon around the Sova creative hub.
- Reshaped the Friendship territory to stop at Sova's border.
- Added a dedicated orange territory polygon around the skatepark under the Viaduct.
- Reshaped the Promzona boundary so the skatepark has its own territory.
- Converted both locations to TERRITORY entities, so each gets its own influence score, FLY TAG round, local claim progress, graffiti tags and gallery.
- Added a graffiti wall associated with the skatepark territory.
- Kept the illustrated architecture, map pan/zoom, selection panel, close button, and existing districts.
- No mosque or church added.

Deploy:
1. Upload this ZIP to Netlify Drop or deploy the folder as a static site.
2. Open the Map section on mobile.
3. Tap the purple Sova territory and orange skatepark territory. Each should open as a separate playable district with its own local progress.

Note: progress is still local to the browser/device; shared online territory control is not enabled by this change.
