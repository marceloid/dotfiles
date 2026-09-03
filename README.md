# My Dotfiles

This directory contains the dotfiles for my system, managed using [GNU Stow](https://www.gnu.org/software/stow/).

The repository is structured to support multiple operating systems (Linux/macOS) and separates **common** configurations from OS-specific ones.

---

## Quick Start

If you just want to bootstrap your dotfiles on a new machine:

```bash
# Clone the repository and run the install script
git clone git@github.com:marceloid/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
````

The script will:

* Detect your OS (`linux` or `macos`)
* Stow all common and OS-specific packages folder by folder
* Automatically create symlinks in your `$HOME` using the `--dotfiles` convention

---

## Repository Structure

```
dotfiles/
├── install.sh            # Main install/uninstall script
├── .stowrc               # Stow default options
├── .stow-local-ingore    # Stow ignore files
├── common/               # Shared configurations (both OSes)
│   ├── espanso/
│   │   └── dot-config/espanso/
│   │       ├── config/default.yml
│   │       └── match/base.yml
│   ├── herdr/
│   │   └── dot-config/herdr/config.toml
│   ├── nvim/
│   │   └── dot-config/nvim/
│   └── tmux/
│       └── dot-tmux.conf
├── linux/                # Linux-specific configs
│   ├── ghostty/
│   │   └── dot-config/ghostty/config
│   ├── git/
│   │   └── dot-gitconfig (identidade + preferências; defaults vêm do Omarchy)
│   └── hyprmoncfg/
│       └── dot-config/hyprmoncfg/profiles/ (perfis de monitores do Hyprland)
└── macos/                # macOS-specific configs
    ├── aerospace/
    │   └── dot-config/aerospace/
    │       └── aerospace.toml
    ├── ghostty/
    │   └── dot-config/ghostty/config
    ├── git/
    │   └── dot-gitconfig
    └── zsh/
        └── dot-zshrc
```

---

## Requirements

Ensure the following are installed on your system:

### Git

```bash
# Linux (Ubuntu/Debian)
sudo apt install git

# macOS
brew install git
```

### GNU Stow

```bash
# Linux (Ubuntu/Debian)
sudo apt install stow

# macOS
brew install stow
```

---

## Installation (Detailed)

1. **Clone the repository** to your `$HOME` directory:

```bash
$ git clone git@github.com:marceloid/dotfiles.git
$ cd dotfiles
```

2. **Run the installation script** to automatically stow all packages folder by folder, including OS-specific configurations:

```bash
$ ./install.sh
```

* The script will detect your OS and stow both `common/` and your OS-specific folder.
* All dotfiles are managed with the `--dotfiles` option: files/folders prefixed with `dot-` in the repository will be linked as normal dotfiles in your home directory (`.` prefix).

---

### Optional: Uninstall / Remove symlinks

To safely remove all symlinks created by the script:

```bash
$ ./install.sh --unstow
```

This will unstow `common/` and your OS-specific dotfiles.

---

### Notes

* The repo uses a **folder-by-folder approach**:

  * `common/` → configs shared across all systems (e.g., Git, Zsh, Neovim)
  * `linux/` → Linux-specific configs
  * `macos/` → macOS-specific configs

* The script is **idempotent**: running it multiple times will not duplicate links or overwrite existing files.

## Omarchy 4

Since **Omarchy 4**, the following configs are managed by Omarchy itself and are
**intentionally not versioned here**:

* **Hyprland** → `~/.config/hypr/*.lua` (new Lua format; personal overrides
  live directly there, see `omarchy` CLI / `omarchy refresh hyprland`)
* **Shell/bar (antiga waybar)** → Omarchy Shell, via `~/.config/omarchy/shell.json`
* **Defaults do git (aliases, rerere, etc.)** → `/usr/share/omarchy/config/git/config`
* **Webapps (.desktop)** → gerenciados pelo Omarchy (`omarchy launch webapp ...`)

Por isso os antigos pacotes `linux/hypr`, `linux/waybar`, `linux/copyq`,
`linux/app_launchers` e `common/kitty` foram removidos do repo.

---

## Configured Apps

### AeroSpace (tiling window manager)

Config at `macos/aerospace/dot-config/aerospace/aerospace.toml`. Key highlights:

* **Vim-style navigation:** `Alt + H / J / K / L` to focus left/down/up/right.
* **Move windows:** `Alt + Shift + H / J / K / L` (or HyperKey: `Cmd+Ctrl+Alt+Shift + H/J/K/L`).
* **Workspaces:**
  * Numbers: `Alt + 1..9` (Switch) / `Alt + Shift + 1..9` (Move window)
  * Dedicated letters:
    * `Alt + B`: Browser (Chrome, Safari, Firefox, Edge)
    * `Alt + T`: Terminal (Ghostty, Kitty, iTerm)
    * `Alt + N`: Notes (Obsidian, Notion, Evernote)
    * `Alt + C`: Communication (Telegram, WhatsApp, Slack)
    * `Alt + D`: Dev / Docs / Database (DBeaver, VS Code, Excel, Word, Acrobat)
    * `Alt + E`: Explorer (Finder)
    * `Alt + M`: Music / Media (Spotify, VLC)
    * `Alt + V`: Video / Production (OBS Studio, CapCut, HandBrake)
* **Layouts:** `Alt + /` (tiles), `Alt + ,` (accordion), `Alt + Shift + F` (fullscreen).
* **Modes:**
  * Resize mode: `Alt + Shift + R` (`H/J/K/L`, `-`/`+`, `B` to balance, `Enter`/`Esc` to exit).
  * Service mode: `Alt + Shift + ;` (`Esc` reload config, `R` flatten tree, `F` toggle floating/tiling, `H/J/K/L` join-with).
* **Automatic floating windows:** System Settings, Keychain, Activity Monitor, Calculator, Bitwarden, AppCleaner, Shottr, Wispr Flow, Tailscale, etc.

Reload with `aerospace reload-config` or `Alt + Shift + ;` then `Esc` (also reloads automatically on save).

### Espanso (text expander)

Shared config at `common/espanso/`. Triggers defined in `match/base.yml`:

| Trigger | Expands to |
| ------- | ---------- |
| `;today` | Current date (`dd/mm/YYYY`) |
| `;now` | Current date and time (`dd/mm/YYYY HH:MM`) |
| `;email` | Personal email address |
| `;assino` | Signature block |

On macOS the install script symlinks `~/Library/Application Support/espanso` →
`~/.config/espanso` so the same config works on both OSes. Reload with
`espanso restart` after changes.

### Ghostty (terminal)

- **macOS:** config em `macos/ghostty/dot-config/ghostty/config`. Tema embutido
  (`theme = Ultra Dark`), fonte `JetBrainsMonoNL Nerd Font` tamanho 14, atalhos
  com Super (`Cmd+1..9` para abas). Recarregue com `Cmd+Shift+,`.
- **Linux (Omarchy / Hyprland):** config em `linux/ghostty/dot-config/ghostty/config`.
  Importa o tema dinâmico do Omarchy (`~/.local/state/omarchy/current/theme/ghostty.conf`),
  usa backend `epoll` para Wayland, atalhos CSI-u, fonte tamanho 14 e navegação
  de abas via `Alt+1..9` (sem conflitar com o Hyprland). Recarregue com
  `omarchy restart terminal` ou reiniciando o Ghostty.

### hyprmoncfg (perfis de monitores — Linux/Omarchy)

Perfis em `linux/hyprmoncfg/dot-config/hyprmoncfg/profiles/`. O app
(`hyprmoncfg-bin`, AUR) e o painel na barra do Omarchy (plugin `crmne.hyprmoncfg`)
gerenciam o layout de monitores e os workspaces persistentes, com troca
automática de perfil ao conectar/desconectar monitores. Perfis são amarrados
por EDID/descrição do monitor (sobrevivem à troca de conector). Editar pelo
TUI (`hyprmoncfg`) ou pelo painel já reflete neste repo via symlink do stow.

### Tmux

Config at `common/tmux/dot-tmux.conf` (prefix: `C-a`). Useful bindings:

| Binding | Action |
| ------- | ------ |
| `C-a r` | Reload `~/.tmux.conf` |
| `C-a h/j/k/l` | Navigate panes (vim-style) |
| `C-a X` | Kill current session (asks for confirmation) |

---

### Optional: Preview changes

If you want to see what would be linked before actually doing it:

```bash
$ stow -n --dotfiles common
$ stow -n --dotfiles linux
```

or

```bash
$ stow -n --dotfiles macos
```

The `-n` (`--no`) option prints what would be linked without making changes.

