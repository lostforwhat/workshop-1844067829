local events = require("event_table")

local loot = { -- oceanfish_shoalspawner 鱼场
new_loot = {
        {chance = 5, item = "log"},--木头
        {chance = 1, item = "charcoal"},--木炭
        {chance = 0.06, item = "pinecone"},--松果
        {chance = 0.06, item = "acorn"},--桦木果
        {chance = 0.5, item = "flint"},--燧石
        {chance = 0.4, item = "nitre"},--硝石
        {chance = 1, item = "rocks"},--石头
        {chance = 2, item = "cutgrass"},--草
        {chance = 2, item = "twigs"},--树枝
        {chance = 0.5, item = "petals"},--花瓣
        {chance = 0.5, item = "foliage"},--蕨叶
        {chance = 0.1, item = "marble"},--大理石
        {chance = 0.2, item = "goldnugget"},--黄金
        {chance = 2, item = "ice"},--冰
        {chance = 0.15, item = "dug_grass"},--草丛
        {chance = 0.15, item = "dug_sapling"},--树苗
        {chance = 0.08, item = "dug_berrybush"},--普通浆果丛
        {chance = 0.08, item = "dug_berrybush2"},--三叶浆果丛
        {chance = 1, item = "petals_evil"},--恶魔花瓣
        {chance = 0.5, item = "cutreeds"},--芦苇
        {chance = 2, item = "tumbleweed"},--风滚草
        {chance = 0.5, item = "boards"},--木板
        {chance = 0.5, item = "cutstone"},--石砖
        {chance = 0.2, item = "papyrus"},--纸
        {chance = 0.8, item = "pigskin"},--猪皮
        {chance = 0.2, item = "manrabbit_tail"},--兔毛
        {chance = 1, item = "spidergland"},--蜘蛛腺体
        {chance = 0.02, item = "honeycomb"},--蜂巢
        {chance = 0.2, item = "tentaclespots"},--触手皮
        {chance = 0.5, item = "mosquitosack"},--蚊子血囊
        {chance = 0.2, item = "lightninggoathorn"},--闪电羊角
        {chance = 0.2, item = "glommerfuel"},--咕噜姆黏液
        {chance = 1.2, item = "nightmarefuel"},--噩梦燃料
        {chance = 0.2, item = "transistor"},--电子元件
        {chance = 0.5, item = "poop"},--便便
        {chance = 0.2, item = "compostwrap"},--肥料包
        {chance = 0.02, item = "waxpaper"},--蜡纸
        {chance = 0.1, item = "moonrocknugget"},--月石
        {chance = 0.5, item = "houndstooth"},--狗牙
        {chance = 0.05, item = "stinger"},--蜂刺
        {chance = 0.2, item = "gears"},--齿轮
        {chance = 0.1, item = "boneshard"},--骨头碎片
        {chance = 0.08, item = "spidereggsack"},--蜘蛛卵
        {chance = 0.5, item = "feather_crow"},--乌鸦羽毛
        {chance = 0.5, item = "feather_robin"},--红雀羽毛
        {chance = 0.5, item = "feather_robin_winter"},--冬雀羽毛
        {chance = 0.3, item = "feather_canary"},--金丝雀羽毛
        {chance = 0.3, item = "beefalowool"},--牛毛
        {chance = 0.5, item = "beardhair"},--胡子
        {chance = 0.05, item = "townportaltalisman"},--砂石
        {chance = 1, item = "lightbulb"},--荧光果
        {chance = 1.5, item = "foliage"},--蕨叶
        {chance = 0.1, item = "lureplantbulb"},--食人花
        {chance = 0.02, item = "slurtleslime"},--蜗牛黏液
        {chance = 0.02, item = "slurtle_shellpieces"},--蜗牛壳碎片
        {chance = 0.1, item = "slurper_pelt"},--啜食者皮
        {chance = 0.5, item = "guano"},--鸟粪
        {chance = 0.05, item = "fossil_piece"},--化石碎片
        {chance = 5, item = "berries"},--浆果
        {chance = 0.34, items = {"seeds","asparagus_seeds","carrot_seeds","corn_seeds","dragonfruit_seeds","durian_seeds","eggplant_seeds",
            "garlic_seeds","onion_seeds","pepper_seeds","pomegranate_seeds","potato_seeds","pumpkin_seeds","tomato_seeds","watermelon_seeds"}},--种子
        {chance = 1, item = "red_cap"},--红蘑菇
        {chance = 0.5, item = "green_cap"},--绿蘑菇
        {chance = 2, item = "blue_cap"},--蓝蘑菇
        {chance = 0.3, item = "trunk_summer"},--夏象鼻
        {chance = 0.2, item = "trunk_winter"},--冬象鼻
        {chance = 0.4, item = "pumpkin"},--南瓜
        {chance = 0.2, item = "dragonfruit"},--火龙果
        {chance = 0.8, item = "pomegranate"},--石榴
        {chance = 0.6, item = "corn"},--玉米
        {chance = 1, item = "durian"},--榴莲
        {chance = 0.8, item = "eggplant"},--茄子
        {chance = 0.3, item = "cave_banana"},--洞穴香蕉
        {chance = 0.3, item = "cactus_meat"},--仙人掌肉
        {chance = 0.5, item = "watermelon"},--西瓜
        {chance = 0.3, item = "smallmeat"},--小肉
        {chance = 0.2, item = "meat"},--大肉
        {chance = 0.3, item = "barnacle"},--藤壶
        {chance = 0.5, item = "drumstick"},--鸡腿
        {chance = 0.8, item = "monstermeat"},--疯肉
        {chance = 0.5, item = "plantmeat"},--食人花肉
        {chance = 0.4, item = "bird_egg"},--鸡蛋
        {chance = 0.1, item = "tallbirdegg"},--高鸟蛋
        {chance = 0.5, item = "fish"},--鱼
        {chance = 0.5, item = "froglegs"},--蛙腿
        {chance = 0.3, item = "batwing"},--蝙蝠翅膀
        {chance = 0.01, item = "mandrake"},--曼德拉草
        {chance = 0.5, item = "honey"},--蜂蜜
        {chance = 0.02, item = "butter"},--黄油
        {chance = 0.15, item = "milkywhites"},--乳白物
        {chance = 0.1, item = "goatmilk"},--羊奶
        {chance = 0.1, item = "fig"},--无花果
        {chance = 0.05, item = "brush"},--洗刷
        {chance = 0.05, item = "farm_plow_item"},--耕地机
        {chance = 0.05, item = "wateringcan"},--空浇水壶
        {chance = 0.05, item = "compost"},--耕作先驱帽
        {chance = 0.1, item = "soil_amender"},--堆肥
        {chance = 0.1, item = "plantregistryhat"},--催长剂起子
        {chance = 0.5, item = "axe"},--斧头
        {chance = 0.25, item = "goldenaxe"},--黄金斧头
        {chance = 0.15, item = "moonglassaxe"},--月光玻璃斧头
        {chance = 0.5, item = "pickaxe"},--鹤嘴锄
        {chance = 0.25, item = "goldenpickaxe"},--黄金鹤嘴锄
        {chance = 0.4, item = "shovel"},--铲子
        {chance = 0.25, item = "goldenshovel"},--黄金铲子
        {chance = 0.5, item = "farm_hoe"},--园艺锄
        {chance = 0.25, item = "golden_farm_hoe"},--黄金园艺锄
        {chance = 0.1, item = "hammer"},--锤子
        {chance = 0.05, items = {"boat_item","boat_grass_item"}},--船套装
        {chance = 0.06, items = {"boatpatch","anchor_item","oar","steeringwheel_item","golden_farm_hoe","boat_cannon_kit","ocean_trawler_kit"}},--桅杆套装
        {chance = 0.05, item = "mast_item"},--海钓竿
        {chance = 0.05, item = "boat_rotator_kit"},--海钓竿
        {chance = 0.05, item = "oceanfishingrod"},--木球浮标
        {chance = 0.05, item = "oceanfishingbobber_ball"},--木球浮标
        {chance = 0.05, item = "oceanfishingbobber_oval"},--硬物浮标
        {chance = 0.2, item = "saltrock"},--盐晶
        {chance = 0.1, item = "featherpencil"},--羽毛笔
        {chance = 0.1, item = "pitchfork"},--草叉
        {chance = 0.05, items = {"houndbone","skeleton","dead_sea_bones","pighead","mermhead"}, building = true},--骨\头柱
        {chance = 0.01, items = {"driftwood_tall","driftwood_tall1","driftwood_tall2"}, building = true},--浮木桩
        {chance = 0.1, item = "trap"},--陷阱
        {chance = 0.1, item = "grass_umbrella"},--普通花伞
        {chance = 0.4, item = "bedroll_straw"},--凉席
        {chance = 0.3, item = "spear"},--长矛
        {chance = 0.4, item = "armorgrass"},--草甲
        {chance = 0.1, item = "flowerhat"},--花环
        {chance = 0.1, item = "strawhat"},--草帽
        {chance = 0.1, item = "watermelonhat"},--西瓜帽
        {chance = 0.05, item = "featherhat"},--羽毛帽
        {chance = 0.02, item = "bushhat"},--灌木帽
        {chance = 0.1, item = "tophat"},--绅士高帽
        {chance = 0.15, item = "rainhat"},--防雨帽
        {chance = 0.15, item = "earmuffshat"},--小兔耳罩
        {chance = 0.1, item = "beefalohat"},--牛角帽
        {chance = 0.15, item = "winterhat"},--冬帽
        {chance = 0.1, item = "catcoonhat"},--浣熊猫帽子
        {chance = 0.2, item = "icehat"},--冰块帽
        {chance = 0.05, item = "beehat"},--养蜂帽
        {chance = 0.1, item = "raincoat"},--雨衣
        {chance = 0.33, item = "sweatervest"},--格子背心
        {chance = 0.15, item = "trunkvest_summer"},--保暖小背心
        {chance = 0.13, item = "reflectivevest"},--清凉夏装
        {chance = 0.13, item = "hawaiianshirt"},--花衬衫
        {chance = 0.02, item = "lifeinjector"},--强心针
        {chance = 0.25, item = "birdtrap"},--捕鸟陷阱
        {chance = 0.25, item = "bugnet"},--捕虫网
        {chance = 0.05, item = "fishingrod"},--钓竿
        {chance = 0.15, item = "umbrella"},--雨伞
        {chance = 0.1, item = "waterballoon"},--水球
        {chance = 0.1, item = "heatrock"},--热能石
        {chance = 0.08, item = "piggyback"},--猪皮背包
        {chance = 0.1, item = "bedroll_furry"},--毛皮铺盖
        {chance = 0.1, item = "fertilizer"},--堆肥桶
        {chance = 0.1, item = "sewing_kit"},--针线包
        {chance = 0.1, item = "minerhat"},--矿工帽
        {chance = 0.1, item = "molehat"},--鼹鼠帽
        {chance = 0.1, item = "lantern"},--提灯
        {chance = 0.1, item = "deer_antler"},--鹿角
        {chance = 2, item = "butterfly"},--蝴蝶
        {chance = 0.1, item = "fireflies"},--萤火虫
        {chance = 1.8, item = "perd"},--火鸡
        {chance = 1, item = "bee", aggro = true},--蜜蜂   
        {chance = 0.1, item = "beefalo", aggro = true},--牛
        {chance = 0.1, item = "lightninggoat", aggro = true},--闪电羊
        {chance = 0.1, item = "pigman", aggro = true},--猪人
        {chance = 0.02, item = "little_walrus", aggro = true},--小海象
        {chance = 0.2, items = {"koalefant_summer","koalefant_winter"}, aggro = true},--大象
        {chance = 0.05, item = "rocky", aggro = true},--石虾
        {chance = 0.12, item = "catcoon", aggro = true},--猫
        {chance = 0.1, item = "carrat_planted"},--胡萝卜鼠
        {chance = 0.05,item="wobster_sheller"},--龙虾
        {chance = 0.1, item = "dug_sapling_moon"},--月岛树苗
        {chance = 0.02, item = "dug_bananabush"},--香蕉丛
        {chance = 0.02, item = "dug_monkeytail"},--猴尾草
        {chance = 0.2, item = "moonbutterfly"},--蝴蝶
        {chance = 0.1, item = "moonglass"},--月亮碎片
        {chance = 0.3, item = "fruitdragon", aggro = true},--沙拉蝾螈
        {chance = 0.05, item = "dug_trap_starfish"},--海星陷阱
        {chance = 0.2, item = "bullkelp_beachedroot"},--海带
        {chance = 0.6, item = "driftwood_log"},--浮木
        {chance = 0.15, item = "dug_marsh_bush"},--荆棘丛
        {chance = 0.01, item = "rock_avocado_bush", building = true},--石果灌木种下
        {chance = 0.1, item = "dug_rock_avocado_bush"},--石果灌木
        {chance = 0.1, items = {"spore_medium","spore_small","spore_tall","lightflier"}},--孢子
        {chance = 0.04, item = "livingtree", building = true},--完全正常的树
        {chance = 0.08, item = "dug_berrybush_juicy"},--多汁浆果丛
        {chance = 0.02, item = "phlegm"},--脓鼻涕
        {chance = 0.1, item = "eel"},--鳗鱼
        {chance = 0.1, item = "bullkelp_root"},--海带茎
        {chance = 0.01, item = "waterplant_planter"},--海芽插穗
        {chance = 0.01, item = "palmcone_scale"},--棕榈松果树鳞片
        {chance = 0.01, item = "palmcone_seed"},--棕榈松果树芽
        {chance = 0.01, item = "yotc_seedpacket"},--种子包
    },

s_loot = {
        -- {chance = 0.1, item = "butterflymuffin"},--蝴蝶松饼
        -- {chance = 0.2, item = "frogglebunwich"},--蛙腿三明治 
        -- {chance = 0.09, item = "honeyham"},--蜜汁火腿
        -- {chance = 0.09, item = "figatoni"},--无花果意面 
        -- {chance = 0.09, item = "frognewton"},--无花果蛙腿三明治 变暖
        -- {chance = 0.09, item = "figkabab"},--无花果烤串 变暖
        -- {chance = 0.09, item = "ceviche"},--酸橘汁腌鱼 降温
        -- {chance = 0.04, item = "dragonpie"},--火龙果馅饼
        -- {chance = 0.05, item = "taffy"},--太妃糖
        -- {chance = 0.05, item = "pumpkincookie"},--南瓜饼
        -- {chance = 0.15, item = "kabobs"},--肉串 变暖
        -- {chance = 0.05, item = "powcake"},--芝士蛋糕
        -- {chance = 0.02, item = "mandrakesoup"},--曼德拉草汤
        -- {chance = 0.04, item = "baconeggs"},--培根煎蛋
        -- {chance = 0.06, item = "bonestew"},--肉汤
        -- {chance = 0.25, item = "ratatouille"},--蔬菜什锦
        -- {chance = 0.15, item = "fruitmedley"},--水果圣代
        -- {chance = 0.18, item = "fishtacos"},--玉米鱼卷
        -- {chance = 0.05, item = "waffles"},--华夫饼
        -- {chance = 0.05, item = "turkeydinner"},--火鸡正餐
        -- {chance = 0.04, item = "fishsticks"},--鱼排
        -- {chance = 0.15, item = "stuffedeggplant"},--香酥茄盒
        -- {chance = 0.4, item = "honeynuggets"},--甜蜜金砖
        -- {chance = 0.5, item = "meatballs"},--肉丸
        -- {chance = 0.25, item = "jammypreserves"},--果酱
        -- {chance = 0.15, item = "flowersalad"},--仙人掌沙拉
        -- {chance = 0.05, item = "icecream"},--冰淇淋
        -- {chance = 0.15, item = "watermelonicle"},--西瓜冰
        -- {chance = 0.45, item = "trailmix"},--坚果
        -- {chance = 0.05, item = "guacamole"},--鳄梨沙拉
        -- {chance = 0.15, item = "glowberrymousse"},--发光浆果慕斯
        -- {chance = 0.03, item = "barnaclesushi"},--藤壶握寿司
        -- {chance = 0.03, item = "barnaclinguine"},--藤壶中细面
        -- {chance = 0.03, item = "barnaclepita"},--藤壶皮塔饼
        -- {chance = 0.03, item = "shroomcake"},--蘑菇蛋糕
        -- {chance = 0.03, item = "californiaroll"},--加州卷
        -- {chance = 0.03, item = "sweettea"},--舒缓茶 变暖
        -- {chance = 0.04, item = "leafymeatsouffle"},--果冻沙拉
        -- {chance = 0.06, item = "leafymeatburger"},--素食堡
        -- {chance = 0.09, item = "leafloaf"},--叶肉糕
        -- {chance = 0.05, item = "surfnturf"},--海鲜牛排
        -- {chance = 0.09, item = "seafoodgumbo"},--海鲜浓汤
        -- {chance = 0.05, item = "lobsterbisque"},--龙虾汤
        -- {chance = 0.09, item = "lobsterdinner"},--龙虾正餐
        -- {chance = 0.3, item = "tillweedsalve"},--犁地草膏
        -- {chance = 0.03, item = "unagi"},--鳗鱼料理
        -- {chance = 0.07, item = "vegstinger"},--蔬菜鸡尾酒
        -- {chance = 0.13, item = "voltgoatjelly"},--伏特羊肉冻
        {chance = 0.01, item = "yotc_seedpacket_rare"},--高级种子包
        {chance = 0.3, item = "healingsalve"},--治疗药膏
        {chance = 0.2, item = "bandage"},--蜂蜜药膏
        {chance = 0.01, item = "walrus_tusk"},--象牙
        {chance = 0.02, item = "bundlewrap"},--捆绑包装纸
        {chance = 0.05, item = "featherfan"},--羽毛扇
        {chance = 0.02, item = "icepack"},--保鲜背包
        {chance = 0.08, item = "multitool_axe_pickaxe"},--多功能工具
        --{chance = 0.01, item = "klaussackkey"},--克劳斯钥匙
        {chance = 0.2, item = "armorwood"},--木甲
        {chance = 0.15, item = "footballhat"},--橄榄球头盔
        {chance = 0.15, item = "hambat"},--火腿棍
        {chance = 0.1, item = "nightstick"},--晨星
        {chance = 0.15, item = "tentaclespike"},--狼牙棒
        {chance = 0.15, item = "glasscutter"},--玻璃刀
        {chance = 0.1, item = "whip"},--三尾猫鞭
        {chance = 0.1, item = "armormarble"},--大理石甲
        {chance = 0.3, item = "blowdart_sleep"},--催眠吹箭
        {chance = 0.3, item = "blowdart_fire"},--火焰吹箭
        {chance = 0.5, item = "blowdart_pipe"},--吹箭
        {chance = 0.2, item = "blowdart_yellow"},--电箭
        {chance = 0.2, item = "boomerang"},--回旋镖
        {chance = 0.2, item = "waterplant_bomb"},--种壳

        {chance = 0.05, item = "shieldofterror"},--恐怖盾牌
        {chance = 0.1, item = "eyemaskhat"},--眼面具

        {chance = 0.1, item = "balloonspeed"},--迅捷气球
        {chance = 0.1, item = "balloonvest"},--充气背心
        {chance = 0.1, item = "balloonparty"},--派对气球

        {chance = 0.1, items = {"spice_sugar","spice_salt","spice_chili","spice_garlic"}},--香料

        {chance = 0.15, item = "wortox_soul"},--灵魂

        {chance = 0.1, item = "beemine"},--蜜蜂地雷
        {chance = 0.15, item = "trap_teeth"},--犬牙陷阱
        {chance = 0.15, item = "armorslurper"},--饥饿腰带
        {chance = 0.25, item = "wathgrithrhat"},--战斗头盔
        {chance = 0.15, item = "spear_wathgrithr"},--战斗长矛
        {chance = 0.1, item = "cutless"},--木头短剑
        {chance = 0.1, item = "oar_monkey"},--战桨
        {chance = 0.1, item = "gunpowder"},--炸药
        {chance = 0.06, item = "purplegem"},--紫宝石
        {chance = 0.1, item = "bluegem"},--蓝宝石
        {chance = 0.1, item = "moonrockcrater"},--带孔月岩
        {chance = 0.08, item = "redgem"},--红宝石
        {chance = 0.05, item = "armor_sanity"},--暗影护甲
        {chance = 0.05, item = "nightsword"},--暗夜剑
        {chance = 0.05, item = "batbat"},--蝙蝠棒
        {chance = 0.1, item = "amulet"},--重生护符
        {chance = 0.08, item = "blueamulet"},--寒冰护符
        {chance = 0.03, item = "purpleamulet"},--噩梦护符
        {chance = 0.05, item = "firestaff"},--火焰法杖
        {chance = 0.05, item = "icestaff"},--冰魔杖
        {chance = 0.02, item = "telestaff"},--传送魔杖
        {chance = 0.2, item = "thulecite_pieces"},--铥矿碎片
        {chance = 0.05, item = "armordragonfly"},--鳞甲
        {chance = 0.05, item = "staff_tornado"},--天气棒
        {chance = 0.05, item = "goggleshat"},--时髦目镜
        {chance = 0.05, item = "deserthat"},--沙漠目镜
        {chance = 0.05, item = "trunkvest_winter"},--寒冬背心
        {chance = 0.06, item = "steelwool"},--钢绒
        {chance = 0.05, item = "goose_feather"},--鹿鸭羽毛
        {chance = 0.01, item = "bearger_fur"},--熊皮
        {chance = 0.02, item = "beargervest"},--熊皮背心
        {chance = 0.05, items = {"red_mushroomhat","green_mushroomhat","blue_mushroomhat"}},--红蘑菇帽
        {chance = 0.1, item = "armor_bramble"},--荆棘甲
        {chance = 0.5, item = "blueprint"},--蓝图
        {chance = 0.02, item = "trident"},--三叉戟

        {chance = 0.01, item = "book_tentacles"}, --触手书
        {chance = 0.01, item = "book_birds"}, --鸟书
        {chance = 0.01, item = "book_brimstone"}, --末日书
        {chance = 0.01, item = "book_sleep"}, --催眠书

        {chance = 0.02, items = {"chessjunk","chessjunk1","chessjunk2","chessjunk3"}, building = true},--损坏的发条装置

        {chance = 0.01, items = {"statuemaxwell","marblepillar","statueharp","statue_marble_pawn","statue_marble","statue_marble_muse","marbletree"}, building = true},--大理石建筑

        {chance = 0.04, items = {"asparagus_oversized","carrot_oversized","corn_oversized","dragonfruit_oversized","durian_oversized","eggplant_oversized","garlic_oversized","onion_oversized",
        "pepper_oversized","pomegranate_oversized","potato_oversized","pumpkin_oversized","tomato_oversized","watermelon_oversized"}, building = true},--巨型蔬菜
        -- {chance = 0.04, item = "carrot_oversized"},--巨型胡萝卜
        -- {chance = 0.04, item = "corn_oversized"},--巨型玉米
        -- {chance = 0.04, item = "dragonfruit_oversized"},--巨型火龙果
        -- {chance = 0.04, item = "durian_oversized"},--巨型榴莲
        -- {chance = 0.04, item = "eggplant_oversized"},--巨型茄子
        -- {chance = 0.04, item = "garlic_oversized"},--巨型大蒜
        -- {chance = 0.04, item = "onion_oversized"},--巨型洋葱
        -- {chance = 0.04, item = "pepper_oversized"},--巨型辣椒
        -- {chance = 0.04, item = "pomegranate_oversized"},--巨型石榴
        -- {chance = 0.04, item = "potato_oversized"},--巨型土豆
        -- {chance = 0.04, item = "pumpkin_oversized"},--巨型南瓜
        -- {chance = 0.04, item = "tomato_oversized"},--巨型西红柿
        -- {chance = 0.04, item = "watermelon_oversized"},--巨型西瓜

        {chance = 0.004, items = {"saltstack","seastack"}, building = true},--盐堆
        {chance = 0.02, items = {"shell_cluster","sunkenchest"}, building = true},--贝壳堆沉底宝箱
        {chance = 0.05, item = "mandrake_active"},--活曼德拉草
    },

ss_loot = {
        {chance = 0.006, item = "klaus_sack", building = true},--克劳斯袋
        {chance = 0.001, item = "krampus_sack"},--坎普斯背包
        {chance = 0.002, item = "minotaurhorn"},--远古守护者角
        {chance = 0.003, item = "deerclops_eyeball"},--巨鹿眼球
        {chance = 0.08, item = "livinglog", announce = false},--活木
        {chance = 0.005, item = "dragon_scales", announce = false},--蜻蜓鳞片
        {chance = 0.003, item = "shroom_skin", announce = false},--蛤蟆皮
        {chance = 0.002, item = "shadowheart"},--暗影之心
        {chance = 0.02, item = "orangegem", announce = false},--橙宝石
        {chance = 0.01, item = "yellowgem", announce = false},--黄宝石
        {chance = 0.01, item = "greengem"}, announce = false,--绿宝石
        {chance = 0.01, item = "opalpreciousgem"},--彩虹宝石
        {chance = 0.08, item = "thulecite", announce = false},--铥矿
        {chance = 0.08, item = "moonstorm_static_item", announce = false},--约束静电
        {chance = 0.005, item = "cane"},--步行手杖
        {chance = 0.01, item = "eyebrellahat"},--眼球伞
        {chance = 0.01, item = "polly_rogershat"},--波莉·罗杰的帽子
        {chance = 0.01, item = "panflute"},--排箫
        {chance = 0.02, item = "orangeamulet", announce = false},--懒人强盗
        {chance = 0.01, item = "yellowamulet"},--魔光护符
        {chance = 0.01, item = "greenamulet"},--建造护符
        {chance = 0.006, item = "orangestaff"},--瞬移魔杖
        {chance = 0.01, item = "yellowstaff"},--唤星者法杖
        {chance = 0.006, item = "greenstaff"},--解构魔杖
        {chance = 0.05, item = "ruinshat"},--远古皇冠
        {chance = 0.05, item = "armorruins"},--远古护甲
        {chance = 0.05, item = "ruins_bat"},--远古棒
        {chance = 0.002, item = "eyeturret_item"},--眼球塔
        {chance = 0.03, item = "slurtlehat", announce = false},--蜗牛帽
        {chance = 0.03, item = "armorsnurtleshell", announce = false},--蜗牛盔甲
        {chance = 0.01, item = "hivehat"},--蜂后头冠
        {chance = 0.002, item = "opalstaff"},--唤月法杖
        {chance = 0.005, item = "armorskeleton"},--远古骨甲
        {chance = 0.001, item = "ruins_statue_mage", building = true}, --远古雕像
        {chance = 0.001, item = "archive_moon_statue", building = true}, --远古月亮雕像
        {chance = 0.0003, item = "moonbase", building = true}, --月亮石
        {chance = 0.0005, item = "pigking", building = true}, --猪王
        {chance = 0.008, item = "oceanvine", building = true},--苔藓藤条植株
        {chance = 0.002, item = "cavelight", name = "洞穴光"}, -- 洞穴光
        {chance = 0.001, items = {"nightmaregrowth","atrium_idol","atrium_overgrowth"}, building = true}, --梦魇城墙
        {chance = 0.01, items = {"birdcage","lightning_rod","cookpot","mushroom_farm","firesuppressor","icebox","resurrectionstatue","siestahut","portabletent","tent","beebox"}, name = "家具", building = true}, --家具
    },

d_loot = {
        {chance = 0.01, item = "cursed_monkey_token"},--诅咒饰品
        {chance = 0.05, item = "monsterlasagna"},--怪物千层饼
        {chance = 0.05, item = "wetgoop"},--湿腻焦糊
        {chance = 0.05, item = "mushroombomb"},--炸弹蘑菇
        {chance = 0.05, item = "mushroombomb_dark"},--悲惨的炸弹蘑菇 
        {chance = 0.01, item = "shark", aggro = true},--岩石大白鲨 
        {chance = 0.01, item = "gnarwail", aggro = true},--一角鲸 
        {chance = 0.1, item = "spider_healer", aggro = true},--护士蜘蛛 
        {chance = 0.1, item = "spider_water", aggro = true},--海黾 
        {chance = 0.1, item = "grassgator", aggro = true},--草鳄鱼 
        {chance = 0.1, item = "tallbird", aggro = true},--高鸟
        {chance = 0.1, item = "crawlinghorror", aggro = true},--暗影爬行怪
        {chance = 0.1, item = "terrorbeak", aggro = true},--尖嘴暗影怪
        {chance = 0.1, item = "pigguard", aggro = true},--猪人守卫
        {chance = 0.1, item = "bunnyman", aggro = true},--兔人
        {chance = 0.4, item = "merm", aggro = true},--鱼人
        {chance = 0.1, item = "squid", aggro = true},--鱿鱼
        {chance = 0.1, item = "lightcrab", aggro = true},--发光蟹
        {chance = 0.1, item = "powder_monkey", aggro = true},--火药猴
        --{chance = 0.4, item = "mushgnome", aggro = true},--蘑菇地精
        {chance = 0.3, item = "spider_warrior", aggro = true},--蜘蛛战士
        {chance = 0.25, item = "spider_hider", aggro = true},--蜘蛛2
        {chance = 0.25, item = "spider_spitter", aggro = true},--蜘蛛3
        {chance = 0.3, item = "spider_dropper", aggro = true},--白蜘蛛
        {chance = 0.3, item = "spider_moon", aggro = true},--破碎蜘蛛
        {chance = 0.5, item = "hound", aggro = true},--猎狗
        {chance = 0.2, item = "firehound", aggro = true},--火狗
        {chance = 0.2, item = "icehound", aggro = true},--冰狗
        {chance = 0.08, item = "walrus", aggro = true},--海象
        {chance = 0.08, item = "slurtle", aggro = true},--蜗牛1
        {chance = 0.08, item = "snurtle", aggro = true},--蜗牛2
        {chance = 0.1, item = "slurper", aggro = true},--缀食者
        {chance = 0.14, item = "monkey", aggro = true},--猴子
        {chance = 0.6, item = "bat", aggro = true},--蝙蝠
        {chance = 1.2, item = "mosquito", aggro = true},--蚊子
        {chance = 1.1, item = "spider", aggro = true},--蜘蛛
        {chance = 0.6, item = "frog", aggro = true},--青蛙
        {chance = 0.1, item = "penguin", aggro = true},--企鹅
        --{chance = 0.05, item = "birchnutdrake", aggro = true},--坚果树精
        --{chance = 0.05, item = "deciduoustree", aggro = true},--桦木树精
        {chance = 0.002, item = "monkeybarrel", building = true, announce = true}, -- 猴子桶
        {chance = 0.002, item = "monkeyhut", building = true, announce = true}, -- 猴子小屋
        {chance = 0.002, item = "catcoonden", building = true, announce = true}, --中空树桩
        {chance = 0.002, item = "pigtorch", building = true, announce = true}, -- 猪人火炬
        {chance = 0.002, item = "houndmound", building = true, announce = true}, -- 猎犬丘
        {chance = 0.002, item = "wasphive", building = true, announce = true}, -- 杀人蜂巢
        {chance = 0.004, item = "beehive", building = true, announce = true}, -- 蜂窝
        {chance = 0.004, item = "wobster_den", building = true}, -- 龙虾窝
        {chance = 0.004, item = "moonglass_wobster_den", building = true}, -- 月光玻璃窝
        {chance = 0.002, item = "gingerbreadhouse", building = true}, -- 姜饼猪屋
        {chance = 0.01, item = "moonspider_spike"},--月亮蜘蛛钉
        {chance = 0.01, item = "trap_teeth_maxwell", building = true},--麦斯威尔的犬牙陷阱
        {chance = 0.02, item = "beemine_maxwell", building = true},--麦斯威尔的蚊子陷阱
    },

dd_loot = {
        {chance = 0.1, items = {"knight","knight_nightmare"}, aggro = true},--发条骑士
        -- {chance = 0.1, item = "knight_nightmare", aggro = true},--损坏的发条骑士
        {chance = 0.1, items = {"bishop","bishop_nightmare"}, aggro = true},--发条主教
        -- {chance = 0.1, item = "bishop_nightmare", aggro = true},--损坏的发条主教
        {chance = 0.1, items = {"rook","rook_nightmare"}, aggro = true},--发条战车
        -- {chance = 0.1, item = "rook_nightmare", aggro = true},--损坏的发条战车
        {chance = 0.1, item = "worm", aggro = true},--洞穴蠕虫
        {chance = 0.1, item = "krampus", aggro = true},--小偷
        {chance = 0.1, item = "mossling", aggro = true},--小鸭
        {chance = 0.2, item = "tentacle", aggro = true},--触手
        {chance = 0.05, item = "spiderqueen", aggro = true, announce = true},--蜘蛛女王
        {chance = 0.05, item = "leif", aggro = true, announce = true},--树精
        {chance = 0.05, item = "leif_sparse", aggro = true, announce = true},--稀有树精
        --{chance = 0.01, item = "deerclops", aggro = true},--巨鹿
        --{chance = 0.02, item = "moose", aggro = true},--鹿鸭
        {chance = 0.02, item = "warg", aggro = true, announce = true},--座狼
        --{chance = 0.01, item = "bearger", aggro = true},--熊大
        {chance = 0.03, item = "spat", aggro = true, announce = true},--钢羊
        --{chance = 0.02, item = "shadow_rook", aggro = true},--暗影战车
        --{chance = 0.02, item = "shadow_knight", aggro = true},--暗影骑士
        --{chance = 0.02, item = "shadow_bishop", aggro = true},--暗影主教 
    },

big_boss_loot = {
        --{chance = 0.01, item = "minotaur", aggro = true},--远古守护者
        {chance = 0.01, item = "dragonfly", aggro = true},--龙蝇
        {chance = 0.01, item = "beequeen", aggro = true},--蜂后
        --{chance = 0.01, item = "toadstool", aggro = true},--蘑菇蛤
        {chance = 0.03, item = "deerclops", aggro = true},--巨鹿
        {chance = 0.05, item = "moose", aggro = true},--鹿鸭\麋鹿鹅
        -- {chance = 0.02, item = "warg", aggro = true},--座狼
        {chance = 0.03, item = "bearger", aggro = true},--熊大
        {chance = 0.03, item = "klaus", name = "克劳斯", event = events.klaus},--克劳斯
        --{chance = 0.01, item = "stalker_atrium", aggro = true},--远古影织者
        --{chance = 0.01, item = "stalker", aggro = true},--复活的骨架
        --{chance = 0.03, item = "stalker_forest", aggro = true},--森林守护者
        --{chance = 0.005, item = "alterguardian_phase1", aggro = true},--天体英雄
        {chance = 0.02, items = {"shadow_rook","shadow_knight","shadow_bishop"}, aggro = true},--暗影战车
        -- {chance = 0.02, item = "shadow_knight", aggro = true},--暗影骑士
        -- {chance = 0.02, item = "shadow_bishop", aggro = true},--暗影主教 
        -- {chance = 0.03, item = "malbatross", aggro = true},--邪天翁
        -- {chance = 0.01, item = "crabking", aggro = true},--帝王蟹

        {chance = 0.03, item = "eyeofterror", aggro = true},--恐怖之眼

        {chance = 0.03, items = {"twinofterror1","twinofterror2"}, aggro = true},--机械之眼1 激光眼
        -- {chance = 0.03, item = "twinofterror2", aggro = true},--机械之眼2 魔焰眼
    },

cave_loot = {
        {chance = 0.09, item = "mushroombomb"},--炸弹蘑菇
        {chance = 0.09, item = "mushroombomb_dark"},--悲惨的炸弹蘑菇 
        {chance = 0.01, item = "spiderhole", building = true}, -- 蜘蛛岩
        {chance = 0.1, item = "molebat", aggro = true},--裸鼹鼠蝙蝠
        {chance = 0.1, item = "bat", aggro = true},--蝙蝠
        {chance = 0.14, item = "monkey", aggro = true},--猴子
        {chance = 0.08, item = "slurtle", aggro = true},--蜗牛1
        {chance = 0.08, item = "snurtle", aggro = true},--蜗牛2
        {chance = 0.01, item = "slurtlehole", building = true},--蜗牛巢穴
        {chance = 0.1, item = "slurper", aggro = true},--缀食者
    },

cave_boss_loot = {
        {chance = 0.01, item = "stalker", aggro = true},--复活的骨架
        {chance = 0.01, item = "minotaur", aggro = true},--远古守护者
        {chance = 0.01, item = "toadstool", aggro = true},--蘑菇蛤
        {chance = 0.01, item = "toadstool_dark", aggro = true},--毒蘑菇蛤
    },
forest_boss_loot = {
        {chance = 0.01, item = "malbatross", aggro = true},--邪天翁
        {chance = 0.01, item = "crabking", aggro = true, building = true},--帝王蟹
    },

trap_loot = { --陷阱
        {chance = 0.01, item = "rock_circle", trap = true},--囚笼陷阱
        {chance = 0.04, item = "lightningstrike", trap = true},--天雷陷阱
        {chance = 0.05, item = "sanity_attack", trap = true},--脑残陷阱
        {chance = 0.02, item = "perish_attack", trap = true},--腐烂陷阱
        {chance = 0.02, item = "broken_attack", trap = true},--破坏陷阱
        {chance = 0.05, item = "tentacle_circle", trap = true},--触手阵陷阱
        {chance = 0.01, item = "boom_circle", trap = true},--爆炸陷阱
        {chance = 0.04, item = "fire_circle", trap = true},--火烧陷阱
        {chance = 0.002, item = "season_change", trap = true},--季节转换陷阱
        {chance = 0.02, item = "shadow_boss", trap = true},--暗影boss陷阱
        {chance = 0.05, item = "ghost_circle", trap = true},--鬼魂陷阱
        {chance = 0.08, item = "monster_circle", trap = true},--怪物陷阱
        {chance = 0.04, item = "campfire_circle", trap = true},--营火陷阱
        {chance = 0.01, item = "shit_circle", trap = true},--倒霉蛋陷阱        
        {chance = 0.01, item = "weatherchanged_circle", trap = true},--变天陷阱       
        {chance = 0.01, item = "lethargy", trap = true},--昏睡陷阱       
        {chance = 0.001, item = "prank", trap = true},--恶作剧       
        {chance = 0.01, item = "celestialfury", trap = true},--天体震怒     
    },

gift_loot = { --彩蛋
        {chance = 0.05, item = "tumbleweed_gift", gift = true},--风滚草彩蛋
        {chance = 0.01, item = "hutch_gift", gift = true},--哈奇彩蛋
        {chance = 0.005, item = "pond_gift", gift = true},--池塘彩蛋
        {chance = 0.03, item = "plant_gift", gift = true},--作物彩蛋
        {chance = 0.03, item = "cave_plant_gift", gift = true},--地下作物彩蛋
        {chance = 0.01, item = "bird_gift", gift = true},--鸟彩蛋
        {chance = 0.001, item = "resurrect_gift", gift = true},--复活石彩蛋
        {chance = 0.002, item = "ancient_gift", gift = true},--远古彩蛋
        {chance = 0.007, item = "cook_gift", gift = true},--锅冰箱彩蛋
        {chance = 0.03, item = "butterfly_gift", gift = true},--蝴蝶彩蛋
        {chance = 0.01, item = "player_gift", gift = true}, --专属彩蛋     
        {chance = 0.03, item = "box_gift", gift = true}, --箱子彩蛋    
        {chance = 0.06, item = "packing_gift", gift = true}, --礼物彩蛋       
        {chance = 0.01, item = "luck_gift", gift = true}, --好运来彩蛋       
        {chance = 0.02, item = "kingtreasure", gift = true}, --王的宝库     
        -- {chance = 0.02, item = "open_gift", gift = true}, --开草福利  
    },

new_items_loot = { --新物品
        {chance = 0.001, item="package_staff"}, --空间魔杖
        {chance = 0.004, item="prayer_symbol"}, --祈祷符
        {chance = 0.01, item="book_gardening"}, --园艺书
        {chance = 0.001, item="achiv_clear"}, --任务卷轴
        {chance = 0.001, item="book_season"}, --遗失法典
        {chance = 0.006, item="potion_luck"}, --幸运药水
        {chance = 0.004, item="potion_achiv"}, --神秘药水
        {chance = 0.009, item="stealingknife"}, --偷窃刀
	    {chance = 0.001, item="opalgemsamulet"}, --彩色护符 
    },
}
-- 添加海鱼
local fishs = {}
for i = 1, 9 do
    table.insert(fishs, "oceanfish_small_"..i.."_inv")
