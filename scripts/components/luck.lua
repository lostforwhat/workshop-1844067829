local MAX_LUCK = 100
local MIN_LUCK = 0

local function onluck(self, luck)
	self.inst.currentluck:set(luck)
end

local function onstate(self, state)

end

local Luck = Class(function(self, inst) 
    self.inst = inst
    self.defaultluck = 0
    self.luck = 0
    self.state = ""
    self:Init()
end,
nil,
{
	luck = onluck,
	state = onstate,
})

function Luck:GetLuck()
	return self.luck or 0
end

function Luck:SetLuck(val)
	local oldluck = self.luck
	self.luck = val
	self.inst:PushEvent("luckchange", {oldluck=oldluck,luck=self.luck})
end

function Luck:Init()
	if self.defaultluck == 0 then
		self.defaultluck = math.random(MIN_LUCK+1, MAX_LUCK*0.2)
		self.luck = self.defaultluck
		self.inst:PushEvent("luckchange", {oldluck=0,luck=self.luck})
	end
end

function Luck:DoDelta(val)
	local oldluck = self.luck
	if self.luck ~= nil and val ~= nil and val ~= 0 then
		self.luck = self.luck + val
		if self.luck < MIN_LUCK then
			self.luck = MIN_LUCK
		end
		if self.luck > MAX_LUCK then
			self.luck = MAX_LUCK
		end
		self.inst:PushEvent("luckchange", {oldluck=oldluck,luck=self.luck})
	end
end

function Luck:Random()
	local oldluck = self.luck
	local maxluck = math.random(MAX_LUCK*0.2, MAX_LUCK)
	self.luck = math.random(MIN_LUCK, maxluck)
	self.inst:PushEvent("luckchange", {oldluck=oldluck,luck=self.luck})
end

function Luck:OnSave()
	return {
		defaultluck = self.defaultluck,
		luck = self.luck,
		state = self.state,
	}
end

function Luck:OnLoad(data)
	if data ~= nil then
		self.defaultluck = data.defaultluck
	    self.luck = data.luck
	    self.state = data.state
	end
end

return Luck