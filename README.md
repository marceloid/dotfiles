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
│   ├── kitty/
│   │   └── dot-config/kitty/kitty.conf
│   ├── ghostty/
│   │   └── dot-config/ghostty/config
│   ├── nvim/
│   │   └── dot-config/nvim/
│   └── tmux/
│       └── dot-tmux.conf
├── linux/                # Linux-specific configs
│   ├── app_launchers/
│   │   └── dot-local/share/applications/
│   ├── copyq/
│   │   └── dot-config/copyq/
│   ├── git/
│   │   └── dot-gitconfig
│   ├── hypr/
│   │   └── dot-config/hypr/
│   └── waybar/
│       └── dot-config/waybar/
└── macos/                # macOS-specific configs
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

* Symlinks are created relative to `$HOME`, for example:

``` bash
~/.zshrc -> ~/dotfiles/common/zsh/dot-zshrc
~/.config/nvim/init.lua -> ~/dotfiles/common/nvim/dot-config/nvim/init.lua
~/.config/kitty/kitty.conf -> ~/dotfiles/common/kitty/dot-config/kitty/kitty.conf
~/.config/espanso/match/base.yml -> ~/dotfiles/common/espanso/dot-config/espanso/match/base.yml
```

* The script is **idempotent**: running it multiple times will not duplicate links or overwrite existing files.

---

## Configured Apps

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

Config at `common/ghostty/dot-config/ghostty/config`. A single file works on
both Linux and macOS (macOS also reads the XDG path). Reload with
`Cmd+Shift+,` (macOS) or `Ctrl+Shift+,` (Linux). Theme is built-in
(`theme = Catppuccin Mocha`), so no external theme file is needed.

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

