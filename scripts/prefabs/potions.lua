local assets =
{
    Asset("ANIM", "anim/potions.zip"),
    Asset("IMAGE", "images/potions/potion_blue.tex"),
    Asset("ATLAS", "images/potions/potion_blue.xml"),
    Asset("IMAGE", "images/potions/potion_green.tex"),
    Asset("ATLAS", "images/potions/potion_green.xml"),
    Asset("IMAGE", "images/potions/potion_luck.tex"),
    Asset("ATLAS", "images/potions/potion_luck.xml"),
    Asset("IMAGE", "images/potions/potion_red.tex"),
    Asset("ATLAS", "images/potions/potion_red.xml"),
}

local function create_light(eater, lightprefab)
    if eater.wormlight ~= nil then
        if eater.wormlight.prefab == lightprefab then
            eater.wormlight.components.spell.lifetime = 0
            eater.wormlight.components.spell.duration = TUNING.WORMLIGHT_DURATION * 8
            eater.wormlight.components.spell:ResumeSpell()
            return
        else
            eater.wormlight.components.spell:OnFinish()
        end
    end

    local light = SpawnPrefab(lightprefab)
    light.components.spell:SetTarget(eater)
    if light:IsValid() then
        if light.components.spell.target == nil then
            light:Remove()
        else
        	light.components.spell.duration = TUNING.WORMLIGHT_DURATION * 8
            light.components.spell:StartSpell()
        end
    end
end

local function dobackperish(player)
    if player == nil or player.components.inventory == nil then return end
    local percent = math.random()
    percent = math.clamp(percent, 0, 0.5)
    for k,v in pairs(player.components.inventory.itemslots) do
        if v and v.components.perishable then
            v.components.perishable:ReducePercent(-percent)
        end
    end
    for k,v in pairs(player.components.inventory.equipslots) do
        if v and v.components.perishable then
            v.components.perishable:ReducePercent(-percent)
        end
    end
    for k,v in pairs(player.components.inventory.opencontainers) do
        if k and k:HasTag("backpack") and k.components.container then
            for i,j in pairs(k.components.container.slots) do
                if j and j.components.perishable then
                    j.components.perishable:ReducePercent(-percent)
                end
            end
        end
    end
end

local function takeglommerfuel(player)
	local glommer = c_find("glommer", 10, player)
	if glommer then
		local x,y,z = glommer.Transform:GetWorldPosition()
		local fuel = SpawnPrefab("glommerfuel")
		fuel.components.stackable:SetStackSize(math.random(5))
		glommer.sg:GoToState("goo", fuel)
	end
end

