if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/icon_sk.vmt")
	resource.AddFile("materials/vgui/ttt/sprite_sk.vmt")
	resource.AddFile("materials/smokey.png")
end

-- creates global var "TEAM_SERIALKILLER" and other required things
-- TEAM_[name], data: e.g. icon, color,...
InitCustomTeam("SERIALKILLER", {
		icon = "vgui/ttt/sprite_sk",
		color = Color(85, 26, 139, 255)
})

-- important to add roles with this function,
-- because it does more than just access the array ! e.g. updating other arrays
InitCustomRole("SERIALKILLER", { -- first param is access for ROLES array => SERIALKILLER or ROLES["SERIALKILLER"]
		color = Color(85, 26, 139, 255), -- ...
		dkcolor = Color(47, 5, 86, 255), -- ...
		bgcolor = Color(206, 197, 26, 255), -- ...
		abbr = "sk", -- abbreviation
		defaultTeam = TEAM_SERIALKILLER, -- the team name: roles with same team name are working together
		defaultEquipment = SPECIAL_EQUIPMENT, -- here you can set up your own default equipment
		surviveBonus = 1, -- bonus multiplier for every survive while another player was killed
		scoreKillsMultiplier = 5, -- multiplier for kill of player of another team
		scoreTeamKillsMultiplier = -16 -- multiplier for teamkill
	}, {
		pct = 0.13, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 8, -- minimum amount of players until this role is able to get selected
		credits = 1, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 20, -- randomness of getting this role selected in a round
		shopFallback = SHOP_FALLBACK_TRAITOR
})

-- if loading of lang file fns has finished
hook.Add("TTT2FinishedLoading", "SerialInitT", function()
	if SERVER and JESTER then
		-- add a easy role filtering to receive all jesters
		-- but just do it, when the role was created, then update it with recommended function
		-- theoretically this function is not necessary to call, but maybe there are some modifications
		-- of other addons. So it's better to use this function
		-- because it calls hooks and is doing some networking
		SERIALKILLER.networkRoles = {JESTER}
	end

	if CLIENT then -- just on client !

		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", SERIALKILLER.name, "Serial Killer")
		LANG.AddToLanguage("English", TEAM_SERIALKILLER, "TEAM Serial Killers")
		LANG.AddToLanguage("English", "hilite_win_" .. TEAM_SERIALKILLER, "THE SK WON") -- name of base role of a team -> maybe access with GetTeamRoles(SERIALKILLER.team)[1].name
		LANG.AddToLanguage("English", "win_" .. TEAM_SERIALKILLER, "The Serial Killer has won!") -- teamname
		LANG.AddToLanguage("English", "info_popup_" .. SERIALKILLER.name, [[Now its your turn! Kill them ALL.]])
		LANG.AddToLanguage("English", "body_found_" .. SERIALKILLER.abbr, "This was a Serial Killer...")
		LANG.AddToLanguage("English", "search_role_" .. SERIALKILLER.abbr, "This person was a Serial Killer!")
		LANG.AddToLanguage("English", "ev_win_" .. TEAM_SERIALKILLER, "The deadly Serial Killer won the round!")
		LANG.AddToLanguage("English", "target_" .. SERIALKILLER.name, "Serial Killer")
		LANG.AddToLanguage("English", "ttt2_desc_" .. SERIALKILLER.name, [[The Serialkiller needs to kill every player and must be the last survivor to win the game.
He can access his own ([C]) shop and is able to see every player through the walls (as well as he is able to select the Jester from the other players).]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", SERIALKILLER.name, "Serienkiller")
		LANG.AddToLanguage("Deutsch", TEAM_SERIALKILLER, "TEAM Serienkiller")
		LANG.AddToLanguage("Deutsch", "hilite_win_" .. TEAM_SERIALKILLER, "THE SK WON")
		LANG.AddToLanguage("Deutsch", "win_" .. TEAM_SERIALKILLER, "Der Serienkiller hat gewonnen!")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. SERIALKILLER.name, [[Jetzt bist du dran! Töte sie ALLE...]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. SERIALKILLER.abbr, "Er war ein Serienkiller...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. SERIALKILLER.abbr, "Diese Person war ein Serienkiller!")
		LANG.AddToLanguage("Deutsch", "ev_win_" .. TEAM_SERIALKILLER, "Der tötliche Serienkiller hat die Runde gewonnen!")
		LANG.AddToLanguage("Deutsch", "target_" .. SERIALKILLER.name, "Serienkiller")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. SERIALKILLER.name, [[Der Serienkiller muss alle anderen Spieler töten und muss der letzte Überlebende (außer den Narren) sein, um zu gewinnen.
Er kann seinen eigenen ([C]) Shop nutzen und kann alle anderen Spieler durch Wände sehen (sowie speziell den Jester sehen).]])
	end
end)

if SERVER then

	-- just some networking...
	util.AddNetworkString("Newserialkillers")

	-- is called if the role has been selected in the normal way of team setup
	hook.Add("TTT2RoleTypeSet", "UpdateSerialRoleSelect", function(ply)
		if ply:GetSubRole() == ROLE_SERIALKILLER then
			ply:StripWeapon("weapon_zm_improvised")
			ply:Give("weapon_sk_knife")
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

				if v:GetRole() == SERIALKILLER.index and v:Alive() then
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
	hook.Add("PreDrawHalos", "AddSerialkillerHalos", function()
		if not SERIALKILLER then return end

		local client = LocalPlayer()

		if client:GetSubRole() == ROLE_SERIALKILLER then
			local staff = {}
			local jesty = {}

			for _, v in ipairs(player.GetAll()) do
				if v:IsActive() and v:GetSubRole() ~= ROLE_SERIALKILLER then
					local b = false

					-- check whether role exists
					if JESTER then
						b = v:GetSubRole() == ROLE_JESTER
					end

					if v:Alive() and not b then
						table.insert(staff, v)
					elseif v:Alive() and b then
						table.insert(jesty, v)
					end
				end
			end

			halo.Add(staff, Color(0, 255, 0), 0, 0, 2, true, true)
			halo.Add(jesty, Color(255, 85, 100), 0, 0, 2, true, true)
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
