env._G = GLOBAL --设置全局表
env.RECIPETABS = GLOBAL.RECIPETABS 
env.AllRecipes = GLOBAL.AllRecipes
env.CUSTOM_RECIPETABS = GLOBAL.CUSTOM_RECIPETABS
env.TECH = GLOBAL.TECH
env.require = GLOBAL.require
env.ACTIONS = GLOBAL.ACTIONS
env.ActionHandler = GLOBAL.ActionHandler
local NODE_TYPE = GLOBAL.NODE_TYPE
local StartThread = GLOBAL.StartThread
local Sleep = GLOBAL.Sleep
local SetSharedLootTable = GLOBAL.SetSharedLootTable

TUNING.start_protect=GetModConfigData("start_protect")--开局保护设置
TUNING.drop_chance=GetModConfigData("drop_chance")--物品掉落率
TUNING.more_blueprint=GetModConfigData("more_blueprint")--蓝图掉落率
TUNING.boss_chance=GetModConfigData("boss_chance")--有无boss
TUNING.new_items = GetModConfigData("new_items")--新物品
local stronger_boss=GetModConfigData("stronger_boss")--boss加强
local worldregrowth_enabled = GetModConfigData("worldregrowth_enabled")--资源再生
local achievement_system = GetModConfigData("achievement_system")--成就系统
TUNING.vips = GetModConfigData("vip")--vip列表
TUNING.vipurl = GetModConfigData("vipurl")

modimport("scripts/asyncworld.lua") -- 执行世界季节不同步 D:\饥荒联机原文件\scripts1\scripts\widgets\redux\characterselect.lua
require 'AllAchiv/allachivbalance'
require 'AllAchiv/titlebalance'
require "loot_table"
modimport("scripts/equipment_cs.lua")


local mlang = _G.LanguageTranslator.defaultlang
if mlang == "zh" or mlang == "chs" then
    modimport("scripts/strings_chs.lua")
else
    modimport("scripts/strings.lua")
end

-------------修改人物描述-------------------------------------------------------------------------------
GLOBAL.GetCharacterDescription = function(herocharacter)
    if herocharacter == "woodie" then
        if GLOBAL.TheNet:GetCountryCode() == "CA" then
            herocharacter = herocharacter.."_canada"
        elseif GLOBAL.TheNet:GetCountryCode() == "US" then
            herocharacter = herocharacter.."_us"
        end
    end
    if GLOBAL.TheNet:GetServerGameMode() == "lavaarena" then
        return GLOBAL.STRINGS.LAVAARENA_CHARACTER_DESCRIPTIONS[herocharacter]
    elseif GLOBAL.TheNet:GetServerGameMode() == "quagmire" then
        return GLOBAL.STRINGS.QUAGMIRE_CHARACTER_DESCRIPTIONS[herocharacter]
    end
    return GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS_MOD[herocharacter] --替换为自己的描述列表
end
-------------修改提示内容-------------------------------------------------------------------------------
local MOD_TIPS = {
    CS_TIPS1 = "掉落物分类：一般、稀有、宝物、怪物、洞穴怪物、精英、巨兽、洞穴巨兽、森林巨兽、彩蛋、陷阱、特殊(即新物品)",
    CS_TIPS2 = "每次开风滚草时，玩家会掉落2个随机物品。",
    CS_TIPS3 = "风滚草掉落物的影响参数：风滚草颜色类型、天数、san值、幸运值、【次元之客】称号",
    CS_TIPS4 = "不同颜色风滚草对不同掉落物类型的影响程度不尽相同。",
    CS_TIPS5 = "随天数增加掉落怪物精英巨兽陷阱概率。天数=世界天数+幸存天数，但玩家佩戴【初出江湖】称号时，天数=幸存天数。",
    CS_TIPS6 = "S当san低于50%时，随san百分比值，降低一般、稀有、宝物、彩蛋、特殊的掉落率。",
    CS_TIPS7 = "幸运值会直接影响一般、稀有、宝物、彩蛋、特殊的掉落率，数值高，掉落率高。",
    CS_TIPS8 = "【次元之客】称号：会使掉落物数量+1。",
    CS_TIPS9 = "说明：彩蛋不是宝物，不被记录开到宝物数里。",
    CS_TIPS10 = "橙色和发光的风滚草，在幸运值大于20时，有5%概率消耗一点幸运，增加1点掉落物",
    CS_TIPS11 = "彩蛋、陷阱、建筑类掉落物品，每个风滚草仅能有其中一种的一项，重复将变为草",
    CS_TIPS12 = "成就页面的前14页为一次性成就，第15页为重复成就。还有一些隐藏成就。",
    CS_TIPS13 = "每完成成就，获得成就点数为奖励，完成当前全部重复成就，可以额外奖励5点成就点数，并刷新重复成就。",
    CS_TIPS14 = "一些指定一次性成就，是解锁称号的必要条件。",
    CS_TIPS15 = "可以按住shift+alt键，同时左击【成就点数 xx 】的星星图案，快捷发送：我的任务进度",
    CS_TIPS16 = "现有13中称号，每次只可佩戴一个称号，会显示在玩家角色的头顶位置。",
    CS_TIPS17 = "每个称号都有对应的需求，满足需求，就解锁了对应的称号，对应位置出现【佩戴】按钮。",
    CS_TIPS18 = "每个称号都有着一些普通功能，即不需要佩戴就可生效，有部分功能仅在佩戴中才有效。",
    CS_TIPS19 = "开局每个角色的幸运值在1~20之间随机。",
    CS_TIPS20 = "开到宝物、彩蛋幸运值将在增加-4~1点。",
    CS_TIPS21 = "可以通过点燃祈祷符，给附近半径2块地皮内全部角色重置幸运值。",
    CS_TIPS22 = "幸运值可以影响风滚草掉落物、偷窃、及其毕业称号的每日奖励，佩戴【天选之子】时也会影响制作武器伤害值。",
    CS_TIPS23 = "屏幕的左下角，有一个”复活“图标，死亡后点击可复活，有冷却cd。",
    CS_TIPS24 = "复活的基础cd180s，每使用一次免费，cd延长5秒。次元之客，减少30%的cd。冷却中，可以通过商店使用成就点数购买复活",
    CS_TIPS25 = "此mod设置了不同世界的季节并不同步。",
    CS_TIPS26 = "能够查看当前角色的各类属性，显示当前等级及其需要的经验，一般而言击杀怪物巨兽才有经验，【悠然自得】称号可通过种植烹饪等行为获取经验。",
    CS_TIPS27 = "每提升2级，会增加角色的饥饿值、san值、生命值上限各1点，机器人另外计算。",
    CS_TIPS28 = "每提升5级奖励1点成就点，基础等级上限是100级，可以通过【等级-强化】来提升等级上限。",
    CS_TIPS29 = "专属成就系统分为4子系统，分别为：查看成就、交换奖励、查看称号、查看等级，共同组成了这个专属成就系统。任何子系统页面可以按Esc键快速关闭。",
    CS_TIPS30 = "交换奖励界面有4页不同的内容，分别是属性、特殊、专属、商店。还有【重置】按钮。",
    CS_TIPS31 = "交换奖励界面前3页可消耗成就点数来换取自身的加强，也是可重置返还成就点数。",
    CS_TIPS32 = "交换奖励界面第4页的商店内容，是不能通过重置来返还成就点数。",
    CS_TIPS33 = "重置是，清空奖励并只返还90%消耗在奖励的成就点数。",
    CS_TIPS34 = "【吸血】对旺达不起作用。",
    CS_TIPS35 = "【书籍阅读】获得阅读书籍的能力，并不能做书籍",
    CS_TIPS36 = "【偷工减料】制作减半，需求材料减半，向下取整",
    CS_TIPS37 = "【彩色护符】耐久没了并不会消失。",
    CS_TIPS38 = "获取成就点数途径并不是只能通过完成成就",
    CS_TIPS39 = "欢迎您的到来，祝您好运！(*￣3￣)╭♡❀小花花砸你-月",
}
GLOBAL.STRINGS.UI.LOADING_SCREEN_OTHER_TIPS = GLOBAL.STRINGS.UI.LOADING_SCREEN_OTHER_TIPS or {}
for k,v in pairs(MOD_TIPS) do
    GLOBAL.STRINGS.UI.LOADING_SCREEN_OTHER_TIPS[k] = v
end

local tipcategorystartweights =
{
    CONTROLS = 0,
    SURVIVAL = 0,
    LORE = 0,
    LOADING_SCREEN = 0,
    OTHER = 0.2,
}

SetLoadingTipCategoryWeights(GLOBAL.LOADING_SCREEN_TIP_CATEGORY_WEIGHTS_START, tipcategorystartweights)

local tipcategoryendweights =
{
    CONTROLS = 0,
    SURVIVAL = 0,
    LORE = 0,
    LOADING_SCREEN = 0,
    OTHER = 0.5,
}
--UM tips are guaranteed on the second tip during the loading screen.
SetLoadingTipCategoryWeights(GLOBAL.LOADING_SCREEN_TIP_CATEGORY_WEIGHTS_END, tipcategoryendweights)
GLOBAL.TheLoadingTips = require("loadingtipsdata")()

-- Recalculate loading tip & category weights.
local TheLoadingTips = GLOBAL.TheLoadingTips
TheLoadingTips.loadingtipweights = TheLoadingTips:CalculateLoadingTipWeights()
TheLoadingTips.categoryweights = TheLoadingTips:CalculateCategoryWeights()

GLOBAL.TheLoadingTips:Load()

---------------------------------------------------------------------------------------------------
if TUNING.new_items then
    PrefabFiles =
    {
        "package_ball",
        "package_staff",
        "prayer_symbol",
        "opalgemsamulet",
        "stealingknife",
        "statusclock",
        "fatemod",
    }
else
    PrefabFiles = {}
end

--兼容老版本
if stronger_boss == true then
    stronger_boss = 1
end
if stronger_boss == false then
    stronger_boss = 0
end

_G.TUMBLEWEED_5_NUM=nil


_G.GetTableLength = function(tab)
    local count = 0
    if type( tab ) ~= "table" then
        return 0
    end
    for k, v in pairs( tab ) do
        count = count + 1
    end
    return count
end

_G.TableToStr = function(t)
    if t == nil then return "" end
    local retstr= "{"

    local i = 1
    for key,value in pairs(t) do
        local signal = ","
        if i==1 then
          signal = ""
        end

        if key == i then
            retstr = retstr..signal.._G.ToStringEx(value)
        else
            if type(key)=='number' or type(key) == 'string' then
                retstr = retstr..signal..'['.._G.ToStringEx(key).."]=".._G.ToStringEx(value)
            else
                if type(key)=='userdata' then
                    retstr = retstr..signal.."*s".._G.TableToStr(_G.getmetatable(key)).."*e".."=".._G.ToStringEx(value)
                else
                    retstr = retstr..signal..key.."=".._G.ToStringEx(value)
                end
            end
        end

        i = i+1
    end

     retstr = retstr.."}"
     return retstr
end

_G.ToStringEx = function(value)
    if type(value)=='table' then
       return _G.TableToStr(value)
    elseif type(value)=='string' then
        return "\'"..value.."\'"
    else
       return tostring(value)
    end
end

