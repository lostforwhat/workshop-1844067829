local loot_table = require("loot_table")

local function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end

    return _copy(object)
end
local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
end
local function addnextdamage(self, inst)
	local level = inst.components.levelsystem and inst.components.levelsystem.level or 1
	local luck = inst.components.luck and inst.components.luck:GetLuck() or 1
	local maxdamage = 2000 + level*20
	self.nextdamage = self.nextdamage + math.random(1, level) * math.random(0, luck) * 0.01
	if self.nextdamage > maxdamage then
		self.nextdamage = maxdamage
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
        "archive_moon_statue",
        "nightmaregrowth",
        "atrium_idol",
        "atrium_overgrowth",
        "moonbase",
        "pigking",
        "achiv_clear",
        "blueprint",
        "little_walrus",
        "book_gardening",
        "book_sleep",
        "book_brimstone",
        "book_birds",
    }
    for i, v in ipairs(notice_goods) do
        if goods == v then 
            return true
        end
    end
    return false
end

local function randomItem(value)--传入vip等级
	--[[
	local num = GetTableLength(recycle_table)
	local rand = math.random(1, num)
	local index = 1
	for k,v in pairs(recycle_table) do
		if index == rand then
			if v < value then
				return k
			else
				rand = math.random(1, num)
			end
		else
			index = index + 1
		end
	end
	]]
	if loot_table == nil then return end
	--普通物品表
	local types1 = {"new_loot","s_loot"}
	--高级物品表
	local types2 = {"ss_loot","cave_loot","dd_loot","d_loot"}
	--稀有物品表
	local types3 = {"new_items_loot"}
	--选择的物品表
	local types = nil
    
    value= value or 0
    --根据算法，选择物品表
    local  gl = math.random()

    if  gl<= 0.05+0.1*(value/(value+1)) and TUNING.new_items then  --是否开启新物品啊
    	types=types3
    elseif gl<= 0.1+0.1*(value/(value+1)) then
    	types=types2
    else
    	types=types1
    end

	local items = deepcopy(loot_table[types[math.random(#types)]])
    local loot = items[math.random(#items)]--随机表中的项

	local prefab = loot.item  --项的名称
	if prefab=="bullkelp_beachedroot" then return SpawnPrefab("ash") end
	if prefab ~= nil and PrefabExists(prefab) then   --判断预制体是否存在
		local item = SpawnPrefab(prefab)
		if item.components.inventoryitem == nil then
			local pack_item = SpawnPrefab("package_ball")
			pack_item.components.packer:Pack(item)
			return pack_item
		end
		return item
	end
	return SpawnPrefab("ash")
end

local function HearPanFlute(inst, musician)
    if inst ~= musician and
        (TheNet:GetPVPEnabled() or not inst:HasTag("player")) and
        not (inst.components.freezable ~= nil and inst.components.freezable:IsFrozen()) and
        not (inst.components.pinnable ~= nil and inst.components.pinnable:IsStuck()) and
        not (inst.components.fossilizable ~= nil and inst.components.fossilizable:IsFossilized()) then
        local maxhealth = inst.components.health and inst.components.health.maxhealth or 0
        if maxhealth > 10000 then return end
        local mount = inst.components.rider ~= nil and inst.components.rider:GetMount() or nil
        if mount ~= nil then
            mount:PushEvent("ridersleep", { sleepiness = 10, sleeptime = TUNING.PANFLUTE_SLEEPTIME })
        end
        if inst.components.sleeper ~= nil then
            inst.components.sleeper:AddSleepiness(10, TUNING.PANFLUTE_SLEEPTIME)
        elseif inst.components.grogginess ~= nil then
            inst.components.grogginess:AddGrogginess(10, TUNING.PANFLUTE_SLEEPTIME)
        else
            inst:PushEvent("knockedout")
        end
    end
end
local function redirectdamagefn(inst, attacker, damage, weapon, stimuli)
	local function validtarget(target)
		if target ~= nil and target ~= attacker and target ~= inst
			and target:IsValid() and not target.inlimbo  then
			return target.components.combat and 
			(target.components.combat.redirectdamagefn == nil
				or (target.components.titlesystem and 
					target.components.titlesystem.equip ~= 7))
					and not target:HasTag("wall") or false
		end
		return false
	end
	local success, target = pcall(function() 
		local titles = inst.components.titlesystem and inst.components.titlesystem.titles or {}
		local equip = inst.components.titlesystem and inst.components.titlesystem.equip or 0
		if titles[7] == 1 then
			if math.random() < title_data["title7"]["direct"] then
				local x, y, z = inst.Transform:GetWorldPosition()
				local ents = TheSim:FindEntities(x,y,z, 15, {"_combat", "_health"}, { "FX", "NOCLICK", "DECOR", "INLIMBO" })
			    if #ents > 2 then
			    	local target = ents[math.random(#ents)]
			    	local times = 1
			    	while not validtarget(target) do
			    		target = ents[math.random(#ents)]
			    		times = times + 1
			    		if times > #ents then
			    			target = nil
			    			break
			    		end
			    	end
			    	if target ~= nil then
			    		return target
			    	end
			    end
			end
			
			if equip == 7 then
				local hppercent = inst.components.health and inst.components.health:GetPercent() or 1
				if hppercent <= title_data["title7"]["health"] then
					local followers = inst.components.leader and inst.components.leader.followers or {}
				    --if followers == nil then return nil end
				    for k,v in pairs(followers) do
				        if k:IsValid() and not k.inlimbo and 
				        	k.components.combat ~= nil and k.components.health ~= nil
				        	and k.components.health.invincible ~= true then
				        	return k
				        end 
				    end
				    if inst.bigbernies ~= nil and next(inst.bigbernies) ~= nil then
				    	for m,n in pairs(inst.bigbernies) do
				    		if m and n then
				    			if m:IsValid() and not m.inlimbo 
				    				and m.components.combat ~= nil and m.components.health ~= nil
				    				and m.components.health.invincible ~= true then
						        	return m
						        end 
				    		end
				    	end
				    end
				end
			end
		end 
		local hp = inst.components.health and inst.components.health.currenthealth or 0
		local invincible = inst.components.health and inst.components.health.invincible or false
		local luck = inst.components.luck and inst.components.luck:GetLuck() or 0
		local hppercent = inst.components.health and inst.components.health:GetPercent() or 1
		--[[if inst.prefab == "wathgrithr" and titles[5] == 1 then
			local miss = (1-hppercent)*title_data["title5"]["miss"]
			if not invincible and math.random()<miss then
				inst.components.health:SetInvincible(true)
				inst:DoTaskInTime(0.2, function() 
					inst.components.health:SetInvincible(false)
				end)
			end
		end]]
		if titles[10] == 1 and hp>0 and damage >= hp 
			and luck*5 >= hp and not invincible then
			if math.random() < title_data["title10"]["live"] then
				inst.components.health:SetInvincible(true)
				inst:DoTaskInTime(0.2, function() 
					inst.components.health:SetInvincible(false)
				end)
				inst.components.luck:DoDelta(math.ceil(hp/5))
			end
		end
		if titles[12] == 1 and not invincible and math.random()<title_data["title12"]["miss"] then
			inst.components.health:SetInvincible(true)
			inst:DoTaskInTime(0.2, function() 
				inst.components.health:SetInvincible(false)
			end)
		end
		return nil
	end)
	--print("--success--:"..tostring(success))
	--print("--target--:"..(target~=nil and target.prefab or "nil"))
	return target 
end
local function getluck(self, inst)
	local luck = inst.components.luck and inst.components.luck:GetLuck() or 0
	if self.titles[10] == 1 and luck < title_data["title10"]["luck"] then
		if math.random() < title_data["title10"]["luckup"] then
			inst.components.luck:DoDelta(1)
		end
	end
end
local function ontitles(self,titles) 
	for k,v in pairs(STRINGS.TITLE) do
		local value = titles[k] or 0
		self.inst["current"..v.id]:set(value)
		if titles[5] > 0 then
			if self.inst.components.crit then
				self.inst.components.crit:AddExtraChance("title5", title_data["title5"]["crit"])
			end
			if self.inst.components.lifesteal then
				self.inst.components.lifesteal:AddExtraPercent("title5", title_data["title5"]["stealhealth"])
			end
		else
			if self.inst.components.crit then
				self.inst.components.crit:RemoveExtraChance("title5")
			end
			if self.inst.components.lifesteal then
				self.inst.components.lifesteal:RemoveExtraPercent("title5")
			end
		end
		if titles[6] > 0 and self.inst.prefab=="wendy" then
			if self.inst.components.revenge == nil then
				self.inst:AddComponent("revenge")
			end
		end
	end
end
local function ondesc(self,desc)
	for k,v in pairs(STRINGS.TITLE) do
		local title = v.id
		local desc_val = desc[k] or {}
		for m,n in pairs(v.desc) do
			local val = desc_val[m] or 0
			self.inst["current"..title.."_desc"..tostring(m)]:set(val)
		end
	end
end
local function onequip(self,equip)
	if equip > 0 then
		if self.inst._title ~= nil then self.inst._title:Remove() end
		self.inst._title = SpawnPrefab("titles_fx_"..tostring(equip))
		self.inst._title.entity:SetParent(self.inst.entity)
		self.inst._title.Transform:SetPosition(0, 3.2 + self.titlepos, 0)
	else
		if self.inst._title ~= nil then self.inst._title:Remove() end
	end
	local inst = self.inst
	if equip == 12 then
		inst:DoTaskInTime(1, function()
			if inst._fireflylight ~= nil and inst._fireflylight.Light ~= nil then
				inst._fireflylight.Light:SetRadius(2)
			end
		end)
	else
		if inst._fireflylight ~= nil and inst._fireflylight.Light ~= nil then
			inst._fireflylight.Light:SetRadius(0.5)
		end
	end
	if equip == 5 then
		if self.inst.components.crit then
			self.inst.components.crit.max_hit = 6
		end
	else
		if self.inst.components.crit then
			self.inst.components.crit.max_hit = 4
		end
	end
	if equip == 10 then
		if self.inst.components.crit then
			self.inst.components.crit.luck_crit = true
		end
	else
		if self.inst.components.crit then
			self.inst.components.crit.luck_crit = false
		end
	end
	self.inst.currentequip:set(equip)
end

local function ontitlepos(self, titlepos)
	if self.inst._title ~= nil then
		self.inst._title.Transform:SetPosition(0, 3.2 + self.titlepos, 0)
	end
end
local function onnextdamage(self, nextdamage)
	self.inst.currentnextdamage:set(nextdamage)
end
local function onhasgift(self, hasgift)
	self.inst.currenthasgift:set(hasgift)
end
local function ongiftdata(self, giftdata)
	self.inst.currentgiftdata:set(TableToStr(giftdata))
	if giftdata and #giftdata > 0 then
		self.hasgift = 1
	else
		self.hasgift = 0
	end
end

local Titlesystem = Class(function(self, inst)
  self.inst = inst
	self.titles = {0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	self.desc = {
		{0},{0,0},{0,0,0},{0,0,0},{0,0,0},{0,0},{0,0,0},{0,0},{0,0,0,0},{0,0,0},{0,0,0,0},{0,0,0},{0},{0}
	}
	self.equip = 0

	self.killenragedklaus = 0
	self.deathtimes = 0
	self.tumbleweedtrap = {}
	self.vip_level = 0
	self.healthup = 0
	self.sanityup = 0
	self.hungerup = 0
	self.speedup = 0
	self.nextdamage = 0
	self.cmdcd = 0
	self.titlepos = 0
	self.hasgift = 0
	self.giftdata = {}
end,
nil,
{
    titles = ontitles,
    desc = ondesc,
    equip = onequip,
    titlepos = ontitlepos,
    nextdamage = onnextdamage,
    hasgift = onhasgift,
    giftdata = ongiftdata,
})


function Titlesystem:OnSave()
    local data = {
        titles = self.titles,
        desc = self.desc,
        equip = self.equip,
        killenragedklaus = self.killenragedklaus,
        deathtimes = self.deathtimes,
        tumbleweedtrap = self.tumbleweedtrap,
        healthup = self.healthup,
        sanityup = self.sanityup,
        hungerup = self.hungerup,
        speedup = self.speedup,
        cmdcd = self.cmdcd,
        titlepos = self.titlepos,
        hasgift = self.hasgift,
        giftdata = self.giftdata,
    }
    return data
end


function Titlesystem:OnLoad(data)
    self.titles = data.titles or {0,0,0,0,0,0,0,0,0,0,0,0,0}
    self.desc = data.desc or {
		{0},{0,0},{0,0,0},{0,0,0},{0,0,0},{0,0},{0,0,0},{0,0},{0,0,0,0},{0,0,0},{0,0,0,0},{0,0,0},{0},{0}
	}
    self.equip = data.equip or 0
    self.killenragedklaus = data.killenragedklaus or 0
    self.deathtimes = data.deathtimes or 0
    self.tumbleweedtrap = data.tumbleweedtrap or {}
    self.healthup = data.healthup or 0
    self.sanityup = data.sanityup or 0 
    self.hungerup = data.hungerup or 0
    self.speedup = data.speedup or 0
    self.cmdcd = data.cmdcd or 0
    self.titlepos = data.titlepos or 0
    self.hasgift = data.hasgift or 0
    self.giftdata = data.giftdata or {}
end

function Titlesystem:ApplayTilte(inst)
	inst:WatchWorldState("cycles", function() 
		local equip = self.equip
		if equip == 1 and inst.components.luck and inst.components.luck:GetLuck() < 80 then
			local cycles = TheWorld.state.cycles
			local age = inst.components.age and inst.components.age:GetAgeInDays() or 0
			if cycles % title_data["title1"]["days"] == 0 then
				local luck_val = title_data["title1"]["luck"] + math.min(math.ceil(cycles/(age+100)), 5)
				inst.components.luck:DoDelta(luck_val)
			end
		end
		if self.titles[9] == 1 and inst.prefab=="wormwood" then
        	local age = inst.components.age and inst.components.age:GetAgeInDays() or 0
        	self.healthup = math.min(math.floor(age/10), 100)
        	self.sanityup = math.min(math.floor(age/10), 100)
        	self.hungerup = math.min(math.floor(age/10), 100)
        end
        if self.equip == 12 then
        	local item = randomItem(500+self.vip_level*20) or SpawnPrefab("ash")
        	if math.random() < 0.01 then
        		local tb = {"tumbleweedspawner", "moonbase", "pond_cave", 
        		"ancient_altar", "pigking", "pigtorch"}
        		local package_ball = SpawnPrefab("package_ball")
        		local target = SpawnPrefab(tb[math.random(#tb)])
        		package_ball.components.packer:Pack(target)
        		inst.components.inventory:GiveItem(package_ball)
        		TheNet:Announce("【王者之巅】 "..self.inst:GetDisplayName().." 从每日物资里得到了珍贵的【"..package_ball:GetDisplayName().."】")
        	else
        		inst.components.inventory:GiveItem(item)
        	end
			--宣告贵重物品
    		if item ~= nil and needNotice(item.prefab) then
        		TheNet:Announce("【王者之巅】 "..self.inst:GetDisplayName().." 从每日物资里得到了珍贵的【"..item:GetDisplayName().."】")
    		elseif inst.components.talker then 
    			inst.components.talker:Say("【每日物资】 "..item:GetDisplayName(),2,true,true,false) 
    		end
        end
	end)
	inst:ListenForEvent("xpdelta", function(inst, data) 
		local value = data.value
		local extra_exp = 0
		if self.titles[1] == 1 then 
			local cycles = TheWorld.state.cycles
			local age = inst.components.age and inst.components.age:GetAgeInDays() or 0
			local num = (1-(age/cycles)) * 0.5
			if age <= 50 then
				extra_exp = extra_exp + math.ceil(value*num)
			end
		end
		if self.titles[2] == 1 then
			extra_exp = extra_exp + value*title_data["title2"]["exp"]
		end
		if self.titles[11] == 1 then
			extra_exp = extra_exp + value*title_data["title13"]["exp"]
		end
		if extra_exp>0 and self.xpcd ~= true then
			self.xpcd = true
			inst:DoTaskInTime(0.3, function() self.xpcd=false end)
			inst.components.levelsystem:xpDoDelta(extra_exp, inst)
		end
	end)
	inst:ListenForEvent("levelup", function(inst, data)
		if self.titles[2] == 1 then 
			local level = data.level
			local maxhealth = inst.components.health.maxhealth
			inst.components.health:DoDelta(title_data["title2"]["health"]*maxhealth)
			inst.components.sanity:DoDelta(title_data["title2"]["sanity"]*maxhealth)
		end
	end)
	--监听击中事件
	inst:ListenForEvent("onhitother", function(inst, data)
		local damage = data.damage
	    local target = data.target
	    if target:HasTag("wall") then return end  --如果目标有"墙"标签 结束
	    if target.components.health == nil then return end   --目标有血量组件吗
	    local hp = target.components.health and target.components.health.currenthealth or 0
	    local maxhp = target.components.health and target.components.health.maxhealth or 0
	    local extra_damage = 0   --额外伤害
	    if self.titles[11] == 1 then    --厄运之躯
	    	local luck = inst.components.luck and inst.components.luck:GetLuck() or 0
	    	if luck < title_data["title11"]["luck"] then
	    		extra_damage = extra_damage + title_data["title11"]["extra"]*damage
	    	end
	    	if self.equip == 11 and math.random() < title_data["title11"]["per"] then
	    		local weapon = inst.components.combat:GetWeapon()
	    		if weapon ~= nil then
	    			local num = 0
	    			if weapon.components.finiteuses ~= nil then
	    				num = weapon.components.finiteuses:GetUses()
	    			end
	    			if weapon.components.perishable ~= nil then
	    				num = weapon.components.perishable:GetPercent() * 100
	    			end
	    			if num > 1 then
	    				extra_damage = extra_damage + title_data["title11"]["damage"]*damage*num
	    				inst:DoTaskInTime(0.3, function() weapon:Remove() end)
	    			end
	    		end
	    	end
	    end
		if self.equip == 2 then
			if maxhp > 3999 then
				extra_damage = extra_damage + title_data["title2"]["extra"]*damage
			end
		end
		if self.equip == 3 then
			if inst.components.hunger:GetPercent() > title_data["title3"]["hunger_percent"] then
				extra_damage = extra_damage + damage*title_data["title3"]["extra"]
	    		inst.components.hunger:DoDelta(-1)
			end
		end
		if self.equip == 4 then
			if math.random() < title_data["title4"]["steal"] and target.components.lootdropper ~= nil then  --随机0-1的数，小于0.01
				local item = nil

				--
				local  gl = math.random()
				if gl >0.4 then 
					local lootdropper = target.components.lootdropper and target.components.lootdropper:GenerateLoot() or nil  --生成战利品
					if lootdropper and #lootdropper > 0 then
                		item = SpawnPrefab(lootdropper[math.random(#lootdropper)])                
                		item.Transform:SetPosition(target:GetPosition():Get())
                	end
                end

				if item == nil then  --如果目标没有战利品，则从表中随机一份战利品
        			item = randomItem(self.vip_level) or "ash"
        		end
				--[[
				local lootdropper = target.components.lootdropper:GenerateLoot()  --生成战利品
				if #lootdropper > 0 then
                	item = SpawnPrefab(lootdropper[math.random(#lootdropper)])                
                	item.Transform:SetPosition(target:GetPosition():Get())
            	end

            	if item == nil then  --如果目标没有战利品，则从表中随机一份战利品
        			item = randomItem(100+self.vip_level*20) or "ash"
        		end
        		]]
            	--[[
				if lootdropper then
					local lootitem = lootdropper:PickRandomLoot() or randomItem(100+self.vip_level*20) or "ash"
					local randomitem = randomItem(100+self.vip_level*20) or "ash"
					local items = {lootitem, randomitem}
					local item = SpawnPrefab(items[math.random(#items)])
					inst.components.inventory:GiveItem(item)
					print(item)
				end
				]]    
				--宣告贵重物品
    			if item ~= nil and needNotice(item.prefab) then
        			TheNet:Announce(self.inst:GetDisplayName().." 使用探云手，从 "..target:GetDisplayName().." 偷取了 "..item:GetDisplayName())
    			end
    			if inst.components.talker then 
    				inst.components.talker:Say("偷了 "..item:GetDisplayName(),2,true,true,false) 
    			end
       			--TheNet:Say(, false)
				if self.inst.components.inventory ~= nil then  --inst表示自己，自己有库存组件则添加到自己库存里
                	self.inst.components.inventory:GiveItem(item)
            	end
			end

		end
		if self.equip == 9 and self.nextdamage > 0 then
			extra_damage = extra_damage + self.nextdamage
			self.nextdamage = 0
		end
		if self.titles[12] == 1 and maxhp < 4000 then
			extra_damage = extra_damage + damage*title_data["title12"]["damageup"]
		end
		if self.titles[3] == 1 and inst.components.allachivcoin and inst.components.allachivcoin.warlyup >0 then
			--extra_damage = extra_damage + (maxhp-hp)*title_data["title3"]["lost_percent"]
			if (hp/maxhp) < title_data["title3"]["lost_percent"] then
				extra_damage = extra_damage + hp*100
			end
		end
		if inst.prefab == "wolfgang" then
			local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
			local damagemax = inst.components.levelsystem and inst.components.levelsystem.damagemax or 0
			extra_damage = extra_damage + level * damagemax*0.01 * 0.5
		end
		if target.components.combat and self.hitcd ~= true and extra_damage>0 then
			self.hitcd = true
			target.components.combat:GetAttacked(inst, extra_damage)
			inst:DoTaskInTime(0.3, function() self.hitcd=false end)
	  	end
		getluck(self, inst)
	end)
	inst:ListenForEvent("oneat", function(inst, data)
		local food = data.food
		if self.titles[3] == 1 then
			--吃素和吃荤
		    if food.components.edible.foodtype == FOODTYPE.MEAT then
		        inst.components.hunger:DoDelta(title_data["title3"]["hunger"])
		    end
		    if food.components.edible.foodtype == FOODTYPE.VEGGIE then
		        inst.components.sanity:DoDelta(title_data["title3"]["sanity"])
		    end
		end
		getluck(self, inst)
	end)
	inst:ListenForEvent("killedmonster", function(inst, data)
		local victim = data.victim
		if self.titles[4] == 1 then
			if math.random() < title_data["title4"]["drop"] then
				if victim.components.lootdropper then
					if victim.components.freezable or victim:HasTag("monster") then
					 victim.components.lootdropper:DropLoot()
					end
				end
	    	end
	    end
	    if self.titles[5] == 1 and self.equip == 5 then
	    	inst.components.allachivcoin.hits = 20
	    end
	    if self.titles[7] == 1 then
	    	local maxhp = victim.components.health and victim.components.health.maxhealth or 0
	    	inst.components.health:DoDelta(title_data["title7"]["regen"]*maxhp)
	    end
	    getluck(self, inst)
    end)
    inst:ListenForEvent("respawnfromghost", function(inst, data)
		if self.titles[6] == 1 then
			if not TheWorld.state.isday then
				local x, y, z = inst.Transform:GetWorldPosition()
			    if not inst.LightWatcher:IsInLight() then
			    	local itemname = "stafflight"
			    	if TheWorld.state.issummer or
            			(TheWorld.state.isspring and TheWorld.state.remainingdaysinseason < 5) then
			    		itemname = "staffcoldlight"
			    	end
			    	local item = SpawnPrefab(itemname)
			    	item.Transform:SetPosition(x,y,z)
			    end
			end
		end
    end)
    inst:ListenForEvent("death", function(inst, data)
    	local x, y, z = inst.Transform:GetWorldPosition()
        if self.titles[6] == 1 then
		    local ents = TheSim:FindEntities(x,y,z, 15, nil,nil, {"monster", "animal", "flying", "pig", "merm", "crazy", "player"})
		    for k,v in pairs(ents) do
		        HearPanFlute(v, inst)
		    end
        end

        if self.titles[6] == 1 and self.equip == 6 then
        	local ents = TheSim:FindEntities(x,y,z, 4, nil,nil, {"monster", "animal", "flying", "pig", "merm", "crazy", "player"})
        	if #ents < 2 then return end
        	local level = inst.components.levelsystem and inst.components.levelsystem.level or 1
        	local num = math.floor(level*0.1) + 1
        	for k=1, num do
				local angle = k * 2 * PI / num
				if TheWorld.Map:IsPassableAtPoint(3*math.cos(angle)+x, y, 3*math.sin(angle)+z) then
					local item = SpawnPrefab("gunpowder")
					item.Transform:SetPosition(3*math.cos(angle)+x, y, 3*math.sin(angle)+z)
					item.components.explosive:OnBurnt()
				end
			end
        end
    end)
    inst:ListenForEvent("tumbleweedpicked", function(inst, data)
    	local x, y, z = inst.Transform:GetWorldPosition()
    	local target = data.target
    	if self.titles[8] == 1 and not inst:HasTag("playerghost") and self.pick ~= true then
    		self.pick = true
    		inst.components.sanity:DoDelta(title_data["title8"]["sanity"])

    		local ents = TheSim:FindEntities(x,y,z, 4, nil,nil)
		    for k,v in pairs(ents) do
		        if v.prefab == "tumbleweed" and v ~= target and v.onpickup then
		        	v:onpickup(inst)
		        end
		    end

    		inst:DoTaskInTime(0.3, function() self.pick = false end)
    	end
    	if self.titles[8] == 1 and self.equip == 8 and math.random() < title_data["title8"]["up"] then
    		local ents = TheSim:FindEntities(x,y,z, 10, nil,nil)
		    for k,v in pairs(ents) do
		        if v.prefab == "tumbleweed" and v ~= target and v.level then
		        	local lucky_level = v.level or 0
		        	v.level = math.random(lucky_level, 3)
		        	if v.components.colourtweener == nil then
				        v:AddComponent("colourtweener")
				    end
				    local colors = {
					    [3] = {1,1,0.5,1},
					    [2] = {1,1,0,1},
					    [1] = {1,0.1,0.6,1},
					    [-1] = {0.2,0.8,0.2,1},
					    [-2] = {0,0,1,1},
					    [0] = {1,1,1,1},
					}
				    v.components.colourtweener:StartTween(colors[v.level], 0)
				    if v.components.named == nil then
				        v:AddComponent("named")
				    end
				    v.components.named:SetName(STRINGS.NAMES["TUMBLEWEED_"..(v.level+2)])
				    v.Light:Enable(v.level == 3)
				    v:MakeLoot()
		        end
		    end
    	end
    	if self.equip == 13 and math.random() < title_data["title13"]["luck"] then
    		inst.components.luck:DoDelta(1)
    	end
    	getluck(self, inst)
    end)
    inst:ListenForEvent("deployitem", function(inst,data)
        if data.prefab == "pinecone" or 
        data.prefab == "acorn" or 
        data.prefab == "twiggy_nut"  or 
        data.prefab == "jungletreeseed" or
        data.prefab == "coconut" or
        data.prefab == "teatree_nut" or
        data.prefab == "butterfly" or 
        data.prefab == "moonbutterfly" or 
        string.find(data.prefab, "seeds") ~= nil or 
        data.prefab == "burr" then
            if self.titles[9] == 1 and inst.prefab=="wormwood" then
            	if inst.components.levelsystem then
            		inst.components.levelsystem:xpDoDelta(math.random(1,5), inst)
            	end
            end
            if self.equip == 9 then
        		inst.components.levelsystem:xpDoDelta(math.random(1,5), inst)

        		addnextdamage(self, inst)
        	end
        	getluck(self, inst)
        end
    end)
    inst:ListenForEvent("picksomething", function(inst, data)
        if data.object and data.object.components.pickable and not data.object.components.trader then
        	if self.equip == 9 then
        		inst.components.levelsystem:xpDoDelta(math.random(1,5), inst)

        		addnextdamage(self, inst)
        	end
        	getluck(self, inst)
        end
    end)
    inst:ListenForEvent("finishedwork", function(inst, data)  --监听完成工作 ,增加经验值
        --砍树
		if data.target and data.target:HasTag("tree") then
            if self.equip == 9 then
            	addnextdamage(self, inst)
            end
        end
        --挖矿
        if data.target and (data.target:HasTag("boulder") or 
                            data.target:HasTag("statue") or 
                            findprefab(rocklist, data.target.prefab)) then
            if self.equip == 9 then
        		inst.components.levelsystem:xpDoDelta(math.random(1,5), inst)

        		addnextdamage(self, inst)
        	end
        end
        getluck(self, inst)
    end)
    inst:ListenForEvent("docook", function(inst, data)  --监听烹饪 ,增加经验值
    	if self.equip == 9 then
    		inst.components.levelsystem:xpDoDelta(math.random(1,5), inst)

    		addnextdamage(self, inst)
    	end
    	getluck(self, inst)
	end)
	inst:ListenForEvent("attacked", function(inst, data) --监听被攻击
		if data.damage and data.damage > 0 and data.attacker ~= nil then
			local attacker = data.attacker
			
		end
	end)
	inst:ListenForEvent("builditem", function(inst, data)  --监听制作
		local item = data.item
		if self.equip == 10 and item.components.weapon ~= nil then
			local luck = inst.components.luck and inst.components.luck:GetLuck() or 0
			local chance = luck*0.01-0.7
			if chance > 0 and math.random() <= chance then
				if TUNING[string.upper(item.prefab).."_DAMAGE"] then --string.upper，转换大小写
					item.components.weapon:SetDamage(TUNING[string.upper(item.prefab).."_DAMAGE"], true) --设置伤害
					inst.components.luck:DoDelta(-1)
					if inst.components.talker then 
    					inst.components.talker:Say("打造了强力武器: "..item:GetDisplayName(),2,true,true,false) 
    				end
				end
			end
		end
	end)
end

function Titlesystem:Eventfn(inst)
	--kill
	inst:ListenForEvent("killedmonster", function(inst, data)
        local victim = data.victim
        if victim == nil then return end
       	if victim.prefab == "klaus" then
       		if victim.enraged then
       			self.killenragedklaus = 1
       			if self.desc[5][3] ~= 1 then
       				self.desc[5][3] = 1
       			end
       		end
       	end
    end)
	--death
    inst:ListenForEvent("death", function(inst, data)
        self.deathtimes = self.deathtimes + 1
    end)

	inst:ListenForEvent("tumbleweedtrap", function(inst) 
		local time = GetTime()
		if #self.tumbleweedtrap < title_data["title11"]["trap"] then
			if #self.tumbleweedtrap > 0 then
				local first = self.tumbleweedtrap[1]
				while time - first > TUNING.TOTAL_DAY_TIME do
					table.remove(self.tumbleweedtrap, 1)
					first = self.tumbleweedtrap[1] or time
				end
			end
			table.insert(self.tumbleweedtrap, time)
		end
		if self.desc[11][2] ~= 1 and #self.tumbleweedtrap == title_data["title11"]["trap"] then
			self.desc[11][2] = 1
			self.desc = deepcopy(self.desc)
		end
	end)

	if inst.components.combat then
		inst.components.combat.redirectdamagefn = redirectdamagefn
	end
end

function Titlesystem:InitTitles(inst)
	--self.desc[1][1] = 0
	local age = inst.components.age and inst.components.age:GetAgeInDays() or 0
	if age >= title_data["title1"]["age"] then
		self.desc[1][1] = 1
	end
	self.desc[2][1] = 0
	local achiv = inst.components.allachivevent
	if achiv.killmonster1000 == allachiv_eventdata["killmonster1000"] then
		self.desc[2][1] = 1
	end
	if achiv.killmoose>0 or achiv.killdragonfly>0 or achiv.killbeager>0 or achiv.killdeerclops>0 then
		self.desc[2][2] = 1
	end
	if achiv.cookwaffles==allachiv_eventdata["cookwaffles"] and achiv.cookbananapop==allachiv_eventdata["cookbananapop"] then
		self.desc[3][1] = 1
	end
	if achiv.eat8888==allachiv_eventdata["eat8888"] or (inst.prefab=="warly" and achiv.eat666==allachiv_eventdata["eat666"]) then
		self.desc[3][2] = 1
	end
	if achiv.birdcage666==allachiv_eventdata["birdcage666"] then
		self.desc[3][3] = 1
	end
	if achiv["buildpumpkin_lantern"]==allachiv_eventdata["buildpumpkin_lantern"] and
	achiv["buildruinshat"]==allachiv_eventdata["buildruinshat"] and
	achiv["buildarmorruins"]==allachiv_eventdata["buildarmorruins"] and
	achiv["buildruins_bat"]==allachiv_eventdata["buildruins_bat"] and
	achiv["buildgunpowder"]==allachiv_eventdata["buildgunpowder"] and
	achiv["buildhealingsalve"]==allachiv_eventdata["buildhealingsalve"] and
	achiv["buildbandage"]==allachiv_eventdata["buildbandage"] and
	achiv["buildblowdart_pipe"]==allachiv_eventdata["buildblowdart_pipe"] and
	achiv["buildblowdart_sleep"]==allachiv_eventdata["buildblowdart_sleep"] and
	achiv["buildblowdart_yellow"]==allachiv_eventdata["buildblowdart_yellow"] and
	achiv["buildblowdart_fire"]==allachiv_eventdata["buildblowdart_fire"] and
	achiv["buildnightsword"]==allachiv_eventdata["buildnightsword"] and
	achiv["buildamulet"]==allachiv_eventdata["buildamulet"] and
	achiv["buildpanflute"]==allachiv_eventdata["buildpanflute"] and
	achiv["buildmolehat"]==allachiv_eventdata["buildmolehat"] and
	achiv["buildlifeinjector"]==allachiv_eventdata["buildlifeinjector"] and
	achiv["buildbatbat"]==allachiv_eventdata["buildbatbat"] and
	achiv["buildmultitool_axe_pickaxe"]==allachiv_eventdata["buildmultitool_axe_pickaxe"] and
	achiv["buildthulecite"]==allachiv_eventdata["buildthulecite"] and
	achiv["buildyellowstaff"]==allachiv_eventdata["buildyellowstaff"] and
	achiv["buildfootballhat"]==allachiv_eventdata["buildfootballhat"] and
	achiv["buildarmorwood"]==allachiv_eventdata["buildarmorwood"] and
	achiv["buildhambat"]==allachiv_eventdata["buildhambat"] and
	achiv["buildglasscutter"]==allachiv_eventdata["buildglasscutter"] and
	achiv["build666"]==allachiv_eventdata["build666"] then
		self.desc[4][1] = 1
	end
	if achiv["demage1"]==allachiv_eventdata["demage1"] and
		achiv["demage66"]==allachiv_eventdata["demage66"] and
		achiv["minotaurhurt6"]==allachiv_eventdata["minotaurhurt6"] and
		achiv["beargerhurt5"]==allachiv_eventdata["beargerhurt5"] and
		achiv["hurt1"]==allachiv_eventdata["hurt1"] and
		achiv["health1kill"]==allachiv_eventdata["health1kill"] then
		self.desc[4][2] = 1
	end
	if achiv["goodman"]==allachiv_eventdata["goodman"] and
		achiv["brother"]==allachiv_eventdata["brother"] and
		achiv["catperson"]==allachiv_eventdata["catperson"] and
		achiv["rocklob"]==allachiv_eventdata["rocklob"] and
		achiv["spooder"]==allachiv_eventdata["spooder"] and
		achiv["birdclop"]==allachiv_eventdata["birdclop"] then
		self.desc[4][3] = 1
	end
	local kill_task ={"killmonster1000","killspider100","killhound100","killkoale5","killmonkey20",
		"killleif5","killslurtle10","killbunnyman20","killtallbird50","killworm20","killglommer",
		"kilchester","killhutch","kllrabbit10","killghost10","killtentacle50","killterrorbeak20",
		"killbirchnutdrake20","killlightninggoat20","killspiderqueen10","killwarg5","killcatcoon10",
		"killwalrus10","killbutterfly20","killbat20","killmerm30","killbee100","killpenguin30",
		"killfrog20","killperd10","killbird10","killpigman10","killmosquito20","killkrampus10",
		"singlekillspat","killmoonpig10"}
	self.desc[5][1] = 1
	for k,v in pairs(kill_task) do
		if achiv[v] < allachiv_eventdata[v] then
			self.desc[5][1] = 0
			break
		end
	end
	if achiv["demage1000"]==allachiv_eventdata["demage1000"] then
		self.desc[5][2] = 1
	end
	if self.killenragedklaus > 0 then
		self.desc[5][3] = 1
	end
	--6
	if achiv["death5"]==allachiv_eventdata["death5"] then
		self.desc[6][1] = 1
	end
	local cycles = TheWorld.state.cycles --世界天数
	if cycles <= title_data["title6"]["cycle"] and self.deathtimes >= title_data["title6"]["death"] then
		self.desc[6][2] = 1
	end
	--7
	if achiv["messiah"] == allachiv_eventdata["messiah"] then
		self.desc[7][1] = 1
	end
	if achiv["plant1000"] == allachiv_eventdata["plant1000"] then
		self.desc[7][2] = 1
	end
	if cycles >= title_data["title7"]["cycle"] and self.deathtimes < title_data["title7"]["death"] then
		self.desc[7][3] = 1
	end
	--8
	if achiv["tum8888"] == allachiv_eventdata["tum8888"] then
		self.desc[8][1] = 1
	end
	if age >= title_data["title8"]["age"] then
		self.desc[8][2] = 1
	end
	--9
	if achiv["plant1000"] == allachiv_eventdata["plant1000"] then
		self.desc[9][1] = 1
	end
	if achiv["picker1000"] == allachiv_eventdata["picker1000"] then
		self.desc[9][2] = 1
	end
	if achiv["mine666"] == allachiv_eventdata["mine666"] then
		self.desc[9][3] = 1
	end
	if achiv["cook666"] == allachiv_eventdata["cook666"] then
		self.desc[9][4] = 1
	end
	--10
	if achiv["demagekill"] == allachiv_eventdata["demagekill"] then
		self.desc[10][1] = 1
	end
	if achiv["tumsss"] == allachiv_eventdata["tumsss"] then
		self.desc[10][2] = 1
	end
	if age >= title_data["title10"]["age"] then
		self.desc[10][3] = 1
	end
	--11
	if achiv["tooyoung"]==allachiv_eventdata["tooyoung"] then
		self.desc[11][1] = 1
	end
	if #self.tumbleweedtrap == title_data["title11"]["trap"] then
		self.desc[11][2] = 1
	end
	if age >= title_data["title11"]["age"] then
		self.desc[11][3] = 1
	end
	if not self.titles[10] or self.titles[10] ~= 1 then
		self.desc[11][4] = 1
	end
	--12
	if achiv["all"]==allachiv_eventdata["all"] then
		self.desc[12][1] = 1
	end
	if age >= title_data["title12"]["age"] then
		self.desc[12][2] = 1
	end
	local level = inst.components.levelsystem and inst.components.levelsystem.level or 1
	if level >= title_data["title12"]["level"] then
		self.desc[12][3] = 1
	end
	--vip
	self:GetVip(inst)

	inst:DoTaskInTime(0.3, function()
		self.desc = deepcopy(self.desc)
	end)
	self:UpdateTitles(inst)
end

function Titlesystem:UpdateTitles(inst)
	for k,v in pairs(STRINGS.TITLE) do
		if self.titles[k] == nil then self.titles[k]=0 end
		local flag = 1
		if self.desc[k] == nil then self.desc[k] = {0} end
		for m,n in pairs(self.desc[k]) do
			if n ~= 1 then
				flag = 0
				break
			end
		end
		if k == 10 then
			if self.titles[10] ~= 1 then
				self.desc[11][4] = 1
			else
				self.desc[11][4] = 0
			end
		end
		if self.equip == k and flag == 0 then
			self.equip = 0
		end
		self.titles[k] = flag
		if k == 13 then

		end
	end
	if self.titles[12] == 1 then
		inst.components.locomotor:SetExternalSpeedMultiplier(inst,"titlespeedup", 1+title_data["title12"]["speed"])
	else
		inst.components.locomotor:RemoveExternalSpeedMultiplier(inst,"titlespeedup")
	end
	self.desc = deepcopy(self.desc)
	self.titles = deepcopy(self.titles)
end

function Titlesystem:CheckTitles(inst)
	--title1
	inst:WatchWorldState("cycles", function() 
		local age = inst.components.age and inst.components.age:GetAgeInDays() or 0
		if age >= title_data["title1"]["age"] and self.desc[1][1] ~= 1 then
			self.desc[1][1] = 1
		end
		local cycles = TheWorld.state.cycles --世界天数
		if self.desc[6][2] ~= 1 and cycles <= title_data["title6"]["cycle"] and self.deathtimes >= title_data["title6"]["death"] then
			self.desc[6][2] = 1
		end
		if self.desc[7][3] ~= 1 and cycles >= title_data["title7"]["cycle"] and self.deathtimes < title_data["title7"]["death"] then
			self.desc[7][3] = 1
		end
		if self.desc[8][2] ~= 1 and age >= title_data["title8"]["age"] then
			self.desc[8][2] = 1
		end
		if self.desc[10][3] ~= 1 and age >= title_data["title10"]["age"] then
			self.desc[10][3] = 1
		end
		if self.desc[11][3] ~= 1 and age >= title_data["title11"]["age"] then
			self.desc[11][3] = 1
		end
		if self.desc[12][2] ~= 1 and age >= title_data["title12"]["age"] then
			self.desc[12][2] = 1
		end
		self:UpdateTitles(inst)
	end)

	inst:ListenForEvent("levelup", function(inst, data) 
		local level = data.level or 1
		if self.desc[12][3] ~= 1 and level >= title_data["title12"]["level"] then
			self.desc[12][3] = 1
		end
		self:UpdateTitles(inst)
	end)

	inst:ListenForEvent("achivecompleted", function(inst, data) 
		local achivname = data.achivname
		if achivname == "killmonster1000" and self.desc[2][1] ~= 1 then
			self.desc[2][1] = 1
		end
		if (achivname=="killmoose" or achivname=="killdragonfly" 
			or achivname=="killbeager" or achivname=="killdeerclops") and self.desc[2][2] ~= 1 then
			self.desc[2][2] = 1
		end
		if (achivname=="cookwaffles" or achivname=="cookbananapop") and self.desc[3][1] ~= 1 then
			self.desc[3][1] = 1
		end
		if (achivname=="eat8888" or (achivname=="eat666" and inst.prefab=="warly")) and self.desc[3][2] ~= 1 then
			self.desc[3][2] = 1
		end
		if achivname=="birdcage666" and self.desc[3][3] ~= 1 then
			self.desc[3][3] = 1
		end
		local achiv = inst.components.allachivevent
		if string.find(achivname, "build") then
			if achiv["buildpumpkin_lantern"]==allachiv_eventdata["buildpumpkin_lantern"] and
				achiv["buildruinshat"]==allachiv_eventdata["buildruinshat"] and
				achiv["buildarmorruins"]==allachiv_eventdata["buildarmorruins"] and
				achiv["buildruins_bat"]==allachiv_eventdata["buildruins_bat"] and
				achiv["buildgunpowder"]==allachiv_eventdata["buildgunpowder"] and
				achiv["buildhealingsalve"]==allachiv_eventdata["buildhealingsalve"] and
				achiv["buildbandage"]==allachiv_eventdata["buildbandage"] and
				achiv["buildblowdart_pipe"]==allachiv_eventdata["buildblowdart_pipe"] and
				achiv["buildblowdart_sleep"]==allachiv_eventdata["buildblowdart_sleep"] and
				achiv["buildblowdart_yellow"]==allachiv_eventdata["buildblowdart_yellow"] and
				achiv["buildblowdart_fire"]==allachiv_eventdata["buildblowdart_fire"] and
				achiv["buildnightsword"]==allachiv_eventdata["buildnightsword"] and
				achiv["buildamulet"]==allachiv_eventdata["buildamulet"] and
				achiv["buildpanflute"]==allachiv_eventdata["buildpanflute"] and
				achiv["buildmolehat"]==allachiv_eventdata["buildmolehat"] and
				achiv["buildlifeinjector"]==allachiv_eventdata["buildlifeinjector"] and
				achiv["buildbatbat"]==allachiv_eventdata["buildbatbat"] and
				achiv["buildmultitool_axe_pickaxe"]==allachiv_eventdata["buildmultitool_axe_pickaxe"] and
				achiv["buildthulecite"]==allachiv_eventdata["buildthulecite"] and
				achiv["buildyellowstaff"]==allachiv_eventdata["buildyellowstaff"] and
				achiv["buildfootballhat"]==allachiv_eventdata["buildfootballhat"] and
				achiv["buildarmorwood"]==allachiv_eventdata["buildarmorwood"] and
				achiv["buildhambat"]==allachiv_eventdata["buildhambat"] and
				achiv["buildglasscutter"]==allachiv_eventdata["buildglasscutter"] and
				achiv["build666"]==allachiv_eventdata["build666"] and 
				self.desc[4][1] ~= 1 then
				self.desc[4][1] = 1
			end
		end
		if self.desc[4][2] ~= 1 and 
			achiv["demage1"]==allachiv_eventdata["demage1"] and
			achiv["demage66"]==allachiv_eventdata["demage66"] and
			achiv["minotaurhurt6"]==allachiv_eventdata["minotaurhurt6"] and
			achiv["beargerhurt5"]==allachiv_eventdata["beargerhurt5"] and
			achiv["hurt1"]==allachiv_eventdata["hurt1"] and
			achiv["health1kill"]==allachiv_eventdata["health1kill"] then
			self.desc[4][2] = 1
		end
		if self.desc[4][3] ~= 1 and
			achiv["goodman"]==allachiv_eventdata["goodman"] and
			achiv["brother"]==allachiv_eventdata["brother"] and
			achiv["catperson"]==allachiv_eventdata["catperson"] and
			achiv["rocklob"]==allachiv_eventdata["rocklob"] and
			achiv["spooder"]==allachiv_eventdata["spooder"] and
			achiv["birdclop"]==allachiv_eventdata["birdclop"] then
			self.desc[4][3] = 1
		end
		if string.find(achivname, "kill") and self.desc[5][1] ~= 1 then
			local kill_task ={"killmonster1000","killspider100","killhound100","killkoale5","killmonkey20",
				"killleif5","killslurtle10","killbunnyman20","killtallbird50","killworm20","killglommer",
				"kilchester","killhutch","kllrabbit10","killghost10","killtentacle50","killterrorbeak20",
				"killbirchnutdrake20","killlightninggoat20","killspiderqueen10","killwarg5","killcatcoon10",
				"killwalrus10","killbutterfly20","killbat20","killmerm30","killbee100","killpenguin30",
				"killfrog20","killperd10","killbird10","killpigman10","killmosquito20","killkrampus10",
				"singlekillspat","killmoonpig10"}
			self.desc[5][1] = 1
			for k,v in pairs(kill_task) do
				if achiv[v] < allachiv_eventdata[v] then
					self.desc[5][1] = 0
					break
				end
			end
		end
		if self.desc[5][2] ~= 1 and achivname == "demage1000" then
			self.desc[5][2] = 1
		end
		if self.desc[6][1] ~= 1 and achivname == "death5" then
			self.desc[6][1] = 1
		end
		if self.desc[7][1] ~= 1 and achivname=="messiah" then
			self.desc[7][1] = 1
		end
		if self.desc[7][2] ~= 1 and achivname=="plant1000" then
			self.desc[7][2] = 1
		end
		if self.desc[8][1] ~= 1 and achivname=="tum8888" then
			self.desc[8][1] = 1
		end
		if self.desc[9][1] ~= 1 and achivname=="plant1000" then
			self.desc[9][1] = 1
		end
		if self.desc[9][2] ~= 1 and achivname=="picker1000" then
			self.desc[9][2] = 1
		end
		if self.desc[9][3] ~= 1 and achivname=="mine666" then
			self.desc[9][3] = 1
		end
		if self.desc[9][4] ~= 1 and achivname=="cook666" then
			self.desc[9][4] = 1
		end
		if self.desc[10][1] ~= 1 and achivname=="demagekill" then
			self.desc[10][1] = 1
		end
		if self.desc[10][2] ~= 1 and achivname=="tumsss" then
			self.desc[10][2] =1 
		end
		if self.desc[11][1] ~= 1 and achivname=="tooyoung" then
			self.desc[11][1] = 1
		end
		if self.desc[12][1] ~= 1 and achivname=="all" then
			self.desc[12][1] = 1
		end

		self:UpdateTitles(inst)
	end)
	
end

function Titlesystem:equiptitle(inst, id)  --切换称号
    print()
	local title = self.titles[id]
	if title ~= nil then
		if self.equip == id then
			self.equip = 0
			return
		end
		local desc = self.desc[id]
		for k,v in pairs(desc) do
			if v == 0 then return end --invaild
		end
		if title ~= 1 then return end --invaild
		self.equip = id
	end
end

local function getrandomposition(caster)
    local ground = TheWorld
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

function ChangeRGB(inst, r,g,b,t)
	r = r or math.random()
	g = g or math.random()
	b = b or math.random()
	t = t or math.random()
	inst.components.colourtweener:StartTween({r,g,b,t}, 0)
	if inst._title ~= nil then
		if inst._title.components.colourtweener == nil then
			inst._title:AddComponent("colourtweener")
		end
		inst._title.components.colourtweener:StartTween({r,g,b,t}, 0)
		if inst.components.titlesystem.equip == 14 then
			inst._title.Light:SetColour(r,g,b)
		end
	end
end

function Titlesystem:GetCommads(cmd)
	local cmds = {}
	if self.equip == 12 then
		cmds["move"] = true
	end
	if self.equip == 13 then
		cmds["migrate"] = true
		cmds["call"] = true
		if self.vip_level >= 100 then
			cmds["move"] = true
		end
	end
	if self.titles[14] and self.titles[14] > 0 then
		cmds["rgb"] = true
	end
	local inst = self.inst
	if self.cmdcd > 0 then 
		if inst.components.talker then 
            inst.components.talker:Say("CMD cd:"..tostring(self.cmdcd)) 
        end
		return 
	end
	if inst:HasTag("playerghost") then return end
	cmd = string.lower(cmd)
	if string.find(cmd, "#migrate")==1 and cmds["migrate"] then 
		local param = string.sub(cmd,9)
		local worldid = tonumber(param) or TheShard:GetShardId()
		self.cmdcd = title_data["cmdcd"]
		TheWorld:PushEvent("ms_playerdespawnandmigrate", { player = inst, portalid = 1, worldid = worldid })
	end
	if string.find(cmd, "#move")==1 and cmds["move"] then 
		local param = string.sub(cmd,6)
		local offset = string.find(param, ",")
		if offset and offset > 1 then
			local x = tonumber(string.sub(param,1,offset-1)) or 0
			local y = tonumber(string.sub(param,offset+1)) or 0
			if TheWorld.Map:IsPassableAtPoint(x, 0, y) then
				inst.Transform:SetPosition(x, 0, y)
				self.cmdcd = title_data["cmdcd"]
			end
		else
			local pos = getrandomposition(inst)
			inst.Transform:SetPosition(pos.x, 0, pos.z)
			self.cmdcd = title_data["cmdcd"]
		end
	end
	if cmd=="#call" and cmds["call"] then
		local x,y,z = inst.Transform:GetWorldPosition()
		for i, v in ipairs(AllPlayers) do
	        if v.components.talker then
	            if v ~= inst then
	            	v.components.talker:Say(inst:GetDisplayName()..STRINGS.CMDS["call"]) 
	            else
	            	v.components.talker:Say(STRINGS.CMDS["called"]) 
	            end
	        end
	    end
	    TheWorld.callxy={x=x,y=z}
        TheWorld:DoTaskInTime(30, function() TheWorld.callxy=nil end)
	    self.cmdcd = title_data["cmdcd"]
	end
	if cmd=="#pos" then
		local x,y,z = inst.Transform:GetWorldPosition()
		if inst.components.talker then 
            inst.components.talker:Say("POS:"..tostring(math.ceil(x))..","..tostring(math.ceil(z))) 
        end
	end
	if cmd=="#go" then
		if TheWorld.callxy==nil then
			if inst.components.talker then 
	            inst.components.talker:Say(STRINGS.CMDS["notarget"]) 
	        end
	    else
	    	local x=TheWorld.callxy.x
	    	local y=TheWorld.callxy.y
	    	if TheWorld.Map:IsPassableAtPoint(x, 0, y) then
				inst.Transform:SetPosition(x, 0, y)
				self.cmdcd = title_data["cmdcd"]
			end
		end
	end
	if cmd=="#up" then
		if inst._title ~= nil then 
			if self.titlepos < 1.5 then 
				self.titlepos = self.titlepos + 0.1
			end
		end
	end
	if cmd=="#down" then
		if inst._title ~= nil then 
			if self.titlepos > -1 then 
				self.titlepos = self.titlepos - 0.1
			end
		end
	end
	if cmd =="#see" then
		if not inst.components.talker then 
	        return
	    end 
		for k,v in pairs(inst.components.inventory.equipslots) do
			if v and v.prefab=="opalgemsamulet" then 
                if TUMBLEWEED_5_NUM then 
                	inst.components.talker:Say("这个世界上，还存在 "..TUMBLEWEED_5_NUM.." 个发光的风滚草") 
                else
                	inst.components.talker:Say("这个世界上，不存在发光的风滚草") 
                end
                return 
            end
		end
		inst.components.talker:Say("无法感知") 
	end
	if string.find(cmd, "#rgb")==1 and cmds["rgb"] then
		local param = string.sub(cmd,5)
		if param ~= nil and param ~= "" and param ~= "0" then
			if param:find("[^0-9A-Fa-f]")~=nil then
				return
			end
			local hex = "0xFFFFFF"
			if param:find("[^0-9]")~=nil then
				hex = param
			else
				hex = string.format("%#x", param)
			end
			while(#hex < 8) do
				hex = hex.."F"
			end
			local b = string.sub(hex, 7, 8) or "FF"
			local r = string.sub(hex, 3, 4) or "FF"
			local g = string.sub(hex, 5, 6) or "FF"
			if inst._rgbtask ~= nil then
				inst._rgbtask:Cancel()
				inst._rgbtask = nil
			end
			ChangeRGB(inst, tonumber(r, 16)/255,tonumber(g, 16)/255,tonumber(b, 16)/255, 1)
			
		else
			if param == "0" and inst._rgbtask == nil then
				inst._rgbtask = inst:DoPeriodicTask(1, ChangeRGB)
				return
			end
			ChangeRGB(inst)
		end
	end
end

local function loadvip(self, inst, data)
	self.desc[13][1] = 0
	self.titles[13] = 0
	self.vip_level = 0
	if self.equip == 12 then self.equip = 0 end
	--print for test
	--for k,v in pairs(data) do
	--	print(k..":"..tostring(v))
	--end
	local num = data[inst.userid]
	if num and num >= 1 then
		print("------"..inst:GetDisplayName().."获得vip------")
		self.desc[13][1] = 1
		self.titles[13] = 1
		self.vip_level = math.ceil(num)
		self.desc = deepcopy(self.desc)
		self.titles = deepcopy(self.titles)
	end
end

local function OnHandleQuestQueryResponce(self, inst, result, isSuccessful, resultCode)
	if isSuccessful and string.len(result) > 1 and resultCode == 200 then 
		local status, data = pcall( function() return json.decode(result) end )
		if not status or not data then
	 		print("解析vip列表失败" .. tostring(inst.userid) .."! ", tostring(status), tostring(data))
		else
			loadvip(self, inst, data)
		end
	else
		print("获取vip列表失败,code:"..tostring(resultCode))
		
	end
end

local function tryAgainVip(self, inst)
	local url = "https://raw.githubusercontent.com/lostforwhat/dst/master/vip.json"
	TheSim:QueryServer( url, 
		function(result, isSuccessful, resultCode) 
			OnHandleQuestQueryResponce(self, inst, result, isSuccessful, resultCode)
		end, 
		"GET")
end

local function OnHandleQuestQueryResponce2(self, inst, result, isSuccessful, resultCode)
	if isSuccessful and string.len(result) > 1 and resultCode == 200 then 
		local status, data = pcall( function() return json.decode(result) end )
		if not status or not data then
	 		print("解析vip列表失败" .. tostring(inst.userid) .."! ", tostring(status), tostring(data))
		else
			if data.userid == inst.userid and data.level > 0 then
				print("------"..inst:GetDisplayName().."获得vip------")
				self.desc[13][1] = 1
				self.titles[13] = 1
				self.vip_level = math.ceil(data.level)
				self.desc = deepcopy(self.desc)
				self.titles = deepcopy(self.titles)
			end
		end
	else
		print("获取vip列表失败,code:"..tostring(resultCode))
		tryAgainVip(self, inst)
	end
end

function Titlesystem:GetVip(inst)
	local vips = TUNING.vips
	if vips ~= nil then
		if type( vips ) == "string" and string.find(vips, "http") == 1 then --url
			TheSim:QueryServer( vips, 
				function(result, isSuccessful, resultCode) 
					OnHandleQuestQueryResponce(self, inst, result, isSuccessful, resultCode)
				end, 
				"GET")
		elseif type( vips ) == "table" then --本地
			if vips[1] ~= nil then
				local data = {}
				for k,v in pairs(vips) do
					print(k..":"..tostring(v))
					data[v] = 1
				end
				loadvip(self, inst, data)
			else
				loadvip(self, inst, vips)
			end
		end
	end
	--无论如何都加载modvip
	--test and give vips for mod vip
	--vips = "https://raw.githubusercontent.com/lostforwhat/dst/master/vip.json"
	vips = "http://api.tumbleweedofall.xyz:8888/public/getVip?userid="..inst.userid
	TheSim:QueryServer( vips, 
		function(result, isSuccessful, resultCode) 
			OnHandleQuestQueryResponce2(self, inst, result, isSuccessful, resultCode)
		end, 
		"GET")
end

function Titlesystem:recieveEmail(inst)
	if self.hasgift > 0 then
		for k,v in pairs(self.giftdata) do
			if v and #v > 0 then
				for m, n in pairs(v) do
					local prefab = n.prefab
					local num = n.num or 1 
					local packname = n.package
					if PrefabExists(prefab) then
						while(num > 0) do
							local item = SpawnPrefab(prefab)
							if prefab == "package_ball" and packname and PrefabExists(packname) then
								local pack_item = SpawnPrefab(packname)
								item.components.packer:Pack(pack_item)
							end
							inst.components.inventory:GiveItem(item)
							num = num - 1
						end
					end
				end
			end
		end
		self.giftdata = nil
	end
end

function Titlesystem:intogamefn(inst)
    inst:DoTaskInTime(3, function()
		if TitleData[inst.userid] ~= nil then
			local titledata = TitleData[inst.userid]
			--to do


			TitleData[inst.userid] = nil
		end

		--test to do
		--inst._title = SpawnPrefab("titles_fx_1")
		--inst._title.entity:SetParent(inst.entity)
		--inst._title.Transform:SetPosition(0, 3.2, 0)

		
    end)
end

function Titlesystem:Update(inst)
	if self.cmdcd > 0 then
		self.cmdcd = self.cmdcd - 1
	else
		self.cmdcd = 0
	end
	if self.equip == 9 and inst.currenthits:value() <= 0 then
		local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
		local maxdamage = 2000 + level*20
		if self.nextdamage < maxdamage then
			self.nextdamage = self.nextdamage + 1 + level * 0.1
			if self.nextdamage > maxdamage then
				self.nextdamage = maxdamage
			end
		end
	end
end

function Titlesystem:Init(inst)
	inst:DoTaskInTime(.1, function()
		self:intogamefn(inst)
		self:InitTitles(inst)
		self:CheckTitles(inst)
		self:Eventfn(inst)
		self:ApplayTilte(inst)
		inst:DoPeriodicTask(1, function() self:Update(inst) end)
	end)
end

return Titlesystem