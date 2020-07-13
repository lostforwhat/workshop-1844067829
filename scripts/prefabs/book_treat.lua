local assets =
{
    Asset("ANIM", "anim/new_books.zip"),
    Asset("IMAGE", "images/book_treat.tex"),
    Asset("ATLAS", "images/book_treat.xml"),
}

local function Isfriend(follower)
    if follower.components.follower then
        local leader = follower.components.follower:GetLeader()
        if leader ~= nil and leader:HasTag("player") then
            return true
        end
    end
    if follower.prefab == "bernie_big" then
        return true
    end
    return false
end

local function Onread(inst, reader)
    reader.components.sanity:DoDelta(-TUNING.SANITY_SMALL)
    local regenpercent = 0.5
    if reader.prefab ~= "wickerbottom" and reader.components.talker then 
        reader.components.talker:Say(STRINGS.TALKER_BOOK_KILL_COMMON) 
        regenpercent = 0.1
    end

    local x, y, z = reader.Transform:GetWorldPosition()
    local range = 20
    local ents = TheSim:FindEntities(x, y, z, range, nil, nil, { "player", "character", "monster", "animal", "crazy" })
    
    --print("nums:"..#ents)
    if #ents > 0 then
        local timevar = 1 - 1 / (#ents + 1)
        for i, v in pairs(ents) do
            if v:HasTag("player") or Isfriend(v) then
                v:DoTaskInTime(timevar * math.random(), function(v) 
                    --print("Prefab:"..v.prefab)
                    if v.components.health and not v.components.health:IsDead() then
                        local maxhealth = v.components.health.maxhealth
                        v.components.health:DoDelta(maxhealth*regenpercent, nil, "book_treat")
                    end
                end)
            end
        end
    end
    local item = SpawnPrefab("magic_circle_treat")
    item.Transform:SetPosition(x, y, z)
    if reader.prefab == "wickerbottom" then
        local num = math.random(2, 6)
        for k=1,num do
            local angle = k * 2 * PI / num
            if TheWorld.Map:IsPassableAtPoint(3*math.cos(angle)+x, y, 3*math.sin(angle)+z) then
                local follower = SpawnPrefab("pigman")
                follower.Transform:SetPosition(3*math.cos(angle)+x, y, 3*math.sin(angle)+z)
                reader.components.leader:AddFollower(follower)
                follower.components.follower:AddLoyaltyTime(30)
                follower:AddTag("cloned")
                follower.components.lootdropper.numrandomloot = 0
                follower:DoTaskInTime(30, function(follower)
                    if follower:IsValid() then follower:Remove() end
                end)
            end
        end
    end
    return true
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("new_books")
    inst.AnimState:SetBuild("new_books")
    inst.AnimState:PlayAnimation("book_treat")
    inst.Transform:SetScale(2, 2, 1)

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -----------------------------------

    inst:AddComponent("inspectable")
    inst:AddComponent("book")
    inst.components.book.onread = Onread

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/book_treat.xml"

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(10)
    inst.components.finiteuses:SetUses(10)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    --MakeHauntableLaunchOrChangePrefab(inst, TUNING.HAUNT_CHANCE_OFTEN, TUNING.HAUNT_CHANCE_OCCASIONAL, nil, nil, morphlist)
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("book_treat", fn, assets)
