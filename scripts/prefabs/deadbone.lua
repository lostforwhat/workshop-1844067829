local assets =
{
    Asset("ANIM", "anim/hound_base.zip"),
}


local names = { "piece1", "piece2", "piece3" }


local function onsave(inst, data)
    data.anim = inst.animname
    data.soul = inst.soul
end

local function onload(inst, data)
    if data ~= nil and data.anim ~= nil then
        inst.animname = data.anim
        inst.AnimState:PlayAnimation(inst.animname)
    end
    if data ~= nil and data.soul then
        inst.soul = data.soul
    end
end

local function getdesc(inst, viewer)
    if inst.soul ~= nil and not viewer:HasTag("playerghost") then
        
        local soul_name = STRINGS.NAMES[string.upper(inst.soul)] or "??"
        local desc = STRINGS.CHARACTERS.GENERIC.DESCRIBE.DEADBONE

        return string.format(desc, soul_name)
    end
end

local function SetDescription(inst, soul)
    inst.soul = soul
    inst.components.inspectable.getspecialdescription = getdesc
end

local function get_name(inst)
    if inst.soul ~= nil then
        local soul_name = STRINGS.NAMES[string.upper(inst.soul)]  or "??"
        return string.format(STRINGS.DEADBONEFORMAT, soul_name)
    else
        return STRINGS.NAMES.DEADBONE
    end
end

local function setcharged(inst)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    local soul = inst.soul or "ghost"
    --print("soul:"..soul)
    if soul and soul ~= "ghost" then
        local item = SpawnPrefab(soul)
        item:AddComponent("limited")
        item.Transform:SetPosition(inst.Transform:GetWorldPosition())
    end
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("hound_base")
    inst.AnimState:SetBank("houndbase")

    inst:AddTag("bone")
    --inst:AddTag("FX")
    --inst:AddTag("unpackage")
    inst:AddTag("deadbone")
    inst:AddTag("lightningrod")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    local bonetype = math.random(#names)
    inst.animname = names[bonetype]
    inst.AnimState:PlayAnimation(inst.animname)


    --MakeHauntableLaunch(inst)

    -------------------
    inst:AddComponent("inspectable")
    inst.components.inspectable.getspecialdescription = getdesc

    MakeSnowCovered(inst)
    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:ListenForEvent("lightningstrike", setcharged)
    inst.setcharged = setcharged

    inst.SetDescription = SetDescription
    inst.displaynamefn = get_name

    inst:DoTaskInTime(60, inst.Remove)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        if math.random() < 0.2 then
            inst:setcharged()
        end
        return true
    end)

    return inst
end

return Prefab("deadbone", fn, assets)