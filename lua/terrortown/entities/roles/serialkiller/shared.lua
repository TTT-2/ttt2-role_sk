if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_sk.vmt")
	resource.AddFile("materials/smokey.png")
end

-- creates global var "TEAM_SERIALKILLER" and other required things
-- TEAM_[name], data: e.g. icon, color,...
roles.InitCustomTeam(ROLE.name, {
		icon = "vgui/ttt/dynamic/roles/icon_sk",
		color = Color(49, 105, 109, 255)
})

function ROLE:PreInitialize()
	self.color = Color(49, 105, 109, 255) -- ...
	self.dkcolor = Color(11, 60, 65, 255) -- ...
	self.bgcolor = Color(179, 126, 79, 255) -- ...
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

	if CLIENT then
		-- Role specific language elements
		LANG.AddToLanguage("English", self.name, "Serial Killer")
		LANG.AddToLanguage("English", self.defaultTeam, "TEAM Serial Killers")
		LANG.AddToLanguage("English", "hilite_win_" .. self.defaultTeam, "THE SK WON")
		LANG.AddToLanguage("English", "win_" .. self.defaultTeam, "The Serial Killer has won!")
		LANG.AddToLanguage("English", "info_popup_" .. self.name, [[Now its your turn! Kill them ALL.]])
		LANG.AddToLanguage("English", "body_found_" .. self.abbr, "This was a Serial Killer...")
		LANG.AddToLanguage("English", "search_role_" .. self.abbr, "This person was a Serial Killer!")
		LANG.AddToLanguage("English", "ev_win_" .. self.defaultTeam, "The deadly Serial Killer won the round!")
		LANG.AddToLanguage("English", "target_" .. self.name, "Serial Killer")
		LANG.AddToLanguage("English", "ttt2_desc_" .. self.name, [[The Serialkiller needs to kill every player and must be the last survivor to win the game.
He can access his own ([C]) shop and is able to see every player through the walls (as well as he is able to select the Jester from the other players).]])

		LANG.AddToLanguage("Deutsch", self.name, "Serienkiller")
		LANG.AddToLanguage("Deutsch", self.defaultTeam, "TEAM Serienkiller")
		LANG.AddToLanguage("Deutsch", "hilite_win_" .. self.defaultTeam, "THE SK WON")
		LANG.AddToLanguage("Deutsch", "win_" .. self.defaultTeam, "Der Serienkiller hat gewonnen!")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. self.name, [[Jetzt bist du dran! Töte sie ALLE...]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. self.abbr, "Er war ein Serienkiller...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. self.abbr, "Diese Person war ein Serienkiller!")
		LANG.AddToLanguage("Deutsch", "ev_win_" .. self.defaultTeam, "Der tötliche Serienkiller hat die Runde gewonnen!")
		LANG.AddToLanguage("Deutsch", "target_" .. self.name, "Serienkiller")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. self.name, [[Der Serienkiller muss alle anderen Spieler töten und muss der letzte Überlebende (außer den Narren) sein, um zu gewinnen.
Er kann seinen eigenen ([C]) Shop nutzen und kann alle anderen Spieler durch Wände sehen (sowie speziell den Jester sehen).]])
	end
end

