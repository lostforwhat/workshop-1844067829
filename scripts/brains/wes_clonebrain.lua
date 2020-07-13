require "behaviours/chaseandattack"
require "behaviours/follow"
local MIN_DIST = 1
local TARGET_DIST = 6
local MAX_DIST = 8

local WesCloneBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function WatchingMinigame(inst)
    return (inst.components.follower.leader ~= nil and inst.components.follower.leader.components.minigame_participator ~= nil) and inst.components.follower.leader.components.minigame_participator:GetMinigame() or nil
end

local function CanFight(inst)
    if inst.components.combat.target then return true end
    local player = inst.components.follower.leader
    if player ~= nil then
        local target = player.components.combat.target
        if target ~= nil then
            inst.components.combat:SetTarget(target)
            return true
        end
    end
    return false
end

local function ShouldGo(inst)
    return inst.components.follower.leader == nil or not inst.components.follower.leader:IsValid()
end

function WesCloneBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function() return CanFight(self.inst) end, "CanFight",
                ChaseAndAttack(self.inst)),
        Follow(self.inst, GetLeader, MIN_DIST, TARGET_DIST, MAX_DIST),
        FaceEntity(self.inst, WatchingMinigame, WatchingMinigame),
        WhileNode(function() return ShouldGo(self.inst) end, "ShouldGo", ActionNode(function() self.inst:Remove() end))
    }, .25)

    self.bt = BT(self.inst, root)
end

return WesCloneBrain
