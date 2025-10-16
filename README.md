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
├── common/               # Shared configurations
│   ├── git/
│   │   ├── dot-gitconfig
│   │   └── dot-gitignore_global
│   ├── zsh/
│   │   └── dot-zshrc
│   ├── nvim/
│   │   └── dot-config/nvim/init.lua
│   └── kitty/
│       └── dot-config/kitty/kitty.conf
├── linux/                # Linux-specific configs
│   ├── bash/
│   │   └── dot-bashrc
│   └── hypr/
│       └── dot-config/hypr/hyprland.conf
└── macos/                # macOS-specific configs
    ├── zsh/
    │   └── dot-zshrc
    └── .../
        └── dot-config/karabiner/karabiner.json
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
```

* The script is **idempotent**: running it multiple times will not duplicate links or overwrite existing files.

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

