AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/weapons/w_bugbait.mdl")
	self:PrecacheGibs()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local Phys = self:GetPhysicsObject()

	if Phys:IsValid() then
		Phys:Wake()
	end
end

function ENT:PhysicsCollide(Data, PhysObj)
	if Data.HitEntity:IsPlayer() then
		Data.HitEntity:TakeDamage(50)
		local ent = ents.Create("ttt_crowbar")

		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:Spawn()
		ent:SetModel("models/weapons/w_crowbar.mdl")

		self:Remove()
	else
		local ent = ents.Create("ttt_crowbar")

		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:Spawn()
		ent:SetModel("models/weapons/w_crowbar.mdl")

		self:Remove()
	end
end

function ENT:OnRemove()

end

function ENT:OnTakeDamage(DmgInfo)

end

function ENT:Think()

end

function ENT:Break()

end
