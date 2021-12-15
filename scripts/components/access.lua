local function IsThereRecord(self)
    return self.healthcurrent~=nil and self.hungercurrent~=nil and self.sanitycurrent~=nil
end

local Access = Class(function(self, inst) 
    self.inst = inst
    self.recordFn = nil -- 记录时执行
    self.readFn = nil -- 读取时执行
    self.state = false

    self.healthcurrent = nil
    self.hungercurrent = nil
    self.sanitycurrent = nil
end)

function Access:SetRecordFn(fn)
    self.recordFn = fn
end
function Access:SetReadFn(fn)
    self.readFn = fn
end

-- 记录
function Access:Record(inst, prayers)
    if prayers == nil then return end
	if self.recordFn~=nil then
		self.recordFn(self.inst, prayers)
	end
    if prayers.components.health ~= nil then
        self.healthcurrent = prayers.components.health:GetPercent()
    end
    if prayers.components.hunger ~= nil then
        self.hungercurrent = prayers.components.hunger:GetPercent()
    end
    if prayers.components.sanity ~= nil then
        self.sanitycurrent = prayers.components.sanity:GetPercent()
    end
    prayers.components.talker:Say("记录了当前状态")
end
function Access:Read(inst, prayers)
    if prayers == nil then return end
    if not IsThereRecord(self) then self:Record(inst, prayers) return end --没有记录就记录当前的
    if self.readFn~=nil then
        self.readFn(self.inst, prayers)
    end
    if prayers.components.health ~= nil and prayers.components.oldager ~= nil then
        -- prayers.components.oldager:OnTakeDamage((self.healthcurrent-prayers.components.health.currenthealth)/0.4,nil,"statusclock")
        prayers.components.oldager:OnTakeDamage((self.healthcurrent*prayers.components.health.maxhealth-prayers.components.health.currenthealth)/0.4,nil,"statusclock")
    end
    if prayers.components.hunger ~= nil then
        -- prayers.components.hunger:DoDelta(self.hungercurrent-prayers.components.hunger.current)
        prayers.components.hunger:DoDelta(self.hungercurrent*prayers.components.hunger.max-prayers.components.hunger.current)
    end
    if prayers.components.sanity ~= nil then
        -- prayers.components.sanity:DoDelta(self.sanitycurrent-prayers.components.sanity.current)
        prayers.components.sanity:DoDelta(self.sanitycurrent*prayers.components.sanity.max-prayers.components.sanity.current)
    end
    -- 执行一下更新
    prayers.components.talker:Say("回到之前记录状态")
    return true
end
-------------------------------
function Access:OnSave()
    return {
        state = self.state,
        healthcurrent = self.healthcurrent,
        hungercurrent = self.hungercurrent,
        sanitycurrent = self.sanitycurrent,
    }
end

function Access:OnLoad(data)
	self.state = data.state
    self.healthcurrent = data.healthcurrent
    self.hungercurrent = data.hungercurrent
    self.sanitycurrent = data.sanitycurrent
end

return Access