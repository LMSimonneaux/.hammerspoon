#!/usr/bin/env bash
# Bootstrap dotfiles sur une nouvelle machine (macOS).
# Idempotent : relançable sans risque. Sauvegarde tout fichier existant avant de linker.
#
#   git clone https://github.com/LMSimonneaux/.hammerspoon.git ~/.hammerspoon
#   ~/.hammerspoon/dotfiles/install.sh
#
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH_DIR/custom}"
STAMP="$(date +%Y%m%d-%H%M%S)"

backup() {  # backup <path> — déplace un fichier/lien existant (non-symlink vers nous)
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.backup.$STAMP"
    echo "  ↳ sauvegardé : $target.backup.$STAMP"
  elif [ -L "$target" ]; then
    rm "$target"
  fi
}

link() {  # link <src> <dest>
  backup "$2"
  ln -s "$1" "$2"
  echo "  → $2  ⇒  $1"
}

echo "== 1. Oh My Zsh =="
if [ ! -d "$ZSH_DIR" ]; then
  echo "  installation d'oh-my-zsh…"
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "  déjà présent."
fi

echo "== 2. Plugins zsh (clonés, pas versionnés) =="
clone_plugin() {  # clone_plugin <url> <nom>
  local dest="$ZSH_CUSTOM/plugins/$2"
  if [ ! -d "$dest" ]; then
    git clone --depth=1 "$1" "$dest" && echo "  cloné : $2"
  else
    echo "  déjà présent : $2"
  fi
}
clone_plugin https://github.com/zsh-users/zsh-autosuggestions "zsh-autosuggestions"
clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting "zsh-syntax-highlighting"

echo "== 3. Liens symboliques =="
link "$DOTFILES/zshrc" "$HOME/.zshrc"
mkdir -p "$ZSH_CUSTOM"
link "$DOTFILES/omz-custom/zsh-highlight-colors.zsh" "$ZSH_CUSTOM/zsh-highlight-colors.zsh"

echo "== 4. Secrets locaux =="
if [ ! -f "$HOME/.zshrc.local" ]; then
  cp "$DOTFILES/zshrc.local.example" "$HOME/.zshrc.local"
  echo "  créé ~/.zshrc.local depuis le template — À REMPLIR avec tes vrais secrets."
else
  echo "  ~/.zshrc.local existe déjà (on n'y touche pas)."
fi

echo "== 5. iTerm2 =="
ITERM_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
echo "  ⚠️  Quitte iTerm avant de restaurer ses préférences, sinon elles seront réécrites."
read -r -p "  Restaurer le plist iTerm maintenant ? [y/N] " ans
if [[ "${ans:-N}" =~ ^[Yy]$ ]]; then
  backup "$ITERM_PLIST"
  cp "$DOTFILES/iterm2/com.googlecode.iterm2.plist" "$ITERM_PLIST"
  defaults read com.googlecode.iterm2 >/dev/null 2>&1 || true
  echo "  restauré. Relance iTerm."
else
  echo "  ignoré. Pour le faire plus tard : cp \"$DOTFILES/iterm2/com.googlecode.iterm2.plist\" \"$ITERM_PLIST\" (iTerm fermé)."
fi

echo
echo "✅ Terminé. Ouvre un nouveau shell (ou : source ~/.zshrc) et remplis ~/.zshrc.local."
