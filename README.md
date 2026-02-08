# dotfiles

<!-- Replace with a screenshot or gif of your desktop -->
![Desktop preview](https://via.placeholder.com/960x540?text=screenshot+here)

Personal dotfiles for a Fedora Sway Atomic desktop, managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **sway** - Tiling Wayland compositor
- **waybar** - Status bar
- **swaync** - Notification center
- **swaylock** - Screen lock
- **fuzzel** - Application launcher
- **kitty** - Terminal emulator (GTK dark theme)
- **nvim** - Neovim with lazy.nvim
- **zsh** - Shell config (starship, fzf, zoxide, atuin, direnv)
- **cava** - Audio visualizer
- **qt6ct** - Qt6 theming (GTK dark)
- **atuin** - Shell history

## Usage

```sh
chezmoi init --apply https://github.com/borninthedark/dotfiles
```

## Exousia integration

These dotfiles are designed to work with the [exousia](https://github.com/borninthedark/exousia) image builder. The exousia chezmoi module handles installing the chezmoi binary, initializing this repo, and keeping dotfiles updated via systemd services — so dotfiles are applied automatically on login without manual setup.

Example exousia module config:

```yaml
type: chezmoi
repository: "https://github.com/borninthedark/dotfiles"
file-conflict-policy: replace
```

See the [exousia chezmoi module docs](https://github.com/borninthedark/exousia) for all configuration options including update intervals, per-user enablement, and init/update service controls.