-- 自动换皮服
GLOBAL.SetSpellCB = function(target,player)
    if target == nil or not target:IsValid() then return false end
    -- player = player or target.components.inventorytarget.owner --没有就在看是否存在持有者,要加变胡子彩蛋？
    local target_types = {}
    if GLOBAL.PREFAB_SKINS[target.prefab] ~= nil then
        for _,target_type in pairs(GLOBAL.PREFAB_SKINS[target.prefab]) do
            if GLOBAL.TheInventory:CheckClientOwnership(player.userid, target_type) then
                table.insert(target_types,target_type)
            end
        end
    end
    if #target_types<=0 then
        return false
    end
    GLOBAL.TheSim:ReskinEntity( target.GUID, target.skinname, target_types[math.random(#target_types)], nil, player.userid ) --玩家有的随机物品皮肤
end

-- 开启新物品后，彩色护符存在
if TUNING.new_items then
    AddPrefabPostInit("world",function(inst)
        if not GLOBAL.TheWorld.ismastersim then
            return inst
        end
        --不需要被保存，每次开始游戏时，都会重新生成
        inst.tumbleweed_5 = {}
        local function AddTumbleweed_5(inst,data)
            if not inst.tumbleweed_5[data.tumbleweed.GUID] then
                inst.tumbleweed_5[data.tumbleweed.GUID] = data.tumbleweed
            end
        end
        local function RemoveTumbleweed_5(inst,data)
            inst.tumbleweed_5[data.tumbleweed.GUID] = nil
        end
        inst:DoTaskInTime(0,function(inst)
            inst:ListenForEvent("Atumbleweed_5",AddTumbleweed_5)
            inst:ListenForEvent("Rtumbleweed_5",RemoveTumbleweed_5)
        end)
    end)
end
--控制台指令
--c_teleport(0,0,0, ThePlayer)

local function ResetBoss(stronger_health, stronger_speed, stronger_attack,stronger_period,stronger_aoe)
    --ResetBoss(2.25, 2.5, 1.25, 1.2, 4)
	stronger_health = 1 + math.min(stronger_health, 2)
	stronger_speed = math.min(stronger_speed, 3)
	stronger_attack = 1 + math.min(stronger_attack, 1)
	stronger_period = math.min(stronger_period, 1.5)
    stronger_aoe = math.min(stronger_aoe, 5)

	--春鸭
	TUNING.MOOSE_HEALTH = 3000 * 2 * stronger_health
    TUNING.MOOSE_DAMAGE = 150 * stronger_attack
    TUNING.MOOSE_ATTACK_PERIOD = 3 - stronger_period
    TUNING.MOOSE_ATTACK_RANGE = 5.5 + stronger_aoe * 0.2
    TUNING.MOOSE_WALK_SPEED = 8 + stronger_speed * 2
    TUNING.MOOSE_RUN_SPEED = 12 + stronger_speed * 3
    --冬鹿
	TUNING.DEERCLOPS_HEALTH = 2000 * 2 * stronger_health -- harder for multiplayer
    TUNING.DEERCLOPS_DAMAGE = 150 * stronger_attack
    TUNING.DEERCLOPS_DAMAGE_PLAYER_PERCENT = .5
    TUNING.DEERCLOPS_ATTACK_PERIOD = 4 - stronger_period * 1.5
    TUNING.DEERCLOPS_ATTACK_RANGE = 8 + stronger_aoe*1.5
    TUNING.DEERCLOPS_AOE_RANGE = 6 + stronger_aoe
   	TUNING.DEERCLOPS_AOE_SCALE = 0.8
   	--秋熊
   	TUNING.BEARGER_HEALTH = 3000 * 2 * stronger_health -- harder for multiplayer
    TUNING.BEARGER_DAMAGE = 200 * stronger_attack
    TUNING.BEARGER_ATTACK_PERIOD = 3 - stronger_period
    TUNING.BEARGER_MELEE_RANGE = 6 + stronger_aoe
    TUNING.BEARGER_ATTACK_RANGE = 6 + stronger_aoe * 0.5
    TUNING.BEARGER_CALM_WALK_SPEED = 3 + stronger_speed
    TUNING.BEARGER_ANGRY_WALK_SPEED = 6 + stronger_speed * 1.5
    TUNING.BEARGER_RUN_SPEED = 10 + stronger_speed *2
    --夏蝇
    TUNING.DRAGONFLY_HEALTH = 27500 * 1.5
    TUNING.DRAGONFLY_DAMAGE = 150 * stronger_attack
    TUNING.DRAGONFLY_ATTACK_PERIOD = 4 - stronger_period
    TUNING.DRAGONFLY_ATTACK_RANGE = 4 + stronger_aoe * 0.5
    TUNING.DRAGONFLY_HIT_RANGE = 5 + stronger_aoe * 0.5
    TUNING.DRAGONFLY_SPEED = 5 + stronger_speed

    TUNING.DRAGONFLY_FIRE_ATTACK_PERIOD = 3 - stronger_period
    TUNING.DRAGONFLY_FIRE_DAMAGE = 300 * stronger_attack
    TUNING.DRAGONFLY_FIRE_HIT_RANGE = 6 + stronger_aoe * 1.5
    TUNING.DRAGONFLY_FIRE_SPEED = 7 + stronger_speed*1.5
    --犀牛
    TUNING.MINOTAUR_DAMAGE = 100 * stronger_attack
    TUNING.MINOTAUR_HEALTH = 2500 * 4 * stronger_health
    TUNING.MINOTAUR_ATTACK_PERIOD = 2 - stronger_period
    TUNING.MINOTAUR_WALK_SPEED = 5 + stronger_speed
    TUNING.MINOTAUR_RUN_SPEED = 17 + stronger_speed * 3
    TUNING.MINOTAUR_TARGET_DIST = 25
    --蜂王
    TUNING.BEEQUEEN_HEALTH = 22500 * 1.5
    TUNING.BEEQUEEN_DAMAGE = 120 * stronger_attack
    TUNING.BEEQUEEN_ATTACK_PERIOD = 2 - stronger_period
    TUNING.BEEQUEEN_ATTACK_RANGE = 4 + stronger_aoe * 0.5
    TUNING.BEEQUEEN_HIT_RANGE = 6 + stronger_aoe * 0.6
    TUNING.BEEQUEEN_SPEED = 4 + stronger_speed
    --klaus克劳斯
    TUNING.KLAUS_HEALTH = 10000 * 2
    TUNING.KLAUS_HEALTH_REGEN = 25 * stronger_attack --per second (only when not in combat)
    TUNING.KLAUS_HEALTH_REZ = .5
    --TUNING.KLAUS_DAMAGE = 75 * stronger_attack
    --TUNING.KLAUS_ATTACK_PERIOD = 3 - stronger_period
    TUNING.KLAUS_ATTACK_RANGE = 3 + stronger_aoe * 0.5
    TUNING.KLAUS_HIT_RANGE = 4 + stronger_aoe * 0.5
    TUNING.KLAUS_SPEED = 2.75 + stronger_speed
    --骨架
    TUNING.STALKER_HEALTH = 4000 * stronger_health
    TUNING.STALKER_DAMAGE = 200 * stronger_attack
    TUNING.STALKER_ATTACK_PERIOD = 4 - stronger_period
    TUNING.STALKER_ATTACK_RANGE = 2.4 + stronger_aoe
    TUNING.STALKER_HIT_RANGE = 3.8 + stronger_aoe * 0.5
    TUNING.STALKER_AOE_RANGE = 2 + stronger_aoe * 0.5
    TUNING.STALKER_AOE_SCALE = .8
    TUNING.STALKER_SPEED = 4.2 + stronger_speed
    --影织者
    TUNING.STALKER_ATRIUM_HEALTH = 16000 * 2
    TUNING.STALKER_ATRIUM_PHASE2_HEALTH = 10000 * stronger_health
    TUNING.STALKER_ATRIUM_ATTACK_PERIOD = 3 - stronger_period
    --蘑菇蛤
    TUNING.TOADSTOOL_HEALTH = 52500 * 1
    TUNING.TOADSTOOL_ATTACK_RANGE = 7 + stronger_aoe
    TUNING.TOADSTOOL_EPICSCARE_RANGE = 10 + stronger_aoe * 1.5
    --[[TUNING.TOADSTOOL_SPEED_LVL =
    {
        [0] = .6 + stronger_speed,
        [1] = .8 + stronger_speed,
        [2] = 1.2 + stronger_speed,
        [3] = 3.2 + stronger_speed,
    }
    TUNING.TOADSTOOL_DAMAGE_LVL =
    {
        [0] = 100 * stronger_attack,
        [1] = 120 * stronger_attack,
        [2] = 150 * stronger_attack,
        [3] = 250 * stronger_attack,
    }
    TUNING.TOADSTOOL_ATTACK_PERIOD_LVL =
    {
        [0] = 3.5 - stronger_period,
        [1] = 3 - stronger_period,
        [2] = 2.5 - stronger_period,
        [3] = 2 - stronger_period,
    }
    --]]

    --蚁狮
    TUNING.ANTLION_HEALTH = 6000 * stronger_health
    TUNING.ANTLION_MAX_ATTACK_PERIOD = 4 *0.5
    TUNING.ANTLION_MIN_ATTACK_PERIOD = 2 *0.5
    TUNING.ANTLION_SPEED_UP = -.2
    TUNING.ANTLION_SLOW_DOWN = .4
    TUNING.ANTLION_CAST_RANGE = 15 + stronger_aoe*2
    TUNING.ANTLION_CAST_MAX_RANGE = 20 + stronger_aoe *4
    TUNING.ANTLION_WALL_CD = 20 * 0.5
    TUNING.ANTLION_HIT_RECOVERY = 1
    TUNING.ANTLION_EAT_HEALING = 200

    --恐怖之眼
    TUNING.EYEOFTERROR_HEALTH = 5000 * 2 * stronger_health
    TUNING.EYEOFTERROR_DAMAGE = 125 * stronger_attack
    TUNING.EYEOFTERROR_MINI_ATTACK_PERIOD = 3 - stronger_period

    

    TUNING.SHADOW_ROOK =
    {
        LEVELUP_SCALE = {1, 1.2, 1.6},
        SPEED = 7 + 3,                          -- levels are procedural
        HEALTH = {1000, 4000, 10000},
        DAMAGE = {45, 100, 165},
        ATTACK_PERIOD = {6-2, 5.5-2, 5-2},
        ATTACK_RANGE = 8 + 4,                   -- levels are procedural
        HIT_RANGE = 3.35 + 2,
        RETARGET_DIST = 15,
    }

    TUNING.SHADOW_KNIGHT =
    {
        LEVELUP_SCALE = {1, 1.7, 2.5},
        SPEED = {7, 9, 12},
        HEALTH = {900, 2700, 8100},
        DAMAGE = {40, 90, 150},
        ATTACK_PERIOD = {3, 2.5, 2},
        ATTACK_RANGE = 2.3+2,                 -- levels are procedural
        ATTACK_RANGE_LONG = 4.5+2,            -- levels are procedural
        RETARGET_DIST = 15,
    }

    TUNING.SHADOW_BISHOP =
    {
        LEVELUP_SCALE = {1, 1.6, 2.2},
        SPEED = 3+3,                          -- levels are procedural
        HEALTH = {800, 2500, 7500},
        DAMAGE = {20*2, 35*2, 60*2},
        ATTACK_PERIOD = {15-2, 14-4, 12-6},
        ATTACK_RANGE = {4*1.5, 6*1.5, 8*1.5},           -- levels are procedural
        HIT_RANGE = 1.75,
        ATTACK_TICK = .5,
        ATTACK_START_TICK = .2,
        RETARGET_DIST = 15,
    }

    --其他生物，仅调整hp和attack
    TUNING.SPAT_HEALTH = 800 * math.min(stronger_health, 1.5)
    TUNING.SPAT_MELEE_DAMAGE = 60 * math.min(stronger_attack, 1.5)
    --树精
    TUNING.LEIF_HEALTH = 2000 * 1.5 * math.min(stronger_health, 1.5)
    TUNING.LEIF_DAMAGE = 150 * math.min(stronger_attack, 1.5)
    --蜘蛛
    TUNING.SPIDER_HEALTH = 100 * math.min(stronger_health, 1.5)
    TUNING.SPIDER_DAMAGE = 20 * math.min(stronger_attack, 1.5)
    TUNING.SPIDER_WARRIOR_HEALTH = 200 * 2 * math.min(stronger_health, 1.5)
    TUNING.SPIDER_WARRIOR_DAMAGE = 20 * math.min(stronger_attack, 1.5)
    TUNING.SPIDER_HIDER_HEALTH = 150 * 1.5 * math.min(stronger_health, 1.5)
    TUNING.SPIDER_HIDER_DAMAGE = 20 * math.min(stronger_attack, 1.5)
    TUNING.SPIDER_SPITTER_HEALTH = 175 * 2 * math.min(stronger_health, 1.5)
    TUNING.SPIDER_SPITTER_DAMAGE_MELEE = 20 * math.min(stronger_attack, 1.5)
    TUNING.SPIDER_MOON_HEALTH = 250 * math.min(stronger_health, 1.5)
	TUNING.SPIDER_MOON_DAMAGE = 25 * math.min(stronger_attack, 1.5)
	--猎犬
	TUNING.HOUND_HEALTH = 150 * math.min(stronger_health, 1.5)
    TUNING.HOUND_DAMAGE = 20 * math.min(stronger_attack, 1.5)
    TUNING.FIREHOUND_HEALTH = 100 * math.min(stronger_health, 1.5)
    TUNING.FIREHOUND_DAMAGE = 30 * math.min(stronger_attack, 1.5)
    TUNING.ICEHOUND_HEALTH = 100 * math.min(stronger_health, 1.5)
    TUNING.ICEHOUND_DAMAGE = 30 * math.min(stronger_attack, 1.5)
    --蠕虫
    TUNING.WORM_DAMAGE = 75 * math.min(stronger_attack, 1.5)
    TUNING.WORM_HEALTH = 900 * math.min(stronger_health, 1.5)
    --触手
    TUNING.TENTACLE_DAMAGE = 34 * math.min(stronger_attack, 1.5)
    TUNING.TENTACLE_HEALTH = 500 * math.min(stronger_health, 1.5)
    --鱼人
    TUNING.MERM_DAMAGE = 30 * math.min(stronger_attack, 1.5)
    TUNING.MERM_HEALTH = 250 * 2 * math.min(stronger_health, 1.5)
    --高鸟
    TUNING.TALLBIRD_HEALTH = 400 * 2 * math.min(stronger_health, 1.5)
    TUNING.TALLBIRD_DAMAGE = 50 * math.min(stronger_attack, 1.5)
    --青蛙
    TUNING.FROG_HEALTH = 100 * math.min(stronger_health, 1.5)
    TUNING.FROG_DAMAGE = 10 * math.min(stronger_attack, 1.5)
    --海象
    TUNING.WALRUS_DAMAGE = 33 * math.min(stronger_attack, 1.5)
    TUNING.WALRUS_HEALTH = 150 * 2 * math.min(stronger_health, 1.5)
    --缀食者
    TUNING.SLURPER_HEALTH = 200 * math.min(stronger_health, 1.5)
    TUNING.SLURPER_DAMAGE = 30 * math.min(stronger_attack, 1.5)
    --企鹅
    TUNING.PENGUIN_DAMAGE = 33 * math.min(stronger_attack, 1.5)
    TUNING.PENGUIN_HEALTH = 150 * math.min(stronger_health, 1.5)
    --发条骑士
    TUNING.KNIGHT_DAMAGE = 40 * math.min(stronger_attack, 1.5)
    TUNING.KNIGHT_HEALTH = 300 * 3 * math.min(stronger_health, 1.5)
    --发条战车
    TUNING.ROOK_DAMAGE = 45 * math.min(stronger_attack, 1.5)
    TUNING.ROOK_HEALTH = 300 * 3 * math.min(stronger_health, 1.5)
    --发条主教
    TUNING.BISHOP_DAMAGE = 40 * math.min(stronger_attack, 1.5)
    TUNING.BISHOP_HEALTH = 300 * 3 * math.min(stronger_health, 1.5)
    --邪天翁
    TUNING.MALBATROSS_HEALTH = 2500 * 2 * stronger_health
    TUNING.MALBATROSS_DAMAGE = 150 * stronger_attack
    --帝王蟹
    TUNING.CRABKING_HEALTH = 20000 * 2 * stronger_health
    TUNING.CRABKING_DAMAGE = 150 * stronger_attack
    TUNING.CRABKING_CLAW_HEALTH = 500 * 2 *stronger_health
    TUNING.CRABKING_CLAW_HEALTH_BOOST = 50 * 2 * stronger_health
    TUNING.CRABKING_ATTACK_RANGE = 7
    TUNING.CRABKING_AOE_RANGE = 4
    TUNING.CRABKING_CLAW_PLAYER_DAMAGE = 30
    TUNING.CRABKING_ATTACK_PERIOD = 2
    TUNING.CRABKING_FREEZE_RANGE = 12
    TUNING.CRABKING_REGEN = 800
    TUNING.CRABKING_REGEN_BUFF = 150
    TUNING.CRABKING_CLAW_RESPAWN_DELAY = 15
    TUNING.CRABKING_CLAW_REGEN_DELAY = 3
    TUNING.CRABKING_CLAW_WALK_SPEED = 2
    TUNING.CRABKING_CLAW_RUN_SPEED = 5
    TUNING.CRABKING_CAST_TIME = 5
    --天体英雄1
    TUNING.ALTERGUARDIAN_PHASE1_WALK_SPEED = 5 + stronger_speed
    TUNING.ALTERGUARDIAN_PHASE1_HEALTH = 10000 *1.15 * stronger_health
    TUNING.ALTERGUARDIAN_PHASE1_ROLLDAMAGE = 166.67 * stronger_attack
    TUNING.ALTERGUARDIAN_PHASE1_AOEDAMAGE = 66.67 * stronger_attack
    TUNING.ALTERGUARDIAN_PHASE1_ATTACK_PERIOD = 7.5 - stronger_period
    TUNING.ALTERGUARDIAN_PHASE1_ROLLCOOLDOWN = 8.5 - stronger_period
    TUNING.ALTERGUARDIAN_PHASE1_MINROLLCOUNT = 4
    TUNING.ALTERGUARDIAN_PHASE1_SUMMONCOOLDOWN = 15
    TUNING.ALTERGUARDIAN_PHASE1_TARGET_DIST = 25
    TUNING.ALTERGUARDIAN_PHASE1_SHIELDABSORB = 0.85
    --天体英雄2
    TUNING.ALTERGUARDIAN_PHASE2_WALK_SPEED = 4.5 + stronger_speed
    TUNING.ALTERGUARDIAN_PHASE2_MAXHEALTH = 20000 *1.25* stronger_health
    TUNING.ALTERGUARDIAN_PHASE2_STARTHEALTH = 13000 *1.25 * stronger_health
    TUNING.ALTERGUARDIAN_PHASE2_DAMAGE = 133.33 * stronger_attack
    TUNING.ALTERGUARDIAN_PHASE2_ATTACK_PERIOD = 6 - stronger_period
    TUNING.ALTERGUARDIAN_PHASE2_CHOP_RANGE = 4.5 + stronger_aoe
    TUNING.ALTERGUARDIAN_PHASE2_SPIN_RANGE = 18 + stronger_aoe
    TUNING.ALTERGUARDIAN_PHASE2_SPIN_SPEED = 8.5
    TUNING.ALTERGUARDIAN_PHASE2_SPINCD = 14.25 - stronger_period
    TUNING.ALTERGUARDIAN_PHASE2_SPIKEDAMAGE = 50 * stronger_attack
    TUNING.ALTERGUARDIAN_PHASE2_SUMMONCOOLDOWN = 24.25 - stronger_period
    --天体英雄3
    TUNING.ALTERGUARDIAN_PHASE3_WALK_SPEED = 7.5 + stronger_speed
    TUNING.ALTERGUARDIAN_PHASE3_MAXHEALTH = 22500 *1.25* stronger_health
    TUNING.ALTERGUARDIAN_PHASE3_STARTHEALTH = 14000 *1.25 * stronger_health
    TUNING.ALTERGUARDIAN_PHASE3_DAMAGE = 150 * stronger_attack
    TUNING.ALTERGUARDIAN_PHASE3_LASERDAMAGE = 120 * stronger_attack
    TUNING.ALTERGUARDIAN_PHASE3_ATTACK_PERIOD = 5 - stronger_period
    TUNING.ALTERGUARDIAN_PHASE3_SUMMONCOOLDOWN = 45 - stronger_period
    TUNING.ALTERGUARDIAN_PHASE3_ATTACK_RANGE = 14 + stronger_aoe
    TUNING.ALTERGUARDIAN_PHASE3_TRAP_MINRANGE = 2.0 + stronger_aoe

    TUNING.MOSSLING_HEALTH = 5000

end

-- 增加血量，不然使用的是饥荒原本的TUNING.EYEOFTERROR_HEALTH值
AddPrefabPostInit("twinofterror1",function(inst)
    if inst.components and inst.components.health then
        inst.components.health:SetMaxHealth(TUNING.EYEOFTERROR_HEALTH*1.5)
    end
end)
AddPrefabPostInit("twinofterror2",function(inst)
    if inst.components and inst.components.health then
        inst.components.health:SetMaxHealth(TUNING.EYEOFTERROR_HEALTH*1.5)
    end
end)

--boss强化
local function UpdateBoss()
    --添加多世界宣告支持
    local function resetNotice(msg)
        local worldShardId = _G.TheShard:GetShardId()
        local serverName = ""
        if worldShardId ~= nil and worldShardId ~= 0 then
            serverName ="[" ..  _G.STRINGS.TUM.WORLD .. worldShardId .. "] "
        end
        return serverName .. msg
    end
    if stronger_boss == 1 then
    	local days = _G.TheWorld.state.cycles  --世界天数
    	if days >= 100 then
    		local ex_days = days - 100
    		if math.fmod(ex_days, 20)==0 then
    			_G.TheNet:Announce(resetNotice(_G.STRINGS.TUM.BOSSUPDATED))
    		end
    		local stronger_health = math.floor(ex_days/20) * 0.01  	--HP增加倍率
    		local stronger_speed = math.floor(ex_days/80) *	0.05	--speed增加固定值
    		local stronger_attack = math.floor(ex_days/50) * 0.05	--attack增加倍率
    		local stronger_period = math.floor(ex_days/250)	* 0.25	--attack频率
    		ResetBoss(stronger_health, stronger_speed, stronger_attack, stronger_period, 0)
    	end
    elseif stronger_boss == 2 then
        local days = _G.TheWorld.state.cycles  --世界天数
        if days >= 20 then
            local ex_days = days - 20
            if math.fmod(ex_days, 10)==0 then
                _G.TheNet:Announce(resetNotice(_G.STRINGS.TUM.BOSSUPDATED))
            end
            local stronger_health = math.floor(ex_days/10) * 0.02   --HP增加倍率
            local stronger_speed = math.floor(ex_days/60) * 0.07    --speed增加固定值
            local stronger_attack = math.floor(ex_days/30) * 0.07   --attack增加倍率
            local stronger_period = math.floor(ex_days/100) * 0.25  --attack频率
            ResetBoss(stronger_health, stronger_speed, stronger_attack, stronger_period, 1)
        end
    elseif stronger_boss == 3 then
         ResetBoss(2.25, 2.5, 1.25, 1.2, 4)
    end
end

local function getrandomposition(caster)
    local ground = _G.TheWorld
    local centers = {}
    for i, node in ipairs(ground.topology.nodes) do
        if ground.Map:IsPassableAtPoint(node.x, 0, node.y) and node.type ~= NODE_TYPE.SeparatedRoom then
            table.insert(centers, {x = node.x, z = node.y})
        end
    end
    if #centers > 0 then
        local pos = centers[math.random(#centers)]
        return Point(pos.x, 0, pos.z)
    else
        return caster:GetPosition()
    end
end

local function sendtorandomposition(item)
    local pos = getrandomposition(item)
    item.Transform:SetPosition(pos.x, 0, pos.z)
end

local function OnEntityDropLoot(world, data)
    local inst = data.inst
    if inst.components.health ~= nil and inst.components.health.maxhealth > 9999 then
        if inst.prefab == "stalker_atrium" and not inst:IsNearAtrium() then
            return
        end
        if inst.prefab == "stalker" or inst.prefab == "stalker_forest" then
            return
        end
        if TUNING.new_items and achievement_system then 
            local loot = {}
            if math.random() < 0.01 then
                table.insert(loot, "prayer_symbol")
            end
            if math.random() < 0.01 then
                table.insert(loot, "potion_achiv")
            end
            if math.random() < 0.015 then
                table.insert(loot, "potion_blue")
            end
            if math.random() < 0.02 then
                table.insert(loot, "potion_green")
            end
            if math.random() < 0.01 then
                table.insert(loot, "potion_lucky")
            end
            if inst.prefab == "klaus" then
                if inst.enraged then
                    table.insert(loot, "prayer_symbol")
                    table.insert(loot, "prayer_symbol")
                    table.insert(loot, "prayer_symbol")
                    table.insert(loot, "package_staff")
                    table.insert(loot, "achiv_clear")
                end
            end
            if #loot > 0 then
                inst.components.lootdropper:SpawnLootPrefab(loot[math.random(#loot)])
            end
        end
        if TUNING.more_blueprint and math.random() < 0.1 then
            inst.components.lootdropper:SpawnLootPrefab("blueprint")
        end
    end
    if inst.prefab == "little_walrus" and TUNING.new_items and math.random() < 0.15 then
        inst.components.lootdropper:SpawnLootPrefab("prayer_symbol")
    end
end

local monster_prefabs = {
    "spider",--蜘蛛
    "frog",--青蛙
    "bee",--蜜蜂 
    "killerbee",--杀人蜂
    "mosquito",--蚊子
    "beefalo",--牛
    "lightninggoat",--闪电羊
    "pigman",--猪人
    "pigguard",--猪人守卫
    "bunnyman",--兔人
    "merm",--鱼人
    "spider_warrior",--蜘蛛战士
    "spider_dropper",--蜘蛛
    "spider_moon",--蜘蛛
    "spider_hider",--蜘蛛
    "spider_spitter",--蜘蛛
    "spider_water",--海黾
    "grassgator",--草鳄鱼
    "spiderqueen",--蜘蛛女王
    "hound",--猎狗
    "firehound",--火狗
    "icehound",--冰狗
    "leif",--树精
    "leif_sparse",--稀有树精
    "walrus",--海象
    "little_walrus",--小海象
    "tallbird",--高鸟
    "koalefant_summer",--夏象
    "koalefant_winter",--冬象
    "bat",--蝙蝠
    "squid",--鱿鱼
    "molebat",--裸鼹鼠蝙蝠
    --"rocky",--石虾
    "monkey",--猴子
    "knight",--发条骑士
    "knight_nightmare",
    "bishop",--发条主教
    "bishop_nightmare",
    "rook",--发条战车
    "rook_nightmare",
    "deerclops",--巨鹿
    "minotaur",--远古守护者
    "worm",--洞穴蠕虫
    "krampus",--小偷
    "moose",--鹿鸭
    "mossling",--小鸭
    "dragonfly",--龙蝇
    "warg",--座狼
    "bearger",--熊大
    "toadstool",--蘑菇蛤
    "beequeen",--蜂后
    "spat",--钢羊
    "shadow_rook",--暗影战车
    "shadow_knight",--暗影骑士
    "shadow_bishop",--暗影主教
    "slurtle", -- 蜗牛1
    "snurtle", -- 蜗牛2
    "slurper", -- slurper
    "penguin", -- 企鹅
    "catcoon", --猫
    "stalker", --地洞复活的骨架
    "stalker_atrium", --远古影织者
    "stalker_forest", --森林守护者
    "perd",--火鸡
    "antlion",--蚁狮
    "buzzard", --秃鹰
    "malbatross",--邪天翁
    "crabking",--帝王蟹
    "alterguardian_phase1",--天体英雄1
    "alterguardian_phase2",
    "alterguardian_phase3",
    "eyeofterror", --恐怖之眼
    "twinofterror1", --机械之眼1
    "twinofterror2", --机械之眼2
 
    --神话boss
    "blackbear", --黑风
    "rhino3_red",--三兄弟
    "rhino3_blue",
    "rhino3_yellow",
    "myth_goldfrog",--金蛤蟆
}

if _G.TheNet:GetIsServer() or _G.TheNet:IsDedicated() then
	modimport("scripts/player_start.lua")
    modimport("scripts/tumbleweed_pick.lua")
	--boss强化
	if stronger_boss ~= nil and stronger_boss > 0 then 
	    AddPrefabPostInit(
	        "world",
	        function(inst)
	        	UpdateBoss()
                if stronger_boss == 1 then
                    inst:DoPeriodicTask(1 * TUNING.TOTAL_DAY_TIME, UpdateBoss)   
                end
                -- 新添加物品掉落
                if TUNING.new_items then
                    inst:ListenForEvent("entity_droploot", OnEntityDropLoot)
                end
	        end
	    )
	end

    if stronger_boss == 2 then
        for k,v in pairs(monster_prefabs) do
            AddPrefabPostInit(v, function(inst)
                if inst.components.health ~= nil and inst.components.health.regen == nil then
                    local regen_health = 8
                    local regen_period = 2
                    local max_health = inst.components.health.maxhealth
                    if max_health > 1999 then
                        regen_health = 2--25
                    end
                    if max_health > 9999 then
                        regen_health = 15--50
                    end
                    inst.components.health:StartRegen(regen_health, regen_period, false)
                end
                local x,y,z = inst.Transform:GetWorldPosition()
                if (inst.components.health ~= nil and inst.components.health.maxhealth > 4999) then
                    inst:ListenForEvent("attacked", function(inst, data)
                        if data.attacker ~= nil then
                            if data.attacker:HasTag("player") then
                                if inst.components.health:GetPercent() < 0.6 and inst.components.health:GetPercent() > 0.1 then
                                    if inst.components.health.maxhealth > 1999 then
                                        local extra_att = math.random()
                                        if extra_att < 0.02 then
                                            data.attacker:StartThread(function()
                                                local pos = data.attacker:GetPosition()
                                                _G.TheWorld:PushEvent("ms_sendlightningstrike", pos) --触发天气事件，生成雷劈
                                            end)
                                        elseif extra_att < 0.05 then
                                            data.attacker:StartThread(function()
                                                local pos = data.attacker:GetPosition()
                                                GLOBAL.SpawnPrefab("alterguardian_phase3trapprojectile").Transform:SetPosition(pos.x, pos.y, pos.z)
                                            end)
                                        elseif extra_att < 0.1 then
                                            if data.attacker.components.moisture ~= nil then --潮湿度5
                                                data.attacker.components.moisture:DoDelta(5)
                                            end
                                        elseif extra_att < 0.15 then
                                            if data.attacker.components.sanity ~= nil then --降低理智
                                                data.attacker.components.sanity:DoDelta(-5)
                                            end
                                        end
                                    end
                                    if math.random() < 0.01 and inst:IsNear(data.attacker, 13) and not inst:IsNear(data.attacker, 3) then
                                        local px, py, pz = data.attacker.Transform:GetWorldPosition()
                                        --想到更好的处理方案再说
                                        --inst.Transform:SetPosition(px, py, pz)
                                    end
                                end
                            elseif data.attacker.components.health and data.attacker.components.health.maxhealth > 9999 then --更换目标,boss不能互相打起来
                                if inst.components.health:GetPercent() < 0.7 then
                                    
                                    local ents = TheSim:FindEntities(x,y,z, 90, nil,nil, {"player"})
                                    local has_target = false
                                    for k,v in pairs(ents) do
                                        inst.components.combat:SuggestTarget(v)
                                        has_target = true
                                        break
                                    end
                                    if not has_target and inst.components.sleeper ~= nil then
                                        sendtorandomposition(data.attacker)
                                        --inst.components.sleeper:GoToSleep(1 + math.random() * 4)
                                    end
                                end
                            end
                        end
                    end)
                    inst:ListenForEvent("healthdelta", function(inst, data) 
                        if inst.components.health:GetPercent() < 0.05 then
                            if inst.components.health.absorb == 0 then
                                inst.components.health.absorb = 0.5
                                inst:AddTag("absorbadd")
                            end
                        else
                            if inst:HasTag("absorbadd") then
                                inst.components.health.absorb = 0
                                inst:RemoveTag("absorbadd")
                            end
                        end
                    end)

                end
                if v == "klaus" then
                    inst:ListenForEvent("killed", function(inst, data) 
                        if inst.enraged then
                           local max_health = inst.components.health.maxhealth
                           inst.components.health:DoDelta(max_health*0.02) 
                        end
                    end)
                    inst:ListenForEvent("enrage", function() 
                        local max_health = inst.components.health.maxhealth
                        inst.components.health:DoDelta(max_health*1.15)
                    end)
                end
                if v == "alterguardian_phase1" or v == "alterguardian_phase2" or v == "alterguardian_phase3" then
                    inst:ListenForEvent("attacked", function(inst, data)
                        if math.random()>0.85 then
                            data.attacker:StartThread(function()
                                local pos = data.attacker:GetPosition()
                                GLOBAL.SpawnPrefab("alterguardian_phase3trapprojectile").Transform:SetPosition(pos.x, pos.y, pos.z)
                            end)
                        end
                    end)
                end
            end)
        end
    end
    if stronger_boss == 3 then
        for k,v in pairs(monster_prefabs) do
            AddPrefabPostInit(v, function(inst)
                if v == "mossling" and inst.components.health and inst.components.health.invincible~=true then

                end
                if inst.components.health ~= nil and inst.components.health.regen == nil then
                    local regen_health = 8
                    local regen_period = 2
                    local max_health = inst.components.health.maxhealth
                    if max_health > 1999 then
                        regen_health = 25
                    end
                    if max_health > 9999 then
                        regen_health = 50
                    end
                    inst.components.health:StartRegen(regen_health, regen_period, false)
                end
                local x,y,z = inst.Transform:GetWorldPosition()
                if (inst.components.health ~= nil and inst.components.health.maxhealth > 4999) then
                    inst:ListenForEvent("attacked", function(inst, data)
                        if data.attacker ~= nil then
                            
                            if data.attacker:HasTag("player") then
                                if inst.components.health:GetPercent() < 0.6 and inst.components.health:GetPercent() > 0.1 then
                                    if inst.components.health.maxhealth > 1999 then
                                        local extra_att = math.random()
                                        if extra_att < 0.02 then
                                            data.attacker:StartThread(function()
                                                local pos = data.attacker:GetPosition()
                                                _G.TheWorld:PushEvent("ms_sendlightningstrike", pos) --触发天气事件，生成雷劈
                                            end)
                                        elseif extra_att < 0.15 then
                                            if data.attacker.components.freezable ~= nil then --增加冰冻层数
                                                data.attacker.components.freezable:AddColdness(1)
                                                data.attacker.components.freezable:SpawnShatterFX() --冰冻粉碎效果
                                            end
                                        elseif extra_att < 0.25 then
                                            if data.attacker.components.moisture ~= nil then --潮湿度5
                                                data.attacker.components.moisture:DoDelta(5)
                                            end
                                        elseif extra_att < 0.4 then
                                            if data.attacker.components.sanity ~= nil then --降低理智
                                                data.attacker.components.sanity:DoDelta(-5)
                                            end
                                        end
                                    end
                                    if math.random() < 0.01 and inst:IsNear(data.attacker, 13) and not inst:IsNear(data.attacker, 3) then
                                        local px, py, pz = data.attacker.Transform:GetWorldPosition()
                                        --想到更好的处理方案再说
                                        --inst.Transform:SetPosition(px, py, pz)
                                    end
                                end
                            elseif data.attacker.components.health and data.attacker.components.health.maxhealth > 9999 then --更换目标,boss不能互相打起来
                                if inst.components.health:GetPercent() < 0.7 then
                                    
                                    local ents = TheSim:FindEntities(x,y,z, 90, nil,nil, {"player"})
                                    local has_target = false
                                    for k,v in pairs(ents) do
                                        inst.components.combat:SuggestTarget(v)
                                        has_target = true
                                        break
                                    end
                                    if not has_target and inst.components.sleeper ~= nil then
                                        sendtorandomposition(data.attacker)
                                        --inst.components.sleeper:GoToSleep(1 + math.random() * 4)
                                    end
                                end
                            end
                        end
                    end)
                    inst:ListenForEvent("healthdelta", function(inst, data) 
                        if inst.components.health:GetPercent() < 0.05 then
                            if inst.components.health.absorb == 0 then
                                inst.components.health.absorb = 0.5
                                inst:AddTag("absorbadd")
                            end
                        else
                            if inst:HasTag("absorbadd") then
                                inst.components.health.absorb = 0
                                inst:RemoveTag("absorbadd")
                            end
                        end
                    end)

                end
                if v == "klaus" then
                    inst:ListenForEvent("killed", function(inst, data) 
                        if inst.enraged then
                           local max_health = inst.components.health.maxhealth
                           inst.components.health:DoDelta(max_health*0.04) 
                        end
                    end)
                    inst:ListenForEvent("enrage", function() 
                        local max_health = inst.components.health.maxhealth
                        inst.components.health:DoDelta(max_health*2)
                    end)
                end
            end)
        end
    end
    if not worldregrowth_enabled then
        AddComponentPostInit("regrowthmanager", function(self)
            function self:LongUpdate()
                
            end
        end)

        AddComponentPostInit("desolationspawner", function(self)
            function self:LongUpdate()
                
            end
        end)

        _G.require("gamemodes")
        for k, v in pairs(_G.GAME_MODES) do
            if v.resource_renewal then
                v.resource_renewal = false
            end
        end

        AddComponentPostInit("plantregrowth", function(self)
            function self:TrySpawnNearby()
                
            end
        end)
    
        AddPrefabPostInit("world", function(inst)
            if inst.components.forestresourcespawner ~= nil then
                inst:RemoveComponent("forestresourcespawner")
            end
            if inst.components.regrowthmanager ~= nil then
                inst:RemoveComponent("regrowthmanager")
            end
            if inst.components.desolationspawner ~= nil then
                inst:RemoveComponent("desolationspawner")
            end
        end)
    end

    if TUNING.new_items then
        local unpackage_items = {
            "wormhole",
            "multiplayer_portal",
            "multiplayer_portal_moonrock_constr",
            "multiplayer_portal_moonrock",
            "cave_entrance",
            "cave_entrance_open",
            "cave_exit",
            "moon_altar",
            "eyeturret",
            "tentacle_pillar",
            "tentacle_pillar_hole",
        }
        for k,v in pairs(unpackage_items) do
            AddPrefabPostInit(v, function(inst)
                inst:AddTag("unpackage")
            end)
        end
    end

    if TUNING.more_blueprint then
        local function CanBlueprintSpecificRecipe(recipe)
            --Exclude crafting station and character specific
            if recipe.nounlock or recipe.builder_tag ~= nil then
                return false
            end
            for k, v in pairs(recipe.level) do
                if v > 0 then
                    return true
                end
            end
            --Exclude TECH.NONE
            return false
        end
        local function resethaunt(inst)
            if inst.components.hauntable ~= nil then
                inst.components.hauntable.onhaunt = function(inst, haunter) 
                    if not inst.is_rare then 
                        if inst.broken ~= true then
                            if math.random() < 0.4 then
                                local recipes = {}
                                for k, v in pairs(AllRecipes) do
                                    table.insert(recipes, v)
                                end
                                inst.recipetouse = recipes[math.random(#recipes)].name or "unknown"
                                inst.components.teacher:SetRecipe(inst.recipetouse)
                                local str = _G.STRINGS.NAMES[string.upper(inst.recipetouse)] or "unknown"
                                inst.components.named:SetName(str.." ".._G.STRINGS.NAMES.BLUEPRINT)
                            else
                                inst.broken = true
                                if inst.components.burnable == nil then
                                    _G.MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
                                    _G.MakeSmallPropagator(inst)
                                end
                                inst.components.burnable:Ignite()
                            end
                            return true
                        else
                            if inst.components.burnable == nil then
                                _G.MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
                                _G.MakeSmallPropagator(inst)
                            end
                            inst.components.burnable:Ignite()
                        end
                    end
                    return false 
                end
            end
        end
        AddPrefabPostInit("blueprint", resethaunt)
        for k, v in pairs(RECIPETABS) do
            if not v.crafting_station then
                AddPrefabPostInit(string.lower(v.str or "NONAME").."_blueprint", resethaunt)
            end
        end
        for k, v in pairs(AllRecipes) do
            if CanBlueprintSpecificRecipe(v) then
                AddPrefabPostInit(string.lower(k or "NONAME").."_blueprint", resethaunt)
            end
        end

        local TechTree = require("techtree")

        AddPrefabPostInit("researchlab", function(inst)
            --inst:RemoveTag("prototyper") 
            inst.components.prototyper.trees = TechTree.Create({
                SCIENCE = 0,
                MAGIC = 0,
            })
        end)

        AddPrefabPostInit("researchlab2", function(inst)
            inst.components.prototyper.trees = TechTree.Create({
                SCIENCE = 0,
                MAGIC = 0,
            })
        end)

        AddPrefabPostInit("researchlab3", function(inst)
            inst:RemoveTag("prototyper")
        end)

        AddPrefabPostInit("researchlab4", function(inst)
            inst:RemoveTag("prototyper")
        end)

        AddPrefabPostInit("wickerbottom", function(inst)
            if inst.components.builder then
                inst.components.builder.science_bonus = 0
            end
        end)

        local original_TEACH = _G.ACTIONS.TEACH.fn
        _G.ACTIONS.TEACH.fn = function(act)
            local ret, reason = original_TEACH(act)
            if ret and act.invobject.components.teacher then
                local blueprint_str = act.invobject.name
                if blueprint_str:sub(-9):lower() == "blueprint" then
                    blueprint_str = blueprint_str:sub(1,-11)
                end
                local name = _G.STRINGS.NAMES[string.upper(blueprint_str)] or "??"
                _G.TheNet:Announce(string.format(_G.STRINGS.LEARN_NEW, act.doer:GetDisplayName(), blueprint_str))
            end
            return ret, reason
        end
    end

	--未测试通过代码
	AddPrefabPostInit("cave", function(inst)
		--if TheWorld:HasTag("cave") then
			--inst:AddComponent("tumbleweed_spawner")
            --inst:DoTaskInTime(10, function()
            --    inst.components.tumbleweed_spawner:Init()
            --end)
		--end
	end)
end

if TUNING.new_items then
    --添加制作
    --[[AddRecipe("package_staff", 
        {Ingredient("greengem", 4), Ingredient("thulecite", 8), Ingredient("walrus_tusk", 1)},
        RECIPETABS.ANCIENT, 
        TECH.ANCIENT_TWO,
        nil,
        nil,
        nil,
        nil,
        nil,
        "images/package_staff.xml"
    ) ]]

    --祈祷动作
    AddAction("PRAY",_G.STRINGS.TUM.PRAY,function(act)
        if act.doer ~= nil and act.invobject ~= nil and act.invobject.components.prayable ~= nil then
            act.invobject.components.prayable:StartPray(act.invobject,act.doer)
            return true
        end
    end)
    AddComponentAction("INVENTORY", "prayable", function(inst,doer,actions,right)
        if doer:HasTag("player") then
            table.insert(actions, ACTIONS.PRAY)
        end
    end)

    AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.PRAY, "give"))
    AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.PRAY,"give"))

    -- 传送动作
    AddAction("SEE",_G.STRINGS.TUM.SEE,function(act)
        if act.doer ~= nil and act.invobject ~= nil and act.invobject.components.opal ~= nil then
            act.invobject.components.opal:StartPray(act.invobject,act.doer)
            return true
        end
    end)
    
    -- 查看动作
    AddAction("CKK",_G.STRINGS.TUM.CKK,function(act)
        if act.doer ~= nil and act.invobject ~= nil and act.invobject.components.opal ~= nil then
            act.invobject.components.rechargeable:SetCharge(0)
            act.invobject.components.opal:StartCK(act.invobject,act.doer)
            return true
        end
    end)
    --客户端执行
    --位于装备槽时可以用，卸下优先级低，冷却期间移除这个标签，冷却好了就加回去就好 
    AddComponentAction("INVENTORY", "opal", function(inst, doer, actions, right)
        if doer:HasTag("player") and inst:HasTag("opalgemsamulet") then
            if not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding()) or inst:HasTag("pocketwatch_mountedcast") then -- 乘骑状态不让使用
                table.insert(actions, ACTIONS.CKK)
            end
        elseif doer:HasTag("player") and inst:HasTag("kcs") then
            if not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding()) or inst:HasTag("pocketwatch_mountedcast") then
                table.insert(actions, ACTIONS.SEE)
            end
        end
    end)

    AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.CKK, "give"))
    AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.CKK,"give"))
    AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.SEE, "give"))
    AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.SEE,"give"))

    --记录动作
    AddAction("RECORD",_G.STRINGS.TUM.RECORD,function(act)
        print("服务器执行?")
        if act.doer ~= nil and act.invobject ~= nil and act.invobject.components.access ~= nil then
            act.invobject.components.access:Record(act.invobject,act.doer)
            print("记录了动作") -- 记录
            return true
        end
    end)
    --读取动作
    AddAction("READ_MOD",_G.STRINGS.TUM.READ_MOD,function(act)
        if act.doer ~= nil and act.invobject ~= nil and act.invobject.components.access ~= nil then
            if act.invobject.components.access:Read(act.invobject,act.doer) then -- 读取成功后执行
                act.invobject.components.rechargeable:SetCharge(0)
            end
            return true
        end
    end)

    AddComponentAction("INVENTORY", "access", function(inst,doer,actions,right)
        -- CONTROL_FORCE_STACK 是与 按ctrl键 堆叠动作 共用的
        if doer:HasTag("achivwatchmaker") and doer.components.playercontroller:IsControlPressed(_G.CONTROL_FORCE_STACK) and doer:HasTag("pocketwatchcaster") then
            if not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding()) or inst:HasTag("pocketwatch_mountedcast") then -- 乘骑状态不让使用
                table.insert(actions, ACTIONS.RECORD)
            end
        elseif doer:HasTag("achivwatchmaker") and doer:HasTag("pocketwatchcaster") and inst:HasTag("pocketwatch_inactive") then
            if not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding()) or inst:HasTag("pocketwatch_mountedcast") then
                table.insert(actions, ACTIONS.READ_MOD)
            end
        end
    end)

    AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.RECORD, "give"))
    AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.RECORD,"give"))
    AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.READ_MOD, "pocketwatch_cast"))
    AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.READ_MOD,"pocketwatch_cast"))
