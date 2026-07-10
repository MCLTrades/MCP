# Bilder für die Bongard-Website

Legen Sie Ihre Maschinenfotos **mit exakt diesen Dateinamen** in diesem Ordner ab.
Sobald eine Datei vorhanden ist, ersetzt sie automatisch die Platzhalter-Illustration.
Fehlt eine Datei, zeigt die Seite weiterhin die SVG-Illustration – die Seite bleibt
also immer funktionsfähig.

## Benötigte Dateien

| Dateiname                 | Motiv / Verwendung                                   | Empf. Format |
|---------------------------|------------------------------------------------------|--------------|
| `hero-line.jpg`           | Großes Panorama-Banner (gelb-blaue Ziehlinie)        | quer, ~1920×800 |
| `drahtziehmaschine.jpg`   | Galerie: Drahtziehmaschine                            | 4:3, ~1000×750 |
| `verseilmaschine.jpg`     | Galerie: Verseilmaschine / Verseilerei               | 4:3, ~1000×750 |
| `haspler.jpg`             | Galerie: Spuler & Haspler                            | 4:3, ~1000×750 |
| `gluehanlage.jpg`         | Galerie: Glüh- / Wärmeanlage                          | 4:3, ~1000×750 |
| `walzanlage.jpg`          | Galerie: Walzanlage (optional)                       | 4:3, ~1000×750 |
| `isolierlinie.jpg`        | Galerie: Isolier- / Extrusionslinie (optional)       | 4:3, ~1000×750 |

## Tipps

- **Format:** `.jpg` (wie oben) oder `.png`. Bei `.png` bitte den Dateinamen im
  `<img src>` bzw. im Skript entsprechend anpassen.
- **Seitenverhältnis:** Die Galerie-Rahmen sind 4:3; die Bilder werden per
  `object-fit: cover` beschnitten – zentrale Motive funktionieren am besten.
- **Dateigröße:** Für schnelle Ladezeiten auf ~200–400 KB pro Bild optimieren.
