# AKM GRAFFITI WARS — NETLIFY DEPLOY (v7.9)

1. Extract the ZIP.
2. Upload the extracted contents to Netlify Drop, or deploy the folder to your existing Netlify site.
3. Keep `index.html`, `assets/` and `supabase/` together at the publish root.
4. Test map panning/zoom, territory selection, cars on red carriageways, pedestrians on yellow/green routes, street lighting and skaters.

Route inspection:
- `?roads=1` shows red car roads, yellow courtyard paths and green pedestrian paths.
- `?occlusion=1` outlines the foreground masks in magenta.
- `?roads=1&occlusion=1` shows both.
- Desktop: `D` toggles route inspection; `O` toggles occlusion inspection.

The approved city artwork is unchanged. Because the city background is a flattened illustration, depth is simulated with manually traced routes and foreground masks rather than a full 3D road/building scene.

Netlify Drop: https://app.netlify.com/drop
