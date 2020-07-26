local function getlevel(self,level) 
	self.inst.currentlevel:set(level) 
	local worldId = TheShard:GetShardId()
	self.inst.currentworld:set(worldId)
end
local function getlevelxp(self,levelxp) self.inst.currentlevelxp:set(levelxp) end
local function getoverallxp(self,overallxp) self.inst.currentoverallxp:set(overallxp) end

local function currenthungermax(self,hunger) self.inst.currenthungermax:set(hunger) end
local function currentsanitymax(self,sanity) self.inst.currentsanitymax:set(sanity) end
local function currenthealthmax(self,health) self.inst.currenthealthmax:set(health) end
local function currentspeedmax(self,speed) self.inst.currentspeedmax:set(speed) end
local function currentabsorbmax(self,absorb) self.inst.currentabsorbmax:set(absorb) end
local function currentdamagemax(self,damage) self.inst.currentdamagemax:set(damage) end
local function currentinsulationmax(self,insulation) self.inst.currentinsulationmax:set(insulation) end
local function currentinsulationsummermax(self,insulationsummer) self.inst.currentinsulationsummermax:set(insulationsummer) end

local function currentzoomlevel(self,zoomlevel) self.inst.currentzoomlevel:set(zoomlevel) end
local function currentwidgetxpos(self,widgetxpos) self.inst.currentwidgetxpos:set(widgetxpos) end

local function currentpower(self, power) self.inst.currentpower:set(power) end

local levelsystem = Class(function(self, inst)
    self.inst = inst
	self.level = 1
    self.levelxp = 0
	self.overallxp = 0
	
	self.attributepoints = 0
	self.attributepointsspent = 0

    self.hungerupamount = 0
    self.sanityupamount = 0
    self.healthupamount = 0

    self.speedupamount = 0
    self.absorbupamount = 0
    self.damageupamount = 0
	
	self.insulationupamount = 0
	self.insulationsummerupamount = 0
	
	self.hungercost = 1
	self.sanitycost = 1
	self.healthcost = 1
	self.speedcost = 1
	self.absorbcost = 1
	self.damagecost = 1
	self.insulationcost = 1
	self.insulationsummercost = 1
	
	self.hungermax = -1
	self.sanitymax = -1
	self.healthmax = -1
	self.speedmax = -1
	self.absorbmax = -1
	self.damagemax = -1
	self.insulationmax = 0
	self.insulationsummermax = 0
	self.insulationwinter = -1
	self.insulationsummer = -1
	
	self.achievementhungerup = 0
	self.achievementsanityup = 0
	self.achievementhealthup = 0
	self.achievementspeedup = 0
	self.achievementabsorbup = 0
	self.achievementdamageup = 0
	
	self.levelhungerup = 0
	self.levelsanityup = 0
	self.levelhealthup = 0
	self.levelspeedup = 0
	self.levelabsorbup = 0
	self.leveldamageup = 0
	
	self.zoomlevel = 1
	self.widgetXpos = -1

	self.power = 0
	
end,
nil,
{
    level = getlevel,
	levelxp = getlevelxp,
	overallxp = getoverallxp,
	
	hungermax = currenthungermax,
    sanitymax = currentsanitymax,
    healthmax = currenthealthmax,
    speedmax = currentspeedmax,
    absorbmax = currentabsorbmax,
    damagemax = currentdamagemax,
	insulationmax = currentinsulationmax,
	insulationsummermax = currentinsulationsummermax,
	
	zoomlevel = currentzoomlevel,
	widgetXpos = currentwidgetxpos,

	power = currentpower,
})


function levelsystem:OnSave()
    local data = {
        level = self.level,
		levelxp = self.levelxp,
		overallxp = self.overallxp,
		
        hungerupamount = self.hungerupamount,
        sanityupamount = self.sanityupamount,
        healthupamount = self.healthupamount,
        speedupamount = self.speedupamount,
        absorbupamount = self.absorbupamount,
        damageupamount = self.damageupamount,
		
		insulationupamount = self.insulationupamount,
		insulationsummerupamount = self.insulationsummerupamount,
		
		hungercost = self.hungercost,
		sanitycost = self.sanitycost,
		healthcost = self.healthcost,
		speedcost = self.speedcost,
		absorbcost = self.absorbcost,
		damagecost = self.damagecost,
		insulationcost = self.insulationcost,
		insulationsummercost = self.insulationsummercost,
		
		widgetXpos = self.widgetXpos,
		zoomlevel = self.zoomlevel,
		
    }
    return data