local potions_type = {
	blue = {
		health = 1,
		sanity = 10,
		hunger = 1,
		fn = function(inst, eater)
			if eater and eater.components.locomotor and eater:HasTag("player") then
				if eater.potion_blue_task ~= nil then
					eater.potion_blue_task:Cancel()
					eater.potion_blue_task = nil
				end
				local speedup = 1.2
				if eater:HasTag("potionbuilder") then
					speedup = 1.5
				end
				eater.components.locomotor:SetExternalSpeedMultiplier(eater,"potionspeedup", speedup)
				eater:AddTag("shadow")
				eater.components.colourtweener:StartTween({0.3,0.3,0.3,1}, 0)

				eater.potion_blue_task = eater:DoTaskInTime(120, function() 
					eater.components.locomotor:RemoveExternalSpeedMultiplier(eater, "potionspeedup")
					if eater:HasTag("shadow") then
						eater:Show()
		                eater:RemoveTag("shadow")
		                eater.components.colourtweener:StartTween({1,1,1,1}, 0)
		            end
				end)
			end
			
		end
	},
	green = {
		health = -5,
		sanity = 20,
		hunger = 10,
		fn = function(inst, eater)
			if eater and eater.components.health then
				eater.potion_green_task_time = 15
				eater.potion_green_task = eater:DoPeriodicTask(1, function() 
					eater.potion_green_task_time = eater.potion_green_task_time - 1
					if eater.potion_green_task_time <= 0 then
						eater.potion_green_task_time = 0
						if eater.potion_green_task ~= nil then
							eater.potion_green_task:Cancel()
							eater.potion_green_task = nil
						end
					else
						local x, y, z = eater.Transform:GetWorldPosition()
	    				local ents = TheSim:FindEntities(x,y,z, 20, nil,nil, {"monster", "animal", "flying", "pig", "merm"})
						for k,v in pairs(ents) do
					        if v.components.combat and v:IsValid() then
					        	v.components.combat:SetTarget(eater)
					        end
					    end
					end
				end)
			end
			if eater:HasTag("potionbuilder") then
				dobackperish(eater)
			end
		end
	},
	luck = {
		health = 40,
		sanity = 5,
		hunger = 10,
		fn = function(inst, eater)
			if eater and eater.components.luck then
				local num = math.random(5,20)
				eater.components.luck:DoDelta(num)
			end
			create_light(eater, "wormlight_light")
			if eater:HasTag("potionbuilder") then
				takeglommerfuel(eater)
			end
		end
	},
	red = {
		health = 100,
		sanity = 5,
		hunger = 1,
		fn = function(inst, eater)
			if eater and eater:HasTag("player") and not eater:HasTag("playerghost") then
				if eater.potion_red_task ~= nil then
					eater.potion_red_task:Cancel()
					eater.potion_red_task = nil
				end
				--local currentscale = eater.Transform:GetScale()
				local scale = 1.5
				if eater:HasTag("potionbuilder") then
					scale = 2
				end
				eater:ApplyScale("potion", scale)
				
				if eater.components.combat then
					eater.components.combat.externaldamagemultipliers:SetModifier("potiondamageup", scale)
				end
				eater.potion_red_task = eater:DoTaskInTime(30, function() 
					eater:ApplyScale("potion", 1)
					eater.components.combat.externaldamagemultipliers:RemoveModifier("potiondamageup")
				end)
			end
		end
	}
}

local function MakePotion(type)
	local function fn()
		local inst = CreateEntity()
	    inst.entity:AddTransform()
	    inst.entity:AddAnimState()
	    inst.entity:AddNetwork()
	    MakeInventoryPhysics(inst)
	    
	    -- Set animation info
	    inst.AnimState:SetBuild("potions")
	    inst.AnimState:SetBank("potions")
	    inst.AnimState:PlayAnimation("potion_"..type)
	    inst.Transform:SetScale(2, 2, 1)

	    --inst:AddTag("irreplaceable")
	    if type == "luck" then
	    	inst.entity:AddLight()
	    	inst.Light:SetFalloff(0.7)
		    inst.Light:SetIntensity(.5)
		    inst.Light:SetRadius(2)
		    inst.Light:SetColour(225/255, 231/255, 25/255)
		    inst.Light:Enable(true)

		    inst:AddTag("lightbattery")
	    end

	    inst:AddTag("meat")
	    inst:AddTag("preparedfood")
	    --MakeInventoryFloatable(inst, "small", 0.05, {1.2, 0.75, 1.2})
	    inst.entity:SetPristine()

	    if not TheWorld.ismastersim then
	        return inst
	    end

	    inst:AddComponent("edible")
	    inst.components.edible.healthvalue = potions_type[type].health or 0 -- Amount to heal
	    inst.components.edible.hungervalue =  potions_type[type].hunger or 0 -- Amount to fill belly
	    inst.components.edible.sanityvalue = potions_type[type].sanity or 0 -- Amount to help Sanity
	    inst.components.edible.foodtype = "GOODIES"
	    inst.components.edible:SetOnEatenFn(potions_type[type].fn) 

	  	inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	    inst:AddComponent("inspectable")

	    inst:AddComponent("inventoryitem")
	    inst.components.inventoryitem.atlasname = "images/potions/potion_"..type..".xml" -- here's the atlas for our tex

	    --inst.OnSave = OnSave
	    --inst.OnLoad = OnLoad

	    return inst
	end

	return Prefab("potion_"..type, fn, assets)
end

return MakePotion("blue"),
MakePotion("green"),
MakePotion("luck"),
MakePotion("red")