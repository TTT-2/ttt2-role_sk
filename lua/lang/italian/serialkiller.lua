L = LANG.GetLanguageTableReference("italian")

-- GENERAL ROLE LANGUAGE STRINGS
L[SERIALKILLER.name] = "Serial Killer"
L[SERIALKILLER.defaultTeam] = "TEAM Serial Killers"
L["hilite_win_" .. SERIALKILLER.defaultTeam] = "I SERIAL KILLER HANNO VINTO"
L["win_" .. SERIALKILLER.defaultTeam] = "Il Serial Killer ha vinto!"
L["info_popup_" .. SERIALKILLER.name] = [[Ora è il turno! Uccidi tutti. Usa il tuo tracker per trovare i tuoi bersagli.
Clickare con il tasto destro sul tuo coltello lancia una mini discombulator.]]
L["body_found_" .. SERIALKILLER.abbr] = "Era un Serial Killer!"
L["search_role_" .. SERIALKILLER.abbr] = "Questa persona era un Serial Killer!"
L["ev_win_" .. SERIALKILLER.defaultTeam] = "Il letale Serial Killer ha vinto il round!"
L["target_" .. SERIALKILLER.name] = "Serial Killer"
L["ttt2_desc_" .. SERIALKILLER.name] = [[Il Serial Killer deve uccidere tutti i player e deve rimanere l'ultimo sopravvissuto
Può accedere al suo shop dei ([C]) e può vedere tutti i giocatori attraverso le pareti (può anche distinguere il jester dagli altri giocatori.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_sk_knife_primary"] = "{primaryfire} attacca il player nel mirino"
L["ttt2_role_sk_knife_secondary"] = "{secondaryfire} lancia una mini discombulator"
