local assets =
{
	Asset("ANIM", "anim/titles_fx.zip"),
    Asset("ANIM", "anim/titles_ex.zip")
}

local function updateLight(inst)
    if TheWorld.state.isnight then
        inst.Light:Enable(true)
    else
        inst.Light:Enable(false)
    end
end


local function common_fn(type)
    return function()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.AnimState:SetBank("titles_fx")
        inst.AnimState:SetBuild("titles_fx")
        inst.AnimState:PlayAnimation("titles_"..type)
        --inst.AnimState:PlayAnimation("magic_circle_fx",true) 
        --inst.Transform:SetScale(5, 5, 1)  --这里可以改变预设物大小
        --inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
        --inst.AnimState:SetLayer(LAYER_BACKGROUND)
        --inst.AnimState:SetSortOrder(3)

        --inst.entity:AddLight()
        --inst.Light:SetColour(255,222,0)
        --inst.Light:SetFalloff(0.3)
        --inst.Light:SetIntensity(0.8)
        --inst.Light:SetRadius(4)

        inst.entity:SetPristine()
        inst:AddTag("FX")
        
        return inst
    end
end

local function ex_fn(type)
    return function()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.AnimState:SetBank("titles_ex")
        inst.AnimState:SetBuild("titles_ex")
        inst.AnimState:PlayAnimation("titles_"..type)

        inst.entity:AddLight()
        inst.Light:SetColour(255,222,0)
        inst.Light:SetFalloff(0.3)
        inst.Light:SetIntensity(0.8)
        inst.Light:SetRadius(2)
        inst.Light:Enable(false)

        inst.entity:SetPristine()
        inst:AddTag("FX")

        if not TheWorld.ismastersim then
            return inst
        end

        inst:WatchWorldState("isnight", updateLight)
        updateLight(inst)
        
        return inst
    end
end

local prefabs = {}
for k=1,13 do
    table.insert(prefabs, Prefab("titles_fx_"..tostring(k), common_fn(k), assets))
end

table.insert(prefabs, Prefab("titles_fx_"..tostring(14), ex_fn(14), assets))

return unpack(prefabs)