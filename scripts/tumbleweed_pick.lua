local PI = GLOBAL.PI
local loot_table = require("loot_table")

local function removetools(picker)
    for k,v in pairs(picker.components.inventory.itemslots) do
        if v and (v.prefab=="multitool_axe_pickaxe"
            or v.prefab=="goldenpickaxe"
            or v.prefab=="pickaxe") then
            v:Remove()
        end
    end
    --装备栏
    for k,v in pairs(picker.components.inventory.equipslots) do
        if v and (v.prefab=="multitool_axe_pickaxe"
            or v.prefab=="goldenpickaxe"
            or v.prefab=="pickaxe") then
            v:Remove()
        end
    end
    --背包
    for k,v in pairs(picker.components.inventory.opencontainers) do
        if k and k:HasTag("backpack") and k.components.container then
            for i,j in pairs(k.components.container.slots) do
                if j and (j.prefab=="multitool_axe_pickaxe"
                    or j.prefab=="goldenpickaxe"
                    or j.prefab=="pickaxe") then
                    j:Remove()
                end
            end
        end
    end
end

local function removeweapon(picker)--破坏武器
    if picker == nil or picker.components.inventory == nil then return end
    for k,v in pairs(picker.components.inventory.equipslots) do
        if v and (v.components.weapon or v:HasTag("weapon")
            or v.components.armor or v:HasTag("armor"))
            and v.components.perishable == nil then
            v:Remove()
        end
    end
end

local function doperish(picker)--腐烂陷阱
    if picker == nil or picker.components.inventory == nil then return end
    --考虑到有可能有返鲜机制，允许100%腐烂
    local percent = math.random() * 2
    percent = math.clamp(percent, 0.5, 1)
    for k,v in pairs(picker.components.inventory.itemslots) do
        if v and v.components.perishable then
            v.components.perishable:ReducePercent(percent)
        end
    end
    for k,v in pairs(picker.components.inventory.equipslots) do
        if v and v.components.perishable then
            v.components.perishable:ReducePercent(percent)
        end
    end
    for k,v in pairs(picker.components.inventory.opencontainers) do
        if k and k:HasTag("backpack") and k.components.container then
            for i,j in pairs(k.components.container.slots) do
                if j and j.components.perishable then
                    j.components.perishable:ReducePercent(percent)
                end
            end
        end
    end
end

local function lightningTarget(picker)
    picker:StartThread(function()
        local x,y,z = picker.Transform:GetWorldPosition()
        local num = 10
        for k = 1, num do
            local r = math.random(1, 5)
            local angle = k * 2 * PI / num
            local pos = GLOBAL.Point(r*math.cos(angle)+x, y, r*math.sin(angle)+z)
            GLOBAL.TheWorld:PushEvent("ms_sendlightningstrike", pos)
            GLOBAL.Sleep(.2 + math.random())
        end
    end)
end

local function keepPickerStop(picker)
    if picker.components.freezable then
        picker.components.freezable:AddColdness(10, 2)
    end
end

