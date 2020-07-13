local assets =
{
    Asset("ANIM", "anim/new_books.zip"),
    Asset("IMAGE", "images/book_kill.tex"),
    Asset("ATLAS", "images/book_kill.xml"),
}

local function Onread(inst, reader)
    reader.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
    local x, y, z = reader.Transform:GetWorldPosition()
    local item = SpawnPrefab("magic_circle_kill")
    item.Transform:SetPosition(x, y, z)
    item._master = reader
    item._parent = inst
    if reader.prefab ~= "wickerbottom" and reader.components.talker then 
        reader.components.talker:Say(STRINGS.TALKER_BOOK_KILL_COMMON) 
    end
    return true
end

local function Onread2(inst, reader)
    reader.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
    local x, y, z = reader.Transform:GetWorldPosition()
    local item = SpawnPrefab("magic_circle_kill")
    item.entity:SetParent(reader.entity)
    item.Transform:SetPosition(0,0,0)
    item._master = reader
    item._parent = inst
    if reader.prefab ~= "wickerbottom" and reader.components.talker then 
        reader.components.talker:Say(STRINGS.TALKER_BOOK_KILL_COMMON) 
    end
    return true
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("new_books")
    inst.AnimState:SetBuild("new_books")
    inst.AnimState:PlayAnimation("book_kill")
    inst.Transform:SetScale(2, 2, 1)

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -----------------------------------

    inst:AddComponent("inspectable")
    inst:AddComponent("book")
    inst.components.book.onread = Onread

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "book_kill"
    inst.components.inventoryitem.atlasname = "images/book_kill.xml"

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(5)
    inst.components.finiteuses:SetUses(5)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    --MakeHauntableLaunchOrChangePrefab(inst, TUNING.HAUNT_CHANCE_OFTEN, TUNING.HAUNT_CHANCE_OCCASIONAL, nil, nil, morphlist)
    MakeHauntableLaunch(inst)

    return inst
end

local function new_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("new_books")
    inst.AnimState:SetBuild("new_books")
    inst.AnimState:PlayAnimation("book_kill")
    inst.Transform:SetScale(2, 2, 1)

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -----------------------------------

    inst:AddComponent("inspectable")
    inst:AddComponent("book")
    inst.components.book.onread = Onread2

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "book_kill"
    inst.components.inventoryitem.atlasname = "images/book_kill.xml"

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(10)
    inst.components.finiteuses:SetUses(10)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    --MakeHauntableLaunchOrChangePrefab(inst, TUNING.HAUNT_CHANCE_OFTEN, TUNING.HAUNT_CHANCE_OCCASIONAL, nil, nil, morphlist)
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("book_kill", fn, assets),
        Prefab("book_kill_new", new_fn, assets)
