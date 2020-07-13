local assets =
{
	Asset("ANIM", "anim/package_ball.zip"),
    Asset( "ATLAS", "images/package_ball.xml" ),
    Asset( "IMAGE", "images/package_ball.tex" ),
}

local function do_unpack(inst, pt, deployer)
	if inst and inst.components.packer and inst.components.packer:Unpack(pt) then
		
		inst:Remove()
	end
end

local function get_name(inst)
	local basename = inst.components.packer:GetName()
	if basename then
		return basename
	else
		return STRINGS.TUM.UNKNOWN_PACKAGE
	end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("package_ball")
	inst.AnimState:SetBuild("package_ball")
	inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetScale(4,4,4)
	
	
	--inst.displaynamefn = get_name
	inst.entity:SetPristine()
	if not TheWorld.ismastersim or not TheNet:GetIsServer() then
		return inst
    end

    --inst:AddTag("irreplaceable")
    inst:AddTag("unpackage")
	inst:AddComponent("inspectable")
	
	inst:AddComponent("deployable")
	inst.components.deployable.ondeploy = do_unpack
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.nobounce = true
	inst.components.inventoryitem.atlasname = "images/package_ball.xml"
	
	inst:AddComponent("waterproofer")
	inst.components.waterproofer.effectiveness = 0
	inst:AddComponent("packer")
	inst:AddComponent("named")
	--inst.components.named:SetName(get_name(inst))
	inst.displaynamefn = get_name
	return inst
end

return 	Prefab("common/inventory/package_ball", fn, assets),
		MakePlacer("common/package_ball_placer", "package_ball", "package_ball", "idle")
