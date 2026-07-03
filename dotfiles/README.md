# dotfiles

Config shell + terminal versionnée avec le reste de `~/.hammerspoon`, pour repartir vite sur une
nouvelle machine.

## Contenu

| Fichier | Rôle | Où ça atterrit |
|---|---|---|
| `zshrc` | `.zshrc` sanitisé (alias, fonctions `kp`/`razzia`/`flowlab`, plugins, thème) | symlink `~/.zshrc` |
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

- Les secrets vivent dans **`~/.zshrc.local`** (non versionné, cf. `.gitignore`). Le `.zshrc`
  versionné le `source` s'il existe.
- Le token GitHub du serveur MCP est lu à la volée via `gh auth token` — aucun PAT stocké.
- Le plist iTerm a été scanné : aucune clé API IA ni secret.

## Mettre à jour depuis la machine courante

Les fichiers `~/.zshrc` et `$ZSH_CUSTOM/zsh-highlight-colors.zsh` sont des **symlinks vers ce repo** :
les éditer met directement à jour le repo. Pour iTerm après avoir changé des réglages :

```bash
cp ~/Library/Preferences/com.googlecode.iterm2.plist \
   ~/.hammerspoon/dotfiles/iterm2/com.googlecode.iterm2.plist
```
