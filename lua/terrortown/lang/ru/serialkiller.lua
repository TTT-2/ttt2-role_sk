local L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[SERIALKILLER.name] = "Серийный убийца"
L[SERIALKILLER.defaultTeam] = "Команда серийных убийц"
L["hilite_win_" .. SERIALKILLER.defaultTeam] = "ПОБЕДА СЕРИЙНЫХ УБИЙЦ"
L["win_" .. SERIALKILLER.defaultTeam] = "Серийный убийца победил!"
L["info_popup_" .. SERIALKILLER.name] = [[Теперь твоя очередь! Убить их всех. Используйте трекер, чтобы найти свои цели.
Щёлкнув правой кнопкой мыши с ножом, вы бросите гранату.]]
L["body_found_" .. SERIALKILLER.abbr] = "Он был серийным убийцей!"
L["search_role_" .. SERIALKILLER.abbr] = "Этот человек был серийным убийцей!"
L["ev_win_" .. SERIALKILLER.defaultTeam] = "Смертоностные серийные убийцы выиграли раунд!"
L["target_" .. SERIALKILLER.name] = "Серийный убийца"
L["ttt2_desc_" .. SERIALKILLER.name] = [[Серийный убийца должен убить каждого игрока и должен быть последним выжившим, чтобы выиграть игру.
Он может получить доступ к своему ([C]) магазину и может видеть каждого игрока через стены (а также он может выбирать шута среди других игроков).]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_sk_knife_primary"] = "Атаковать сфокусированного игрока"
L["ttt2_role_sk_knife_secondary"] = "Бросить гранату встряски"

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
