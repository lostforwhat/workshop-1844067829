local MAX_PERCENT = 100

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

local function onpercent(self, percent)

end

local LifeSteal = Class(function(self, inst) 
    self.inst = inst
    self.default = 0
    self.percent = 0
    self.max_percent = MAX_PERCENT
    self.extra_percent = 0
    self:Init()
end,
nil,
{
	percent = onpercent
})

function LifeSteal:OnSave()
	return {
		percent = self.percent
	}
end

function LifeSteal:Init()
	self.inst:ListenForEvent("onhitother", function(inst, data)
		if data.target and
			not inst.components.health:IsDead() and 
			IsValidVictim(data.target) and 
			data.damage>0 then

			local damage = data.damage or 0
            local target = data.target
            local stimuli = data.stimuli
			
			if self.percent > 0 then
				local absorb = target.components.health and target.components.health.absorb or 0
				damage = damage * (1- math.clamp(absorb, 0, 1))
				local lifestealnum = self.percent * 0.01 * damage * (1 + self.extra_percent)
				inst.components.health:DoDelta(lifestealnum, false, "lifesteal")
			end
		end
    end)
end

return LifeSteal