if SERVER then
	-- Give Loadout on respawn and rolechange	
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		ply:GiveEquipmentItem('item_ttt_tracker')
	end

	-- Remove Loadout on death and rolechange
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		ply:RemoveEquipmentItem('item_ttt_tracker')
	end

	-- just some networking...
	util.AddNetworkString("Newserialkillers")

	-- remove the crowbar in favor of something else
	hook.Add("TTT2ModifyDefaultLoadout", "ModifySKLoadout", function(loadout_weapons, subrole)
		if subrole == ROLE_SERIALKILLER then
			for k, v in ipairs(loadout_weapons[subrole]) do
				if v == "weapon_zm_improvised" then
					table.remove(loadout_weapons[subrole], k)

					local tbl = weapons.GetStored("weapon_zm_improvised")

					if tbl and tbl.InLoadoutFor then
						for k2, sr in ipairs(tbl.InLoadoutFor) do
							if sr == subrole then
								table.remove(tbl.InLoadoutFor, k2)
							end
						end
					end
				end
			end
		end
	end)

	hook.Add("PlayerDeath", "SerialDeath", function(victim, infl, attacker)
		if IsValid(attacker) and attacker:IsPlayer() and attacker:GetSubRole() == ROLE_SERIALKILLER then
			timer.Stop("sksmokechecker")
			timer.Start("sksmokechecker")
			timer.Remove("sksmoke")
		end
	end)

	hook.Add("ScalePlayerDamage", "SerialScaleDmg", function(ply, hitgroup, dmginfo)
		if ply:GetSubRole() == ROLE_SERIALKILLER then
			dmginfo:ScaleDamage(0.5)
		end

		if ply:IsPlayer() and dmginfo:GetAttacker():IsPlayer()
		and dmginfo:IsBulletDamage() and dmginfo:GetAttacker():GetSubRole() == ROLE_SERIALKILLER
		then
			dmginfo:ScaleDamage(1.25)
		end
	end)

	-- following code by Jenssons
	function thatsksmoke()
		timer.Remove("sksmoke")
		timer.Create("sksmoke", 0.1, 0, function()
			timer.Remove("thatsksmokecheckers")

			for _, v in ipairs(player.GetAll()) do
				if not IsValid(v) then return end

				if v:GetSubRole() == ROLE_SERIALKILLER and v:Alive() then
					v:PrintMessage(HUD_PRINTCENTER, "Your Evil is showing")

					net.Start("Newserialkillers")
					net.WriteEntity(v)
					net.Broadcast()
				else
					timer.Remove("thatsksmokecheckers")
					timer.Remove("sksmoke")
				end
			end
		end)
	end

	function thatsksmokechecker()
		timer.Create("sksmokechecker", 75, 0, thatsksmoke)
	end

	timer.Create("roundcheckers", 0.1, 0, function()
		if GetRoundState() == ROUND_ACTIVE then
			timer.Create("thatsksmokecheckers", 1, 1, thatsksmokechecker)
		else
			timer.Remove("thatsksmokecheckers")
			timer.Remove("sksmoke")
		end
	end)
end

if CLIENT then
	local staff = {}
	local jesty = {}
	
	hook.Add("TTT2UpdateSubrole", "AdjustSerialkillerMarks", function(ply, old, new)
		if not SERIALKILLER then return end

		local client = LocalPlayer()
		if client ~= ply then return end

		if old == ROLE_SERIALKILLER then
			marks.Remove(staff)
			marks.Remove(jesty)
			
			staff = {}
			jesty = {}
		elseif new == ROLE_SERIALKILLER then
			for _, v in ipairs(player.GetAll()) do
				if v:Alive() and v:IsTerror() and v:GetSubRole() ~= ROLE_SERIALKILLER then
					local jes = false

					-- check whether role exists
					if JESTER then
						jes = v:GetSubRole() == ROLE_JESTER
					end

					if jes then
						jesty[#jesty + 1] = v
					else
						staff[#staff + 1] = v
					end
				end
			end

			marks.Add(staff, Color(0, 255, 0))
			marks.Add(jesty, Color(255, 85, 100))
		end
	end)

	local serialkillers = Material("smokey.png")

	net.Receive("Newserialkillers", function()
		local ent = net.ReadEntity()

		local pos = ent:GetPos() + Vector(0, 0, 50)

		local velFax = 50
		local gravMax = 5

		local gravity = Vector(math.random(-gravMax, gravMax), math.random(-gravMax, gravMax), math.random(-gravMax, 0))

		--Handles particles
		local emitter = ParticleEmitter(pos, true)

		for I = 1, 150 do
			local p = emitter:Add(serialkillers, pos)
			p:SetStartSize(math.random(6, 10))
			p:SetEndSize(0)
			p:SetAngles(Angle(math.random(0, 360), math.random(0, 360), math.random(0, 360)))
			p:SetAngleVelocity(Angle(math.random(5, 50), math.random(5, 50), math.random(5, 50)))
			p:SetVelocity(Vector(math.random(-velFax, velFax), math.random(-velFax, velFax), math.random(-velFax, velFax)))
			p:SetColor(0, 0, 0)
			p:SetDieTime(0.5)
			p:SetGravity(gravity)
			p:SetAirResistance(125)
		end
	end)
end
