if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_sk.vmt")
end

-- creates global var "TEAM_SERIALKILLER" and other required things
-- TEAM_[name], data: e.g. icon, color,...
roles.InitCustomTeam(ROLE.name, {
		icon = "vgui/ttt/dynamic/roles/icon_sk",
		color = Color(49, 105, 109, 255)
})

function ROLE:PreInitialize()
	self.color = Color(49, 105, 109, 255)

	self.abbr = "sk" -- abbreviation
	self.surviveBonus = 1 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 5 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -16 -- multiplier for teamkill

	self.defaultTeam = TEAM_SERIALKILLER -- the team name: roles with same team name are working together
	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment

	self.conVarData = {
		pct = 0.13, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 8, -- minimum amount of players until this role is able to get selected
		credits = 1, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 20, -- randomness of getting this role selected in a round
		shopFallback = SHOP_FALLBACK_TRAITOR
	}
end

function ROLE:Initialize()
	if SERVER and JESTER then
		-- add a easy role filtering to receive all jesters
		-- but just do it, when the role was created, then update it with recommended function
		-- theoretically this function is not necessary to call, but maybe there are some modifications
		-- of other addons. So it's better to use this function
		-- because it calls hooks and is doing some networking
		self.networkRoles = {JESTER}
	end
end

if SERVER then
	--CONSTANTS
	-- Enum for tracker mode
	local TRACKER_MODE = {NONE = 0, RADAR = 1, TRACKER = 2}

	-- Give Loadout on respawn and rolechange
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		ply:GiveEquipmentWeapon("weapon_ttt_sk_knife")
		if GetConVar("ttt2_serialkiller_tracker_mode"):GetInt() == TRACKER_MODE.RADAR then
			ply:GiveEquipmentItem("item_ttt_radar")
		elseif GetConVar("ttt2_serialkiller_tracker_mode"):GetInt() == TRACKER_MODE.TRACKER then
			ply:GiveEquipmentItem("item_ttt_tracker")
		end
		ply:GiveArmor(GetConVar("ttt2_serialkiller_armor"):GetInt())
	end

	-- Remove Loadout on death and rolechange
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		ply:StripWeapon("weapon_ttt_sk_knife")
		if GetConVar("ttt2_serialkiller_tracker_mode"):GetInt() == TRACKER_MODE.RADAR then
			ply:RemoveEquipmentItem("item_ttt_radar")
		elseif GetConVar("ttt2_serialkiller_tracker_mode"):GetInt() == TRACKER_MODE.TRACKER then
			ply:RemoveEquipmentItem("item_ttt_tracker")
		end
		ply:RemoveArmor(GetConVar("ttt2_serialkiller_armor"):GetInt())
	end

	hook.Add("PlayerDeath", "SerialDeath", function(victim, infl, attacker)
		if IsValid(attacker) and attacker:IsPlayer() and attacker:GetSubRole() == ROLE_SERIALKILLER then
			timer.Stop("sksmokechecker")
			timer.Start("sksmokechecker")
			timer.Remove("sksmoke")
		end
	end)
end
