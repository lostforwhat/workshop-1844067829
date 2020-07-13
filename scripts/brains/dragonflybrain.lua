require "behaviours/chaseandattack"
require "behaviours/leash"
require "behaviours/wander"
require "behaviours/doaction"

local DragonflyBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function HomePoint(inst)
    return inst.components.knownlocations:GetLocation("spawnpoint")
end

local function ShouldResetFight(self)
    if not self.inst.reset then
        local dx, dy, dz = self.inst.Transform:GetWorldPosition()
        local spx, spy, spz = self.inst.components.knownlocations:GetLocation("spawnpoint"):Get()
        if distsq(spx, spz, dx, dz) >= (TUNING.DRAGONFLY_RESET_DIST * TUNING.DRAGONFLY_RESET_DIST) or
                TheWorld.Map:IsSurroundedByWater(dx, dy, dz, 4) then
            self.inst.reset = true
            self.inst:Reset()
        else
            self.resetting = nil
        end
    end
    self.inst.sg.mem.flyover = self.inst.reset
    return self.inst.reset
end

local function ShouldRetryReset(self)
    if self.resetting then
        local action = self.inst:GetBufferedAction()
        return action == nil or action.action ~= ACTIONS.GOHOME
    end
    self.resetting = true
    return false
end

local function GoHome(inst)
    return BufferedAction(inst, nil, ACTIONS.GOHOME)
end

local function ShouldSpawnFn(self)
    if self.inst.components.rampingspawner:GetCurrentWave() <= 0 then
        self._spawnpos = nil
    elseif self._spawnpos == nil then
        local pos = self.inst.components.knownlocations:GetLocation("spawnpoint")
        local lavae_ponds = TheSim:FindEntities(pos.x, pos.y, pos.z, TUNING.DRAGONFLY_RESET_DIST, { "lava" })
        local target = #lavae_ponds > 0 and lavae_ponds[math.random(#lavae_ponds)] or self.inst
        self._spawnpos = target:GetPosition()
    end
    self.inst.sg.mem.flyover = self._spawnpos ~= nil
    return self.inst.sg.mem.flyover
end

local function NearPlayer(inst)
    local target = inst.components.combat.target
    if target == nil then return false end
    if target:HasTag("player") then return false end
    local range = inst.components.combat:GetHitRange()
    local lx,ly,lz = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(lx,ly,lz, range*5,nil, {"playerghost"}, {"player"})
    for k,v in pairs(ents) do
        if v:IsValid() and v ~= target then
            return true
        end
    end
    return false
end

local function changetarget(inst)
    local target = inst.components.combat.target
    local range = inst.components.combat:GetHitRange()
    local lx,ly,lz = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(lx,ly,lz, range*5, nil, {"playerghost"}, {"player"})
    for k,v in pairs(ents) do
        if v:IsValid() and v ~= target then
            inst.components.combat:SetTarget(v)
        end
    end
end

function DragonflyBrain:OnSpawnLavae()
    self._spawnpos = nil
    self.inst.components.rampingspawner:SpawnEntity()
end

function DragonflyBrain:OnStart()
    local root =
        PriorityNode(
        {
            
            WhileNode(function() return ShouldResetFight(self) end, "Reset Fight",
                PriorityNode({
                    WhileNode(function() return ShouldRetryReset(self) end, "Retry Reset", ActionNode(function() end)),
                    DoAction(self.inst, GoHome),
                }, .25)),
            WhileNode(function() return ShouldSpawnFn(self) end, "Spawn Lavae",
                PriorityNode({
                    Leash(self.inst, function() return self._spawnpos end, 5, 5),
                    ActionNode(function() self.inst:PushEvent("spawnlavae") end),
                }, .25)),
            --WhileNode(function() return NearPlayer(self.inst) end, "Changetarget", 
            --    ActionNode(function() changetarget(self.inst) end)),
            ChaseAndAttack(self.inst),
            Leash(self.inst, HomePoint, 20, 10),
            Wander(self.inst, HomePoint, 15)
        }, .25)
    self.bt = BT(self.inst, root)
end

function DragonflyBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("spawnpoint", self.inst:GetPosition())
end

return DragonflyBrain
