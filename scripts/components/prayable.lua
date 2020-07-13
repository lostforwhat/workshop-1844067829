local Prayable = Class(function(self, inst) 
    self.inst = inst
    self.prayfn = nil
end)

function Prayable:SetPrayFn(fn)
    self.prayfn = fn
end

function Prayable:StartPray(inst, prayers)
	if self.prayfn~=nil then
		self.prayfn(self.inst, prayers)
	end
	if inst.components.stackable ~= nil then
		inst.components.stackable:Get():Remove()
	else
		inst:Remove()
	end
end

return Prayable