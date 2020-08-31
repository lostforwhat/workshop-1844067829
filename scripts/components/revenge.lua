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
    inst.components.revenge:Onhitother(inst, data)
end

local function Onattcked(inst, data)
    inst.components.revenge:Onattcked(inst, data)
end

local Revenge = Class(function(self, inst) 
    self.inst = inst
    self.damge_percent = 0.05
    self.revenge_data = {}
    self:Init()
end,
nil,
{
    
})

function Revenge:Onhitother(inst, data)
    if data.target and 
        not self.attacking and
        not inst.components.health:IsDead() and 
        IsValidVictim(data.target) and 
        data.damage>0 then

        local damage = data.damage or 0
        local target = data.target
        local stimuli = data.stimuli
        if stimuli ~= nil then return end
        
        if self.revenge_data[target] and self.revenge_data[target] > 0 then
            self.attacking = true
            local revenge_damage = damage*self.revenge_data[target]*self.damge_percent
            if revenge_damage > damage * 2 then
                revenge_damage = damage * 2
            end
            target.components.combat:GetAttacked(inst, revenge_damage, nil, "revenge")
            self.inst:DoTaskInTime(.2, function() self.attacking = false end)
        end
        
    end
end

function Revenge:Onattcked(inst, data)
    local damage = data.damage
    local attacker = data.attacker 
    if damage > 0 and attacker ~= nil then
        if self.revenge_data[attacker] == nil then
            self.revenge_data[attacker] = 1
        else
            self.revenge_data[attacker] = self.revenge_data[attacker] + 1
        end
    end
end

function Revenge:Init()
    self.inst:ListenForEvent("onhitother", Onhitother)
    self.inst:ListenForEvent("attacked", Onattcked)
end

function Revenge:OnRemoveFromEntity()
    self.inst:RemoveEventCallback("onhitother", Onhitother)
    self.inst:RemoveEventCallback("attacked", Onattcked)
end

function Revenge:OnSave()
    return {
        
    }
end

function Revenge:OnLoad(data)
    if data ~= nil then
        
    end
end


return Revenge