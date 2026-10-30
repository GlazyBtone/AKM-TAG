AKM GRAFFITI WARS v5.2 — ART-DIRECTED INTERACTIVE CITY

What changed from v5.1:
- Replaced the prior repetitive vector-building field with a newly authored, dense winter-city illustration as the detailed environment layer.
- Kept game interactions as separate SVG objects above the art: five territory hit regions, six graffiti-wall hit regions, nine landmark pins, selected territory highlighting, and existing map HUD / draw / gallery / info / minigame flows.
- Map panning and zoom remain handled by the app canvas, not baked into the illustration.
- The environment contains no mosque or church; the central square uses a neutral civic monument.
- The artwork contains no text labels, so all names are rendered dynamically by the app UI.

Important technical note:
The high-detail environment is a visual art layer, while territories, walls, landmarks, selection, and game actions are live interactive SVG/HTML layers. Individual windows and facade details inside the illustration are not individually selectable; the game interaction targets are the territories, mural zones, and landmark pins.

Deploy:
1. Upload this ZIP to Netlify Drop.
2. Open the published app on iPhone and go to Map.
3. Drag to pan, pinch or use +/- to zoom, tap territory polygons, landmark pins, or mural hit areas.

This is an authored fictionalized game map inspired by the northern winter-city direction, not a survey-accurate map of Novy Urengoy. Territory scores remain local demo state; online multiplayer is not enabled.
