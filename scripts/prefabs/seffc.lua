local assets = {
    Asset( "ANIM", "anim/seffc.zip" ),
    Asset("SOUNDPACKAGE", "sound/seffcsound.fev"),
    Asset("SOUND", "sound/seffcsound.fsb"),
}

local prefabs = {}

local function lighton(inst)
    for i=1, 25 do
        inst:DoTaskInTime(i/200, function()
            inst.Light:SetRadius(i/25*2)
            --inst.Light:SetIntensity(i/25*.5)
        end)
    end
end

local function lightoff(inst)
    for i=1, 25 do
        inst:DoTaskInTime(i/50, function()
            inst.Light:SetRadius(2-i/25*2)
            --inst.Light:SetIntensity(.5-i/25*.5)
        end)
    end
end

local function smalllight(inst)
    inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(0)
    inst.Light:SetColour(255/255,255/255,255/255)

    lighton(inst)
    inst:DoTaskInTime(1.5, function() lightoff(inst) end)
end

local function fn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("notarget")

    inst.AnimState:SetBank("seffc")
    inst.AnimState:SetBuild("seffc")
    inst.AnimState:PlayAnimation("anim")
    --inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoTaskInTime(2, function() inst:Remove() end)

    inst.persists = false

	smalllight(inst)
    inst.SoundEmitter:PlaySound("seffcsound/sound/seffc")

    return inst
end

return Prefab("seffc", fn, assets, prefabs)