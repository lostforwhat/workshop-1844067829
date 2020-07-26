local MIN_CHANCE = 0
local MAX_CHANCE = 100
local DEFAULT_CHANCE = 5

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
    inst.components.attackbroken:Onhitother(inst, data)
end

local function onchance(self, chance)

end

local AttackBroken = Class(function(self, inst) 
    self.inst = inst
    self.default = 0
    self.chance = DEFAULT_CHANCE
    self.extra_chance = 0
    self.force_broken = false
    --self.next_force_broken = false
    self.broken_percent = 10
    self:Init()
end,
nil,
{
    chance = onchance,
})

function AttackBroken:Onhitother(inst, data)
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

        if self.force_broken or self.next_force_broken or
         (math.random(1,100) <= (self.chance + self.extra_chance)) then
            self.attacking = true
            target.components.combat:GetAttacked(inst, hp*self.broken_percent*0.01)
            self.next_force_death = false
            self.inst:PushEvent("attackdeath", {target=target})
            self.inst:DoTaskInTime(.2, function() self.attacking = false end)
        end
    end
end

function AttackBroken:Init()
    self.inst:ListenForEvent("onhitother", Onhitother)
end

function AttackBroken:OnRemoveFromEntity()
    self.inst:RemoveEventCallback("onhitother", Onhitother)
end

function AttackBroken:OnSave()
    return {
        chance = self.chance
    }
end

function AttackBroken:OnLoad(data)
    if data ~= nil then
        self.chance = data.chance or DEFAULT_CHANCE
    end
end


return AttackBroken