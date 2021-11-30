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

local function Onhitother(inst, data)
	inst.components.crit:Onhitother(inst, data)
end

local function onchance(self, chance)

end

local Crit = Class(function(self, inst) 
    self.inst = inst
    self.default = 0
    self.chance = 0
    self.extra_chance = 0
    self.force_crit = false
    self.hit = 1
    self.max_hit = MAX_HIT
    self.min_hit = 1
    self.next_must_crit = false
    self.extra_source_map = nil
    self.luck_crit = false
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

function Crit:SetChance(val)
	if val > MAX_CHANCE then
		self.chance = MAX_CHANCE
		return
	end
	if val < MIN_CHANCE then
		self.chance = MIN_CHANCE
		return
	end
	self.chance = val
end

function Crit:AddExtraChance(source, val)
	if self.extra_source_map == nil then
		self.extra_source_map = {}
	end
	self.extra_source_map[source] = val
	self.extra_chance = 0
	for k, v in pairs(self.extra_source_map) do
		if k and v then
			self.extra_chance = self.extra_chance + v
		end
	end
end

function Crit:RemoveExtraChance(source)
	if self.extra_source_map ~= nil and self.extra_source_map[source] then
		self.extra_source_map[source] = nil
		self.extra_chance = 0
		for k, v in pairs(self.extra_source_map) do
			if k and v then
				self.extra_chance = self.extra_chance + v
			end
		end
	end
end

function Crit:Onhitother(inst, data)
	--print("调用过一次幸运暴击")
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
        --print("伤害",damage)
		if self.force_crit or self.next_must_crit then
			--print("force_crit:",force_crit)
			--print("next_must_crit:",next_must_crit)
			self:ApplyCrit(target, damage*hit, hit)
			self.next_must_crit = false
			return
		end
		if self.luck_crit and inst.components.luck and inst.components.luck:GetLuck() > title_data["title10"]["luck"] then
			--print("幸运暴击")
			if hit < 2 then hit = 2 end
			self:ApplyCrit(target, damage*hit, hit)
			inst.components.luck:DoDelta(-hit)
			return
		end
		if self.chance > 0 and math.random(1,100) <= self.chance*(1+self.extra_chance) then	
			self:ApplyCrit(target, damage*hit, hit)
		end
	end
end

function Crit:Init()
	--print("注册监听幸运暴击")
	self.inst:ListenForEvent("onhitother", Onhitother)
end

function Crit:ApplyCrit(target, damage, hit)  --暴击
	self.criting = true
	target.components.combat:GetAttacked(self.inst, damage)
	local snap = SpawnPrefab("impact")
    snap.Transform:SetScale(3, 3, 3)
    snap.Transform:SetPosition(target.Transform:GetWorldPosition())
    if target.SoundEmitter ~= nil then
        target.SoundEmitter:PlaySound("dontstarve/common/whip_large", nil, 0.3)
    end
	self.inst:PushEvent("crithit", {target=target,damage=damage,hit=hit})
	self.inst:DoTaskInTime(.2, function() self.criting = false end)
end

function Crit:OnRemoveFromEntity()
    self.inst:RemoveEventCallback("onhitother", Onhitother)
end

return Crit