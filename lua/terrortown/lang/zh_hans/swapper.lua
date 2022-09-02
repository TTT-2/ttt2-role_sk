local L = LANG.GetLanguageTableReference("zh_hans")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.SWAPPER.name] = "交换者"
L["info_popup_" .. roles.SWAPPER.name] = [[你是交换者,现在去死吧!]]
L["body_found_" .. roles.SWAPPER.abbr] = "他们是交换者!?"
L["search_role_" .. roles.SWAPPER.abbr] = "这个人是交换者!?"
L["target_" .. roles.SWAPPER.name] = "交换者"
L["ttt2_desc_" .. roles.SWAPPER.name] = [[交换者是一个小丑角色,在被杀时会窃取其杀手身份,并将其作为新的交换者复活!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_swapper_inform_opposite"] = "在这一轮中,你将重生为一个与你的杀手随机相反的角色!"
L["ttt2_role_swapper_inform_same"] = "这一轮你将重生为与杀手相同的角色!"
L["ttt2_role_swapper_inform_wait"] = "直到你的杀手在这一轮中死去,你才会重生!"
L["ttt2_role_swapper_inform_instant"] = "一旦在本回合中被杀!你将在{delay}秒后重生."