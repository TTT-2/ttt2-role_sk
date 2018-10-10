AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

-- Initialize
function ENT:Initialize()
	util.PrecacheSound("weapons/ar2/npc_ar2_altfire.wav")
	util.PrecacheSound("weapons/ar2/ar2_altfire.wav")
	util.PrecacheSound("weapons/grenade/tick1.wav")

	self:SetModel("models/weapons/w_eq_flashbang_thrown.mdl")
	self:SetMaterial("smokenade/smokenade")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()

		-- This is how we make the smoke explosion
		local Smoke = function()

			-- Safeguards
			if not self or not IsValid(self) then return end

			if SERVER then
				self:EmitSound("weapons/ar2/npc_ar2_altfire.wav", 62, 95)
				self:EmitSound("weapons/ar2/ar2_altfire.wav", 62, 95)

				local shake = ents.Create("env_physexplosion")
				shake:SetKeyValue("radius", 512)
				shake:SetKeyValue("magnitude", 48)
				shake:SetKeyValue("spawnflags", "3")
				shake:SetOwner(self.Owner)
				shake:SetPos(self:GetPos())
				shake:Fire("Explode", "", 0)
				shake:Fire("kill", "", 2)

				local fear = ents.Create("ai_sound")
				fear:SetKeyValue("soundtype", 8)
				fear:SetKeyValue("volume", 256)
				fear:SetKeyValue("duration", 5)
				fear:SetOwner(self.Owner)
				fear:SetPos(self:GetPos())
				fear:Fire("EmitAISound", "", 0.82)
				fear:Fire("kill", "", 6)

				local sfx = EffectData()
				sfx:SetOrigin(self:GetPos())

				util.Effect("effect_smokenade_smoke_small", sfx)
				util.ScreenShake(self:GetPos(), 32, 210, 1, 1024)

				self:Remove()
			end
		end

		-- This is the little tick before the explosion
		local Sfx = function()
			if SERVER and IsValid(self) then
				self:EmitSound("weapons/grenade/tick1.wav", 62, 100)
			end
		end


		-- Tick
		timer.Simple(0.62, Sfx)

		-- Summon smoke
		timer.Simple(0.82, Smoke)
	end
end

-- Play physics sound on impact
function ENT:PhysicsCollide(data, physobj)

	-- If hit something too hard
	if data.Speed > 132 and data.DeltaTime > 0.21 then

		-- Hey, slow down there, partner
		local NewVelocity = physobj:GetVelocity():GetNormal()
		local LastSpeed = math.max(NewVelocity:Length(), math.max(data.OurOldVelocity:Length(), data.Speed))

		physobj:SetVelocity(NewVelocity * LastSpeed * 0.62)

		-- Make collision sound
		self:EmitSound("physics/metal/weapon_impact_soft" .. (math.random(1, 2)) .. ".wav", 52, 100)
	end
end
