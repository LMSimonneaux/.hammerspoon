# .hammerspoon

Ma config macOS, versionnée à l'endroit où [Hammerspoon](https://www.hammerspoon.org/) la lit
(`~/.hammerspoon`). Le repo fait deux choses :

## 1. ClipStack — gestionnaire de presse-papier

Tout ce qui est copié (texte et images) est gardé dans un historique persistant (~100 items).
`⌥⌘V` ouvre un panneau pour chercher, coller ou supprimer un item.

- Les contenus sensibles (mots de passe copiés depuis 1Password, Trousseau…) ne sont **jamais** capturés.
- Code : `clipstack.lua` (logique) + `clipstack-panel.html` (interface du panneau).

## 2. dotfiles — config shell & terminal

`dotfiles/` contient ma config zsh (oh-my-zsh, alias) et iTerm2, avec un script d'installation
pour repartir vite sur une nouvelle machine. Détails dans [`dotfiles/README.md`](dotfiles/README.md).

## Installation sur une nouvelle machine

```bash
# 1. Hammerspoon
brew install --cask hammerspoon

# 2. Ce repo, à l'emplacement exact que Hammerspoon lit
git clone https://github.com/LMSimonneaux/.hammerspoon.git ~/.hammerspoon

# 3. Dotfiles (zsh, iTerm2) — sauvegarde l'existant, n'écrase rien
~/.hammerspoon/dotfiles/install.sh
```

Aucun secret n'est versionné : ils vivent dans `~/.zshrc.local` (gitignoré, template fourni).