end
for i = 1, 8 do
    table.insert(fishs, "oceanfish_medium_"..i.."_inv")
end
table.insert(loot.new_loot,{chance = 0.5, items = fishs})

-- 添加食物
local preparedfoods = {}
local preparedfoods_spice1 = {}
local preparedfoods_spice2 = {}
local preparedfoods_spice3 = {}
local preparedfoods_spice4 = {}
local preparedfoods_warly = {}
local preparedfoods_warly_spice1 = {}
local preparedfoods_warly_spice2 = {}
local preparedfoods_warly_spice3 = {}
local preparedfoods_warly_spice4 = {}
-- 添加普通料理
for k, v in pairs(require("preparedfoods")) do
    -- table.insert(loots.foods,{chance = 0.04, item = v.name})
    table.insert(preparedfoods, v.name)
    -- -- 添加调料
    table.insert(preparedfoods_spice1, v.name.."_spice_garlic") --蒜
    table.insert(preparedfoods_spice2, v.name.."_spice_sugar") --糖
    table.insert(preparedfoods_spice3, v.name.."_spice_chili") --辣椒
    table.insert(preparedfoods_spice4, v.name.."_spice_salt") --盐
end
-- 添加大厨料理
for k, v in pairs(require("preparedfoods_warly")) do
    -- table.insert(loots.foods,{chance = 0.01, item = v.name})
    table.insert(preparedfoods_warly, v.name)
    -- -- 添加调料
    table.insert(preparedfoods_warly_spice1, v.name.."_spice_garlic") --蒜
    table.insert(preparedfoods_warly_spice2, v.name.."_spice_sugar") --糖
    table.insert(preparedfoods_warly_spice3, v.name.."_spice_chili") --辣椒
    table.insert(preparedfoods_warly_spice4, v.name.."_spice_salt") --盐
