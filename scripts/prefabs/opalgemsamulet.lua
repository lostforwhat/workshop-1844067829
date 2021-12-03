
local assets =
{
    Asset("ANIM", "anim/amulets_my.zip"),  --地上动画
    Asset("ANIM", "anim/torso_amulets_my.zip"),  --身上动画
    Asset("ATLAS", "images/opalgemsamulet.xml"), --物品栏
    Asset("ATLAS", "images/opalgemsamulet2.xml"), --物品栏
}


local function delivery(inst,owner)
    local tum_5 = {}
    for _, ent in pairs(Ents) do
        if ent:IsValid() and ent.prefab == "tumbleweed_5" then
            table.insert(tum_5,ent)
        end
    end
    if #tum_5>0 then
        owner.components.talker:Say("这个世界存在 "..#tum_5.." 个发光的风滚草")
        local x,y,z = tum_5[1].Transform:GetWorldPosition() --直接飞到第一个,或者反过来，光草到玩家边上
        owner.Transform:SetPosition(x, 0, z) -- 需要调整一下位置比较好，不然可能把光草挤海里
        local opal2 = SpawnPrefab("opalgemsamulet2")
        --设置耐久
        opal2.components.fueled.currentfuel = inst.components.fueled.currentfuel
        --设置冷却时间
        opal2.components.rechargeable:SetCharge(0)
        --设置装备中
        opal2.components.opal.state = true
        owner.components.inventory:Equip(opal2)
        inst:Remove()
    else
        owner.components.talker:Say("这个世界没有发光的风滚草")
    end
end
local function delivery2(inst,owner)
    local tum_5 = {}
    for _, ent in pairs(Ents) do
        if ent:IsValid() and ent.prefab == "tumbleweed_5" then
            table.insert(tum_5,ent)
        end
    end
    if #tum_5>0 then
        owner.components.talker:Say("这个世界存在 "..#tum_5.." 个发光的风滚草")
        local x,y,z = tum_5[1].Transform:GetWorldPosition() --直接飞到第一个,或者反过来，光草到玩家边上
        owner.Transform:SetPosition(x, 0, z)

        inst:Remove()
    else
        owner.components.talker:Say("这个世界没有发光的风滚草")
    end
end



local function onequip(inst, owner)  --装备
    owner.AnimState:OverrideSymbol("swap_body", "torso_amulets_my", "opal_gems_amulet")

    if inst.components.fueled ~= nil and inst.components.fueled.currentfuel > 0 then  --燃料组件,存在,并且当前燃料大于0时     
        inst.Light:SetRadius(2.25) 
        inst.Light:Enable(true)
        inst.components.fueled:StartConsuming() --开始消耗            
    end
    if inst.components.rechargeable:IsCharged() then --装备了，且冷却好了，才添加
        inst:AddTag("opalgemsamulet")
    end
    inst.components.opal.state = true
end

local function onunequip(inst, owner) --卸载
    owner.AnimState:ClearOverrideSymbol("swap_body") --取消局部替换
    if inst.components.fueled ~= nil then
        inst.components.fueled:StopConsuming() --停止消耗
    end
    inst.Light:Enable(false)
    if inst:HasTag("opalgemsamulet") then
        inst:RemoveTag("opalgemsamulet")
    end 
    inst.components.opal.state = false
end


local function usable(inst) -- 冷却结束,装备中吗，是恢复
    if not inst:HasTag("opalgemsamulet") and inst.components.opal.state then
        inst:AddTag("opalgemsamulet")
    end
end
local function unavailable(inst) -- 冷却开始
    if inst:HasTag("opalgemsamulet") then
        inst:RemoveTag("opalgemsamulet")
    end
end
local function Make(name,Fn,assets)
    local function fn()
        local inst = CreateEntity()--生成实体

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddLight() 
        
        MakeInventoryPhysics(inst)

        --放在地上的动画集
        inst.AnimState:SetBank("amulets_my")
        inst.AnimState:SetBuild("amulets_my")
        inst.AnimState:PlayAnimation("opal_gems_amulet")

        inst:AddTag("rechargeable") --冷却标签

        inst.foleysound = "dontstarve/movement/foley/jewlery"

        MakeInventoryFloatable(inst, "med", 0.15, 0.65)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:ListenForEvent("opalgemsamuletstate",function(inst,data) TheWorld:PushEvent("indicatorstate",{inst=inst,Enabled=inst.state:value()}) end)

        inst.Light:SetRadius(.5) --设置半径
        inst.Light:SetFalloff(.7) --设置衰减
        inst.Light:SetIntensity(.65) --设置强度
        inst.Light:SetColour(163 / 255, 234 / 255, 255 / 255) --设置颜色 
        inst.Light:Enable(true) --启用

        --可检查组件
        inst:AddComponent("inspectable")
        
        inst:AddComponent("named")

        --可装备组件，能够装备在身上
        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY --装备的部位是身体 NECK是兼容45格
        inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL --装备回san 100/(30*10*10)
        inst.components.equippable.is_magic_dapperness = true --
        inst.components.equippable:SetOnEquip(onequip)  --装备时调用方法
        inst.components.equippable:SetOnUnequip(onunequip)  --卸载时调用方法
        inst.components.equippable.walkspeedmult = 1.25  --设置步行速度

        --物品栏组件，可以放到物品栏里
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem:SetSinks(true)
        inst.components.inventoryitem.imagename = name --图像,像素大小64*64
        inst.components.inventoryitem.atlasname = "images/"..name..".xml" --图集
        inst.components.inventoryitem:SetOnDroppedFn(function(inst) inst.Light:SetRadius(.5) end) --设置丢下方法

        --耐久组件
        inst:AddComponent("fueled")
        inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE  --设置补充为噩梦燃料 补充30*6
        inst.components.fueled:InitializeFuelLevel(30*16*1.5) --设置耐久度
        inst.components.fueled:SetDepletedFn(function(inst)
            inst.Light:Enable(false)
        end)--耗尽时的方法
        inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)  --设置第一周期满了方法
        inst.components.fueled.accepting = true --能够接受燃料
        inst.components.fueled.depleted=function(inst) --消耗到0时，调用一次        
            if inst.components.fueled ~= nil and inst.components.fueled.currentfuel <= 0 then
                inst.Light:Enable(false)
            end
        end 
        inst.components.fueled.sectionfn=function(a,b,inst)
            if inst.components.fueled ~= nil and inst.components.fueled.currentfuel > 0 then 
                inst.Light:SetRadius(2.25) 
                inst.Light:Enable(true)
                inst.components.fueled:StartConsuming() --开始消耗            
            end
        end

        -- 传送到光草组件
        inst:AddComponent("opal")
        inst.components.opal:SetPrayFn(Fn)


        -- 添加冷却组件
        inst:AddComponent("rechargeable") 
        inst.components.rechargeable:SetOnDischargedFn(unavailable)
        inst.components.rechargeable:SetOnChargedFn(usable)
        inst.components.rechargeable:SetChargeTime(30)

        --热学组件
        inst:AddComponent("heater")
        inst.components.heater:SetThermics(false, true) --设置是否放吸热，第一参数是放热，第二参数是吸热
        inst.components.heater.equippedheat = -25

        MakeHauntableLaunch(inst)
        
        MakeHauntableLaunchAndIgnite(inst)--能够被闹鬼

        return inst
    end
    return Prefab(name, fn, assets)
end

return Make("opalgemsamulet", delivery, assets),
       Make("opalgemsamulet2", delivery2, assets)