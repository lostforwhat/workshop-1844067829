local assets =
{
    Asset("ANIM", "anim/stealingknife.zip"),  --地上的动画
    Asset("ANIM", "anim/swap_stealingknife.zip"), --手里的动画
	Asset("ATLAS", "images/stealingknife.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/stealingknife.tex"),
}


----------------------
local function onequip(inst, owner) --装备时
    owner.AnimState:OverrideSymbol("swap_object", "swap_stealingknife", "material")
								--替换的动画部件	使用的动画.zip	替换的贴图所在文件夹（注意这里也是素材图片文件夹的名字）
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end
local function onunequip(inst, owner) --解除时
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("stealingknife")
    inst.AnimState:SetBuild("stealingknife")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")
    inst:AddTag("toqie") --偷窃标签

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- 武器组件
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(35) --设置伤害

    -- 耐久组件
    inst:AddComponent("finiteuses") 
    inst.components.finiteuses:SetMaxUses(300)
    inst.components.finiteuses:SetUses(300)

    inst.components.finiteuses:SetOnFinished(inst.Remove) --没有耐久了移除武器

    inst:AddComponent("inspectable") --可检查组件

    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/stealingknife.xml" --物品贴图
	
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("stealingknife", fn, assets)