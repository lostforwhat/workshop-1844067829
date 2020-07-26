local MIN_CHANCE = 0
local MAX_CHANCE = 100
local DEFAULT_CHANCE = 20

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
        and victim.components.freezable ~= nil
end

local function Onhitother(inst, data)
    inst.components.attackfrozen:Onhitother(inst, data)
end

local function onchance(self, chance)

end

local AttackFrozen = Class(function(self, inst) 
    self.inst = inst
    self.default = 0
    self.chance = DEFAULT_CHANCE
    self.coldness = 1
    self.freezetime = 2
    self.extra_chance = 0
    self.force_frozen = false
    --self.next_force_frozen = false
    self:Init()
end,
nil,
{
    chance = onchance,
})

function AttackFrozen:Onhitother(inst, data)
    if data.target and 
        not inst.components.health:IsDead() and 
        IsValidVictim(data.target) and 
        data.damage>0 then

        local damage = data.damage or 0
        local target = data.target
        local stimuli = data.stimuli
        if stimuli ~= nil then return end
        
        if self.force_frozen or self.next_force_frozen or
            math.random(1,100) <= self.chance then
            target.components.freezable:AddColdness(self.coldness, self.freezetime)
        end

    end
end

function AttackFrozen:Init()
    self.inst:ListenForEvent("onhitother", Onhitother)
end

function AttackFrozen:OnRemoveFromEntity()
    self.inst:RemoveEventCallback("onhitother", Onhitother)
end

function AttackFrozen:OnSave()
    return {
        chance = self.chance,
        coldness = self.coldness,
        freezetime = self.freezetime,
    }
end

function AttackFrozen:OnLoad(data)
    if data ~= nil then
        self.chance = data.chance or DEFAULT_CHANCE
        self.coldness = data.coldness or 1
        self.freezetime = data.freezetime or 2
    end
end


return AttackFrozen