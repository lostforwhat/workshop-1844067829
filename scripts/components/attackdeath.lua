local MIN_CHANCE = 0
local MAX_CHANCE = 100
local DEFAULT_CHANCE = 1

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

local function Onhitother(inst, data)
    inst.components.attackdeath:Onhitother(inst, data)
end

local function onchance(self, chance)

end

local AttackDeath = Class(function(self, inst) 
    self.inst = inst
    self.default = 0
    self.chance = DEFAULT_CHANCE
    self.extra_chance = 0
    self.force_death = false
    --self.next_force_death = false
    self:Init()
end,
nil,
{
    chance = onchance,
})

function AttackDeath:Onhitother(inst, data)
    if data.target and 
        not self.attacking and
        not inst.components.health:IsDead() and 
        IsValidVictim(data.target) and 
        data.damage>0 then

        local damage = data.damage or 0
        local target = data.target
        local stimuli = data.stimuli
        if stimuli ~= nil then return end
        
        local hp = target.components.health.currenthealth
        local maxhp = target.components.health.maxhealth

        --根据hp调整触发概率基数,小于5000时获得100%基准
        if self.force_death or self.next_force_death or
         (math.random(1,100) <= (self.chance + self.extra_chance) and math.random() < (TUNING.LEIF_HEALTH/maxhp)) then
            self.attacking = true
            target.components.combat:GetAttacked(inst, 99999)
            self.next_force_death = false
            self.inst:PushEvent("attackdeath", {target=target})
            self.inst:DoTaskInTime(.2, function() self.attacking = false end)
        end
    end
end

function AttackDeath:Init()
    self.inst:ListenForEvent("onhitother", Onhitother)
end

function AttackDeath:OnRemoveFromEntity()
    self.inst:RemoveEventCallback("onhitother", Onhitother)
end

function AttackDeath:OnSave()
    return {
        chance = self.chance
    }
end

function AttackDeath:OnLoad(data)
    if data ~= nil then
        self.chance = data.chance or DEFAULT_CHANCE
    end
end


return AttackDeath