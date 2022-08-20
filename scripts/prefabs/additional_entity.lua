

local function equipped(inst,data)
    print("装备了",inst)
end
local function unequipped(inst,data)
    print("卸载了",inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddNetwork()
    inst.entity:SetPristine()

    -- inst.entity:AddTransform()
    -- inst.entity:AddAnimState()
    -- inst.entity:AddNetwork()
    -- inst.entity:AddLight() 

	inst:AddTag("xxx")

    if not TheWorld.ismastersim then
        return inst
    end

    -- inst:AddComponent("additionalcapacity")
    --可检查组件
    -- inst:AddComponent("inspectable")
    
    -- inst:AddComponent("named")

    -- --可装备组件，能够装备在身上
    -- inst:AddComponent("equippable")

    -- --物品栏组件，可以放到物品栏里
    -- inst:AddComponent("inventoryitem")

    -- 生成出来后，没有挂载到父对象上就删除掉它
 --    inst:DoTaskInTime(0,function(inst)
 --    	if inst.parent then
	-- 	    inst.parent:ListenForEvent("equipped",equipped)
	-- 	    inst.parent:ListenForEvent("unequipped",unequipped)

	-- 	    inst.components = inst.parent.components
	-- 	end
	-- end)
	inst:DoTaskInTime(2,function(inst)
		for k, v in pairs(inst.components) do
			print("组件",k,v)
			for a,b in pairs(v and type(v) == "table" and v or {}) do
				print("     内容",a,b)
			end
		end
	end)

	return inst
end

return Prefab("additional_entity", fn)