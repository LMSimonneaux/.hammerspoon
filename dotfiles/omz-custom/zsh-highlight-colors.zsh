# Couleurs zsh-syntax-highlighting + zsh-autosuggestions (optimisées fond noir).
# Placé dans $ZSH_CUSTOM/ → chargé automatiquement par oh-my-zsh, après les plugins.
# Versionné dans le repo .hammerspoon (dotfiles/omz-custom/).

typeset -A ZSH_HIGHLIGHT_STYLES

# Texte de base / arguments → vert
ZSH_HIGHLIGHT_STYLES[default]='fg=green'

# Commande inconnue / introuvable → rouge vif
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=196,bold'

# Commandes, builtins, fonctions, alias → cyan vif (ressortent du vert)
ZSH_HIGHLIGHT_STYLES[command]='fg=51,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=51'
ZSH_HIGHLIGHT_STYLES[function]='fg=51'
ZSH_HIGHLIGHT_STYLES[alias]='fg=51'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=51'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=51'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=51,underline'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=51'

# Mots réservés (if, for, while…) → jaune
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=226'

# Options (-x, --xxx) → orange clair
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=208'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=208'

# Chaînes de caractères → jaune doux
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=222'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=222'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=222'

# Chemins → vert souligné
ZSH_HIGHLIGHT_STYLES[path]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=green,underline'

# Variables / substitutions → magenta vif
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=201'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=201'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=201'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=13'

# Redirections / séparateurs → bleu ciel
ZSH_HIGHLIGHT_STYLES[redirection]='fg=39'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=39'

# Commentaires → gris lisible (le défaut "noir,bold" est illisible sur fond noir)
ZSH_HIGHLIGHT_STYLES[comment]='fg=244'

# Suggestions zsh-autosuggestions → gris visible (défaut fg=8 trop sombre)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
