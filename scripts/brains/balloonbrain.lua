local KILL_DIST = 2

local BalloonBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function ShouldKilled(inst)
    local target = GetClosestInstWithTag("monster", inst, KILL_DIST)
    return target ~= nil and not target:HasTag("notarget")
end

local function Killed(inst)
    inst.components.health:Kill()
end

function BalloonBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function() return ShouldKilled(self.inst) end, "Killed",
            ActionNode(function() Killed(self.inst) end)),
    }, .25)

    self.bt = BT(self.inst, root)
end

return BalloonBrain