end



--成就系统
if achievement_system then
require "AllAchiv/allachivrpc"
require 'AllAchiv/skillrpc'
require 'AllAchiv/skillrpc2'
if mlang == "zh" or mlang == "chs" then
    require 'AllAchiv/strings_acm_chs'
    require 'AllAchiv/strings_title_chs'
else
    require 'AllAchiv/strings_acm_chs' --暂时先使用中文包
    require 'AllAchiv/strings_title_chs'
end

table.insert(PrefabFiles, "seffc")
table.insert(PrefabFiles, "abigail_clone")
table.insert(PrefabFiles, "book_treat")
table.insert(PrefabFiles, "book_kill")
table.insert(PrefabFiles, "book_season")
table.insert(PrefabFiles, "magic_circle")
table.insert(PrefabFiles, "potion_achiv")
table.insert(PrefabFiles, "potions")
table.insert(PrefabFiles, "deadbone")
table.insert(PrefabFiles, "wes_clone")

table.insert(PrefabFiles, "titles_fx")

table.insert(PrefabFiles, "achiv_clear")

--合并两个table
local function MergeTables(...)
    local tabs = {...}
    if not tabs then
        return {}
    end
    local origin = tabs[1]
    for i = 2,#tabs do
        if origin then
            if tabs[i] then
                for k,v in pairs(tabs[i]) do
                    origin[k] = v
                end
            end
        else
            origin = tabs[i]
        end
    end
    return origin
