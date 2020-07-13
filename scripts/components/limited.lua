
local Limited = Class(function(self, inst) 
    self.inst = inst
    self.lifetime = 120
    
    self:Init(inst)
end)

function Limited:SetColor()
    self.inst.AnimState:OverrideMultColour(0.8, 0.15, 0.15, 1)
end


function Limited:Init(inst)
	if self.lifetime > 0 then
		self:SetColor()
		self.inst:StartUpdatingComponent(self)
	else
		self.inst:StopUpdatingComponent(self)
	end
	self.inst:AddTag("limited")
	if self.inst.components.lootdropper then
        self.inst.components.lootdropper.numrandomloot = 0
        self.inst.components.lootdropper:SetLoot(nil)
    end
    if self.inst.components.named == nil and not self.inst:HasTag("player") then
        self.inst:AddComponent("named")   
    end
    local name = STRINGS.GHOST_A..(self.inst.name or (self.inst.prefab and STRINGS.NAMES[string.upper(self.inst.prefab)])) or nil
    self.inst.components.named:SetName(name)
end

function Limited:OnUpdate(dt)
	self.lifetime = self.lifetime - dt
	if self.lifetime <= 0 then
		if self.inst and self.inst.components.health then
			self.inst.components.health:Kill()
		else
			self.inst:Remove()
		end
	end
	if self.inst.components.leader and self.inst.components.leader.numfollowers>0 then
		local followers = self.inst.components.leader.followers
		for k, v in pairs(followers) do
	        if self.lifetime <= 0 then
	        	if k:IsValid() then k:Remove() end
	        else
	        	if k.components.limited == nil then
	        		k:AddComponent("limited")
	        	end
	        	if not k:HasTag("limited") then
	        		k:AddTag("limited")
	        	end
	        end
	    end
	end
end

return Limited