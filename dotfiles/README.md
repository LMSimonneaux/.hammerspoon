# dotfiles

Config shell + terminal versionnée avec le reste de `~/.hammerspoon`, pour repartir vite sur une
nouvelle machine.

## Contenu

| Fichier | Rôle | Où ça atterrit |
|---|---|---|
| `omz-custom/zsh-highlight-colors.zsh` | Couleurs `zsh-syntax-highlighting` + `zsh-autosuggestions` | symlink `$ZSH_CUSTOM/` |
| `iterm2/com.googlecode.iterm2.plist` | Préférences iTerm2 (profil **Flowlab** = celui utilisé) | `~/Library/Preferences/` |
| `zshrc.local.example` | Template des secrets locaux | copié en `~/.zshrc.local` |
| `install.sh` | Bootstrap idempotent (symlinks, clone plugins, restore iTerm) | — |

## Nouvelle machine

```bash
git clone https://github.com/LMSimonneaux/.hammerspoon.git ~/.hammerspoon
~/.hammerspoon/dotfiles/install.sh
# puis remplir ~/.zshrc.local avec les vrais secrets
```

## Secrets

Rien de sensible n'est versionné (le repo est **public**).

- Le `.zshrc` lui-même n'est **pas versionné** (cf. `.gitignore`) ; les secrets vivent dans
  **`~/.zshrc.local`** (non versionné non plus).
- Le token GitHub du serveur MCP est lu à la volée via `gh auth token` — aucun PAT stocké.
- Le plist iTerm a été scanné : aucune clé API IA ni secret.

## Mettre à jour depuis la machine courante

Le fichier `$ZSH_CUSTOM/zsh-highlight-colors.zsh` est un **symlink vers ce repo** :
l'éditer met directement à jour le repo. Pour iTerm après avoir changé des réglages :

```bash
cp ~/Library/Preferences/com.googlecode.iterm2.plist \
   ~/.hammerspoon/dotfiles/iterm2/com.googlecode.iterm2.plist
```
