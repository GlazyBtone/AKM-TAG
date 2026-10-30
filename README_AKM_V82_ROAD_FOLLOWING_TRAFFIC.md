# AKM GRAFFITI WARS v8.2 — corrected road-following traffic

This is a code update to the interactive game, not a replacement map image.

## Changes
- Replaced the speculative vehicle routes from the previous build with centerlines traced from the red road markup supplied on the original 941×1672 city map.
- Removed the extra industrial/roof route that was not supported by the user's road markup.
- Replaced SVG `animateMotion` with `requestAnimationFrame` movement sampled from each SVG road path. This avoids inconsistent SMIL motion on mobile browsers.
- Open road segments reverse at their ends rather than teleporting to the beginning; the memorial perimeter loop remains continuous.
- Vehicle routes use only the red-marked carriageways. Yellow and green paths remain pedestrian-only and do not spawn cars.
- Existing foreground-image masks remain in the rendering stack to hide cars behind marked foreground buildings.
- Debug overlays remain off by default (`?roads=1`, `?occlusion=1`).

## Deploy
Upload the contents of this ZIP to the same Netlify site as a new deployment. This archive does not change a live website by itself. After deployment, hard-refresh the page or open it in a private tab to avoid an old cached build.

## Known limitation
The city itself is still a single illustrated 2D background. Building occlusion is implemented with manually drawn foreground masks, not true 3D depth data, so every edge cannot be inferred perfectly from the image. The current route centerlines follow the red road markup and should be visually checked in the live viewport before treating the traffic system as final.
