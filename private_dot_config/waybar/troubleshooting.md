# Waybar Troubleshooting

Shared reference for Claude, Codex, and Gemini when debugging waybar issues
on this system (Fedora Sway Atomic, Wayland, Maple Mono NF).

---

## Bar Height Inflation (Pango Font Fallback)

**Symptom:** Waybar exclusive zone expands to ~72 px instead of the configured
38 px. Modules render correctly but the bar is nearly double height, pushing
the workspace content down.

**Root cause:** Pango computes line height using the **tallest vertical
metrics** from every font in its itemization chain — not just the font that
actually renders the glyphs. Fontconfig's default coverage rules
(`60-latin.conf`, `65-nonlatin.conf`) append sans-serif fallbacks to every
requested font. For `Maple Mono NF`, the chain includes:

| Font               | Line height @ 14 px | Source                     |
|--------------------|----------------------|----------------------------|
| Maple Mono NF      | 18.48 px             | Primary font               |
| Noto Sans           | 21.27 px             | fontconfig sans-serif      |
| Noto Sans Arabic    | 30.37 px             | fontconfig coverage        |
| PakType Naskh Basic | 35.22 px             | fontconfig coverage        |
| Noto Sans Math      | 79.17 px             | fontconfig coverage        |

Pango picks up these inflated metrics even when all rendered glyphs exist in
Maple Mono NF.

**Trigger:** Dynamic content in `sway/window` (window titles containing
braille spinner chars like U+2810 `⠐`, U+2802 `⠂`) or any module whose
text causes Pango to probe `FcFontSort` for Unicode coverage. The issue is
**intermittent** — it depends on which window is focused and what characters
appear in the title.

### Fix (three layers, all required)

#### 1. CSS: Remove web font fallbacks

`style.css` — the `*` selector:

```css
font-family: 'Maple Mono NF';
```

Do **not** add `system-ui`, `-apple-system`, `sans-serif`, or any other
generic family. These resolve through fontconfig to Noto Sans / Noto Sans
Arabic and inject their tall metrics into Pango's calculation.

#### 2. Fontconfig: Lock the fallback chain

`~/.config/fontconfig/fonts.conf`:

```xml
<?xml version="1.0"?>
<fontconfig>
  <match target="pattern">
    <test qual="any" name="family" compare="eq">
      <string>Maple Mono NF</string>
    </test>
    <edit name="family" mode="assign_replace" binding="same">
      <string>Maple Mono NF</string>
      <string>Noto Sans Mono</string>
      <string>Symbols Nerd Font</string>
      <string>Symbols Nerd Font Mono</string>
    </edit>
  </match>
</fontconfig>
```

`assign_replace` prevents later system rules from appending to the family
list. Note: this reduces but does **not eliminate** the problem — `FcFontSort`
still returns coverage-based matches regardless of the family pattern.

> **fontconfig gotcha:** User configs in `~/.config/fontconfig/conf.d/` are
> scanned but **silently not loaded** on this system. Only
> `~/.config/fontconfig/fonts.conf` is loaded (via `50-user.conf`).

#### 3. Pango markup: Disable fallback on dynamic modules

`config.jsonc` — wrap format strings in `<span fallback="false">`:

```jsonc
"sway/window": {
    "format": "<span fallback=\"false\">{}</span>"
},
"sway/mode": {
    "format": "<span style=\"italic\" fallback=\"false\">{}</span>"
},
"temperature": {
    "format": "<span fallback=\"false\">{temperatureC}°C {icon}</span>"
}
```

This is the **definitive fix**. `fallback="false"` tells Pango's text
itemizer to never load fallback fonts, so their metrics are never consulted.
Safe here because all characters used in active modules (including `°`,
braille chars, Nerd Font icons) are confirmed present in Maple Mono NF.

### Verification

```bash
# Check exclusive zone (should equal configured height)
swaymsg -t get_tree -r | python3 -c "
import sys, json
tree = json.load(sys.stdin)
for node in tree.get('nodes', []):
    for ws in node.get('nodes', []):
        if ws.get('type') == 'workspace' and ws.get('name') != '__i3_scratch':
            print(f'y={ws[\"rect\"][\"y\"]}')
"

# Screenshot the bar
grim -g "0,0 1920x50" /tmp/waybar_check.png

# Check fontconfig fallback chain
fc-match --sort 'Maple Mono NF' --format='%{family}\n' | head -10

# Inspect glyph metrics in the font
uvx --from fonttools python3 -c "
from fontTools.ttLib import TTFont
font = TTFont('/home/uryu/.local/share/fonts/MapleMono-NF-Regular.ttf')
cmap = font.getBestCmap()
print(f'U+00B0 degree: {\"YES\" if 0x00B0 in cmap else \"NO\"}')
print(f'U+2810 braille: {\"YES\" if 0x2810 in cmap else \"NO\"}')
"
```

### What does NOT fix it

| Attempted fix                          | Why it fails                                                    |
|----------------------------------------|-----------------------------------------------------------------|
| Removing `system-ui` from CSS only     | Fontconfig re-injects the same fonts at the fc layer            |
| `fontconfig conf.d/*.xml`              | Silently not loaded on this system; only `fonts.conf` works     |
| `assign_replace` in fontconfig alone   | `FcFontSort` still returns coverage matches outside the family  |
| Swapping Nerd Font icon codepoints     | Icons aren't the problem; fallback font *metrics* are           |
| `min-height: 0` in CSS                 | Already set; GTK natural size from Pango overrides it           |
| `height: 38` in waybar config alone    | GTK expands beyond this when Pango's line height demands it     |

---

## Useful Diagnostic Commands

```bash
# What font renders a specific codepoint?
fc-match --format='%{family}\n' ':charset=0xF00DE'

# Full fontconfig debug for a font query
FC_DEBUG=4 fc-match 'Maple Mono NF' 2>&1 | grep family

# Is the user fontconfig loaded?
FC_DEBUG=1024 fc-match 'Maple Mono NF' 2>&1 | grep -i '/home.*font'

# Font metrics comparison
uvx --from fonttools python3 -c "
from fontTools.ttLib import TTFont
import subprocess
for name in ['Maple Mono NF', 'Noto Sans', 'Noto Sans Arabic', 'Noto Sans Math']:
    path = subprocess.run(['fc-match', '--format=%{file}', name],
                          capture_output=True, text=True).stdout.strip()
    font = TTFont(path)
    os2 = font['OS/2']; em = font['head'].unitsPerEm
    print(f'{name:25s}: {14*(os2.usWinAscent+os2.usWinDescent)/em:.2f}px @ 14px')
"

# Pango version (line_height attr requires 1.50+)
pango-view --version
```

---

## System Context

| Component       | Value                                         |
|-----------------|-----------------------------------------------|
| OS              | Fedora Sway Atomic (immutable)                |
| WM              | Sway (Wayland)                                |
| Waybar          | 0.14.0                                        |
| GTK             | 3 (waybar uses GTK3)                          |
| Pango           | 1.57.1                                        |
| Primary font    | Maple Mono NF (Nerd Font, 1000 UPM)           |
| Font location   | `~/.local/share/fonts/MapleMono-NF-*.ttf`     |
| GTK theme       | Kripton-v40 (dark)                             |
| GTK font-name   | `Maple Mono NF 11` (gsettings)                |
| Output          | HDMI-A-1, 1920x1080, scale 1.0                |
| Bar launch      | `bar { swaybar_command waybar }` in sway config |

---

*Last updated: 2026-03-29 by Claude (Opus 4.6)*
