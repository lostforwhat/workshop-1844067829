local Packer =  Class(function(self, inst)
	self.inst = inst
	self.canpackfn = nil
	self.package = nil
end)

function Packer:HasPackage()
	return self.package ~= nil
end

function Packer:SetCanPackFn(fn)
	self.canpackfn = fn
end

function Packer:CanPackTest(target)
	return target
		and target:IsValid()
		and not target:IsInLimbo()
		and not target:HasTag("player")
		--and GetPlayer().components.inventory
end

function Packer:CanPack(target)
	return self.inst:IsValid()
		and (not target.components or not target.components.packer )
		and not self:HasPackage()
		and self:CanPackTest(target)
		and (not self.canpackfn or self.canpackfn(target, self.inst))
end

local function get_name(target,raw_name)
	local name = raw_name or target:GetDisplayName() or (target.components.named and target.components.named.name)

	if not name or name == "MISSING NAME" then
		name = STRINGS.TUM.UNKNOWN_PACKAGE
	end

	local adj = target:GetAdjective()
	if adj then
		name = adj.." "..name
	end
	
	if target.components.stackable then
		local size = target.components.stackable:StackSize()
		if size > 1 then
			name = name.." x"..tostring(size)
		end
	end

	return name
end

function Packer:Pack(target)
	if not self:CanPack(target) then
		--print("cant pack")
		return false
	end
	self.package = {
		prefab = target.prefab,
		name = STRINGS.NAMES.PACKAGED.."["..get_name(target).."]",
	}
	if target.components.teleporter then
		if target.components.teleporter.targetTeleporter then
			target.components.teleporter.targetTeleporter = nil
		end
		local pos = Vector3(target.Transform:GetWorldPosition())
		local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 3000)
		for k,v in pairs(ents) do
			if v and v.components.teleporter and v.components.teleporter.targetTeleporter and v.components.teleporter.targetTeleporter == target then
				v.components.teleporter.targetTeleporter = nil
			end
		end
	end
	pcall(function() 
		self.package.data, self.package.refs = target:GetPersistData()
	end)
	target:Remove()
	self.inst.components.named:SetName(self.package.name)
	return true
end

function Packer:GetName()
	return self.package and self.package.name
end

local function isValidGUID(guid)
	local inst = _G.Ents[guid]
	return inst and inst:IsValid()
end

local function freshen_refs(self)
	if self.package and self.package.refs then
	end
end

function Packer:Unpack(pt)
	if not self.package then return end

	--pos = pos and Game.ToPoint(pos) or self.inst:GetPosition()
	local pos = pt
	freshen_refs(self)

	local target = SpawnPrefab(self.package.prefab)
	--print("unpackage:" .. self.package.prefab)
	if target then
		target.Transform:SetPosition( pos:Get() )
		--print("unpackage postion:"..pos:Get())
		local newents = {}
		if self.package.refs then
			for _, guid in ipairs(self.package.refs) do
				newents[guid] = {entity = _G.Ents[guid]}
			end
		end
	if target.components.teleporter then
		local pos = Vector3(GetPlayer().Transform:GetWorldPosition())
		local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 3000)
		for k,v in pairs(ents) do
			if v and v.components.teleporter then
				v:RemoveTag("teleporter")
				if v.components.teleporter.targetTeleporter == nil and v ~= target then
					v:AddTag("teleporter")
				end
			end
		end
		local teleporter = TheSim:FindFirstEntityWithTag("teleporter")
		if teleporter then
			teleporter.components.teleporter.targetTeleporter = target
			target.components.teleporter.targetTeleporter = teleporter
		end
	end

	if target.components.leader then
		target.components.leader.LoadPostPass= function(newents, savedata)
			if savedata and savedata.followers then
				for k,v in pairs(savedata.followers) do
					local targ = newents[v]
					if targ and targ.entity and targ.entity.components.follower then
						self:AddFollower(targ.entity)
					end
				end
			end
		end
	end
	pcall(function() 
		target:SetPersistData(self.package.data, newents)
		target:LoadPostPass(newents, self.package.data)
	end)
	target.Transform:SetPosition( pos:Get() )
	self.package = nil
	return true
	end
end

function Packer:OnSave()
	if self.package then
		freshen_refs(self)
		return {package = self.package}, self.package.refs
	end
end

function Packer:OnLoad(data)
	if data and data.package then
		self.package = data.package
	end
end

return Packer