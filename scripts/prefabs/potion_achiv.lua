local assets =
{
    Asset("ANIM", "anim/potion_achiv.zip"),
    Asset("IMAGE", "images/potion_achiv.tex"),
    Asset("ATLAS", "images/potion_achiv.xml"),
}

local function OnSave(inst, data)
    if  inst._userid ~= nil then
        data._userid = inst._userid
    end
    data.minachiv = inst.minachiv
    data.maxachiv = inst.maxachiv
    data._owner = inst._owner
end

local function OnLoad(inst, data)
    if data then
        if data._userid and data._userid ~= nil then
            inst._userid = data._userid
        end
    end 
    inst.minachiv = data.minachiv or 1
    inst.maxachiv = data.maxachiv or 3
    inst._owner = data._owner or nil
end

local function Oneat(inst, eater)
    local coin = math.random(inst.minachiv, inst.maxachiv)
    if inst._userid ~= nil then
        if inst._userid ~= eater.userid then 
            if eater.components.talker then
                eater.components.talker:Say(STRINGS.TALKER_NO_EFFECT)
            end
            return false
        end
    end
    if eater.components.allachivcoin then
        eater.components.allachivcoin:coinDoDelta(coin)
        eater.components.talker:Say(STRINGS.TALKER_GETCOIN..coin)
    end
    return true
end

local function get_name(inst)
    local ownerstr = ""
    if inst._owner ~= nil then
        ownerstr = "["..inst._owner.."]"
    end
    return STRINGS.NAMES.POTION_ACHIV.."("..inst.minachiv.."-"..inst.maxachiv..")"..ownerstr
end


local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    
    -- Set animation info
    inst.AnimState:SetBuild("potion_achiv")
    inst.AnimState:SetBank("potion_achiv")
    inst.AnimState:PlayAnimation("idle")
    inst.Transform:SetScale(2, 2, 1)

    --inst:AddTag("irreplaceable")
    inst:AddTag("preparedfood")
    --MakeInventoryFloatable(inst, "small", 0.05, {1.2, 0.75, 1.2})
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst._userid = nil
    inst._owner = nil
    inst.minachiv = 1
    inst.maxachiv = 5

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = 0  -- Amount to heal
    inst.components.edible.hungervalue =  0 -- Amount to fill belly
    inst.components.edible.sanityvalue = 0  -- Amount to help Sanity
    inst.components.edible.foodtype = "GOODIES"
    inst.components.edible:SetOnEatenFn(Oneat) 
  
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/potion_achiv.xml" -- here's the atlas for our tex

    --inst.displaynamefn = get_name
    inst:AddComponent("named")
    inst.components.named:SetName(get_name(inst))
    inst:DoPeriodicTask(1, function() 
       inst.components.named:SetName(get_name(inst)) 
    end)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("potion_achiv", fn, assets)