end


function levelsystem:OnLoad(data)
    self.level = data.level or 1
	self.levelxp = data.levelxp or 0
	self.overallxp = data.overallxp or 0
	
    self.hungerupamount = data.hungerupamount or 0
    self.sanityupamount = data.sanityupamount or 0
    self.healthupamount = data.healthupamount or 0
    self.speedupamount = data.speedupamount or 0
    self.absorbupamount = data.absorbupamount or 0
    self.damageupamount = data.damageupamount or 0
	
	self.insulationupamount = data.insulationupamount or 0
	self.insulationsummerupamount = data.insulationsummerupamount or 0
	
	self.hungercost = data.hungercost or 1
	self.sanitycost = data.sanitycost or 1
	self.healthcost = data.healthcost or 1
	self.speedcost = data.speedcost or 1
	self.absorbcost = data.absorbcost or 1
	self.damagecost = data.damagecost or 1
	self.insulationcost = data.insulationcost or 1
	self.insulationsummercost = data.insulationsummercost or 1
	
	self.widgetXpos = data.widgetXpos or -1
	self.zoomlevel = data.zoomlevel or 1

end

function levelsystem:savewidgetXPos(inst, xpos)
	self.widgetXpos = xpos
end

function levelsystem:saveZoomLevel(inst, zoomlevel)
	self.zoomlevel = zoomlevel
end

function levelsystem:onlevelup(inst)
    inst.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
	
end

function levelsystem:levelcheck(inst)
	local maxlevel = 100
	if inst.components.allachivcoin.level120 > 0 then
		maxlevel = maxlevel + inst.components.allachivcoin.level120 * 20
	end
	if self.level >= maxlevel then
		self.level = maxlevel
		self:resetability(inst)
	 	return false
	end
	return true
end

function levelsystem:levelDoDelta(inst)
    self.level = self.level + 1
	--self:attributepointDoDelta(3)
	--强化属性，分角色强化
	self:resetability(inst)
	--每5级获得成就点
	local allachivcoin = inst.components.allachivcoin
	if math.fmod(self.level, 5) == 0 and allachivcoin then
		local str = STRINGS.ALLACHIVCURRENCY
		inst.components.talker:Say(str[22]..str[4]..str[5]..str[6].."1"..str[2])
    	allachivcoin:coinDoDelta(1)
	end
	if allachivcoin.abigaillevelup > 0 then
		allachivcoin:aliveabigaillevelup(inst)
	end
	if allachivcoin.waxwellup > 0 then
		allachivcoin:waxwellupalive(inst)
	end
	inst:DoTaskInTime(1, function() 
		inst:PushEvent("levelup", {level=self.level})
	end)
end

function levelsystem:xpDoDelta(value,inst)
	self.overallxp = self.overallxp + value
	if not self:levelcheck(inst) then return end
    self.levelxp = self.levelxp + value
    local leveup_need = math.min(levelxpcap, self.level*200)
	while(self.levelxp >= leveup_need) do 
		self.levelxp = self.levelxp - leveup_need
		self:levelDoDelta(inst)
		self:onlevelup(inst)
	end
	inst:PushEvent("xpdelta",{value=value})
end


function levelsystem:addxp(inst)
	self:xpDoDelta(10000, inst)
end

function levelsystem:resetability(inst)
	local level = math.floor(self.level*0.5)
	self.hungerupamount = level
	self.sanityupamount = level

	if inst.prefab ~= "wolfgang" then
		self.healthupamount = level
	else
		self.healthupamount = 0
	end

	if inst.prefab == "wx78" then
		self.damageupamount = math.floor(level*0.3)
		local currentDamageMult = 1 + 0.01 * self.damageupamount
		inst.components.combat.externaldamagemultipliers:SetModifier("leveldamage", currentDamageMult)
	end

	--[[
	if inst.prefab == "willson" then
		self.speedupamount = math.floor(level*0.2)
		local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
		currentSpeedMult = currentSpeedMult + 0.01 * self.speedupamount
		inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
	end
	if inst.prefab == "wx-78" then
		self.damageupamount = math.floor(level*0.2)
		local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
		currentDamageMult = currentDamageMult + 0.01 * self.damageupamount
		inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
	end
	if inst.prefab == "waxwell" then
		self.absorbupamount = math.floor(level*0.2)
		local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
		if currentAbsorbAdd < 0.95 then
			currentAbsorbAdd = currentAbsorbAdd + 0.01 * self.absorbupamount
			inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)
		end
	end
	]]
