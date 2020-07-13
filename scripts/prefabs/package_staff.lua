local assets=
{
    Asset("ANIM", "anim/package_staff.zip"),
    Asset("ANIM", "anim/swap_package_staff.zip"),
    Asset("IMAGE", "images/package_staff.tex"),
    Asset("ATLAS", "images/package_staff.xml"),
}

local function onfinished(inst, owner)
    inst:Remove()
end
    
local function package_staffequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_package_staff", "swap_package_staff")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function package_staffunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")
end

local function canpacker(target)
	if target and not target:HasTag("chester") and not target:HasTag("player") and not target:HasTag("FX") then
	--	print("test packer " .. ((not target.components.combat or target.components.combat.defaultdamage == 0) and "true" or "false"))
		return true
	--elseif target and not target:HasTag("chester") then
	--	return not target:HasTag("epic")
	end
    return false
end

local function checkLevel(doer, target)
    if not target.components or not target.components.combat or not target.components.health then
        return true
    end
    if doer and doer.components.titlesystem then
        local vip_level = doer.components.titlesystem.vip_level or 0
        --print("vip_level:"..vip_level)
        if target.components.health.maxhealth <= vip_level*1000 then
            return true
        end
    end
    return false
end
	
local function startpacker(staff, target)
	if target and target:IsValid() and (not target:HasTag("unpackage")) then
        local doer = staff.components.inventoryitem.owner
		local targetpos = target:GetPosition()
		local package = SpawnPrefab("package_ball")
		if package then
			package.components.packer:SetCanPackFn(canpacker)
			if checkLevel(doer, target) and package.components.packer:Pack(target) then
				package.Transform:SetPosition( targetpos:Get() )
				staff.components.finiteuses:Use(1)				
				if doer and doer.SoundEmitter then
					doer.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
				end
			else
				package:Remove()
			end
		end
	end    
end

local function onhauntpackage()

end

local function CanCastFn(doer, target, pos)
	return target ~= nil and (not target:HasTag("unpackage"))
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("package_staff")
    anim:SetBuild("package_staff")
    anim:PlayAnimation("idle")

    inst.entity:SetPristine()

	--inst.entity:AddMiniMapEntity()
	--inst.MiniMapEntity:SetIcon( "package_staff.tex" )
	if not TheWorld.ismastersim or not TheNet:GetIsServer() then
		return inst
    end

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished( onfinished )  
    inst.components.finiteuses:SetMaxUses(3)
    inst.components.finiteuses:SetUses(3)


    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/package_staff.xml"
    inst:AddTag("nopunch")
    --inst:AddTag("irreplaceable")
    inst:AddComponent("inspectable")
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( package_staffequip )
    inst.components.equippable:SetOnUnequip( package_staffunequip )

	
    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(startpacker)
    --inst.components.spellcaster:SetSpellTestFn(packertest)
    inst.components.spellcaster.CanCast = CanCastFn
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canusefrominventory = false
	inst:AddComponent("packer")

	MakeHauntableLaunch(inst)
    inst:AddTag("unpackage")
    return inst
end



return Prefab("package_staff", fn, assets)