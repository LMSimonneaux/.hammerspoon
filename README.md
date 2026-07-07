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

## Guide d'installation

Pas besoin d'être développeur — comptez 5 minutes.

**Étape 1 — Installer Hammerspoon** (l'application qui fait tourner tout ça)

1. Téléchargez Hammerspoon sur [hammerspoon.org](https://www.hammerspoon.org/) (bouton *Download*).
2. Double-cliquez sur le fichier téléchargé, puis glissez l'icône **Hammerspoon** dans votre dossier **Applications**.
3. Ouvrez Hammerspoon. macOS va vous demander une autorisation « Accessibilité » : acceptez (c'est ce qui permet le raccourci clavier). Vous pouvez la retrouver dans **Réglages Système → Confidentialité et sécurité → Accessibilité**.

**Étape 2 — Récupérer cette configuration**

1. Ouvrez l'application **Terminal** (tapez « Terminal » dans Spotlight, la loupe 🔍 en haut à droite).
2. Copiez-collez cette ligne, puis appuyez sur Entrée :

   ```bash
   git clone https://github.com/LMSimonneaux/.hammerspoon.git ~/.hammerspoon
   ```

   > Si votre Mac vous propose d'installer les « outils de développement en ligne de commande », acceptez, attendez la fin, puis recollez la ligne.

**Étape 3 — Activer**

1. Cliquez sur l'icône Hammerspoon (le marteau, en haut à droite de l'écran) → **Reload Config**.
2. C'est prêt : appuyez sur `⌥⌘V` (Option + Commande + V) — le panneau ClipStack s'ouvre avec tout ce que vous avez copié récemment.

## Installation express (devs)

```bash
# 1. Hammerspoon
brew install --cask hammerspoon

# 2. Ce repo, à l'emplacement exact que Hammerspoon lit
git clone https://github.com/LMSimonneaux/.hammerspoon.git ~/.hammerspoon

# 3. Dotfiles (zsh, iTerm2) — sauvegarde l'existant, n'écrase rien
~/.hammerspoon/dotfiles/install.sh
```
