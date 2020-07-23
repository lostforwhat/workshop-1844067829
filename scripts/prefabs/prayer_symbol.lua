local assets =
{
    Asset("ANIM", "anim/pray_symbol.zip"),
    Asset("ATLAS", "images/pray_symbol.xml"),
}

local function spawnAtGround(name, x,y,z)
    if TheWorld.Map:IsPassableAtPoint(x, y, z) then
        local item = SpawnPrefab(name)
        if item then
            item.Transform:SetPosition(x, y, z)
            return item
        end
    end
end

local function spawnPackageAtGround(name, x,y,z)
    if TheWorld.Map:IsPassableAtPoint(x, y, z) then
        local package_ball =SpawnPrefab("package_ball")
        local item = SpawnPrefab(name)
        package_ball.components.packer:Pack(item)
        if package_ball and package_ball:IsValid() then
            package_ball.Transform:SetPosition(x, y, z)
            return package_ball
        end
    end
end

local function DoPlant(prayers, inst)
    --添加多世界宣告支持
    local picker_name = prayers and prayers:GetDisplayName() or "???"
    local function resetNotice(...)
        local worldShardId = TheShard:GetShardId()
        local serverName = ""
        if worldShardId ~= nil and worldShardId ~= "0" then
            serverName = "[" .. STRINGS.TUM.WORLD .. worldShardId .. "] "
        end
        local msg = picker_name .. STRINGS.TUM.PRAYED
        for k ,v in pairs({...}) do
            msg = msg .. " " .. v
        end
        TheNet:Announce(serverName .. msg)
    end
    local px,py,pz= prayers.Transform:GetWorldPosition()
    local names = {
        "flower",
        "carrot_planted",
        "cave_fern",
        "red_mushroom",
        "green_mushroom",
        "blue_mushroom",
        "reeds",
        "cactus",
        "lichen",
        "cave_banana_tree",
        "flower_cave_triple",
        "flower_cave_double",
        "flower_cave",
        "wormlight_plant",
        "moon_tree_blossom_worldgen"
    }
    if c_countprefabs("tallbirdnest", true) < 20 then
        table.insert(names, "tallbirdnest")
    end
    if math.random() < 0.05 then
        table.insert(names, "little_walrus")
    end
    local num_prefabs=math.random(8,16)
    local prefab_name = names[math.random(#names)]
    local true_luck = inst.is_rare
    --生成作物
    local item = nil
    for k=1,num_prefabs do
        local angle = k * 2 * PI / num_prefabs
        if true_luck then
            local item2 = spawnPackageAtGround(prefab_name, 4*math.cos(angle)+px, py, 4*math.sin(angle)+pz)
            if item2 ~= nil then item = item2 end
        else
            local item2 = spawnAtGround(prefab_name, 4*math.cos(angle)+px, py, 4*math.sin(angle)+pz)
            if item2 ~= nil then item = item2 end
        end
    end
    prayers:PushEvent("prayed", {item=item,num=num_prefabs})
    if item ~= nil then
        resetNotice(item:GetDisplayName())
    end
    return item ~= nil
end

--使用祈祷函数
local function OnPray(inst, prayers)
	if prayers:HasTag("player") then
		if DoPlant(prayers, inst) then
    		prayers.components.sanity:DoDelta(-20)
        end
	end
end

local function prayburnt(inst, doer)
    local x, y, z = inst.Transform:GetWorldPosition()
    if doer ~= nil then
        x, y, z = doer.Transform:GetWorldPosition()
    end
    local range = 10
    local ents = TheSim:FindEntities(x, y, z, range, nil, nil, {"player", "playerghost"})
    if #ents > 0 then
        local timevar = 1 - 1 / (#ents + 1)
        for i, v in pairs(ents) do
            if v.components.luck ~= nil then
                if doer == nil then
                    doer = v
                end
                v:DoTaskInTime(timevar * math.random(), function(v) 
                    v.components.luck:Random()
                end)
            end
        end
    end

    if doer == nil then return end
    doer:StartThread(function()
        for k = 0, 6 do
            local rad = math.random(3, 10)
            local angle = k * 2 * PI / 7
            local pos = Vector3(rad * math.cos(angle)+x, y, rad * math.sin(angle)+z)
            if not TheWorld:HasTag("cave") then 
                TheWorld:PushEvent("ms_sendlightningstrike", pos)
            else
                TheWorld:PushEvent("ms_miniquake", { rad = 3, num = 5, duration = 0.5, target = doer })
            end
            Sleep(.3 + math.random())
        end
    end)
end

local function onburnt(inst)
    inst:AddTag("burnt")
    prayburnt(inst, nil)
    inst:Remove()
end

local function OnSave(inst, data)
    data.burnt = inst.components.burnable ~= nil and inst.components.burnable:IsBurning() or inst:HasTag("burnt") or nil
    data.is_rare = inst.is_rare
end

local function OnLoad(inst, data)
    if data ~= nil and data.burnt then
        onburnt(inst)
    end
    if data ~= nil and data.is_rare then
        inst.is_rare = data.is_rare
        if inst.components.colourtweener == nil then
            inst:AddComponent("colourtweener")
        end
        inst.components.colourtweener:StartTween({0.7,0,0.5}, 0)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("pray_symbol")
    inst.AnimState:SetBuild("pray_symbol")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("symbol")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.is_rare = math.random(1,10) == 1
    if inst.is_rare then
        if inst.components.colourtweener == nil then
            inst:AddComponent("colourtweener")
        end
        inst.components.colourtweener:StartTween({0.7,0,0.6,1}, 0)
    end
	
    inst:AddComponent("inspectable")
	inst:AddComponent("prayable")
    inst.components.prayable:SetPrayFn(OnPray)

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "pray_symbol"
	inst.components.inventoryitem.atlasname = "images/pray_symbol.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    inst.components.fuel:SetOnTakenFn(prayburnt)

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	inst.components.burnable:SetOnBurntFn(onburnt)
    MakeSmallPropagator(inst)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("prayer_symbol", fn, assets)
