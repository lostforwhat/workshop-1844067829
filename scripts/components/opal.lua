local Opal = Class(function(self, inst) 
    self.inst = inst
    self.prayfn = nil
    self.state = false
end)

function Opal:SetPrayFn(fn)
    self.prayfn = fn
end

function Opal:StartPray(inst, prayers)
	if self.prayfn~=nil then
		self.prayfn(self.inst, prayers)
	end
end

-------------------------------
function Opal:OnSave()
    return {
        state = self.state,
    }
end

function Opal:OnLoad(data)
	self.state = data.state
end

return Opal