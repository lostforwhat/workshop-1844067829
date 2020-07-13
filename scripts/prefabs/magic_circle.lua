local assets =
{
	Asset("ANIM", "anim/magic_circle_treat.zip"),
    Asset("ANIM", "anim/magic_circle_kill.zip"),
    Asset("ANIM", "anim/fire_circle.zip"),
    Asset("ANIM", "anim/treat_circle.zip"),
}

local function Isfriend(follower)
    if follower.components.follower then
        local leader = follower.components.follower:GetLeader()
        if leader ~= nil and leader:HasTag("player") then
            return true
        end
    end
    if follower.prefab == "bernie_big" then
        return true
    end
    return false
end

local function treat(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
    local range = 10
    local ents = TheSim:FindEntities(x, y, z, range, nil, nil, { "player", "character", "monster", "animal", "crazy" })
    
    --print("nums:"..#ents)
    if #ents > 0 then
        local timevar = 1 - 1 / (#ents + 1)
        for i, v in pairs(ents) do
            if v:HasTag("player") or Isfriend(v) then
                v:DoTaskInTime(timevar * math.random(), function(v) 
                    if v.components.health and not v.components.health:IsDead() then
                        local maxhealth = v.components.health.maxhealth
                        v.components.health:DoDelta(maxhealth*0.05, nil, "book_treat")
                    end
                end)
            end
        end
    end
end

local function dofrozen(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local range = 10
    local ents = TheSim:FindEntities(x, y, z, range, nil, { "INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost", "player", "wall", "crazy"})

    if #ents > 0 then
        local timevar = 1 - 1 / (#ents + 1)
        for i, v in pairs(ents) do
            if v.components.combat ~= nil then
                v:DoTaskInTime(timevar * math.random(), function(v) 
                    if v.components.freezable then
                        local coldness = 10
                        local freezetime = 5
                        v.components.freezable:AddColdness(coldness, freezetime)
                    end
                end)
            end
        end
    end
end

local function dohit(inst)
    local damage = 5
    local player = inst._master
    local attacker = inst
    if player ~= nil and player.prefab == "wickerbottom" then 
        damage = 30 * player.components.combat.damagemultiplier
        attacker = player
    end
    local x, y, z = inst.Transform:GetWorldPosition()
    local range = 8
    local ents = TheSim:FindEntities(x, y, z, range, nil, { "INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost", "wall", "crazy"})
    
    --print("nums:"..#ents)
    if #ents > 0 then
        local timevar = 1 - 1 / (#ents + 1)
        for i, v in pairs(ents) do
            while true do
                if v == player then break end
                if v.components.combat ~= nil then
                    v:DoTaskInTime(timevar * math.random(), function(v) 
                        if v.components.health and not v.components.health:IsDead() then
                            local attackdamage = math.random(damage, 2*damage)
                            if not TheNet:GetPVPEnabled() and Isfriend(v) then
                                return
                            end
                            if not v:HasTag("player") then
                                v.components.combat:GetAttacked(attacker, attackdamage, nil, "book_kill")
                            end
                            if TheNet:GetPVPEnabled() and v:HasTag("player") and v~=player then
                                attackdamage = attackdamage*0.2
                                v.components.combat:GetAttacked(attacker, attackdamage, nil, "book_kill")
                            end 
                        end
                        if math.random()<=0.2 and v.components.freezable and not v:HasTag("player") then
                            local coldness = 1
                            local freezetime = 1
                            v.components.freezable:AddColdness(coldness, freezetime)
                        end
                    end)
                end
                break
            end
        end
    end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.AnimState:SetBank("magic_circle_treat")
	inst.AnimState:SetBuild("magic_circle_treat")
	inst.AnimState:PlayAnimation("magic_circle_fx",true) 
    --inst.AnimState:PlayAnimation("idle")
	--inst.Transform:SetScale(5, 5, 1)  --这里可以改变预设物大小
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.entity:AddLight()
	inst.Light:SetColour(255,222,0)
    inst.Light:SetFalloff(0.3)
    inst.Light:SetIntensity(0.8)
    inst.Light:SetRadius(6)

    inst.entity:SetPristine()
    inst:AddTag("FX")

    if not TheWorld.ismastersim then
        return inst
    end
    local treattask = inst:DoPeriodicTask(2, function() 
    	treat(inst) 
    end)
	inst:DoTaskInTime(20, function()
		if treattask ~= nil then
			treattask:Cancel()
			treattask = nil
		end
		inst:Remove()
	end) --这里是播放多长时间后，移除它
	return inst
end

local function starthit(inst)
    inst.AnimState:PlayAnimation("magic_circle_fx",true)
    local hittask = inst:DoPeriodicTask(0.5, function() 
        dohit(inst) 
    end)
    inst:DoTaskInTime(30, function()
        if hittask ~= nil then
            hittask:Cancel()
            hittask = nil
        end
        inst:Remove()
    end) --这里是播放多长时间后，移除它
end

local function kill_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("magic_circle_kill")
    inst.AnimState:SetBuild("magic_circle_kill")
    inst.AnimState:PlayAnimation("idle")
    --inst.AnimState:PlayAnimation("magic_circle_fx",true) 
    --inst.Transform:SetScale(5, 5, 1)  --这里可以改变预设物大小
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.entity:AddLight()
    inst.Light:SetColour(255,222,0)
    inst.Light:SetFalloff(0.3)
    inst.Light:SetIntensity(0.8)
    inst.Light:SetRadius(4)

    inst.entity:SetPristine()
    inst:AddTag("FX")

    if not TheWorld.ismastersim then
        return inst
    end
    inst.starthit = starthit
    inst:DoTaskInTime(0.1, dofrozen)
    inst:DoTaskInTime(5, inst.starthit)
    
    return inst
end

local function fire_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("fire_circle")
    inst.AnimState:SetBuild("fire_circle")
    inst.AnimState:PlayAnimation("idle", true)
    --inst.AnimState:PlayAnimation("magic_circle_fx",true) 
    --inst.Transform:SetScale(5, 5, 1)  --这里可以改变预设物大小
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    --inst.Transform:SetFourFaced()
    --inst.Transform:SetScale(2, 2, 2)  --这里可以改变预设物大小

    inst.entity:AddLight()
    inst.Light:SetColour(255,222,0)
    inst.Light:SetFalloff(0.3)
    inst.Light:SetIntensity(0.8)
    inst.Light:SetRadius(3)

    inst.entity:SetPristine()
    inst:AddTag("FX")
    
    return inst
end

local function treat_fx_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("treat_circle")
    inst.AnimState:SetBuild("treat_circle")
    inst.AnimState:PlayAnimation("idle", true)
    inst.Transform:SetScale(2, 2, 2)

    inst.entity:AddLight()
    inst.Light:SetColour(255,222,0)
    inst.Light:SetFalloff(0.8)
    inst.Light:SetIntensity(0.2)
    inst.Light:SetRadius(2)

    inst.entity:SetPristine()
    inst:AddTag("FX")
    inst:DoTaskInTime(1, inst.Remove)
    
    return inst
end

return Prefab("magic_circle_treat", fn, assets),
        Prefab("magic_circle_kill", kill_fn, assets),
        Prefab("fire_circle", fire_fn, assets),
        Prefab("treat_fx", treat_fx_fn, assets)