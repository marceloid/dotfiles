#!/usr/bin/env bash
set -euo pipefail

# Always run from the repo root (where this script lives)
cd "$(dirname "$0")"

ACTION="stow"
if [[ "${1:-}" == "--unstow" || "${1:-}" == "-D" ]]; then
    ACTION="unstow"
fi

echo "🔍 Detecting operating system..."
case "$(uname -s)" in
    Linux*)  OS="linux" ;;
    Darwin*) OS="macos" ;;
    *) echo "❌ Unsupported OS: $(uname -s)" && exit 1 ;;
esac
echo "✅ Detected OS: $OS"
echo

# Function to (un)stow each subfolder in a given directory
process_folder_by_folder() {
    local base_dir="$1"
    local action="$2"

    if [[ -d "$base_dir" ]]; then
        echo "📦 Processing '$base_dir' for action: $action"
        # Change into the base_dir so package names are relative
        pushd "$base_dir" > /dev/null || return
        # iterate only directories
        for pkg in */; do
            # skip if not a directory (safety) or if pattern doesn't match
            [[ -z "$pkg" ]] && continue
            pkg_name=$(basename "$pkg")
            # ignore hidden folders like .git, dotfiles metadata, etc.
            if [[ "$pkg_name" == .* ]]; then
                continue
            fi

            if [[ "$action" == "stow" ]]; then
                echo "  🔗 Stowing $pkg_name ..."
                stow --dotfiles -v -t ~ "$pkg_name" || echo "  ⚠️ Failed to stow $pkg_name"
            else
                echo "  🧹 Unstowing $pkg_name ..."
                stow -D --dotfiles -v -t ~ "$pkg_name" || echo "  ⚠️ Failed to unstow $pkg_name"
            fi
        done
        popd > /dev/null
        echo
    else
        echo "🚫 Skipping $base_dir (not found)"
    fi
}

# Run for both common and OS-specific directories
if [[ "$ACTION" == "stow" ]]; then
    echo "🔗 Stowing common configs folder-by-folder..."
    process_folder_by_folder "common" "stow"

    echo "🔗 Stowing $OS-specific configs folder-by-folder..."
    process_folder_by_folder "$OS" "stow"

    echo "✨ All done! Dotfiles for '$OS' have been stowed."
else
    echo "🧹 Unstowing common configs folder-by-folder..."
    process_folder_by_folder "common" "unstow"

    echo "🧹 Unstowing $OS-specific configs folder-by-folder..."
    process_folder_by_folder "$OS" "unstow"

    echo "✅ All dotfiles have been unstowed for '$OS'."
fi

###############################################################################
# Arch Linux: instalar dependências e garantir o helper git-credential-libsecret
###############################################################################
# Só executa em Linux e apenas se pacman existir (Arch / derivados)
if [[ "$OS" == "linux" ]]; then
  if command -v pacman >/dev/null; then
    echo "📦 Instalando dependências do libsecret (Arch)..."

    # Garante que git e libsecret estejam instalados
    sudo pacman -S --needed git libsecret

    # No Arch, o helper não vem pronto: compila manualmente se não existir
    if [[ ! -x /usr/local/bin/git-credential-libsecret ]]; then
      echo "🔧 Compilando git-credential-libsecret..."
      cd /usr/share/git/credential/libsecret
      sudo make
      sudo install -m755 git-credential-libsecret /usr/local/bin/
    fi
  fi
fi

###############################################################################
# Inicializar o Secret Service (keyring) na sessão do usuário
###############################################################################
# Necessário para que o libsecret consiga armazenar credenciais
# Deve rodar na sessão gráfica (Wayland/X11)
if command -v gnome-keyring-daemon >/dev/null; then
  eval "$(gnome-keyring-daemon --start --components=secrets,ssh)"
  export SSH_AUTH_SOCK
fi
