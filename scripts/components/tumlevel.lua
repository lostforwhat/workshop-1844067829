local Tumlevel = Class(function(self, inst) 
    self.inst = inst
    self.level = 0
end)

-------------------------------
function Tumlevel:OnSave()
    return {
        level = self.level,
    }
end

function Tumlevel:OnLoad(data)
	self.level = data.level
end

return Tumlevel