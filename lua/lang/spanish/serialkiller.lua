L = LANG.GetLanguageTableReference("spanish")

-- GENERAL ROLE LANGUAGE STRINGS
L[SERIALKILLER.name] = "Asesino Serial"
L[SERIALKILLER.defaultTeam] = "EQUIPO Asesinos Seriales"
L["hilite_win_" .. SERIALKILLER.defaultTeam] = "EL SK GANA"
L["win_" .. SERIALKILLER.defaultTeam] = "¡El Asesino  Serial ganó!"
L["info_popup_" .. SERIALKILLER.name] = [[Una oportunidad única. Mátalos a todos. Usa tu rastreador para matar estratégicamente.
El click secundario de tu cuchillo lanza una granada.]]
L["body_found_" .. SERIALKILLER.abbr] = "¡Era un Asesino Serial!"
L["search_role_" .. SERIALKILLER.abbr] = "Esta persona era un Asesino Serial."
L["ev_win_" .. SERIALKILLER.defaultTeam] = "¡El letal Asesino Serial gana esta ronda!"
L["target_" .. SERIALKILLER.name] = "Asesino Serial"
L["ttt2_desc_" .. SERIALKILLER.name] = [[El Asesino Serial debe matar a todos y debe ser el último en pie para ganar la ronda.
Puede acceder a su propia tienda ([C]) y puede ver a todos los jugadores a través de las paredes (También puede saber quién es el Jester si está durante esa ronda).]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_sk_knife_primary"] = "Atacar a un jugador premeditadamente"
L["ttt2_role_sk_knife_secondary"] = "Lanzar una granada"