end

_G.STRINGS.ALLACHIVNAME_VALUE = _G.STRINGS.ALLACHIVNAME

Assets = {
    
    Asset("ATLAS", "images/hud/background.xml"),
    Asset("IMAGE", "images/hud/background.tex"),
    Asset("ATLAS", "images/hud/star.xml"),
    Asset("IMAGE", "images/hud/star.tex"),
    Asset("ATLAS", "images/hud/reset_info.xml"),
    Asset("IMAGE", "images/hud/reset_info.tex"),
    Asset("ATLAS", "images/hud/levelbadge.xml"),
    Asset("IMAGE", "images/hud/levelbadge.tex"),
    Asset("ATLAS", "images/hud/title.xml"),
    Asset("IMAGE", "images/hud/title.tex"),
    Asset("ATLAS", "images/hud/email.xml"),
    Asset("IMAGE", "images/hud/email.tex"),

    Asset("ATLAS", "images/button/perk.xml"),
    Asset("IMAGE", "images/button/perk.tex"),
    Asset("ATLAS", "images/button/help.xml"),
    Asset("IMAGE", "images/button/help.tex"),
    Asset("ATLAS", "images/button/perk_active.xml"),
    Asset("IMAGE", "images/button/perk_active.tex"),
    Asset("ATLAS", "images/button/perk_shop.xml"),
    Asset("IMAGE", "images/button/perk_shop.tex"),
    Asset("ATLAS", "images/button/button_bg.xml"),
    Asset("IMAGE", "images/button/button_bg.tex"),
    Asset("ATLAS", "images/button/button_bg_active.xml"),
    Asset("IMAGE", "images/button/button_bg_active.tex"),
    Asset("ATLAS", "images/button/achievement.xml"),
    Asset("IMAGE", "images/button/achievement.tex"),
    Asset("ATLAS", "images/button/achievement_active.xml"),
    Asset("IMAGE", "images/button/achievement_active.tex"),
    Asset("ATLAS", "images/button/checkbutton.xml"),
    Asset("IMAGE", "images/button/checkbutton.tex"),
    Asset("ATLAS", "images/button/coinbutton.xml"),
    Asset("IMAGE", "images/button/coinbutton.tex"),
    Asset("ATLAS", "images/button/config_bigger.xml"),
    Asset("IMAGE", "images/button/config_bigger.tex"),
    Asset("ATLAS", "images/button/config_smaller.xml"),
    Asset("IMAGE", "images/button/config_smaller.tex"),

    Asset("ATLAS", "images/skills/resurrect.xml"),
    Asset("IMAGE", "images/skills/resurrect.tex"),
    Asset("ATLAS", "images/skills/shadow.xml"),
    Asset("IMAGE", "images/skills/shadow.tex"),
    Asset("ATLAS", "images/skills/cheatdeath.xml"),
    Asset("IMAGE", "images/skills/cheatdeath.tex"),
    Asset("ATLAS", "images/skills/callback.xml"),
    Asset("IMAGE", "images/skills/callback.tex"),
    Asset("ATLAS", "images/skills/hitattack.xml"),
    Asset("IMAGE", "images/skills/hitattack.tex"),
    Asset("ATLAS", "images/skills/nextdamage.xml"),
    Asset("IMAGE", "images/skills/nextdamage.tex"),
    Asset("ATLAS", "images/skills/strongeraoe.xml"),
    Asset("IMAGE", "images/skills/strongeraoe.tex"),
    Asset("ATLAS", "images/skills/waterwalk.xml"),
    Asset("IMAGE", "images/skills/waterwalk.tex"),

    Asset("ATLAS", "images/title/title_list.xml"),
    Asset("IMAGE", "images/title/title_list.tex"),
    Asset("ATLAS", "images/title/title_content.xml"),
    Asset("IMAGE", "images/title/title_content.tex"),
    Asset("ATLAS", "images/title/equip.xml"),
    Asset("IMAGE", "images/title/equip.tex"),

    Asset("ATLAS", "images/opalgemsamulet.xml"),
    Asset("IMAGE", "images/opalgemsamulet.tex"), --物品栏
    Asset("ATLAS", "images/opalgemsamulet2.xml"),
    Asset("IMAGE", "images/opalgemsamulet2.tex"), --物品栏
    
    Asset("ATLAS", "images/fatemod.xml"),
    Asset("IMAGE", "images/fatemod.tex"),
}
-------- 字符串与表互转 -----------------
--GLOBAL.json.encode(table)
--GLOBAL.json.decode(str)
--可以用饥荒自带的json互换 替换掉下面的代码
function ToStringEx(value)
    if type(value)=='table' then
       return TableToStr(value)
    elseif type(value)=='string' then
        return "\'"..value.."\'"
    else
       return GLOBAL.tostring(value)
    end
