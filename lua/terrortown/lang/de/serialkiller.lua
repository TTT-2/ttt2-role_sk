local L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[SERIALKILLER.name] = "Serienmörder"
L[SERIALKILLER.defaultTeam] = "Team Serienmörder"
L["hilite_win_" .. SERIALKILLER.defaultTeam] = "TEAM SERIENMÖRDER GEWANN"
L["win_" .. SERIALKILLER.defaultTeam] = "Der Serienmörder hat gewonnen!"
L["info_popup_" .. SERIALKILLER.name] = [[Jetzt bist du dran! Töte alle. Nutze deinen Tracker um deine Ziele zu finden.
Rechts klick mit deinem Messer wirft eine explosive Granate.]]
L["body_found_" .. SERIALKILLER.abbr] = "Er war ein Serienmörder..."
L["search_role_" .. SERIALKILLER.abbr] = "Diese Person war ein Serienmörder!"
L["ev_win_" .. SERIALKILLER.defaultTeam] = "Der tötliche Serienmörder hat die Runde gewonnen!"
L["target_" .. SERIALKILLER.name] = "Serienmörder"
L["ttt2_desc_" .. SERIALKILLER.name] = [[Der Serienmörder muss alle anderen Spieler töten und muss der letzte Überlebende (außer den Narren) sein] = um zu gewinnen.
Er kann seinen eigenen ([C]) Shop nutzen und kann alle anderen Spieler durch Wände sehen (sowie speziell den Jester sehen).]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_sk_knife_primary"] = "Greife den fokussierten Spieler an"
L["ttt2_role_sk_knife_secondary"] = "Werfe eine Schüttelgranate"

L["label_serialkiller_armor"] = "Wie viel Rüstung soll der Serienmörder zu Beginn haben?"
L["help_serialkiller_tracker_mode"] = [[
Mit welcher Art von Tracking-Item soll der Serienmörder starten?

Modus 0: Der Serienmörder spawnt nicht mit einem Tracking-Item.
Modus 1: Der Serienmörder spawnt mit einem Radar, welches die Positionen der Spieler alle 30 Sekunden anzeigt.
Modus 2: Der Serienmörder spawnt mit einem Tracker, welches die Positionen der Spieler ständig anzeigt.]]
L["label_serialkiller_tracker_mode"] = "Welcher Modus soll aktiv sein?"
L["label_serialkiller_tracker_mode_0"] = "Modus 0"
L["label_serialkiller_tracker_mode_1"] = "Modus 1"
L["label_serialkiller_tracker_mode_2"] = "Modus 2"
