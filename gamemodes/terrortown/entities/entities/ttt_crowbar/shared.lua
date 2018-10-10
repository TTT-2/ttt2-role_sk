AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ttt_basegrenade_proj"

function ENT:Initialize()
	self:SetModel("models/weapons/w_crowbar.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local Phys = self:GetPhysicsObject()
	if Phys:IsValid() then
		Phys:Wake()
	end
end

function ENT:OnRemove()

end

function ENT:OnTakeDamage(DmgInfo)

end

function ENT:Think()

end

function ENT:Use(activator, caller)
	activator:Give("weapon_sk_crowbar")
	self:Remove()
end

function ENT:Break()

end