end
function StrToTable(str)
    if str == nil or type(str) ~= "string" then
        return
    end
    
    return GLOBAL.loadstring("return " .. str)()
end
function TableToStr(t)
    if t == nil then return "" end
    local retstr= "{"

    local i = 1
    for key,value in pairs(t) do
        local signal = ","
        if i==1 then
          signal = ""
        end

        if key == i then
            retstr = retstr..signal..ToStringEx(value)
        else
            if type(key)=='number' or type(key) == 'string' then
                retstr = retstr..signal..'['..ToStringEx(key).."]="..ToStringEx(value)
            else
                if type(key)=='userdata' then
                    retstr = retstr..signal.."*s"..TableToStr(getmetatable(key)).."*e".."="..ToStringEx(value)
                else
                    retstr = retstr..signal..key.."="..ToStringEx(value)
                end
            end
        end
        i = i+1
    end

    retstr = retstr.."}"
    return retstr
end
-----------------大门记录玩家数据 应对多世界换人问题--------------------
--- 大门前面两种形态 都具有记录数据并将数据返回玩家新实体的能力
AddPrefabPostInit("multiplayer_portal",function(inst)
    inst._savedata = {}
    local function onInheritData(world,data)
        inst._savedata[data.userid] = data.data
    end 
    if GLOBAL.TheWorld.ismastershard then
        inst:DoTaskInTime(0,function(inst)
            inst:ListenForEvent("ms_inheritdata",onInheritData,GLOBAL.TheWorld)
        end)
        inst:ListenForEvent("ms_newplayerspawned", function(world, player)
            if inst._savedata[player.userid] ~= nil then
                if player.LoadForReroll ~= nil then
                    player:LoadForReroll(inst._savedata[player.userid])
                end
                inst._savedata[player.userid] = nil
            end
        end, GLOBAL.TheWorld)
    end
end)
AddPrefabPostInit("multiplayer_portal_moonrock_constr",function(inst)
    inst._savedata = {}
    local function onInheritData(world,data)
        inst._savedata[data.userid] = data.data
    end
    if GLOBAL.TheWorld.ismastershard then
        inst:DoTaskInTime(0,function(inst)
            inst:ListenForEvent("ms_inheritdata",onInheritData,GLOBAL.TheWorld)
        end)
        inst:ListenForEvent("ms_newplayerspawned", function(world, player)
            if inst._savedata[player.userid] ~= nil then
                if player.LoadForReroll ~= nil then
                    player:LoadForReroll(inst._savedata[player.userid])
                end
                inst._savedata[player.userid] = nil
            end
        end, GLOBAL.TheWorld)
    end
end)
AddPrefabPostInit("multiplayer_portal_moonrock",function(inst)
    -- 当玩家要换人的时候
    local function moonrock_onaccept(inst, giver)--, item)
        -- giver.removecoin_mod = true
        giver:AddTag("removecoin_mod") --给玩家添加标记
        giver:PushEvent("ms_playerreroll")

        if giver.components.inventory ~= nil then
            giver.components.inventory:DropEverything() --放下一切
        end

        if giver.components.leader ~= nil then
            local followers = giver.components.leader.followers
            for k, v in pairs(followers) do
                if k.components.inventory ~= nil then
                    k.components.inventory:DropEverything()
                elseif k.components.container ~= nil then
                    k.components.container:DropEverything()
                end
            end
        end

        inst._savedata[giver.userid] = giver.SaveForReroll ~= nil and giver:SaveForReroll() or nil
        GLOBAL.TheWorld:PushEvent("ms_playerdespawnanddelete", giver)
    end
    local function onInheritData(world,data)
        inst._savedata[data.userid] = data.data
    end

    if inst.components.moontrader then
        inst.components.moontrader:SetOnAcceptFn(moonrock_onaccept)
    end
    if GLOBAL.TheWorld.ismastershard then
        inst:DoTaskInTime(0,function(inst)
            inst:ListenForEvent("ms_inheritdata",onInheritData,GLOBAL.TheWorld)
        end)
    end
