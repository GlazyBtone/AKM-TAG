# AKM GRAFFITI WARS v7.9 — User-traced road network

This version applies the user's road classification to the interactive map. The approved city background, map proportions, pan/zoom, seven colored territory markers, Sova and skatepark layers remain unchanged; territory boundaries remain disabled.

## Road classes
- **Red**: vehicle carriageways. Only these paths carry animated cars.
- **Yellow**: courtyard and plaza pedestrian paths.
- **Green**: pedestrian routes through park/landmark approaches, the industrial forecourt and lakeside promenade.

Pedestrians animate along the yellow and green paths; cars do not use these paths. The map image is still a single illustration, so building occlusion uses manually authored foreground masks rather than true 3D geometry.

## Inspect routes
- Add `?roads=1` to the published URL to show red vehicle corridors, yellow courtyard paths and green pedestrian routes.
- Add `?occlusion=1` to show the magenta outlines of the foreground masks.
- Combine both as `?roads=1&occlusion=1`.
- On desktop, press `D` to toggle route overlays and `O` to toggle occlusion masks.

The route lines are an editable first pass traced against the in-game source artwork. Please test them at the live map scale; any individual route can be moved by editing `routeDefs` or `footpathDefs` inside `index.html`.

## Deploy
Extract the ZIP and upload its contents to the Netlify publish root. Keep `index.html`, `assets/` and `supabase/` together.
