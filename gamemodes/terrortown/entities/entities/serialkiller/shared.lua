AddCSLuaFile()

if SERVER then
   resource.AddFile("materials/vgui/ttt/icon_sk.vmt")
   resource.AddFile("materials/vgui/ttt/sprite_sk.vmt")
   resource.AddFile("materials/smokey.png")
end

-- important to add roles with this function,
-- because it does more than just access the array ! e.g. updating other arrays
AddCustomRole("SERIALKILLER", { -- first param is access for ROLES array => ROLES.SERIALKILLER or ROLES["SERIALKILLER"]
	color = Color(85, 26, 139, 255), -- ...
	dkcolor = Color(65, 20, 107, 255), -- ...
	bgcolor = Color(0, 50, 0, 200), -- ...
	name = "serialkiller", -- just a unique name for the script to determine
	printName = "Serialkiller", -- The text that is printed to the player, e.g. in role alert
	abbr = "sk", -- abbreviation
	shop = true, -- can the role access the [C] shop ?
	team = "serialkillers", -- the team name: roles with same team name are working together
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
    random = 20 -- randomness of getting this role selected in a round
})

-- if sync of roles has finished
hook.Add("TTT2_FinishedSync", "SerialInitT", function(ply, first)
    if SERVER and first and ROLES.JESTER then
        -- add a easy role filtering to receive all jesters
        -- but just do it, when the role was created, then update it with recommended function
        -- theoretically this function is not necessary to call, but maybe there are some modifications
        -- of other addons. So it's better to use this function 
        -- because it calls hooks and is doing some networking
        UpdateCustomRole("SERIALKILLER", {
            networkRoles = {
                ROLES.JESTER
            }
        })
    end
    
	if CLIENT and first then -- just on client and first init !

		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", ROLES.SERIALKILLER.name, "Serial Killer")
		LANG.AddToLanguage("English", "hilite_win_" .. ROLES.SERIALKILLER.name, "THE SK WON") -- name of base role of a team -> maybe access with GetTeamRoles(ROLES.SERIALKILLER.team)[1].name
		LANG.AddToLanguage("English", "win_" .. ROLES.SERIALKILLER.team, "The Serial Killer has won!") -- teamname
		LANG.AddToLanguage("English", "info_popup_" .. ROLES.SERIALKILLER.name, [[Now its your turn! Kill them ALL.]])
		LANG.AddToLanguage("English", "body_found_" .. ROLES.SERIALKILLER.abbr, "This was a Serial Killer...")
		LANG.AddToLanguage("English", "search_role_" .. ROLES.SERIALKILLER.abbr, "This person was a Serial Killer!")
        LANG.AddToLanguage("English", "ev_win_" .. ROLES.SERIALKILLER.abbr, "The deadly Serial Killer won the round!")
		LANG.AddToLanguage("English", "target_" .. ROLES.SERIALKILLER.name, "Serial Killer")
        LANG.AddToLanguage("English", "ttt2_desc_" .. ROLES.SERIALKILLER.name, [[The Serialkiller needs to kill every player and must be the last survivor to win the game. 
He can access his own ([C]) shop and is able to see every player through the walls (as well as he is able to select the Jester from the other players).]])
	    
	    -- optional for toggling whether player can avoid the role
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.SERIALKILLER.abbr, "Avoid being selected as Serial Killer!")
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.SERIALKILLER.abbr .. "_tip", 
	        [[Enable this to ask the server not to select you as Serial Killer if possible. Does not mean you are Traitor more often.]])
	    
	    ---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", ROLES.SERIALKILLER.name, "Serienkiller")
		LANG.AddToLanguage("Deutsch", "hilite_win_" .. ROLES.SERIALKILLER.name, "THE SK WON")
		LANG.AddToLanguage("Deutsch", "win_" .. ROLES.SERIALKILLER.team, "Der Serienkiller hat gewonnen!")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. ROLES.SERIALKILLER.name, [[Jetzt bist du dran! Töte sie ALLE...]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. ROLES.SERIALKILLER.abbr, "Er war ein Serienkiller...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. ROLES.SERIALKILLER.abbr, "Diese Person war ein Serienkiller!")
        LANG.AddToLanguage("Deutsch", "ev_win_" .. ROLES.SERIALKILLER.abbr, "Der tötliche Serienkiller hat die Runde gewonnen!")
		LANG.AddToLanguage("Deutsch", "target_" .. ROLES.SERIALKILLER.name, "Serienkiller")
        LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. ROLES.SERIALKILLER.name, [[Der Serienkiller muss alle anderen Spieler töten und muss der letzte Überlebende (außer den Narren) sein, um zu gewinnen. 
Er kann seinen eigenen ([C]) Shop nutzen und kann alle anderen Spieler durch Wände sehen (sowie speziell den Jester sehen).]])
	    
		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.SERIALKILLER.abbr, "Vermeide als Serienkiller ausgewählt zu werden!")
		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.SERIALKILLER.abbr .. "_tip", 
	        [[Aktivieren, um beim Server anzufragen, nicht als Serienkiller ausgewählt zu werden. Das bedeuted nicht, dass du öfter Traitor wirst!]])
	end