end

function levelsystem:resetbuff(inst)
	inst.components.combat.externaldamagemultipliers:RemoveModifier("leveldamage")
    -- resetting the other stats is done in onupdate
	local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
	currentDamageMult = currentDamageMult - self.damageupamount*0.01
	inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
	
	local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
	currentAbsorbAdd = currentAbsorbAdd - self.absorbupamount*0.01
	inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)
	
	local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
	currentSpeedMult = currentSpeedMult - self.speedupamount*0.01
	inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
	
	inst.components.temperature.inherentsummerinsulation = inst.components.temperature.inherentsummerinsulation - 5*self.insulationsummerupamount
	inst.components.temperature.inherentinsulation = inst.components.temperature.inherentinsulation - 5*self.insulationupamount

end

function levelsystem:onreroll(inst)
    inst:ListenForEvent("ms_playerreroll", function(inst)
                local SaveLevel = {}
                SaveLevel["level"] = self.level or 1
				SaveLevel["levelxp"] = self.levelxp or 0
				SaveLevel["overallxp"] = self.overallxp or 0
				SaveLevel["widgetXpos"] = self.widgetXpos or -1
				SaveLevel["zoomlevel"] = self.zoomlevel or 1
				LevelData[inst:GetDisplayName()] = SaveLevel
    end)
end

function levelsystem:intogamefn(inst)
    inst:DoTaskInTime(3, function()
		if self.overallxp == 0 and LevelData[inst:GetDisplayName()] ~= nil then
			local leveldata = LevelData[inst:GetDisplayName()]
			self.level = leveldata["level"]
			self.levelxp = leveldata["levelxp"]
			self.overallxp = leveldata["overallxp"]
			self.widgetXpos = leveldata["widgetXpos"]
			self.zoomlevel = leveldata["zoomlevel"]
			LevelData[inst:GetDisplayName()] = nil
		end
    end)
end

function levelsystem:Init(inst)
	
	inst:DoTaskInTime(.1, function()
		self:onkilledother(inst)
		self:intogamefn(inst)
		self:onreroll(inst)
		self:eatfn(inst)
		self:resetability(inst)
	end)
	
	inst:DoTaskInTime(1, function()

		--self:resetability(inst)

		local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
		currentDamageMult = currentDamageMult + self.damageupamount*0.01
		inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
		local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
		currentAbsorbAdd = currentAbsorbAdd + self.absorbupamount*0.01
		inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)
		local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
		currentSpeedMult = currentSpeedMult + self.speedupamount*0.01
		inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
	end)

	inst.components.combat.damagemultiplier = inst.components.combat.damagemultiplier or 1
    inst:DoPeriodicTask(.5, function() self:onupdate(inst) end)
end

