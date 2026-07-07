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

# backup <path> — met de côté tout existant (fichier OU symlink), ne supprime JAMAIS rien.
backup() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$target.backup.$STAMP"
    echo "  ↳ sauvegardé : $target.backup.$STAMP"
  fi
}

link() {  # link <src> <dest> — idempotent : déjà lié vers nous → no-op
  local src="$1" dest="$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "  = $dest déjà en place"
    return
  fi
  backup "$dest"
  ln -s "$src" "$dest"
  echo "  → $dest  ⇒  $src"
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
# Le zshrc n'est plus versionné : on ne le lie que s'il est présent localement.
if [ -f "$DOTFILES/zshrc" ]; then
  link "$DOTFILES/zshrc" "$HOME/.zshrc"
else
  echo "  (pas de zshrc dans le repo — on garde le ~/.zshrc existant)"
fi
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
