local Luckylevel = Class(function(self, inst) 
    self.inst = inst
    self.defaultlevel = 0
    self.lucky_level = nil
    self:Init(inst)
end)

function Luckylevel:Init(inst)
	if self.lucky_level == nil then
		self:ChangeLevel(inst)
	else
		self:SetLevel(inst, self.lucky_level)
	end
end

function Luckylevel:ChangeLevel(inst)
	if inst._fireflylight ~= nil then 
		inst._fireflylight:Remove()
		inst._fireflylight = nil
	end
	local lucky = math.random(1,1000)
	--print("lucky is "..lucky)
	if lucky > 990 then
		--inst.AnimState:OverrideMultColour(1, 1, 0, 1)
		inst.components.colourtweener:StartTween({1,1,0,1}, 0)
		self.lucky_level = 2
	elseif lucky <20 then
		--inst.AnimState:OverrideMultColour(0, 0, 1, 0.95)
		inst.components.colourtweener:StartTween({0,0,1,1}, 0)
		self.lucky_level = -2
	elseif lucky > 950 then
		--inst.AnimState:OverrideMultColour(1, 0.1, 0.6, 0.95)
		inst.components.colourtweener:StartTween({1,0.1,0.6,1}, 0)
		self.lucky_level = 1
	elseif lucky <100 then
		--inst.AnimState:OverrideMultColour(0.2, 0.8, 0.2, 0.95)
		inst.components.colourtweener:StartTween({0.2,0.8,0.2,1}, 0)
		self.lucky_level = -1
	else
		--inst.AnimState:OverrideMultColour()
		inst.components.colourtweener:StartTween({1,1,1,1}, 0)
		self.lucky_level = 0
	end
	

	if lucky >= 999 then
		--inst.AnimState:OverrideMultColour(1, 1, 0.8, 0.9)
		inst.components.colourtweener:StartTween({1,1,0.5,1}, 0)
		inst._fireflylight = SpawnPrefab("minerhatlight")
        inst._fireflylight.Light:SetRadius(5)
        inst._fireflylight.Light:SetFalloff(.3)
        inst._fireflylight.Light:SetIntensity(.8)
        inst._fireflylight.Light:SetColour(255/255,255/255,128/255)
        inst._fireflylight.entity:SetParent(inst.entity)
	    self.lucky_level = 3
	end
end

function Luckylevel:SetLevel(inst, level)
	if inst._fireflylight ~= nil then 
		inst._fireflylight:Remove()
		inst._fireflylight = nil
	end
	if level == 2 then
		inst.components.colourtweener:StartTween({1,1,0,1}, 0)
	elseif level == -2 then
		inst.components.colourtweener:StartTween({0,0,1,1}, 0)
	elseif level == 1 then
		inst.components.colourtweener:StartTween({1,0.1,0.6,1}, 0)
	elseif level == -1 then
		inst.components.colourtweener:StartTween({0.2,0.8,0.2,1}, 0)
	else
		inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	end

	if level == 3 then
		inst.components.colourtweener:StartTween({1,1,0.5,1}, 0)
		inst._fireflylight = SpawnPrefab("minerhatlight")
	    inst._fireflylight.Light:SetRadius(5)
	    inst._fireflylight.Light:SetFalloff(.3)
	    inst._fireflylight.Light:SetIntensity(.8)
	    inst._fireflylight.Light:SetColour(255/255,255/255,128/255)
	    inst._fireflylight.entity:SetParent(inst.entity)
	end
end

function Luckylevel:OnSave()
	return {
		lucky_level= self.lucky_level
	}
end

function Luckylevel:OnLoad(data)
	if data and data.lucky_level then
		self.lucky_level = data.lucky_level
	end
end

return Luckylevel