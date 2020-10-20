--ConVar syncing
CreateConVar("ttt2_serialkiller_armor", "60", {FCVAR_ARCHIVE, FCVAR_NOTFIY})
CreateConVar("ttt2_serialkiller_tracker_mode", "2", {FCVAR_ARCHIVE, FCVAR_NOTFIY})

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicSerialKillerCVars", function(tbl)
	tbl[ROLE_SERIALKILLER] = tbl[ROLE_SERIALKILLER] or {}

	--# How much armor should the Serial Killer start with?
	-- ttt2_serialkiller_armor [0..n] (default: 60)
	table.insert(tbl[ROLE_SERIALKILLER], {
		cvar = "ttt2_serialkiller_armor",
		slider = true,
		min = 0,
		max = 120,
		decimal = 0,
		desc = "ttt2_serialkiller_armor (Def: 60)"
	})

	--# What type of tracking item should the Serial Killer start with?
	--  ttt2_serialkiller_tracker_mode [0..2] (default: 2)
	--  # 0: Serial Killer does not spawn with a tracking device
	--  # 1: Serial Killer spawns with a radar (Reveals player positions every 30 seconds)
	--  # 2: Serial Killer spawns with a tracker (Reveals player positions constantly)
	table.insert(tbl[ROLE_SERIALKILLER], {
		cvar = "ttt2_serialkiller_tracker_mode",
		combobox = true,
		desc = "ttt2_serialkiller_tracker_mode (Def: 2)",
		choices = {
			"0 - Serial Killer does not spawn with a tracking device",
			"1 - Serial Killer spawns with a radar",
			"2 - Serial Killer spawns with a tracker"
		},
		numStart = 0
	})
end)

hook.Add("TTT2SyncGlobals", "AddSerialKillerGlobals", function()
	SetGlobalInt("ttt2_serialkiller_armor", GetConVar("ttt2_serialkiller_armor"):GetInt())
	SetGlobalInt("ttt2_serialkiller_tracker_mode", GetConVar("ttt2_serialkiller_tracker_mode"):GetInt())
end)

cvars.AddChangeCallback("ttt2_serialkiller_armor", function(name, old, new)
	SetGlobalInt("ttt2_serialkiller_armor", tonumber(new))
end)
cvars.AddChangeCallback("ttt2_serialkiller_tracker_mode", function(name, old, new)
	SetGlobalInt("ttt2_serialkiller_tracker_mode", tonumber(new))
end)
