L = LANG.GetLanguageTableReference("日本語")

-- GENERAL ROLE LANGUAGE STRINGS
L[SERIALKILLER.name] = "Serial Killer"
L[SERIALKILLER.defaultTeam] = "Serial Killer陣営"
L["hilite_win_" .. SERIALKILLER.defaultTeam] = "Serial Killerの勝利"
L["win_" .. SERIALKILLER.defaultTeam] = "Serial Killerが勝利した！"
L["info_popup_" .. SERIALKILLER.name] = [[さあ仕事の時間だ！彼らを皆殺しにしようか。獲物を探すためにトラッカーを用いて。
ナイフを持ちながら右クリックで振動を起こすグレネードを投げれるぞ。]]
L["body_found_" .. SERIALKILLER.abbr] = "奴はSerial Killerだったな！"
L["search_role_" .. SERIALKILLER.abbr] = "こいつはSerial Killerだったようだな！"
L["ev_win_" .. SERIALKILLER.defaultTeam] = "血も涙もないSerial Killerが勝利した！"
L["target_" .. SERIALKILLER.name] = "Serial Killer"
L["ttt2_desc_" .. SERIALKILLER.name] = [[Serial Killerは自分以外の全員を殺せば勝ち。
([C])キーからのショップでアイテム購入できるだけじゃなく、壁を透き通して相手を見ることができる。]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_sk_knife_primary"] = "前方のプレイヤーを攻撃"
L["ttt2_role_sk_knife_secondary"] = "振動グレネードを投げる"
