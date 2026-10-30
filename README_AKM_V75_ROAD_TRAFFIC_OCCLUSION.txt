AKM GRAFFITI WARS v7.5 — ROAD TRAFFIC + OCCLUSION

This build improves the ambient traffic pass:
- Reworked compact top-down car silhouettes with tires, glazing, body panels, subtle headlights and tail lamps.
- Four looping routes are aligned to visible asphalt streets and the industrial road corridor.
- Added a foreground occlusion pass that repaints the exact original city artwork over cars where selected building silhouettes overlap, so cars do not visibly float over those buildings.
- The original background artwork is unchanged. Existing panning, zooming, territory markers, landmarks, window shimmer and skater loops are preserved.

Important technical note: the city background is still a single flattened illustration, so the occlusion pass uses hand-authored silhouette masks rather than true depth geometry. Full physically correct occlusion everywhere would require splitting the map artwork into road, building, tree and foreground layers or creating a depth/segmentation mask.

Deploy the folder contents or upload this ZIP to Netlify. Keep index.html at the root and assets/ beside it.
