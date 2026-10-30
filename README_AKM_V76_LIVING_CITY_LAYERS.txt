AKM GRAFFITI WARS v7.6 — LIVING CITY / DEPTH PASS

What changed:
- Expanded road traffic from four to six compact SVG car models, with slower continuous motion, directional headlight spill, body/glass/tire details, and paths authored along the visible street network.
- Expanded hand-authored foreground occlusion footprints so the original city artwork is repainted over vehicles where they pass behind selected building silhouettes.
- Added warm streetlamp pools and subtle bulb variation around the plaza and nearby streets.
- Added four tiny pedestrians on authored sidewalk/plaza paths and improved skater silhouettes on the frozen lake.
- Kept the original city background asset, approved map proportions, seven colored territory markers, interactive pan/zoom, Sova and skatepark landmarks, and selected-only territory placard.
- Motion is disabled when the device requests reduced motion.

Honest limitation:
The supplied city background is a single flattened illustration. This build creates a practical layered simulation using SVG overlays and hand-authored occlusion masks, but it is not yet a fully separated 2.5D scene: some overlaps outside the masked building footprints cannot be physically correct. A complete depth pass requires original layered artwork or a manually reviewed foreground segmentation mask for every building/tree group.

Deployment:
Upload the contents of this ZIP to Netlify Drop (index.html must be at the root). Keep assets/ and supabase/ beside index.html.
