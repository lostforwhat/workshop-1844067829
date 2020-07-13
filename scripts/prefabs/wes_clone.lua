local assets =
{
    Asset("ANIM", "anim/player_mount_wes.zip"),
    Asset("ANIM", "anim/player_mime.zip"),
}

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)     
end

local function OnKilled(inst, data)

end

local function OnDeath(inst)
    for k,v in pairs(inst.components.inventory.itemslots) do
        if v and (v:IsValid()) then
            v:Remove()
        end
    end
end

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.Transform:SetFourFaced()
    
    inst.entity:AddMiniMapEntity()
    inst.entity:AddAnimState()
    inst.entity:AddDynamicShadow()
    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("wes")
    inst.AnimState:PlayAnimation("idle")
    --inst.AnimState:OverrideSymbol("swap_hat", "hat_walrus", "swap_hat")
    --inst.AnimState:OverrideSymbol("swap_body", "swap_krampus_sack", "backpack")
    --inst.AnimState:OverrideSymbol("swap_body", "swap_krampus_sack", "swap_body")
    
    inst.entity:AddSoundEmitter()

    inst.MiniMapEntity:SetIcon("wes.png")
    
    inst.DynamicShadow:SetSize(1.3, .6)
    MakeCharacterPhysics(inst, 75, .5)
    
    inst.entity:AddNetwork()
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end 

    inst:AddComponent("eater")  
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI})
    inst.components.eater.strongstomach = true

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed= 9
    inst.components.locomotor.runspeed = 9
    inst.components.locomotor.fasteronroad = true
    inst.components.locomotor:SetTriggersCreep(false)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(150)

    --inst.components.health:SetAbsorptionAmount(.6)
    inst:AddComponent("inventory")
    
    inst:AddComponent("talker")
    inst:AddComponent("named")
    inst.components.named:SetName("wes")
    
    inst:AddComponent("follower")
    inst:AddComponent("rider")
    inst:AddComponent("burnable")
    inst:AddComponent("drownable")
    inst:AddComponent("freezable")

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(34)
    inst.components.combat:SetAttackPeriod(.1)
    inst.components.combat:SetRange(2)
    inst.components.combat.hiteffectsymbol = "torso"
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)

    --inst:AddComponent("lootdropper")
    
    inst:AddComponent("inspectable")
    inst:SetStateGraph("SGwes_clone")

    local brain = require "brains/wes_clonebrain"  --自定义AI
    inst:SetBrain(brain)

    --inst:ListenForEvent("killed", OnKilled)
    inst:ListenForEvent("death", OnDeath)
    
    return inst
end
 
return Prefab ("wes_clone", fn, assets)
