local assets =
{
    Asset("ANIM", "anim/achiv_clear.zip"),
    Asset("ATLAS", "images/achiv_clear.xml"),
}

local function IsInTable(value, tbl)
    for k,v in ipairs(tbl) do
      if v == value then
        return true
      end
    end
    return false
end

local function StrToTable(str)
    if str == nil or type(str) ~= "string" then
        return
    end
    
    return loadstring("return " .. str)()
end

local function OnPray(inst, prayers)
    if prayers and not prayers:HasTag("playerghost") and 
        prayers.components.allachivevent then
        if allachiv_eventdata ~= nil then
            --prayers.components.allachivevent.all < 1
            local achiv_tab = {}
            for k,v in pairs(allachiv_eventdata) do
                if prayers.components.allachivevent[k] ~= nil 
                    and prayers.components.allachivevent[k] < v and k ~= "all" then
                    table.insert(achiv_tab, k)
                end
                if prayers.components.allachivevent.tempachiv and 
                    prayers.components.allachivevent.tempachiv[k] ~= nil and
                    prayers.components.allachivevent.tempachiv[k] < v then
                    table.insert(achiv_tab, k)
                end
            end
            if #achiv_tab > 0 then
                local achivname = achiv_tab[math.random(#achiv_tab)]

                if not IsInTable(achivname, tempachiv) then
                    prayers.components.allachivevent[achivname] = allachiv_eventdata[achivname]
                    prayers.components.allachivevent:seffc(prayers, achivname)
                    prayers:DoTaskInTime(0.5,function() 
                        prayers:PushEvent("achivecompleted", {achivname=achivname})
                    end) 
                else
                    prayers.components.allachivevent.tempachiv[achivname] = allachiv_eventdata[achivname]
                    local tempstr = TableToStr(prayers.components.allachivevent.tempachiv)
                    prayers.components.allachivevent.tempachiv = StrToTable(tempstr)
                    prayers.components.allachivevent:seffc(prayers, achivname)
                    prayers:DoTaskInTime(0.5,function() 
                        prayers:PushEvent("achivecompleted", {achivname=achivname})
                    end) 
                    prayers.components.allachivevent:checkAllTemp(prayers)
                end
                
            end
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("achiv_clear")
    inst.AnimState:SetBuild("achiv_clear")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("achiv_clear")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
	inst:AddComponent("prayable")
    inst.components.prayable:SetPrayFn(OnPray)

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "achiv_clear"
	inst.components.inventoryitem.atlasname = "images/achiv_clear.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("achiv_clear", fn, assets)
