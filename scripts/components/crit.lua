local MIN_CHANCE = 0
local MAX_CHANCE = 100
local MAX_HIT = 4

local function IsValidVictim(victim)
    return victim ~= nil
        and not ((victim:HasTag("prey") and not victim:HasTag("hostile")) or
                victim:HasTag("veggie") or
                victim:HasTag("structure") or
                victim:HasTag("wall") or
                victim:HasTag("balloon") or
                victim:HasTag("groundspike") or
                victim:HasTag("smashable") or
                victim:HasTag("companion"))
        and victim.components.health ~= nil
        and victim.components.combat ~= nil
end

local function onchance(self, chance)

end

local Crit = Class(function(self, inst) 
    self.inst = inst
    self.default = 0
    self.chance = 0
    self.force_crit = false
    self.hit = 1
    self.max_hit = MAX_HIT
    self.min_hit = 1
    --self.next_must_crit = false
    self:Init()
end,
nil,
{
	chance = onchance,
})

function Crit:OnSave()
	return {
		chance = self.chance,
		max_hit = self.max_hit
	}
end

function Crit:OnLoad(data)
	if data ~= nil then
		self.chance = data.chance or 0
		self.max_hit = data.max_hit or MAX_HIT
	end
end

function Crit:Init()
	self.inst:ListenForEvent("onhitother", function(inst, data)
		if data.target and 
			not self.criting and
			not inst.components.health:IsDead() and 
			IsValidVictim(data.target) and 
			data.damage>0 then

			local damage = data.damage or 0
            local target = data.target
            local stimuli = data.stimuli
			local max_hit = math.random(self.min_hit, self.max_hit)
            local hit = math.random(self.min_hit, max_hit)

			if self.force_crit or self.next_must_crit then
				self:ApplyCrit(target, damage*hit, hit)
				self.next_must_crit = false
				return
			end
			if self.chance > 0 and math.random(1,100) <= self.chance then	
				self:ApplyCrit(target, damage*hit, hit)
			end
		end
    end)
end

function Crit:ApplyCrit(target, damage, hit)
	self.criting = true
	target.components.combat:GetAttacked(self.inst, damage)
	self.inst:PushEvent("crithit", {target=target,damage=damage,hit=hit})
	self.inst:DoTaskInTime(.2, function() self.criting = false end)
end

return Crit