end)
--------------------------RPC----------------------------
local function HuanRenShi(shardId,uid,dataStr)
    local data = StrToTable(dataStr)
    GLOBAL.TheWorld:PushEvent("ms_inheritdata",{
        userid = uid,
        data = data,
    })
end
AddShardModRPCHandler(modname, "HuanRenShi", HuanRenShi)
----------------------------给玩家添加任务等级成就等组件
AddPlayerPostInit(function(inst)

    local oln_LoadForReroll = inst.LoadForReroll
    local oln_SaveForReroll = inst.SaveForReroll
    --SaveForReroll数据保存在大门里。多世界时，非主世界的大门数据，会在玩家加入世界时，清除掉之前保存的这个玩家的数据。
    --所有使用这个方法记录数据，对多世界时没有用。
    --解决方法：当前世界非主世界时，应当将玩家数据传递到主世界。
    local function SaveForReroll(inst)
        local data = nil
        if oln_SaveForReroll and type(oln_SaveForReroll) == "function" then
            -- print("执行之前的保存方法")
            data = oln_SaveForReroll(inst)
        end
        if data == nil then
            data = {}
        end
        data["allachivevent"] = inst.components.allachivevent ~= nil and inst.components.allachivevent:OnSave() or nil
        data["allachivcoin"] = inst.components.allachivcoin ~= nil and inst.components.allachivcoin:OnSave() or nil
        data["levelsystem"] = inst.components.levelsystem ~= nil and inst.components.levelsystem:OnSave() or nil
        data["coinamount"] = inst:HasTag("removecoin_mod") and math.ceil(inst.components.allachivcoin.coinamount + inst.components.allachivcoin.starsspent*0.95) or nil --用于判断怎么换人的
        if inst:HasTag("removecoin_mod") and not GLOBAL.TheWorld.ismastershard then --非主碎片时，将数据传送到主碎片
            local uid = inst.userid --玩家克雷id
            local dataStr = TableToStr(data)
            SendModRPCToShard(GetShardModRPC(modname, "HuanRenShi"),1,uid,dataStr)--将数据传入主世界
            return 
        end
        return GLOBAL.next(data) ~= nil and data or nil
    end
    local function LoadForReroll(inst, data)
        if oln_LoadForReroll and type(oln_LoadForReroll) == "function" then
            -- print("执行之前的加载方法")
            oln_LoadForReroll(inst,data)
        end
        -- print("加载旧数据",inst.components.allachivevent)

        -- 加载换人时
        if data.allachivevent ~= nil and inst.components.allachivevent then 
            inst.components.allachivevent:OnLoad(data.allachivevent)
        end
        if data.allachivcoin ~= nil and inst.components.allachivcoin then
            inst.components.allachivcoin:OnLoad(data.allachivcoin)
        end
        if data.levelsystem ~= nil and inst.components.levelsystem then 
            inst.components.levelsystem:OnLoad(data.levelsystem)
        end
        if data.coinamount then
            inst.components.allachivcoin.coinamount = data.coinamount
        end
    end

    if _G.TheWorld.ismastersim then inst:DoPeriodicTask(0,function(inst) if inst.components.oldager then inst.components.oldager:AddValidHealingCause("statusclock") end end) end
    for k,v in pairs(_G.allachiv_eventdata) do -- 成就的任务系统
        local checkfnname = "check"..k
        inst[checkfnname] = GLOBAL.net_shortint(inst.GUID, checkfnname) --各类成就任务的网络变量
    end

    inst.checktempachiv = GLOBAL.net_string(inst.GUID, "checktempachiv")
    
    for k,v in pairs(_G.allachiv_coinuse) do -- 消耗成就点系统
        local currentname = "current"..k
        inst[currentname] = GLOBAL.net_shortint(inst.GUID, currentname) --各类成就奖励的网络变量
    end
    inst.currentcallbackcd = GLOBAL.net_shortint(inst.GUID, "currentcallbackcd")
    inst.currentcheatdeathcd = GLOBAL.net_shortint(inst.GUID, "currentcheatdeathcd")
    inst.currentwescheatcd = GLOBAL.net_shortint(inst.GUID, "currentwescheatcd")
    inst.currentresurrectcd = GLOBAL.net_shortint(inst.GUID, "currentresurrectcd")
    inst.currentcoinamount = GLOBAL.net_shortint(inst.GUID,"currentcoinamount")
    
    inst.currentpower = GLOBAL.net_float(inst.GUID,"currentpower")
    inst.currentlevel = GLOBAL.net_shortint(inst.GUID,"currentlevel")
    inst.currentlevelxp = GLOBAL.net_uint(inst.GUID,"currentlevelxp")
    inst.currentoverallxp = GLOBAL.net_uint(inst.GUID,"currentoverallxp")
    
    inst.currenthungermax = GLOBAL.net_shortint(inst.GUID,"currenthungermax")
    inst.currentsanitymax = GLOBAL.net_shortint(inst.GUID,"currentsanitymax")
    inst.currenthealthmax = GLOBAL.net_shortint(inst.GUID,"currenthealthmax")
    inst.currentspeedmax = GLOBAL.net_shortint(inst.GUID,"currentspeedmax")
    inst.currentabsorbmax = GLOBAL.net_shortint(inst.GUID,"currentabsorbmax")
    inst.currentdamagemax = GLOBAL.net_shortint(inst.GUID,"currentdamagemax")
    inst.currentinsulationmax = GLOBAL.net_shortint(inst.GUID,"currentinsulationmax")
    inst.currentinsulationsummermax = GLOBAL.net_shortint(inst.GUID,"currentinsulationsummermax")
    
    inst.currentzoomlevel = GLOBAL.net_float(inst.GUID,"currentzoomlevel")
    inst.currentwidgetxpos = GLOBAL.net_float(inst.GUID,"currentwidgetxpos")

    inst.currentluck = GLOBAL.net_shortint(inst.GUID,"currentluck")
    inst.currentworld = GLOBAL.net_shortint(inst.GUID,"currentwrold")
    inst.currenthits = GLOBAL.net_shortint(inst.GUID, "currenthits")
    inst.currentnextdamage = GLOBAL.net_shortint(inst.GUID, "currentnextdamage")
    inst.currentaoestatus = GLOBAL.net_shortint(inst.GUID, "currentaoestatus")
    inst.currentwaterwalkstatus = GLOBAL.net_shortint(inst.GUID, "currentwaterwalkstatus")

    inst.currenthasgift = GLOBAL.net_shortint(inst.GUID, "currenthasgift")
    inst.currentgiftdata = GLOBAL.net_string(inst.GUID, "currentgiftdata")

    for k,v in pairs(_G.STRINGS.TITLE) do --称号类的网络变量
        local currentname = "current"..v.id
        inst[currentname] = GLOBAL.net_byte(inst.GUID, currentname)
        for m,n in pairs(v.desc) do
            local currentdesc = currentname.."_desc"..tostring(m)
            inst[currentdesc] = GLOBAL.net_byte(inst.GUID, currentdesc)
        end
    end
    inst.currentequip = GLOBAL.net_byte(inst.GUID, "currentequip")
    
    inst:AddComponent("allachivevent")
    inst:AddComponent("allachivcoin")
    inst:AddComponent("levelsystem")
    inst:AddComponent("luck")
    inst:AddComponent("titlesystem")
    if not GLOBAL.TheNet:GetIsClient() then
        inst.components.allachivevent:Init(inst)
        inst.components.allachivcoin:Init(inst)
        inst.components.levelsystem:Init(inst)
        inst.components.titlesystem:Init(inst)
        -- if inst.components.oldager then --旺达吸血
            -- inst.components.oldager:AddValidHealingCause("lifesteal") -- 吸血技能
        -- end
    end
    inst.LoadForReroll = LoadForReroll
    inst.SaveForReroll = SaveForReroll
end)

