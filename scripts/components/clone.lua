local function defaultclonefn(cloner)
	local x, y, z = cloner.Transform:GetWorldPosition()
	local cloned = SpawnPrefab(cloner.prefab)
	cloned.Transform:SetPosition(x, y, z)
end

local function GetAbigailNum(player)
	if player == nil then return 0 end
	local followers = player.components.leader.followers
	local num = 0
    for k,v in pairs(followers) do
        if k.prefab == "abigail_clone" then
            num = num + 1
        end
    end
    return num
end


local Clone = Class(function(self, inst) 
    self.inst = inst
    self.maxclone = 4
    self.clonefn = defaultclonefn
    self:Init(inst)
end)

function Clone:SetCloneFn(fn)
    self.clonefn = fn
end

function Clone:abigailclonefn(inst)
	inst:ListenForEvent("attacked", function(inst, data)
        if math.random() < 0.1 then
        	local x, y, z = inst.Transform:GetWorldPosition()
			local player = inst._playerlink
			if player.abigail_clone == nil or GetAbigailNum(player) < self.maxclone then
				local cloned = SpawnPrefab("abigail_clone")

				cloned.Transform:SetPosition(x, y, z)
				cloned:LinkToPlayer(player)
				cloned:BecomeAggressive()
				cloned.components.combat:SuggestTarget(data.attacker or nil)
				cloned:DoTaskInTime(120, function(cloned) 
					if cloned:IsValid() then cloned:Remove() end
				end)
			end
        end
    end)
end

function Clone:WebberCloneFn(inst)
	inst:ListenForEvent("onhitother", function(inst, data)
		if math.random() < 0.05 then
        	local x, y, z = inst.Transform:GetWorldPosition()
			local player = inst
			local target = data.target
			if player.components.leader and player.components.leader.numfollowers < 8 then
				local followers = {"spider","spider_warrior"}
				local cloned = SpawnPrefab(followers[math.random(#followers)])

				cloned.Transform:SetPosition(x, y, z)
				player.components.leader:AddFollower(cloned)
				cloned.components.combat:SuggestTarget(target)
				cloned.components.follower:AddLoyaltyTime(120)
				cloned:AddTag("spider_cloned")
				cloned:AddTag("cloned")
				cloned.components.lootdropper.numrandomloot = 0
				cloned:DoTaskInTime(120, function(cloned)
					if cloned:IsValid() then cloned:Remove() end
				end)
			end
        end
    end)
end

function Clone:WurtCloneFn(inst)
	inst:ListenForEvent("onhitother", function(inst, data)
		if math.random() < 0.04 then
        	local x, y, z = inst.Transform:GetWorldPosition()
			local player = inst
			local target = data.target
			if player.components.leader and player.components.leader.numfollowers < 6 then
				local followers = {"merm"}
				local cloned = SpawnPrefab(followers[math.random(#followers)])

				cloned.Transform:SetPosition(x, y, z)
				player.components.leader:AddFollower(cloned)
				cloned.components.combat:SuggestTarget(target)
				cloned.components.follower:AddLoyaltyTime(120)
				cloned:AddTag("merm_cloned")
				cloned:AddTag("cloned")
				cloned.components.lootdropper.numrandomloot = 0
				cloned:DoTaskInTime(120, function(cloned)
					if cloned:IsValid() then cloned:Remove() end
				end)
			end
        end
    end)
end


--clonefn
function Clone:StartClone(inst)
	self.clonefn(inst)
end

function Clone:Init(inst)
	if inst.prefab == "abigail" then
		self:abigailclonefn(inst)
	elseif inst.prefab == "webber" then
		self:WebberCloneFn(inst)
	elseif inst.prefab == "wurt" then
		self:WurtCloneFn(inst)
	else
		self:StartClone(inst)
	end
end

return Clone