end)

if SERVER then
    
	-- just some networking...
	util.AddNetworkString("Newserialkillers")

	-- is called if the role has been selected in the normal way of team setup
	hook.Add("TTT2_RoleTypeSet", "UpdateSerialRoleSelect", function(ply)
		if ply:GetRole() == ROLES.SERIALKILLER.index then
			ply:StripWeapon("weapon_zm_improvised")
			ply:Give("weapon_sk_knife")
		end
	end)

	hook.Add("PlayerDeath", "SerialDeath", function(victim, infl, attacker)
	    if attacker:IsPlayer() and attacker:GetRole() == ROLES.SERIALKILLER.index then
	       timer.Stop("sksmokechecker")
	       timer.Start("sksmokechecker")
	       timer.Remove("sksmoke")
	    end
	end)

	hook.Add("ScalePlayerDamage", "SerialScaleDmg", function(ply, hitgroup, dmginfo)
		if ply:GetRole() == ROLES.SERIALKILLER.index then
			dmginfo:ScaleDamage(0.5)
		end

		if ply:IsPlayer() and dmginfo:GetAttacker():IsPlayer() then
			if dmginfo:IsBulletDamage() then
				if dmginfo:GetAttacker():GetRole() == ROLES.SERIALKILLER.index then
			        dmginfo:ScaleDamage(1.25)
			    end
			end
		end
	end)

	hook.Add("TTTPrepareRound", "SerialPreR", function()
	    for _, v in pairs(player.GetAll()) do
	        v:StripWeapon("weapon_sk_knife")
	    end
	end)

    -- following code by Jenssons
	function thatsksmoke()
	   timer.Remove("sksmoke")
	   timer.Create("sksmoke", 0.1, 0, function()   
	      timer.Remove("thatsksmokecheckers")

	      for _, v in pairs(player.GetAll()) do
	         if not IsValid(v) then return end

	         if v:GetRole() == ROLES.SERIALKILLER.index and v:Alive() then
	            v:PrintMessage(HUD_PRINTCENTER, "Your Evil is showing")

	            local HeadIndex = v:LookupBone("ValveBiped.bip01_pelvis")  
	            local HeadPos, HeadAng = v:GetBonePosition(HeadIndex)

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
        if not ROLES.SERIALKILLER then return end
    
		local client = LocalPlayer()

	    if client:GetRole() == ROLES.SERIALKILLER.index then
	        local staff = {}
	        local jesty = {}

	        for _, v in pairs(player.GetAll()) do
	            if v:GetRole() ~= ROLES.SERIALKILLER.index then
                    
                    local b = false
                    
                    -- check whether role exists
                    if ROLES.JESTER then
                        b = v:GetRole() == ROLES.JESTER.index
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
            
            --[[ fix
            timer.Simple(20, function()
               p:Finish()
            end)
            ]]--
		end
	end)
end
