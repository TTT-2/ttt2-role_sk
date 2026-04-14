local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[SERIALKILLER.name] = "Tueur en série"
L[SERIALKILLER.defaultTeam] = "Team Tueur en série"
L["hilite_win_" .. SERIALKILLER.defaultTeam] = "LE TUEUR EN SÉRIE A GAGNÉ"
L["win_" .. SERIALKILLER.defaultTeam] = "Le tueur en série a gagné !"
L["info_popup_" .. SERIALKILLER.name] = [[Maintenant, c'est à votre tour ! Tuez-les tous. Utilisez votre traqueur pour trouver vos cibles.
Un clic droit avec votre couteau lance une grenade explosive.]]
L["body_found_" .. SERIALKILLER.abbr] = "C'était un tueur en série!"
L["search_role_" .. SERIALKILLER.abbr] = "Cette personne était un tueur en série!"
L["ev_win_" .. SERIALKILLER.defaultTeam] = "L'impitoyable tueur en série a gagné le round!"
L["target_" .. SERIALKILLER.name] = "Tueur en série"
L["ttt2_desc_" .. SERIALKILLER.name] = [[Le tueur en série doit tuer tous les joueurs et être le dernier survivant pour gagner la partie.
Il peut accéder à son propre ([C]) shop et est capable de voir chaque joueur à travers les murs (aussi il est capable de sélectionner le bouffon parmi les autres joueurs).]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_sk_knife_primary"] = "Attaquer le joueur ciblé"
L["ttt2_role_sk_knife_secondary"] = "Lance une grenade"

--L["label_serialkiller_armor"] = "How much armor should the Serial Killer start with?"
--L["help_serialkiller_tracker_mode"] = [[
--What type of tracking item should the Serial Killer start with?

--Mode 0: The Serial Killer does not spawn with a tracking device. 
--Mode 1: The Serial Killer spawns with a radar, which reveals player positions every 30 seconds. 
--Mode 2: The Serial Killer spawns with a tracker, which reveals player positions constantly.]]
--L["label_serialkiller_tracker_mode"] = "Which mode should be active?"
--L["label_serialkiller_tracker_mode_0"] = "Mode 0"
--L["label_serialkiller_tracker_mode_1"] = "Mode 1"
--L["label_serialkiller_tracker_mode_2"] = "Mode 2"
