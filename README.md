# dotfiles

<!-- Replace with a screenshot or gif of your desktop -->
![Desktop preview placeholder](https://via.placeholder.com/960x540?text=desktop+preview+placeholder)

Personal dotfiles for a Fedora Sway Atomic desktop, managed with [chezmoi](https://www.chezmoi.io/).

## Usage

```sh
chezmoi init --apply https://github.com/borninthedark/dotfiles
```

## What's included

### Shell (`dot_zshrc`)

Zsh config with `nvim` as default editor and Wayland/Qt environment variables. Integrates starship (prompt), fzf (fuzzy finder with fd/bat), zoxide (smarter cd), atuin (history sync), and direnv (per-directory env). Aliases for lsd, bat, fastfetch, podman, git, and kubectl.

### Sway

Tiling Wayland compositor. Super (Mod4) modifier with vim-style hjkl navigation. Kitty as terminal, fuzzel as launcher, swaylock for lock screen (`Ctrl+Super+L`). Wallpaper from `~/.local/share/wallpapers/default.jpg`.

### Waybar

Status bar at the top (30px). Left: workspaces, mode, scratchpad. Center: focused window. Right: idle inhibitor, power profile, pulseaudio, cpu, memory, temperature, backlight, language, battery, clock, tray.

### Kitty

Terminal emulator — Maple Mono NF at 14pt, GTK dark color scheme.

### Neovim

Single-file Lua config bootstrapping lazy.nvim. Leader `,`, relative line numbers, 100-char column, 4-space indent. Plugins include treesitter, telescope, LSP, completion, lualine, gitsigns, and more.

### Fuzzel

Wayland app launcher — Maple Mono NF at size 14, teal accent, overlay layer, 50% width.

### Swaylock

Lock screen with wallpaper. Ring indicator changes color by state: teal (idle), green (clear), orange (caps lock), red (wrong).

### SwayNC

Notification center, top-right, 500px wide. 10s default timeout, no timeout for critical.

### CAVA

Audio visualizer via PulseAudio. Gradient bars from teal to blue on dark background, 60fps, stereo.

### Qt6ct / Atuin

Qt6 dark theme so Qt apps match GTK. Atuin stores shell history locally with default settings.

### Theme

All configs share a consistent dark palette:

| Role       | Color                                        | Hex       |
|------------|----------------------------------------------|-----------|
| Background | ![background](assets/colors/background.svg)  | `#131519` |
| Surface    | ![surface](assets/colors/surface.svg)        | `#171a1f` |
| Text       | ![text](assets/colors/text.svg)              | `#e0e0e0` |
| Accent     | ![accent](assets/colors/accent.svg)          | `#9bbfbf` |
| Success    | ![success](assets/colors/success.svg)        | `#70af5a` |
| Warning    | ![warning](assets/colors/warning.svg)        | `#aa4b1a` |
| Critical   | ![critical](assets/colors/critical.svg)      | `#b72f1d` |

## Exousia integration

These dotfiles are designed to work with the [exousia](https://github.com/borninthedark/exousia) image builder. The exousia chezmoi module handles installing the chezmoi binary, initializing this repo, and keeping dotfiles updated via systemd services — so dotfiles are applied automatically on login without manual setup.

Example module config:

```yaml
type: chezmoi
repository: "https://github.com/borninthedark/dotfiles"
file-conflict-policy: replace
```

See the [exousia chezmoi module docs](https://github.com/borninthedark/exousia) for all configuration options including update intervals, per-user enablement, and init/update service controls.

## Acknowledgements

- Color scheme based on the [Kripton](https://github.com/EliverLara/Kripton) GTK theme

<!-- Add more acknowledgements here -->
