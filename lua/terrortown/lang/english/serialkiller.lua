local L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[SERIALKILLER.name] = "Serial Killer"
L[SERIALKILLER.defaultTeam] = "Team Serial Killers"
L["hilite_win_" .. SERIALKILLER.defaultTeam] = "TEAM SERIAL KILLER WON"
L["win_" .. SERIALKILLER.defaultTeam] = "The Serial Killer has won!"
L["info_popup_" .. SERIALKILLER.name] = [[Now it's your turn! Kill them all. Use your tracker to find your targets.
Right klicking with your knife throws an explosive grenade.]]
L["body_found_" .. SERIALKILLER.abbr] = "They were a Serial Killer!"
L["search_role_" .. SERIALKILLER.abbr] = "This person was a Serial Killer!"
L["ev_win_" .. SERIALKILLER.defaultTeam] = "The deadly Serial Killer won the round!"
L["target_" .. SERIALKILLER.name] = "Serial Killer"
L["ttt2_desc_" .. SERIALKILLER.name] = [[The Serialkiller needs to kill every player and must be the last survivor to win the game.
He can access his own ([C]) shop and is able to see every player through the walls (as well as he is able to select the jester from the other players).]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_sk_knife_primary"] = "Attack a focused player"
L["ttt2_role_sk_knife_secondary"] = "Throw a shake nade"
