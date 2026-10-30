# AKM GRAFFITI WARS v8.0 — Road lanes & vehicle depth

This build continues the interactive game from v7.9. It keeps the existing map artwork, interactive pan/zoom, seven colored territory markers, Sova and skatepark overlays, and territory panel behavior.

## Road and traffic changes
- Reworked the vehicle centerlines to follow the visible asphalt around the upper street, west approach, memorial-square perimeter, east approach, southern connector, and industrial edge.
- Reduced lane width and car sprite scale so cars fit more naturally within the roadway.
- Kept courtyard/plaza walking routes (yellow) and park/woodland/lakeside footpaths (green) separate from vehicle routes.
- Expanded the foreground building masks so vehicles are covered by roof/building pixels where the route passes behind a structure.
- Road and occlusion guides are debug-only; they are not visible in normal gameplay.

## Deploy
Upload the contents of this ZIP to Netlify (or drag the ZIP into Netlify Drop if enabled). `index.html` is at the root.

## Optional calibration
- Add `?roads=1` to show vehicle corridors and pedestrian paths; press `D` on desktop to toggle.
- Add `?occlusion=1` to outline the foreground masks; press `O` on desktop to toggle.
- Add both query parameters to inspect both systems.

The city remains a 2D isometric illustration with animated SVG vehicle models. Occlusion is approximated by foreground image masks rather than a full 3D scene/depth map.
