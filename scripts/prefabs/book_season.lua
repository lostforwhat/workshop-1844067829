local assets =
{
    Asset("ANIM", "anim/new_books.zip"),
    Asset("IMAGE", "images/book_season.tex"),
    Asset("ATLAS", "images/book_season.xml"),
}

local function changeseason(season)
    if TheWorld:HasTag("cave") then return end
    local names = {"spring","summer","autumn","winter"}
    if season == nil then
        local index = math.random(#names)
        TheWorld:PushEvent("ms_setseason", names[index])
    else
        local index = 1
        for k,v in pairs(names) do
            if v == season then
                if k ~= #names then
                    index = k + 1
                end
            end
        end
        TheWorld:PushEvent("ms_setseason", names[index])
    end
    local worldShardId = TheShard:GetShardId()
    local serverName = ""
    if worldShardId ~= nil and worldShardId ~= "0" then
        serverName = "[" .. STRINGS.TUM.WORLD .. worldShardId .. "] "
    end
    TheNet:Announce(serverName .. STRINGS.TUM.BOOK_SEAN_READ)
end

local function Onread(inst, reader)
    reader.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
    if reader.prefab ~= "wickerbottom" and reader.components.talker then 
        reader.components.talker:Say(STRINGS.TALKER_BOOK_KILL_COMMON) 
        changeseason(nil)
        return true
    end
    changeseason(TheWorld.state.season)
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
    inst.AnimState:PlayAnimation("book_season")
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
    inst.components.inventoryitem.atlasname = "images/book_season.xml"

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(4)
    inst.components.finiteuses:SetUses(4)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    --MakeHauntableLaunchOrChangePrefab(inst, TUNING.HAUNT_CHANCE_OFTEN, TUNING.HAUNT_CHANCE_OCCASIONAL, nil, nil, morphlist)
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("book_season", fn, assets)
