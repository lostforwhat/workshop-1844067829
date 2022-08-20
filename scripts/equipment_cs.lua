AddPrefabPostInitAny(function(inst) 
	if (inst.components.weapon ~= nil and inst.components.stackable == nil and inst.components.finiteuses ~= nil) or inst.components.armor then
		if inst.components.additionalcapacity == nil then
			--inst:AddComponent("additionalcapacity")
		end
		if inst.components.named == nil then
			inst:AddComponent("named")
		end
	end
end)


------------------------------------------------------------------------
--修改物品描述颜色
--[[
require 'util'
local colour_tb = {
    '#76EEC6',
    '#B4EEB4',
    '#4EEE94',
    '#7FFF00',
    '#BBFFFF',
    '#8DEEEE',
    '#98F5FF',
    '#00FFFF',
    '#00BFFF',
    '#4169E1',
    '#0000FF',
    '#6A5ACD',
    '#FFC0CB',
    '#FF69B4',
    '#FF69B4',
    '#FF1493',
    '#FF00FF',
    '#FF0000',
    '#FFA500',
    '#FF7F00',
}
AddClassPostConstruct("widgets/hoverer",function(self)
    local OldSetString = self.text.SetString
    self.text.SetString = function(text, str)
        local target = _G.TheInput:GetHUDEntityUnderMouse()
        if target ~= nil then
            target = target.widget ~= nil and target.widget.parent ~= nil and target.widget.parent.item
        else
            target = _G.TheInput:GetWorldEntityUnderMouse()
        end
        if target ~= nil and target.prefab ~= nil then
            --to do
            -- local name = _G.STRINGS.NAMES[string.upper(target.prefab)]
            if target:HasTag("weapon") or target:HasTag("armor")  then
                -- local st, ed, level = string.find(str, ""..name.."%s*+(%d+)")
                local level = math.random(1,10) 
                if level <= 20 then
                    local r,g,b = _G.HexToPercentColor(colour_tb[level or 1])
                    self.text:SetColour({r,g,b,1})
                else
                    local r,g,b = _G.HexToPercentColor('#FFFF00')
                    self.text:SetColour({r,g,b,1})
                end
            end
        end

        return OldSetString(text, str)
    end
end)
]]