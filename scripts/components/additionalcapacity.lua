--附加能力的容器
--给武器或护甲添加额外能力 抗拒光环

------------------------------------------
-- 祝福
-- 诅咒
-- 套装

------------------------------------------
-- 检测是否形成套装
local function looksuit(inst,data)
	local owner = data.owner
	for k,v in pairs(owner.components.inventory.equipslots) do
		if v.components.additionalcapacity then
			-- 判断套装
		end
	end
end

------------------------------------------
-- 显示
local function information(inst,state)
	if not state then
		return
	end
	if inst and inst.GetShowItemInfo == nil then
		inst.GetShowItemInfo = function(inst)
			return "添加额外显示"
		end
	end
	if inst.components.named ~= nil then
		inst.components.named:SetName(STRINGS.NAMES[string.upper(inst.prefab)].." 强力")
	end	
end

----------------------------------------------
-- 监听器事件
local function onworkfinished(inst,data)
	local ad = inst.components.additionalcapacity
	if ad and ad.appraisal_current then
		ad.appraisal_current = ad.appraisal_current + 1
	end
	
end

----------------------------------------------
-- 数据代理方法
local function onstate(self,state)
	if state then
		information(self.inst,self.state)
	end
end

local function onappraisal_current(self,appraisal_current)
	if appraisal_current ~= nil and appraisal_current >= self.appraisal_level then
		self.state = true
		self.inst:RemoveEventCallback("percentusedchange",onworkfinished)
	end
end
-----------------------------------------------
-- 祝福
local blessing = {
	weapon = {

	},
	armor = {

	},
	currency = {

	}
}
-- 诅咒
local damnation = {
	weapon = {

	},
	armor = {

	},
	currency = {

	}
}

local AdditionalCapacity = Class(function(self, inst) 
    self.inst = inst --武器或护甲
    self.state = false -- 是否鉴定
    self.appraisal_level = 5+1 --监测耐久变化，在加载时会执行一次
    self.appraisal_current = 0 --当前鉴定值
    ------------------------------
    -- 附加
    self.additional = 0 -- 0 普通,1 祝福,2 诅咒
    self.issuit = false -- 是否是套装


    -- 初始化时，要实现的
	--对有耐久的，如果耐久变化，就会监测到
	self.inst:ListenForEvent("percentusedchange",onworkfinished)

	self.inst:DoTaskInTime(0,function(inst)
		if self.inst.components.named ~= nil then
			self.inst.components.named:SetName(STRINGS.NAMES[string.upper(self.inst.prefab)].." 未鉴定")
		end	
	end)
end,
nil,
{
	state = onstate,
	appraisal_current = onappraisal_current,
})

------------------------------------------
--监测
function AdditionalCapacity:xxx()
end
 

---------------保存 与 加载----------------
function AdditionalCapacity:OnSave()
    return {
        state = self.state,
        appraisal_current = self.appraisal_current,
    }
end

function AdditionalCapacity:OnLoad(data)
	self.state = data.state
	self.appraisal_current = data.appraisal_current
end

return AdditionalCapacity