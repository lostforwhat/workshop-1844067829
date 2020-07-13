return Class(function(self,inst)

self.inst = inst

function self:Init()

	local function GenTumbleweed()
		print("start GenTumbleweed")
		local x, y, z = 0,0,0
		--c_countprefabs("tumbleweedspawner", true)
		for k=0,30 do
			local item = nil
			local ground = TheWorld
		    local centers = {}
		    for i, node in ipairs(ground.topology.nodes) do
		        if ground.Map:IsPassableAtPoint(node.x, 0, node.y) and node.type ~= NODE_TYPE.SeparatedRoom then
		            table.insert(centers, {x = node.x, z = node.y})
		        end
		    end
		    if #centers > 0 then
		        local pos = centers[math.random(#centers)]
		        x = pos.x
		        y = 0
		        z = pos.z
		    else
		        return false
		    end
		    item = SpawnPrefab("tumbleweedspawner")
			item.Transform:SetPosition(x,y,z);
		end
	end

	local cave = self.inst
	if not self.given then
		if cave then
			GenTumbleweed()
		end
	end
	self.given = true
end

function self:OnSave()
	return {given = self.given}
end

function self:OnLoad(data)
	self.given = data and data.given
end
	
end)