end

table.insert(loot.s_loot,{chance = 0.09, items = preparedfoods})
table.insert(loot.s_loot,{chance = 0.05, items = preparedfoods_spice1})
table.insert(loot.s_loot,{chance = 0.05, items = preparedfoods_spice2})
table.insert(loot.s_loot,{chance = 0.05, items = preparedfoods_spice3})
table.insert(loot.s_loot,{chance = 0.05, items = preparedfoods_spice4})
table.insert(loot.s_loot,{chance = 0.01, items = preparedfoods_warly})
table.insert(loot.s_loot,{chance = 0.01, items = preparedfoods_warly_spice1})
table.insert(loot.s_loot,{chance = 0.01, items = preparedfoods_warly_spice2})
table.insert(loot.s_loot,{chance = 0.01, items = preparedfoods_warly_spice3})
table.insert(loot.s_loot,{chance = 0.01, items = preparedfoods_warly_spice4})

loot.new_loot.parameter = {
    chancetype = "new_chance",-- 受影响权重的类型
    -- fixed = 63,-- 固定归属类型
    possible = 63,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    -- iscave = false,-- 是否洞穴独有
    -- isprotect = false,-- 是否受开局保护影响
    -- isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.s_loot.parameter = {
    chancetype = "s_chance",-- 受影响权重的类型
    fixed = 60,-- 固定归属类型
    possible = 60,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    -- iscave = false,-- 是否洞穴独有
    -- isprotect = false,-- 是否受开局保护影响
    -- isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.ss_loot.parameter = {
    chancetype = "ss_chance",-- 受影响权重的类型
    fixed = 56,-- 固定归属类型 
    possible = 63,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    -- iscave = false,-- 是否洞穴独有
    -- isprotect = false,-- 是否受开局保护影响
    isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.d_loot.parameter = {
    chancetype = "d_chance",-- 受影响权重的类型
    fixed = 7,-- 固定归属类型 
    possible = 7,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    -- iscave = false,-- 是否洞穴独有
    isprotect = true,-- 是否受开局保护影响
    -- isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.dd_loot.parameter = {
    chancetype = "dd_chance",-- 受影响权重的类型
    fixed = 7,-- 固定归属类型 
    possible = 7,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    -- iscave = false,-- 是否洞穴独有
    isprotect = true,-- 是否受开局保护影响
    -- isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.big_boss_loot.parameter = {
    chancetype = "dd_chance",-- 受影响权重的类型
    fixed = 7,-- 固定归属类型 
    possible = 7,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    -- iscave = false,-- 是否洞穴独有
    isprotect = true,-- 是否受开局保护影响
    isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.cave_loot.parameter = {
    chancetype = "d_chance",-- 受影响权重的类型
    fixed = 7,-- 固定归属类型 
    possible = 7,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    iscave = true,-- 是否洞穴独有
    isprotect = true,-- 是否受开局保护影响
    -- isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.cave_boss_loot.parameter = {
    chancetype = "dd_chance",-- 受影响权重的类型
    fixed = 7,-- 固定归属类型 
    possible = 7,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    iscave = true,-- 是否洞穴独有
    isprotect = true,-- 是否受开局保护影响
    isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.forest_boss_loot.parameter = {
    chancetype = "dd_chance",-- 受影响权重的类型
    fixed = 7,-- 固定归属类型 
    possible = 7,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    isforest = true,-- 是否森林独有
    isprotect = true,-- 是否受开局保护影响
    isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.trap_loot.parameter = {
    chancetype = "dd_chance",-- 受影响权重的类型
    fixed = 7,-- 固定归属类型 
    possible = 7,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    isprotect = true,-- 是否受开局保护影响
    -- isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.gift_loot.parameter = {
    chancetype = "ss_chance",-- 受影响权重的类型
    fixed = 56,-- 固定归属类型 
    possible = 60,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    isprotect = true,-- 是否受开局保护影响
    -- isannounce = true,-- 是否其内全部选项默认会宣告    
}
loot.new_items_loot.parameter = {
    chancetype = "ss_chance",-- 受影响权重的类型
    fixed = 56,-- 固定归属类型 
    possible = 60,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    isprotect = true,-- 是否受开局保护影响
    isannounce = true,-- 是否其内全部选项默认会宣告    
}

-- loot.cs = {
--     {chance = 0.2, item = "gears"},--齿轮
--     {chance = 0.2, item = "rocks"},--齿轮
-- }
-- table.insert(loot.cs,{chance = 0.5, items = fishs})
-- loot.cs.parameter = {
--     chancetype = "ss_chance",-- 受影响权重的类型
--     fixed = 63,-- 固定归属类型 
--     possible = 63,-- 可能归属类型
--     isrevise = true,-- 是否修正权重
--     -- isprotect = true,-- 是否受开局保护影响
--     -- isannounce = true,-- 是否其内全部选项默认会宣告    
-- }

return loot

--[[ 

parameter = {
    chancetype = "new_chance",\"s_chance",\"ss_chance",\"d_chance",\"dd_chance",-- 受影响权重的类型
    fixed = 1~63,-- 固定归属类型
    possible = 1~63,-- 可能归属类型
    isrevise = true,-- 是否修正权重
    iscave = false,-- 是否洞穴独有
    isforest = false,-- 是否森林独有
    isprotect = true,-- 是否受开局保护影响
    isannounce = true,-- 是否其内全部选项默认会宣告
}

1 -- 紫色
2 -- 绿色
4 -- 普通
8 -- 粉色
16 -- 橙色
32 -- 发光

]]