function levelsystem:onupdate(inst)
	--hunger
	local titlesystem = inst.components.titlesystem
	local titlehealthup = titlesystem.healthup or 0
	local titlesanityup = titlesystem.sanityup or 0
	local titlehungerup = titlesystem.hungerup or 0

	local achievementhungerup = allachiv_coindata["hungerup"]*inst.currenthungerup:value() + titlehungerup
	if achievementhungerup ~= self.achievementhungerup then
		local hunger_percent = inst.components.hunger:GetPercent()
		local addhunger = achievementhungerup - self.achievementhungerup
		inst.components.hunger:SetMax(inst.components.hunger.max + addhunger)
		inst.components.hunger:SetPercent(hunger_percent)
		self.achievementhungerup = achievementhungerup
		self.hungermax = inst.components.hunger.max
	end
	if self.hungerupamount ~= self.levelhungerup then
        local hunger_percent = inst.components.hunger:GetPercent()
		local addhunger = self.hungerupamount - self.levelhungerup
        inst.components.hunger:SetMax(inst.components.hunger.max + addhunger)
        inst.components.hunger:SetPercent(hunger_percent)
		self.levelhungerup = self.hungerupamount
		self.hungermax = inst.components.hunger.max
    end
	--in case hunger changes due to other events like when WX eats gears. Upgrades have to be applied again
	if self.hungermax ~= inst.components.hunger.max then
		local hunger_percent = inst.components.hunger:GetPercent()
        inst.components.hunger:SetMax(inst.components.hunger.max + self.hungerupamount + achievementhungerup)
        inst.components.hunger:SetPercent(hunger_percent)
		self.hungermax = inst.components.hunger.max
	end
    
	--sanity
	local achievementsanityup = allachiv_coindata["sanityup"]*inst.currentsanityup:value() + titlesanityup
	local titles = titlesystem.titles or {}
	if titles[9] == 1 then
		achievementsanityup = achievementsanityup + title_data["title9"]["sanity"]
	end
	if achievementsanityup ~= self.achievementsanityup then
		local sanity_percent = inst.components.sanity:GetPercent()
		local addsanity = achievementsanityup - self.achievementsanityup
		inst.components.sanity:SetMax(inst.components.sanity.max + addsanity)
		inst.components.sanity:SetPercent(sanity_percent)
		self.achievementsanityup = achievementsanityup
		self.sanitymax = inst.components.sanity.max
	end
	if self.sanityupamount ~= self.levelsanityup then
        local sanity_percent = inst.components.sanity:GetPercent()
		local addsanity = self.sanityupamount - self.levelsanityup
        inst.components.sanity:SetMax(inst.components.sanity.max + addsanity)
        inst.components.sanity:SetPercent(sanity_percent)
		self.levelsanityup = self.sanityupamount
		self.sanitymax = inst.components.sanity.max
    end
	--in case sanity changes due to other events like when WX eats gears. Upgrades have to be applied again
	if self.sanitymax ~= inst.components.sanity.max then
		local sanity_percent = inst.components.sanity:GetPercent()
        inst.components.sanity:SetMax(inst.components.sanity.max + self.sanityupamount + achievementsanityup)
        inst.components.sanity:SetPercent(sanity_percent)
		self.sanitymax = inst.components.sanity.max
	end
	
	--health
	if inst.prefab ~= "wolfgang" then
		local achievementhealthup = allachiv_coindata["healthup"]*inst.currenthealthup:value() + titlehealthup
		local titles = titlesystem.titles or {}
		if titles[9] == 1 then
			achievementhealthup = achievementhealthup + title_data["title9"]["health"]
		end
		if inst.prefab == "webber" then
			achievementhealthup = achievementhealthup + inst.components.allachivcoin.temphealthup
		end
		if achievementhealthup ~= self.achievementhealthup then
			local health_percent = inst.components.health:GetPercent()
			local addhealth = achievementhealthup - self.achievementhealthup
			inst.components.health.maxhealth = inst.components.health.maxhealth + addhealth
			inst.components.health:SetPercent(health_percent)
			self.achievementhealthup = achievementhealthup
			self.healthmax = inst.components.health.maxhealth
		end
		if self.healthupamount ~= self.levelhealthup then
	        local health_percent = inst.components.health:GetPercent()
			local addhealth = self.healthupamount - self.levelhealthup
			inst.components.health.maxhealth = inst.components.health.maxhealth + addhealth
			inst.components.health:SetPercent(health_percent)
			self.levelhealthup = self.healthupamount
			self.healthmax = inst.components.health.maxhealth
	    end
		--in case health changes due to other events like when WX eats gears. Upgrades have to be applied again
		if self.healthmax ~= inst.components.health.maxhealth then
			local health_percent = inst.components.health:GetPercent()
	        inst.components.health.maxhealth = inst.components.health.maxhealth + self.healthupamount + achievementhealthup
	        inst.components.health:SetPercent(health_percent)
			self.healthmax = inst.components.health.maxhealth
		end
	end
	--Speed
	if self.speedmax == -1 then
		
	end
	self.speedmax = 100*inst.components.locomotor:GetSpeedMultiplier()
	
	--Defense
	local itemabsorb = 0
	local inventory = inst.components.inventory
	if inventory then
		for k, v in pairs(inventory.equipslots) do
			if v.components.armor then
				if(itemabsorb < v.components.armor.absorb_percent) then
					itemabsorb = v.components.armor.absorb_percent
				end
			end
		end
	end
	if itemabsorb == 0 then
		self.absorbmax = 100*(inst.components.health.externalabsorbmodifiers:Get() + inst.components.health.playerabsorb + inst.components.health.absorb)
	else
		self.absorbmax = (inst.components.health.externalabsorbmodifiers:Get() + inst.components.health.playerabsorb + inst.components.health.absorb)
		self.absorbmax = 100*(itemabsorb + (1-itemabsorb)*self.absorbmax)
	end
	
	--Damage
	self.damagemax = 100*inst.components.combat.damagemultiplier*inst.components.combat.externaldamagemultipliers:Get()

	local weapon = inst.components.combat:GetWeapon()
	local basedamage = 0
	if weapon ~= nil then
		basedamage = weapon.components.weapon.damage or 0
		if type(basedamage) == "function" then
			basedamage = 10
		end
	else
		basedamage = inst.components.combat.defaultdamage
	end
	self.power = inst.components.combat.damagemultiplier*inst.components.combat.externaldamagemultipliers:Get() * basedamage
	
	if self.insulationwinter ~= self.insulationupamount*5 and self.insulationupamount > 0 then
		if self.insulationwinter == -1 then 
			inst.components.temperature.inherentinsulation = inst.components.temperature.inherentinsulation + self.insulationupamount*5
		else
			inst.components.temperature.inherentinsulation = inst.components.temperature.inherentinsulation + 5
		end
		self.insulationwinter = self.insulationupamount*5
    end
	
	if self.insulationsummer ~= self.insulationsummerupamount*5 and self.insulationsummerupamount > 0 then
		if self.insulationsummer == -1 then
			inst.components.temperature.inherentsummerinsulation = inst.components.temperature.inherentsummerinsulation + self.insulationsummerupamount*5
		else 
			inst.components.temperature.inherentsummerinsulation = inst.components.temperature.inherentsummerinsulation + 5	
		end
		self.insulationsummer = self.insulationsummerupamount*5  
    end
	
	local winter, summer = inst.components.temperature:GetInsulation()
	if self.insulationsummermax ~= summer or self.insulationmax ~= winter then
		self.insulationmax = winter
		self.insulationsummermax = summer
	end
