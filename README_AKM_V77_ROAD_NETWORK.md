AKM GRAFFITI WARS v7.7 — ROAD NETWORK & TRAFFIC

Changes
- Replaced the previous guessed traffic paths with a smaller set of hand-traced routes following visible asphalt in the original city artwork.
- Removed lower-district routes that crossed warehouse roofs, forest, or rail tracks.
- Added invisible road corridors with widths matched to the road lanes. Vehicles travel only on these route centerlines.
- Added a road-trace inspection mode: append ?roads=1 to the URL to show the traced road corridors in cyan and their centerlines in pale yellow. On desktop, press D to toggle the overlay.
- Kept the original map artwork, seven territory pins, landmark layers, pan/zoom and territory interactions.

Notes
The source map is a single flattened illustration, so occlusion still uses hand-drawn foreground masks. Traffic paths are manually traced against the visible asphalt and should be reviewed in road-trace mode at the deployed viewport scale.

Deploy
Upload the contents of this folder to Netlify, keeping index.html and the assets/ directory together.
