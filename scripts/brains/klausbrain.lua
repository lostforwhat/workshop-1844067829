require "behaviours/chaseandattack"
require "behaviours/wander"

local RESET_COMBAT_DELAY = 10

local KlausBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetHomePos(inst)
    return inst.components.knownlocations:GetLocation("spawnpoint")
end

local function ShouldEnrage(inst)
    return not inst.enraged
        and inst.components.commander:GetNumSoldiers() < 2
end

local function ShouldChomp(inst)
    return inst:IsUnchained()
        and inst.components.combat:HasTarget()
        and not inst.components.timer:TimerExists("chomp_cd")
end

local function shouldchangetarget(inst)
    local target = inst.components.combat.target
    if target == nil then return false end
    local x,y,z = target.Transform:GetWorldPosition()
    if TheWorld.Map:IsOceanTileAtPoint(x, y, z) then
        local lx,ly,lz = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(lx,ly,lz, 25, nil, {"playerghost"}, {"player"})
        for k,v in pairs(ents) do
            if not TheWorld.Map:IsOceanTileAtPoint(v.Transform:GetWorldPosition()) then
                return true
            end
        end
    end
    return false
end

local function changetarget(inst)
    local lx,ly,lz = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(lx,ly,lz, 25, nil, {"playerghost"}, {"player"})
    for k,v in pairs(ents) do
        if not TheWorld.Map:IsOceanTileAtPoint(v.Transform:GetWorldPosition()) then
            inst.components.combat:SetTarget(v)
            return
        end
    end
end

local function cantreachtarget(inst)
    local target = inst.components.combat.target
    if target == nil then return false end
    local x,y,z = target.Transform:GetWorldPosition()
    if TheWorld.Map:IsOceanTileAtPoint(x, y, z) then
        return true
    end
    return false
end


function KlausBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function() return ShouldEnrage(self.inst) end, "Enrage",
            ActionNode(function() self.inst:PushEvent("enrage") end)),
        WhileNode(function() return ShouldChomp(self.inst) end, "Chomp",
            ActionNode(function() self.inst:PushEvent("chomp") end)),

        --WhileNode(function() return shouldchangetarget(self.inst) end, "Changetarget", 
        --    ActionNode(function() changetarget(self.inst) end)),
        WhileNode(function() return cantreachtarget(self.inst) end, "Canttarget", 
            RunAway(self.inst, function() return self.inst.components.combat.target end, 5, 30)),

        ChaseAndAttack(self.inst),
        ParallelNode{
            SequenceNode{
                WaitNode(RESET_COMBAT_DELAY),
                ActionNode(function() self.inst:SetEngaged(false) end),
            },
            Wander(self.inst, GetHomePos, 5),
        },
    }, .5)

    self.bt = BT(self.inst, root)
end

function KlausBrain:OnInitializationComplete()
    local pos = self.inst:GetPosition()
    pos.y = 0
    self.inst.components.knownlocations:RememberLocation("spawnpoint", pos, true)
end

return KlausBrain