end

--Debug
--AllPlayers[1].components.levelsystem:xpDoDelta(10000,AllPlayers[1])
--gain xp
function levelsystem:onkilledother(inst)
    inst:ListenForEvent("killedmonster", function(inst, data)
        local victim = data.victim
        if victim and  
        		not victim:HasTag("limited") and
				not victim:HasTag("veggie") and 
                not victim:HasTag("structure") and 
                not victim:HasTag("wall") and 
                not victim:HasTag("balloon") and 
                not victim:HasTag("groundspike") and 
                not victim:HasTag("smashable") and 
                not victim:HasTag("companion") then

	        if victim.components.health == nil then return end
			local xp = math.floor(victim.components.health.maxhealth*0.1+0.5)
			if xp > 11000 then return end
			if victim:HasTag("epic") then xp = math.floor(victim.components.health.maxhealth*0.25+0.5) end
			
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
			
			local playercount = 0
			for k,v in pairs(ents) do
                if v:HasTag("player") then
					playercount = playercount + 1
                end
            end
			
			for k,v in pairs(ents) do
                if v:HasTag("player") then
					v.components.levelsystem:xpDoDelta(math.ceil(xp/playercount), v)
                end
            end
        end
	end)
end

function levelsystem:eatfn(inst)
    inst:DoTaskInTime(1, function()
        local oldeatfn = inst.components.eater.oneatfn
        function inst.components.eater.oneatfn(inst, food)
			local hunger = food.components.edible.hungervalue
			if food.components.perishable ~= nil then
				if food.components.perishable:IsStale() then
					hunger = hunger * TUNING.STALE_FOOD_HUNGER
				elseif food.components.perishable:IsSpoiled() then
					hunger = hunger * TUNING.SPOILED_FOOD_HUNGER
				end
			end
			if hunger <= 0 then return end 
			self:xpDoDelta(math.floor(hunger/2+0.5), inst)
            if oldeatfn ~= nil then
                oldeatfn(inst, food)
            end
        end
    end)
end


return levelsystem