--UI尺寸
local function PositionUI(self, screensize)
    local hudscale = self.top_root:GetScale()
    --self.uiachievement:SetScale(.72*hudscale.x,.72*hudscale.y,1)
    self.uiachievement:SetScale(0.55*hudscale.x,0.55*hudscale.y,1)
end

--UI
local uiachievement = require("widgets/uiachievement")
local uiachievementWidget = nil
local function hideMenus()
    if type(GLOBAL.ThePlayer) ~= "table" or type(GLOBAL.ThePlayer.HUD) ~= "table" then return end
    uiachievementWidget.mainui.allachiv:Hide()
    uiachievementWidget.mainui.allcoin:Hide()
    uiachievementWidget.mainui.levelbg:Hide()
    uiachievementWidget.mainui.title:Hide()
    uiachievementWidget.mainui.achievement_bg:Hide()
    uiachievementWidget.mainui.infobutton:Hide()
    uiachievementWidget.mainui.perk_cat:Hide()
end
local function Adduiachievement(self)
    self.uiachievement = self.top_root:AddChild(uiachievement(self.owner))
    uiachievementWidget = self.uiachievement
    local screensize = {GLOBAL.TheSim:GetScreenSize()}
    PositionUI(self, screensize)
    self.uiachievement:SetHAnchor(0)
    self.uiachievement:SetVAnchor(0)
    self.uiachievement:MoveToFront()
    local OnUpdate_base = self.OnUpdate
    self.OnUpdate = function(self, dt)
        OnUpdate_base(self, dt)
        local curscreensize = {GLOBAL.TheSim:GetScreenSize()}
        if curscreensize[1] ~= screensize[1] or curscreensize[2] ~= screensize[2] then
            PositionUI(self, curscreensize)
            screensize = curscreensize
        end
    end
    
    GLOBAL.TheInput:AddKeyUpHandler(GLOBAL.KEY_ESCAPE, hideMenus)
end

AddClassPostConstruct("widgets/controls", Adduiachievement)


AddComponentPostInit("crop", function(self)
local _Harvest = self.Harvest
    self.Harvest = function(self, harvester)
        local pos = self.inst:GetPosition()
        local ret, product = _Harvest(self, harvester)
        --print(harvester.components.allachivcoin.pickmaster)
        
        if ret and product and harvester and pos and harvester.components.allachivcoin and harvester.components.allachivcoin.pickmaster>0 then
            local wetness = GLOBAL.TheWorld.state.wetness
            local iswet = GLOBAL.TheWorld.state.iswet
            local item = GLOBAL.SpawnPrefab(product.prefab)
            item.components.inventoryitem:InheritMoisture(wetness, iswet)
            harvester.components.inventory:GiveItem(item, nil, pos)
        end
        return ret, product
    end
end)

local function onwakeup(self)
    if self and self.components.sleepingbag then
        local onwake_old = self.components.sleepingbag.onwake
        self.components.sleepingbag.onwake = function(self, sleeper, nostatechange)                   
            sleeper:PushEvent("wakeup", self.prefab)      
            onwake_old(self, sleeper, nostatechange)                                                       
        end
    end
end
AddPrefabPostInit("siestahut", onwakeup)
AddPrefabPostInit("tent", onwakeup)

local function NewQuickAction(inst, action)
    local quick = false
    if inst and inst:HasTag("fastpick") then
        quick = true
    end 
        if quick then
            return "doshortaction"
        elseif action.target and action.target.components.pickable then
            if action.target.components.pickable.quickpick then
                return "doshortaction"
            else
                return "dolongaction"
            end
        else 
            return "dolongaction"
        end
end

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.PICK, NewQuickAction))
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TAKEITEM, NewQuickAction))
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.HARVEST, NewQuickAction))
GLOBAL.package.loaded["stategraphs/SGwilson"] = nil 

AddPrefabPostInit("balloon", function(inst) 
    inst:ListenForEvent("killed", function(inst, data)
        if inst:HasTag("hide") then return end
        if inst._player then
            inst._player:PushEvent("killed", data)
        end
    end)

    local OldOnSave = inst.OnSave
    inst.OnSave = function(inst, data)
        if OldOnSave ~= nil then
            OldOnSave(inst, data)
        end
        --data.player = inst._player
        data.canbehuman = inst.canbehuman
        data.damage = inst.damage
    end

    local OldOnLoad = inst.OnLoad
    inst.OnLoad = function(inst, data)
        if OldOnLoad ~= nil then
            OldOnLoad(inst, data)
        end
        --if data.player then
        --    local balloonbrain = require("brains/balloonbrain")
        --    inst._player = data.player
        --    inst:SetBrain(balloonbrain)
        --end
        inst.canbehuman = data.canbehuman
        inst.damage = data.damage
        if inst.damage and inst.damage > 5 then
            inst.components.combat:SetDefaultDamage(inst.damage)
        end
        local balloonbrain = require("brains/balloonbrain")
        inst:SetBrain(balloonbrain)
    end

    inst:ListenForEvent("death", function(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        local player = inst._player
        if inst.canbehuman == true and player ~= nil then
            local human = _G.SpawnPrefab("wes_clone")
            human.Transform:SetPosition(x,y,z)
            local current_head = player.components.inventory:GetEquippedItem(_G.EQUIPSLOTS.HEAD)
            local current_body = player.components.inventory:GetEquippedItem(_G.EQUIPSLOTS.BODY)
            local current_hands = player.components.inventory:GetEquippedItem(_G.EQUIPSLOTS.HANDS)
            if current_head then
                --human.components.inventory:Equip(_G.SpawnPrefab(current_head.prefab))
                human.AnimState:OverrideSymbol("swap_hat", "swap_"..string.sub(current_head.prefab,1,-3), "swap_hat")
                human.AnimState:Show("HAT")
                human.AnimState:Show("HAIR_HAT")
                human.AnimState:Hide("HAIR_NOHAT")
                human.AnimState:Hide("HAIR")
            end
            if current_body then
                --human.AnimState:OverrideSymbol("swap_body", current_body.prefab, "swap_body")
                --human.components.inventory:Equip(_G.SpawnPrefab(current_body.prefab))
                if current_body.components.armor then
                    local absorb_percent = current_body.components.armor.absorb_percent-0.1
                    human.components.health:SetAbsorptionAmount(absorb_percent)
                end
            end
            if current_hands then
                --human.components.inventory:Equip(_G.SpawnPrefab(current_hands.prefab))
                human.AnimState:OverrideSymbol("swap_object", "swap_"..current_hands.prefab, "swap_"..current_hands.prefab)
                if current_hands.components.weapon then
                    local damage = current_hands.components.weapon.damage
                    human.components.combat:SetDefaultDamage(damage)
                end
            end
            player.components.leader:AddFollower(human)
            human.components.named:SetName(player:GetDisplayName())
        end
    end)
end)

AddPrefabPostInit("bernie_big", function(inst) 
    inst:ListenForEvent("killed", function(inst, data)
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, 50, nil,nil, {"bernieowner"})
        for k,v in pairs(ents) do
            if v ~= nil and v:HasTag("player") and v.components.sanity:IsCrazy()
                and (v._killedmonster == nil or v._killedmonster[data.victim] == nil) then
                v:PushEvent("killed", data)
            end
        end
    end)
end)


local function GetPlayerById(playerid)
    for _, v in ipairs(_G.AllPlayers) do
        if v ~= nil and v.userid and v.userid == playerid then
            return v
        end
    end
    return nil
end

if _G.TheNet:GetIsServer() or _G.TheNet:IsDedicated() then
    local Old_Networking_Say = _G.Networking_Say
    _G.Networking_Say = function(guid, userid, name, prefab, message, colour, whisper, isemote, ...)
        Old_Networking_Say(guid, userid, name, prefab, message, colour, whisper, isemote, ...)
        local resurrectstr = _G.STRINGS.ALLACHIVCURRENCY[27]
        if string.lower(message) == resurrectstr then
            local player = GetPlayerById(userid)
            if player ~= nil and player.components.allachivcoin then
                player.components.allachivcoin:respawnfromghostfn(player)
            end
        end
        if string.find(message, "#") == 1 then
            local player = GetPlayerById(userid)
            if player ~= nil and player.components.titlesystem then
                player.components.titlesystem:GetCommads(string.lower(message))
            end
        end
    end
end

AddComponentPostInit("armor", function(self)
    function self:InitCondition(amount, absorb_percent)
        if self.level == nil then
            local amount_min = amount
            if amount > 9999 then 
                self.condition = amount
                self.maxcondition = amount
                self.absorb_percent = absorb_percent
                return
            end
            local amount_max = math.ceil(amount * 1.5)
            self.condition = math.random(amount_min, amount_max)
            local absorb_min = absorb_percent-0.05
            local absorb_max = math.min(absorb_percent + .1, 0.98)
            self.absorb_percent = math.random(absorb_min*100, absorb_max*100)*0.01
            self.maxcondition = self.condition
            local level = ""
            if self.absorb_percent == absorb_max then
                level = "[SSS]"
            elseif self.absorb_percent >= absorb_max - 0.02 then
                level = "[S]"
            elseif self.absorb_percent >= absorb_max - 0.04 then
                level = "[A]"
            elseif self.absorb_percent == absorb_min then
                level = "[E]"
            elseif self.absorb_percent <= absorb_min + 0.02 then
                level = "[D]"
            elseif self.absorb_percent <= absorb_min + 0.04 then
                level = "[C]"
            elseif self.absorb_percent >= absorb_max - 0.09 and self.absorb_percent > absorb_percent then
                level = "[B]"
            end
            self.level = level
        end
    end

    function self:OnSave()
        return { 
            condition = self.condition,
            absorb_percent = self.absorb_percent, 
            maxcondition = self.maxcondition, 
            level = self.level,
        }
    end

    function self:OnLoad(data)
        if data.condition ~= nil then
            self.condition = data.condition
        end
        if data.maxcondition ~= nil then
            self.maxcondition = data.maxcondition
        end
        if data.absorb_percent ~= nil then
            self:SetAbsorption(data.absorb_percent)
        end
        if data.level ~= nil then
            self.level = data.level
        end
    end
end)

AddComponentPostInit("weapon", function(self) 
    function self:SetDamage(dmg, ex)
        if type(dmg) ~= "number" then 
            self.damage = dmg
            return 
        end
        if self.level == nil or ex then
            local rand = math.random(1,30) * 0.01 - 0.15
            if ex then
                local rand_max = math.random(16,45)
                rand = math.random(1,rand_max) * 0.01
            end
            self.damage = dmg * (1 + rand)

            local level = ""
            if rand > 0.4 then
                level = "[SSS]"
            elseif rand >= 0.25 then
                level = "[SS]"
            elseif rand >=0.2 then
                level = "[S]"
            elseif rand >=0.1 then
                level = "[A]"
            elseif rand >= 0 then
                level = "[B]"
            elseif rand <= -0.15 then
                level = "[E]"
            elseif rand <= -0.1 then
                level = "[D]"
            elseif rand <= -0.02 then
                level = "[C]"
            end
            self.level = level
            self.rand = rand
        else
            local rand = self.rand or 0
            self.damage = dmg * (1 + rand)
        end
        
    end

    function self:OnSave()
        if type(self.damage) == "number" then
            return { 
                damage = self.damage,
                level = self.level, 
                rand = self.rand,
            }
        end
    end

    function self:OnLoad(data)
        if data.damage ~= nil then
            self.damage = data.damage
        end
        if data.level ~= nil then
            self.level = data.level
        end
        if data.rand ~= nil then
            self.rand = data.rand
        end
    end
end)

AddComponentPostInit("entitytracker", function(self)
    self.OnSave = function()
        if _G.next(self.entities) == nil then
            return
        end

        local ents = {}
        local refs = {}

        for k, v in pairs(self.entities) do
            if v and v.inst and v.inst.GUID then
                table.insert(ents, { name = k, GUID = v.inst.GUID })
                table.insert(refs, v.inst.GUID)
            end
        end

        return { entities = ents }, refs
    end
end)

AddComponentPostInit("balloonmaker", function(self) 
    function self:MakeBalloon(x, y, z)
        local balloon = _G.SpawnPrefab("balloon")
        if balloon then
            balloon.Transform:SetPosition(x,y,z)
            local doer = self.inst.components.inventoryitem.owner
            if doer ~= nil then
                doer:PushEvent("makeballoon", {balloon=balloon,balloonmaker=self.inst})
            end
        end
    end
end)


