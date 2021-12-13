-- 给予玩家初始物品
local start_protect = TUNING.start_protect --开局保护
local vips = TUNING.vips
local more_blueprint = TUNING.more_blueprint
local new_items = TUNING.new_items

--给多少东西给玩家
local function giveItemToPlayer(startInventory, num, prefab_name)
    for i = 1, num do
        table.insert(startInventory, prefab_name)
    end
end

--玩家初始物品（可根据自己需要自行修改）
local function StartingInventory(inst, player)
    local startInventory = {}
    --初始进入的时间是冬天或者临近冬天的时候
    if
        GLOBAL.TheWorld.state.iswinter or
            (GLOBAL.TheWorld.state.isautumn and GLOBAL.TheWorld.state.remainingdaysinseason < 5)
     then
        --额外给的东西
        --giveItemToPlayer(startInventory, 8, "cutgrass")
        --giveItemToPlayer(startInventory, 8, "twigs")
        --giveItemToPlayer(startInventory, 6, "log")
        --giveItemToPlayer(startInventory, 1, "heatrock") --热能石
        giveItemToPlayer(startInventory, 1, "winterhat") --冬帽
        giveItemToPlayer(startInventory, 1, "honeyham") --蜜汁火腿
    end

    --春天
    if
        GLOBAL.TheWorld.state.isspring or
            (GLOBAL.TheWorld.state.iswinter and GLOBAL.TheWorld.state.remainingdaysinseason < 3)
     then
        giveItemToPlayer(startInventory, 1, "umbrella") --雨伞
    end

    --夏天
    if
        GLOBAL.TheWorld.state.issummer or
            (GLOBAL.TheWorld.state.isspring and GLOBAL.TheWorld.state.remainingdaysinseason < 5)
     then
		giveItemToPlayer(startInventory, 8, "ice") --冰
		giveItemToPlayer(startInventory, 1, "icehat") --西瓜帽
    end

    --夜晚
    if GLOBAL.TheWorld.state.isnight or (GLOBAL.TheWorld.state.isdusk and GLOBAL.TheWorld.state.timeinphase > .8) then
        giveItemToPlayer(startInventory, 1, "torch") --火炬
    end

    local days = GLOBAL.TheWorld.state.cycles
    local nums = 1
    if days >= 20 then
        nums = math.min(math.floor(days/20), 10)
        giveItemToPlayer(startInventory, 4 * nums, "cutgrass")
        giveItemToPlayer(startInventory, 4 * nums, "twigs")
        giveItemToPlayer(startInventory, 2 * nums, "log")
        giveItemToPlayer(startInventory, 2 * nums, "rocks")
        --giveItemToPlayer(startInventory, 1 * nums, "flint")
        giveItemToPlayer(startInventory, 1 * nums, "kabobs")
    end
    if days >= 100 then
        nums = math.floor(days/50)
        --giveItemToPlayer(startInventory, 2*nums, "goldnugget")
        --giveItemToPlayer(startInventory, nums, "pigskin")
        --giveItemToPlayer(startInventory, 1, "footballhat_blueprint")
        --giveItemToPlayer(startInventory, 1, "spear_blueprint")
        --giveItemToPlayer(startInventory, 1, "rope")
    end
    if days >= 250 then
        nums = math.floor(days/100)
        --giveItemToPlayer(startInventory, 2*nums, "nightmarefuel")
        --giveItemToPlayer(startInventory, 1, "hambat_blueprint")
        --giveItemToPlayer(startInventory, 1, "amulet_blueprint")
        --giveItemToPlayer(startInventory, 1, "blueamulet_blueprint")
        --giveItemToPlayer(startInventory, 2, "meat")
    end
    if days >= 500 then
        nums = math.floor(days/100)
        --giveItemToPlayer(startInventory, 2*nums, "bandage")
        --giveItemToPlayer(startInventory, 1, "ruinshat")
        giveItemToPlayer(startInventory, 1, "yellowamulet")
    end

    --giveItemToPlayer(startInventory, 1, "meatballs")
    --giveItemToPlayer(startInventory, 5, "healingsalve")
    if more_blueprint then
        giveItemToPlayer(startInventory, 1, "backpack_blueprint")
    end

    --玩家第一次进入时获取初始物品
    local CurrentOnNewSpawn = player.OnNewSpawn or function()
        return true
    end
    player.OnNewSpawn = function(...)
        --PlayerSay(player, GetSayMsg("player_start"), nil, 5)

        player.components.inventory.ignoresound = true
        if startInventory ~= nil and #startInventory > 0 then
            for i, itemName in pairs(startInventory) do
                player.components.inventory:GiveItem(GLOBAL.SpawnPrefab(itemName))
            end
        end
        return CurrentOnNewSpawn(...)
    end
end

local function IsStart(name)
    if not GLOBAL.TheWorld.components.worldstate.data.new_start[name] then
        GLOBAL.TheWorld.components.worldstate.data.new_start[name] = true
        return true
    end
    return false
end

--初始化
AddPrefabPostInit(
    "world",
    function(inst)
        if GLOBAL.TheWorld.ismastersim then --判断是不是主机
            if inst.components.worldstate and inst.components.worldstate.data and inst.components.worldstate.data.new_start == nil then --利用组件保存
                inst.components.worldstate.data.new_start = {} -- 仅第一次进入游戏
            end
            --监听玩家安置，给初始物品
            --if start_protect then
            --    inst:ListenForEvent("ms_playerspawn", StartingInventory, inst)
            --end
            inst:ListenForEvent("ms_playerspawn", function(inst, player)
                if start_protect then
                    StartingInventory(inst, player)
                end

                if new_items then --开启新物品就会给
                    local CurrentOnNewSpawn = player.OnNewSpawn or function() return true end -- 记录角色本身开局物品
                    player.OnNewSpawn = function(...)
                        if IsStart(player.userid) then
                            player.components.inventory.ignoresound = true
                            player.components.inventory:GiveItem(GLOBAL.SpawnPrefab("stealingknife")) --偷窃刀
                        end
                        return CurrentOnNewSpawn(...)
                    end 
                end
            end)

        end
    end
)