local function spawnPlayerGift(picker)
    if picker == nil then return end
    local x,y,z = picker.Transform:GetWorldPosition()
    if picker.prefab == "wortox" then
        for k=1, 6 do
            local item = GLOBAL.SpawnPrefab("wortox_soul_spawn")
            local x_offset = math.random()*2-1
            local z_offset = math.random()*2-1
            item.Transform:SetPosition(x+x_offset, y, z+z_offset)
        end 
    end
    if picker.prefab == "wilson" then
        for k=1,10 do
            local item = GLOBAL.SpawnPrefab("glommerfuel")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "wendy" then
        for k=1,20 do
            local item = GLOBAL.SpawnPrefab("ghostflower")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "willow" then
        local item_tb = {"lighter", "bernie_active"}
        local item = GLOBAL.SpawnPrefab(item_tb[math.random(#item_tb)])
        picker.components.inventory:GiveItem(item)
    end
    if picker.prefab == "wickerbottom" then
        for k=1,16 do
            local item = GLOBAL.SpawnPrefab("papyrus")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "waxwell" then
        for k=1,20 do
            local item = GLOBAL.SpawnPrefab("nightmarefuel")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "webber" then
        for k=1,2 do
            local item = GLOBAL.SpawnPrefab("spiderhat")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "wes" then
        local item = GLOBAL.SpawnPrefab("bushhat")
        picker.components.inventory:GiveItem(item)
    end
    if picker.prefab == "winona" then
        for k=1,16 do
            local item = GLOBAL.SpawnPrefab("sewing_tape")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "woodie" then
        for k=1,5 do
            local item = GLOBAL.SpawnPrefab("monsterlasagna")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "wormwood" then
        for k=1,20 do
            local item = GLOBAL.SpawnPrefab("seeds")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "wurt" then
        for k=1,2 do
            local item = GLOBAL.SpawnPrefab("vegstinger_spice_chili")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "warly" then
        for k=1,10 do
            local item = GLOBAL.SpawnPrefab("spice_chili")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "wathgrithr" then
        for k=1,10 do
            local item = GLOBAL.SpawnPrefab("goldnugget")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "wolfgang" then
        for k=1,2 do
            local item = GLOBAL.SpawnPrefab("bonestew")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "wx78" then
        for k=1,2 do
            local item = GLOBAL.SpawnPrefab("gears")
            picker.components.inventory:GiveItem(item)
        end
    end
    if picker.prefab == "walter" then
        for k=1,20 do
            local item = GLOBAL.SpawnPrefab("rocks")
            picker.components.inventory:GiveItem(item)
        end
    end
end

local function needNotice(goods)
    local notice_goods = {
        "eyebrellahat",
        "cane",
        "hivehat",
        "armorskeleton",
        "opalstaff",
        "krampus_sack",
        "beequeen",
        "toadstool",
        "stalker_atrium",
        "stalker",
        "stalker_forest",
        "spat",
        "bearger",
        "warg",
        "dragonfly",
        "moose",
        "minotaur",
        "deerclops",
        "spiderqueen",
        "package_staff",
        "prayer_symbol",
        "minotaurhorn",
        "yellowstaff",
        "greenstaff",
        "orangestaff",
        "eyeturret_item",
        "ruins_bat",
        "armorruins",
        "ruinshat",
        "yellowamulet",
        "panflute",
        "shadowheart",
        "pigtorch",
        "monkeybarrel", -- 猴子桶
        "catcoonden", --中空树桩
        "ruins_statue_mage",
        "moonbase",
        "pigking",
    }
    for i, v in ipairs(notice_goods) do
        if goods == v then 
            return true
        end
    end
    return false
end

local function spawnAtGround(name, x,y,z)
    if GLOBAL.TheWorld.Map:IsPassableAtPoint(x, y, z) then
        local item = GLOBAL.SpawnPrefab(name)
        if item then
            item.Transform:SetPosition(x, y, z)
            item:AddTag("tumbleweeddropped")
            return item
        end
    end
end

local function doSpawnItem(it, target, picker)
    --添加多世界宣告支持
    local picker_name = picker and picker:GetDisplayName() or "???"
    local function resetNotice(...)
        local worldShardId = GLOBAL.TheShard:GetShardId()
        local serverName = ""
        if worldShardId ~= nil and worldShardId ~= "0" then
            serverName = "[" .. GLOBAL.STRINGS.TUM.WORLD .. worldShardId .. "] "
        end
        local msg = picker_name .. GLOBAL.STRINGS.TUM.PICKTUMBLEWEED
        for k ,v in pairs({...}) do
            msg = msg .. " " .. v
        end
        GLOBAL.TheNet:Announce(serverName .. msg)
    end
    local x, y, z = target.Transform:GetWorldPosition()
    if it.trap then
        if picker ~= nil then
            x, y, z = picker.Transform:GetWorldPosition()
        end
        local name = it.item
        if name == "lightningstrike" then
            if GLOBAL.TheWorld:HasTag("cave") then
                -- There's a roof over your head, magic lightning can't strike!
                GLOBAL.TheWorld:PushEvent("ms_miniquake", { rad = 3, num = 5, duration = 1.5, target = picker })
                return
            end
            lightningTarget(picker)
            resetNotice(GLOBAL.STRINGS.TUM.LIGHTING)
            return
        end
        if name == "rock_circle" then
            local num = 7
            --生成冰山/石头山
            local stone_type = "rock_flintless"
            if GLOBAL.TheWorld.state.iswinter then
                stone_type = "rock_ice"
            end
            for k=1,num do
                local angle = k * 2 * PI / num
                spawnAtGround(stone_type, 2*math.cos(angle)+x, y, 2*math.sin(angle)+z)
            end
            removetools(picker)
            resetNotice(GLOBAL.STRINGS.TUM.CIRCLE)
            return
        end
        if name == "sanity_attack" then
            if picker ~= nil and picker.components.sanity ~= nil then
                local san = picker.components.sanity.current or 0
                picker.components.sanity:DoDelta(-san)
            end
            resetNotice(GLOBAL.STRINGS.TUM.SANITY)
            return
        end
        if name == "perish_attack" then
            doperish(picker)
            resetNotice(GLOBAL.STRINGS.TUM.PERISH)
            return
        end
        if name == "broken_attack" then
            removeweapon(picker)
            resetNotice(GLOBAL.STRINGS.TUM.BROKEN)
            return
        end
        if name == "tentacle_circle" then
            local num=7
            for k=1,num do
                local angle = k * 2 * PI / num
                --spawnAtGround("wall_stone", 2*math.cos(angle)+x, y, 2*math.sin(angle)+z)
                keepPickerStop(picker)
                spawnAtGround("tentacle", 3*math.cos(angle)+x, y, 3*math.sin(angle)+z)
            end
            resetNotice(GLOBAL.STRINGS.TUM.TENTACLE_TRAP)
            return
        end
        if name == "boom_circle" then
            local num=10
            for k=1,num do
                local item = spawnAtGround("gunpowder", x,y,z)
                if item then
                    item.components.explosive:OnBurnt()
                end
            end
            resetNotice("BOOM!!!")
        end
        if name == "fire_circle" then
            local num = 8
            for k=1,num do
                local angle = k * 2 * PI / num
                local item = spawnAtGround("wall_hay", 2*math.cos(angle)+x, y, 2*math.sin(angle)+z)
                if item ~= nil then 
                    item.components.burnable:Ignite() 
                end
            end
            resetNotice(GLOBAL.STRINGS.TUM.FIRE_TRAP)
        end
        if name == "season_change" then
            local names = {"spring","summer","autumn","winter"}
            local index = math.random(#names)
            GLOBAL.TheWorld:PushEvent("ms_setseason", names[index])
            resetNotice(GLOBAL.STRINGS.TUM.SEASON_CHANGE)
        end
        if name == "shadow_boss" then
            local item = GLOBAL.SpawnPrefab("shadow_rook")
            item.Transform:SetPosition(x, y, z)
            local s1 = item:GetDisplayName()
            if picker ~= nil then
                item.components.combat:SuggestTarget(picker)
            end
            item = GLOBAL.SpawnPrefab("shadow_knight")
            item.Transform:SetPosition(x, y, z)
            local s2 = item:GetDisplayName()
            if picker ~= nil then
                item.components.combat:SuggestTarget(picker)
            end
            item = GLOBAL.SpawnPrefab("shadow_bishop")
            item.Transform:SetPosition(x, y, z)
            local s3 = item:GetDisplayName()
            if picker ~= nil then
                item.components.combat:SuggestTarget(picker)
            end
            resetNotice(s1, s2, s3)
        end
        if name == "ghost_circle" then
            local num = 6
            for k=1,num do
                local angle = k * 2 * PI / num
                local item = spawnAtGround("ghost", 2*math.cos(angle)+x, y, 2*math.sin(angle)+z)
                if picker ~= nil and item ~= nil then
                    item.components.combat:SuggestTarget(picker)
                end
            end
        end
        if name == "monster_circle" then
            local monster_tb = {"spider", "hound", "firehound", "icehound", "tallbird", "frog", "merm", "bat", "bee"}
            local monster = monster_tb[math.random(#monster_tb)]
            local num = 6
            for k=1,num do
                local angle = k * 2 * PI / num
                local item = spawnAtGround(monster, 2*math.cos(angle)+x, y, 2*math.sin(angle)+z)
                if picker ~= nil and item ~= nil then
                    item.components.combat:SuggestTarget(picker)
                end
            end
        end
        picker:PushEvent("tumbleweedtrap")
        return
    end
    if it.gift then
        local name = it.item
        if name == "tumbleweed_gift" then
            local tum = "tumbleweed"
            local chance = math.random()
            if chance < 0.2 then
                tum = "tumbleweed_3"
            end
            if chance < 0.05 then
                tum = "tumbleweed_4"
            end
            if chance < 0.01 then
                tum = "tumbleweed_5"
            end
            local num=math.random(3,10)
            for k=1,num do
                spawnAtGround(tum, x+math.random()-0.5,y,z +math.random()-0.5)
            end
        end
        if name == "hutch_gift" then
            local has_hq = type(GLOBAL.c_countprefabs)=="function" and GLOBAL.c_countprefabs("hutch_fishbowl", true) or 1
            if has_hq == 0 then
                spawnAtGround("hutch_fishbowl", x,y,z)
            end
        end
        if name == "pond_gift" then
            local names = {"pond","pond_cave"}
            local item = spawnAtGround(names[math.random(#names)], x,y,z)
            resetNotice(item:GetDisplayName())
            picker:PushEvent("tumbleweeddropped", {item = item})
        end
        if name == "plant_gift" then
            local names = {"flower","carrot_planted","cave_fern","red_mushroom","green_mushroom","blue_mushroom","reeds","cactus","lichen"}
            local num=math.random(7,15)
            --生成作物
            for k=1,num do
                local angle = k * 2 * PI / num
                spawnAtGround(names[math.random(#names)] ,5*math.cos(angle)+x, y, 5*math.sin(angle)+z)
            end
            resetNotice(GLOBAL.STRINGS.TUM.PLANT_GIFT)
        end
        if name == "cave_plant_gift" then
            local num=7
            --生成香蕉树
            local names = {"cave_banana_tree","mushtree_medium","mushtree_small","mushtree_tall"}
            local item = spawnAtGround(names[math.random(#names)], x,y,z)
            --生成荧光果草
            names = {"flower_cave_triple", "flower_cave_double", "flower_cave"}
            for k=1,num do
                local angle = k * 2 * PI / num
                local item2 = spawnAtGround(names[math.random(#names)], 2*math.cos(angle)+x, y, 2*math.sin(angle)+z)
                if item2 then item = item2 end
            end
            resetNotice(item:GetDisplayName())
        end
        if name == "bird_gift" then
            local names = {"crow", "robin", "canary", "puffin"}
            local item = nil
            if GLOBAL.TheWorld.state.iswinter then
                item = spawnAtGround("robin_winter", x,y,z)
            else
                item = spawnAtGround(names[math.random(#names)], x,y,z)
            end
            if item then item:PushEvent("gotosleep") end
        end
        if name == "resurrect_gift" then
            local item = spawnAtGround("resurrectionstone", x,y,z)
            resetNotice(item:GetDisplayName())
            picker:PushEvent("tumbleweeddropped", {item = item})
            local num = 4
            for k=1,num do
                local angle = k *2 *PI/num
                spawnAtGround("pighead", 3*math.cos(angle)+x, y, 3*math.sin(angle)+z)
            end
        end
        if name == "ancient_gift" then
            local item = spawnAtGround("ancient_altar", x,y,z)
            resetNotice(item:GetDisplayName())
            picker:PushEvent("tumbleweeddropped", {item = item})
        end
        if name == "cook_gift" then
            local item = spawnAtGround("icebox", x,y,z)
            local num = 6
            for k=1,num do
                local angle = k *2 *PI/num
                spawnAtGround("cookpot", 3*math.cos(angle)+x, y, 3*math.sin(angle)+z)
            end
            resetNotice(GLOBAL.STRINGS.TUM.COOKIE)
        end
        if name == "butterfly_gift" then
            for k=0,math.random(1,10) do
                spawnAtGround("butterfly", x+math.random()-0.5,y,z +math.random()-0.5)
            end
        end
        if name == "player_gift" then
            spawnPlayerGift(picker)
        end
        return 
    end
    local item = spawnAtGround(it.item, x,y,z)
    if it.aggro and item ~= nil and item.components.combat ~= nil and picker ~= nil then
        item.components.combat:SuggestTarget(picker)
    end
    
    if item ~= nil and needNotice(it.item) then
        local item_name = item:GetDisplayName() or "???"
        resetNotice(item_name)
        picker:PushEvent("tumbleweeddropped", {item = item})
    end
    return item
end

--初始化
AddPrefabPostInit(
    "world",
    function(inst)
        if GLOBAL.TheWorld.ismastersim then --判断是不是主机
            local start_protect = TUNING.start_protect --开局保护
            local drop_chance = TUNING.drop_chance --物品掉率

            inst:ListenForEvent("tumbleweedpicked", function(inst, data) 
                local possible_loot = {
                    {chance = 20,   item = "cutgrass"},--草
                    {chance = 15,   item = "twigs"},--小树枝
                }
                local function insertLoot(loot, n)
                    for a,b in ipairs(loot) do
                        --print("old:"..b.chance)
                        local newchance = b.chance * n --重置chance
                        --print("new:"..b.chance)
                        if newchance > 0 then
                            table.insert(possible_loot, {chance=newchance, item=b.item, aggro=b.aggro, trap=b.trap, gift=b.gift})
                        end
                    end
                end

                local today = GLOBAL.TheWorld.state.cycles  --世界天数
                local target = data.target
                local picker = data.picker
                if picker == nil or not picker:HasTag("player") then
                    return
                end
                local x, y, z = target.Transform:GetWorldPosition()

                local playerage = picker.components.age:GetAgeInDays() or 0 --玩家天数
                local san = picker.components and picker.components.sanity and picker.components.sanity:GetPercent() or 0 --san值
                local luck = picker.components and picker.components.luck and picker.components.luck:GetLuck() or 1
                san = math.max(san, 0.05)

                local world_chance = math.floor(today*0.01 + playerage*0.04)
                if picker.components.titlesystem and picker.components.titlesystem.equip == 1 then
                    world_chance = math.floor(playerage*0.04)
                end

                local new_chance = 1
                local s_chance = 1
                local ss_chance = 1
                local d_chance = 1
                local dd_chance = 1

                local lucky_level = target.level or 0
                --print("lucky_level:"..lucky_level)
                if lucky_level == -1 then
                    d_chance = 20 + (world_chance * 2)
                    dd_chance = 10 + world_chance
                elseif lucky_level == -2 then
                    d_chance = 40 + world_chance
                    dd_chance = 50 + (world_chance * 2)
                elseif lucky_level == 1 then
                    new_chance = 40
                    s_chance = 200
                    ss_chance = 200
                elseif lucky_level == 2 then
                    s_chance = 100
                    ss_chance = 200
                    dd_chance = 0
                    d_chance = 0
                elseif lucky_level ==3 then
                    ss_chance = 1000
                    dd_chance = 0
                    d_chance = 0
                else
                    d_chance = 1 + math.min(world_chance, 29)
                    dd_chance = 1 + math.min(world_chance, 19)
                end

                new_chance = new_chance * (luck*0.05 + 1) * san
                s_chance = s_chance * (luck*0.1 + 1) * san
                ss_chance = ss_chance * (luck*0.15 + 1) * san

                insertLoot(loot_table.new_loot, drop_chance*new_chance)
                insertLoot(loot_table.s_loot, drop_chance*s_chance)
                insertLoot(loot_table.ss_loot, drop_chance*ss_chance)
                insertLoot(loot_table.gift_loot, drop_chance*ss_chance)
                if GLOBAL.TheWorld:HasTag("cave") and world_chance > 0 then
                    insertLoot(loot_table.cave_loot, drop_chance*world_chance)
                else
                    insertLoot(loot_table.cave_loot, drop_chance)
                end

                if (not start_protect or playerage >= 3) and lucky_level < 2 then
                    insertLoot(loot_table.d_loot, drop_chance*d_chance)
                    insertLoot(loot_table.dd_loot, drop_chance*dd_chance)
                    insertLoot(loot_table.trap_loot, drop_chance*dd_chance)
                    if TUNING.boss_chance and dd_chance > 0 then
                        insertLoot(loot_table.big_boss_loot, drop_chance*dd_chance)
                        if GLOBAL.TheWorld:HasTag("cave") then
                            insertLoot(loot_table.cave_boss_loot, drop_chance*dd_chance)
                        else
                            insertLoot(loot_table.cave_boss_loot, drop_chance)
                        end
                    end
                end

                if TUNING.new_items then
                    insertLoot(loot_table.new_items_loot, drop_chance*ss_chance)
                end

                local totalchance = 0
                for m, n in ipairs(possible_loot) do
                    totalchance = totalchance + n.chance
                    --print("name:"..n.item..",chance:"..n.chance)
                end

                local num_loots = 1
                local titles = picker.components.titlesystem and picker.components.titlesystem.titles or {}
                local title4 = titles[4] or 0
                local rand = title_data and title_data["title4"]["drop"] or 0
                if title4 == 1 and math.random() < rand then
                    num_loots = num_loots + 1
                end
                if titles[13] == 1 then
                    num_loots = num_loots + 1
                end
                if TUNING.more_blueprint and lucky_level >=2 then
                    spawnAtGround("blueprint", x, y, z)
                    num_loots = num_loots - 1
                end

                local res_loot = {}
                while num_loots > 0 do
                    next_chance = math.random()*totalchance
                    --print("next_chance:"..next_chance)
                    next_loot = nil
                    for m, n in ipairs(possible_loot) do
                        next_chance = next_chance - n.chance
                        --print("n_chance:"..n.chance)
                        if next_chance <= 0 then
                            next_loot = n
                            break
                        end
                    end
                    if next_loot ~= nil then
                        table.insert(res_loot, next_loot)
                        num_loots = num_loots - 1
                    end
                end
                for k,v in pairs(res_loot) do
                    local item = doSpawnItem(v, target, picker)
                    if item == nil or item:HasTag("structure") then
                        break
                    end
                end

            end)
        end
    end
)