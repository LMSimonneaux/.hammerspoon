-- ~/.hammerspoon/init.lua — point d'entrée Hammerspoon.

require("hs.ipc")                -- active la CLI `hs` (pilotage/diagnostic depuis le terminal)
clipstack = require("clipstack") -- gestionnaire de presse-papier en pile (⌥⌘V)

-- Setup perso du matin (positionnement écran/apps) — fichier LOCAL non versionné.
-- Absent sur une autre machine → chargé seulement s'il existe, sans planter la config.
pcall(require, "morning-setup")

hs.alert.show("Config rechargée ☕️")
