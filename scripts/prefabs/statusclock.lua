
local assets =
{
    Asset("ANIM", "anim/statusclock.zip"),  --地上动画
    Asset("ATLAS", "images/statusclock.xml"), --物品栏
}


local function usable(inst) -- 冷却结束,装备中吗，是恢复
    if inst.components.pocketwatch ~= nil then
        inst.components.pocketwatch.inactive = true
    end
end
local function unavailable(inst) -- 冷却开始
    if inst.components.pocketwatch ~= nil then
        inst.components.pocketwatch.inactive = false
    end
end
local function fn()
    local inst = CreateEntity()--生成实体

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    --放在地上的动画集
    inst.AnimState:SetBuild("statusclock")
    inst.AnimState:SetBank("clock")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("pocketwatch") -- 怀表标签
    inst:AddTag("cattoy")
    inst:AddTag("rechargeable")
    inst:AddTag("pocketwatch_mountedcast") -- 钟表

    MakeInventoryFloatable(inst, "med", 0.15, 0.65)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --可检查组件
    inst:AddComponent("inspectable")
    
    inst:AddComponent("named")
    inst:AddComponent("lootdropper")

    --物品栏组件，可以放到物品栏里
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetSinks(true)
    inst.components.inventoryitem.imagename = "statusclock" --图像,像素大小64*64
    inst.components.inventoryitem.atlasname = "images/statusclock.xml" --图集

    -- -- 将玩家状态进行记录读取
    inst:AddComponent("access")
    -- inst.components.access:SetRecordFn(Fn) -- 记录时执行
    -- inst.components.access:SetReadFn(check) -- 读取时执行

    inst:AddComponent("pocketwatch") --必要的，官方激活表的动作需要
    -- inst.components.pocketwatch.DoCastSpell = DoCastSpell

    -- 添加冷却组件
    inst:AddComponent("rechargeable") 
    inst.components.rechargeable:SetOnDischargedFn(unavailable)
    inst.components.rechargeable:SetOnChargedFn(usable)
    inst.components.rechargeable:SetChargeTime(120) -- 3分钟不过分吧

    MakeHauntableLaunch(inst)
    
    MakeHauntableLaunchAndIgnite(inst)--能够被闹鬼

    return inst
end

return Prefab("statusclock", fn, assets)