--[[AddComponentPostInit("playercontroller", function(self) 
    self.OldGetAttackTarget = self.GetAttackTarget
    function self:GetAttackTarget(force_attack, force_target, isretarget)
        local target = self:OldGetAttackTarget(force_attack, force_target, isretarget)
        if target ~=nil and self.inst:HasTag("canflash") and _G.TheNet:GetIsClient() then
            if not _G.TheWorld.Map:IsPassableAtPoint(target.Transform:GetWorldPosition()) then
                _G.SendModRPCToServer(MOD_RPC["DSTAchievement"]["skills"], "changeposition", nil)
                self.inst.replica.combat:SetAttackRange(2)
            else
                self.inst.replica.combat:SetAttackRange(8)
               _G.SendModRPCToServer(MOD_RPC["DSTAchievement"]["skills"], "changeposition", target)
            end
        end
        return target
    end
end)]]


AddPrefabPostInit("winona_catapult", function(inst) 
    local OldOnSave = inst.OnSave
    inst.OnSave = function(inst, data)
        if OldOnSave ~= nil then
            OldOnSave(inst, data)
        end
        data.level = inst.level
    end

    local OldOnLoad = inst.OnLoad
    inst.OnLoad = function(inst, data)
        if OldOnLoad ~= nil then
            OldOnLoad(inst, data)
        end
        inst.level = data.level
        if inst.level and inst.components.health and inst.components.combat then
            inst.components.health:SetMaxHealth(TUNING.WINONA_CATAPULT_HEALTH*2 + inst.level*5)
            inst.components.combat:SetDefaultDamage(TUNING.WINONA_CATAPULT_DAMAGE*2 + inst.level*2)
        end
    end
end)

for k,v in pairs(_G.throwable) do
    AddPrefabPostInit(k, function(k)
        if not _G.TheWorld.ismastersim then
            --print("----client side-----")
            k:DoTaskInTime(0.345, function() 
            --    k:ReplicateComponent("equippable")
                if k.replica == nil then
                    print("replica is nil ......")
                end
            end)
            return
        end
        k:AddComponent("equippable")
        k.components.equippable.restrictedtag = "throwrock"
    end)
end

AddPrefabPostInit("eyeturret", function(inst) 
    local OldOnSave = inst.OnSave
    inst.OnSave = function(inst, data)
        if OldOnSave ~= nil then
            OldOnSave(inst, data)
        end
        data.level = inst.level
    end

    local OldOnLoad = inst.OnLoad
    inst.OnLoad = function(inst, data)
        if OldOnLoad ~= nil then
            OldOnLoad(inst, data)
        end
        inst.level = data.level
        if inst.level then
            inst.components.health:SetMaxHealth(TUNING.EYETURRET_HEALTH*1.5 + inst.level*5)
            inst.components.combat:SetDefaultDamage(TUNING.EYETURRET_DAMAGE*1.5 + inst.level*0.5)
        end
    end
end)

AddStategraphPostInit("winona_catapult", function(sg)
    local attack_state = sg.states.attack
    local old = attack_state.timeline[2].fn
    attack_state.timeline[2].fn = function(inst)
        old(inst)
        --新增成就等级伤害
        local level = inst.level or 0
        inst.sg.statemem.rock.components.combat:SetDefaultDamage(TUNING.WINONA_CATAPULT_DAMAGE + level*2)

    end
end)

AddStategraphPostInit("klaus", function(sg)
    local attack_state = sg.states.attack_chomp
    local oldonenter = attack_state.onenter
    attack_state.onenter = function(inst)
        oldonenter(inst)
        if inst.components.health:GetPercent() < 0.3 then
            _G.RemovePhysicsColliders(inst)
        end
    end
    local oldonexit = attack_state.onexit
    attack_state.onexit = function(inst)
        oldonexit(inst)
        _G.MakeGiantCharacterPhysics(inst, 1000, 1.2)
    end
end)

local NO_TAGS_PVP = { "INLIMBO", "ghost", "playerghost", "FX", "NOCLICK", "DECOR", "notarget", "companion", "shadowminion" }
local NO_TAGS = { "player" }
local COMBAT_TAGS = { "_combat" }
AddStategraphPostInit("wilson", function(sg)
    local slingshot_shoot = sg.states.slingshot_shoot
    local oldonenter = slingshot_shoot.onenter
    slingshot_shoot.onenter = function(inst)
        
        if not inst:HasTag("quickshot") then
            oldonenter(inst)
        else
            local buffaction = inst:GetBufferedAction()
            inst.components.locomotor:Stop()

            local target = buffaction ~= nil and buffaction.target or nil
            if target ~= nil and target:IsValid() then
                for i, v in ipairs(NO_TAGS_PVP) do
                    table.insert(NO_TAGS, v)
                end
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
                local x, y, z = target.Transform:GetWorldPosition()
                for i, v in ipairs(TheSim:FindEntities(x, y, z, 4, COMBAT_TAGS, _G.TheNet:GetPVPEnabled() and NO_TAGS_PVP or NO_TAGS)) do
                    if v:IsValid() and v.entity:IsVisible() then
                        if inst.components.combat:CanTarget(v) then
                            --if target is not targeting a player, then use the catapult as attacker to draw aggro
                            inst.components.combat:DoAttack(v)
                            --v.components.combat:GetAttacked(attacker, damage + level*.25)
                        end
                    end
                end
            end

            inst.AnimState:PlayAnimation("slingshot_pre")
            inst.AnimState:PushAnimation("slingshot", false)
        end
    end
end)

AddStategraphPostInit("wilson_client", function(sg)
    local slingshot_shoot = sg.states.slingshot_shoot
    local oldonenter = slingshot_shoot.onenter
    slingshot_shoot.onenter = function(inst)
        
        if not inst:HasTag("quickshot") then
            oldonenter(inst)
        else
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("slingshot_pre")
            inst.AnimState:PushAnimation("slingshot_lag", false)

            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil then
                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:ForceFacePoint(buffaction.target:GetPosition())
                end

                inst:PerformPreviewBufferedAction()
            end
        end
    end
end)

local old_eat_fn = _G.ACTIONS.EAT.fn
_G.ACTIONS.EAT.fn = function(act) 
    local obj = act.target or act.invobject
    if obj ~= nil then
        if obj.prefab=="potion_achiv" and obj._userid~=nil and obj._userid ~= act.doer.userid then
            return false
        end
    end
    return old_eat_fn(act)
end

--wickerbottom
AddRecipe("book_treat", 
    {Ingredient("papyrus", 2), Ingredient("spidergland", 5), Ingredient("charcoal", 2)}, 
    GLOBAL.CUSTOM_RECIPETABS.BOOKS, 
    TECH.NONE, 
    nil, 
    nil, 
    nil, 
    nil, 
    "achivbookbuilder", 
    "images/book_treat.xml"
)

AddRecipe("book_kill", 
    {Ingredient("papyrus", 5), Ingredient("livinglog", 2), Ingredient("purplegem", 4)}, 
    GLOBAL.CUSTOM_RECIPETABS.BOOKS, 
    TECH.NONE, 
    nil, 
    nil, 
    nil, 
    nil, 
    "achivbookbuilder", 
    "images/book_kill.xml"
)

AddRecipe("book_kill_new", 
    {Ingredient("papyrus", 5), Ingredient("livinglog", 4), Ingredient("purplegem", 2)}, 
    GLOBAL.CUSTOM_RECIPETABS.BOOKS, 
    TECH.NONE, 
    nil, 
    nil, 
    nil, 
    nil, 
    "achivbookbuilder", 
    "images/book_kill_new.xml"
)

AddRecipe("book_season", 
    {Ingredient("papyrus", 8), Ingredient("opalstaff", 1), Ingredient("greengem", 4)}, 
    GLOBAL.CUSTOM_RECIPETABS.BOOKS, 
    TECH.NONE, 
    nil, 
    nil, 
    nil, 
    nil, 
    "achivbookbuilder", 
    "images/book_season.xml"
)

--willson
AddRecipe("potion_luck", {Ingredient("wormlight",2),Ingredient("butter",1),Ingredient("cave_banana",3)},
RECIPETABS.MAGIC, 
TECH.NONE, 
nil, 
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"potionbuilder", -- builder_tag
"images/potions/potion_luck.xml"
)

AddRecipe("potion_blue", {Ingredient("bluegem",2),Ingredient("stinger",8),Ingredient("petals",3)}, 
RECIPETABS.MAGIC, 
TECH.NONE, 
nil, 
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"potionbuilder", -- builder_tag
"images/potions/potion_blue.xml"
)

AddRecipe("potion_green", {Ingredient("green_cap",5),Ingredient("nightmarefuel",5),Ingredient("rottenegg",4)},
RECIPETABS.MAGIC, 
TECH.NONE, 
nil, 
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"potionbuilder", -- builder_tag
"images/potions/potion_green.xml"
)

AddRecipe("potion_red", {Ingredient("glommerfuel",1),Ingredient("petals_evil",5),Ingredient("mosquitosack",3)},
RECIPETABS.MAGIC, 
TECH.NONE, 
nil, 
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"potionbuilder", -- builder_tag
"images/potions/potion_red.xml"
)

AddRecipe("statusclock", {Ingredient("pocketwatch_parts",1),Ingredient("yellowgem",3)},
CUSTOM_RECIPETABS.CLOCKMAKER, 
TECH.NONE, 
nil, 
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"achivwatchmaker", --"旺达专属标签",
"images/statusclock.xml"
)

AddRecipe("fatemod",{Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 5),Ingredient("goldnugget",2)},
RECIPETABS.MAGIC, --魔法
TECH.NONE, 
nil,
nil, 
nil,
nil, 
"nonequivalence",
"images/fatemod.xml","fatemod.tex")

end

if TUNING.new_items then
AddRecipe("opalgemsamulet",{Ingredient("opalpreciousgem", 1),Ingredient("nightmarefuel", 5),Ingredient("thulecite", 4)},
_G.RECIPETABS.ANCIENT, --远古科技
_G.TECH.ANCIENT_FOUR, 
nil,
nil, 
true, 
nil, 
nil,
"images/opalgemsamulet.xml","opalgemsamulet.tex")
end


if TUNING.more_blueprint then
    AddRecipe("book_gardening", {Ingredient("papyrus", 2), Ingredient("seeds", 1), Ingredient("poop", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
    AddRecipe("book_sleep",     {Ingredient("papyrus", 2), Ingredient("nightmarefuel", 2)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
    AddRecipe("book_brimstone", {Ingredient("papyrus", 2), Ingredient("redgem", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
    AddRecipe("book_tentacles", {Ingredient("papyrus", 2), Ingredient("tentaclespots", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
    AddRecipe("slingshotammo_gold",        {Ingredient("goldnugget", 1)},                                          CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.NONE,      {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
    AddRecipe("slingshotammo_marble",      {Ingredient("marble", 1)},                                              CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.NONE,      {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
    AddRecipe("slingshotammo_poop",        {Ingredient("poop", 1)},                                                CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.NONE,      {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
    AddRecipe("slingshotammo_freeze",      {Ingredient("moonrocknugget", 1), Ingredient("bluegem", 1)},            CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.NONE,        {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
    AddRecipe("slingshotammo_slow",        {Ingredient("moonrocknugget", 1), Ingredient("purplegem", 1)},          CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.NONE,      {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
    AddRecipe("mermhouse_crafted", {Ingredient("boards", 4), Ingredient("cutreeds", 3), Ingredient("pondfish", 2)}, RECIPETABS.TOWN, TECH.NONE, "mermhouse_crafted_placer", nil, nil, nil, "merm_builder", nil, nil, IsMarshLand)
    AddRecipe("mermthrone_construction", {Ingredient("boards", 5), Ingredient("rope", 5)}, RECIPETABS.TOWN, TECH.NONE, "mermthrone_construction_placer", nil, nil, nil, "merm_builder", nil, nil, IsMarshLand)
    AddRecipe("mermwatchtower", {Ingredient("boards", 5), Ingredient("tentaclespots", 1), Ingredient("spear", 2)}, RECIPETABS.TOWN, TECH.NONE, "mermwatchtower_placer", nil, nil, nil, "merm_builder", nil, nil, IsMarshLand)
    AddRecipe("turf_marsh", {Ingredient("cutreeds", 1), Ingredient("spoiled_food", 2)}, RECIPETABS.TOWN,  TECH.NONE, nil, nil, nil, nil, "merm_builder")
    AddRecipe("opalgemsamulet",{Ingredient("opalpreciousgem", 1),Ingredient("nightmarefuel", 5),Ingredient("thulecite", 4)}, _G.RECIPETABS.ANCIENT, _G.TECH.ANCIENT_FOUR, nil, nil, true, nil, nil,"images/opalgemsamulet.xml","opalgemsamulet.tex")
end

