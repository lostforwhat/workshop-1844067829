--设置水上行走
local function SetWereDrowning(inst, mode)
    --V2C: drownable HACKS, using "false" to override "nil" load behaviour
    --     Please refactor drownable to use POST LOAD timing.
    if inst.components.drownable ~= nil then --溺水组件存在
        if mode == 1 then
            if inst.components.drownable.enabled ~= false then  --启用了
                inst.components.drownable.enabled = false                   --关闭溺水
                inst.Physics:ClearCollisionMask()                           --Physics物理 清除碰撞遮罩
                inst.Physics:CollidesWith(COLLISION.GROUND)                 --与地面碰撞
                inst.Physics:CollidesWith(COLLISION.OBSTACLES)              --与障碍物碰撞
                inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)         --与小型障碍物碰撞
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)             --与人物碰撞
                inst.Physics:CollidesWith(COLLISION.GIANTS)                 --与巨人(有boss)碰撞
                inst.Physics:Teleport(inst.Transform:GetWorldPosition())    --传送(自己的位置)
            end
        elseif inst.components.drownable.enabled == false then
            inst.components.drownable.enabled = true                        --开启溺水
            if not inst:HasTag("playerghost") then                          --不是 玩家幽灵 标签 
                inst.Physics:ClearCollisionMask()
                inst.Physics:CollidesWith(COLLISION.WORLD)                  --与世界碰撞
                inst.Physics:CollidesWith(COLLISION.OBSTACLES)
                inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)
                inst.Physics:CollidesWith(COLLISION.GIANTS)
                inst.Physics:Teleport(inst.Transform:GetWorldPosition())
            end
        end
    end
end

local function getcoinamount(self,coinamount) self.inst.currentcoinamount:set(coinamount) end

local function currenthungerup(self,hungerupamount) self.inst.currenthungerup:set(hungerupamount) end
local function currentsanityup(self,sanityupamount) self.inst.currentsanityup:set(sanityupamount) end
local function currenthealthup(self,healthupamount) self.inst.currenthealthup:set(healthupamount) end
local function currentspeedup(self,speedupamount) self.inst.currentspeedup:set(speedupamount) end
local function currentabsorbup(self,absorbupamount) self.inst.currentabsorbup:set(absorbupamount) end
local function currentdamageup(self,damageupamount) self.inst.currentdamageup:set(damageupamount) end
local function currentcrit(self,crit) 
    self.inst.currentcrit:set(crit) 
    if crit > 0 then
        if self.inst.components.crit == nil then
            self.inst:AddComponent("crit")
        end
        self.inst.components.crit:SetChance(allachiv_coindata["crit"]*crit*100)
    else
        self.inst:RemoveComponent("crit")
    end
end
local function currentlifesteal(self,lifesteal) 
    self.inst.currentlifesteal:set(lifesteal)
    if lifesteal > 0 then
        if self.inst.components.lifesteal == nil then
            self.inst:AddComponent("lifesteal")
        end
        self.inst.components.lifesteal:SetPercent(allachiv_coindata["lifesteal"]*self.lifestealupamount*100)
    else
        self.inst:RemoveComponent("lifesteal")
    end 
end

local function currentdoubledrop(self,doubledrop) self.inst.currentdoubledrop:set(doubledrop) end
local function currentnomoist(self,nomoist) self.inst.currentnomoist:set(nomoist) end
local function currentgoodman(self,goodman) self.inst.currentgoodman:set(goodman) end
local function currentcheatdeath(self,cheatdeath) self.inst.currentcheatdeath:set(cheatdeath) end
local function currentrefresh(self,refresh) self.inst.currentrefresh:set(refresh) end
local function currentfishmaster(self,fishmaster) self.inst.currentfishmaster:set(fishmaster) end
local function currentcookmaster(self,cookmaster) self.inst.currentcookmaster:set(cookmaster) end
local function currentchopmaster(self,chopmaster) self.inst.currentchopmaster:set(chopmaster) end
local function currentpickmaster(self,pickmaster) self.inst.currentpickmaster:set(pickmaster) end
local function currentbuildmaster(self,buildmaster) self.inst.currentbuildmaster:set(buildmaster) end
local function currenticebody(self,icebody) self.inst.currenticebody:set(icebody) end
local function currentfirebody(self,firebody) self.inst.currentfirebody:set(firebody) end
local function currentreader(self,reader) self.inst.currentreader:set(reader) end
local function currentmasterchef(self,masterchef) self.inst.currentmasterchef:set(masterchef) end
local function currentattackback(self,attackback) self.inst.currentattackback:set(attackback) end
local function currentminemaster(self,minemaster) self.inst.currentminemaster:set(minemaster) end
local function currentfastworker(self,fastworker) self.inst.currentfastworker:set(fastworker) end
local function currentstopregen(self,stopregen) self.inst.currentstopregen:set(stopregen) end
local function currentattackfrozen(self,attackfrozen) self.inst.currentattackfrozen:set(attackfrozen) end
local function currentattackdead(self,attackdead) 
    self.inst.currentattackdead:set(attackdead) 
    if attackdead > 0 then
        if self.inst.components.attackdeath == nil then
            self.inst:AddComponent("attackdeath")
        end
    else
        self.inst:RemoveComponent("attackdeath")
    end
end
local function currentattackbroken(self,attackbroken) 
    self.inst.currentattackbroken:set(attackbroken) 
    if attackbroken > 0 then
        if self.inst.components.attackbroken == nil then
            self.inst:AddComponent("attackbroken")
        end
    else
        self.inst:RemoveComponent("attackbroken")
    end
end
local function currentwaterwalk(self,waterwalk) self.inst.currentwaterwalk:set(waterwalk) end

--特殊
local function currentlevel120(self,level120) self.inst.currentlevel120:set(level120) end
local function currentabigaillevelup(self,abigaillevelup) self.inst.currentabigaillevelup:set(abigaillevelup) end
local function currentabigailclone(self,abigailclone) self.inst.currentabigailclone:set(abigailclone) end
local function currentbloodangry(self,bloodangry) self.inst.currentbloodangry:set(bloodangry) end
local function currentballoonlevelup(self,balloonlevelup) self.inst.currentballoonlevelup:set(balloonlevelup) end
local function currentballooninspire(self,ballooninspire) self.inst.currentballooninspire:set(ballooninspire) end
local function currentwescheat(self,wescheat) self.inst.currentwescheat:set(wescheat) end
local function currentcallspider(self,callspider) self.inst.currentcallspider:set(callspider) end
local function currentspiderstronger(self,spiderstronger) self.inst.currentspiderstronger:set(spiderstronger) end
local function currentbernielevelup(self,bernielevelup) self.inst.currentbernielevelup:set(bernielevelup) end
local function currentlinghtermore(self,linghtermore) self.inst.currentlinghtermore:set(linghtermore) end
local function currentgearuse(self,gearuse) self.inst.currentgearuse:set(gearuse) end
local function currentcallmerm(self,callmerm) self.inst.currentcallmerm:set(callmerm) end
local function currentmermstronger(self,mermstronger) self.inst.currentmermstronger:set(mermstronger) end
local function currentsoulmore(self,soulmore) self.inst.currentsoulmore:set(soulmore) end
local function currentstrongeraoe(self,strongeraoe) self.inst.currentstrongeraoe:set(strongeraoe) end
local function currentwaxwellup(self,waxwellup) self.inst.currentwaxwellup:set(waxwellup) end
local function currentwinnonaup(self,winnonaup) self.inst.currentwinnonaup:set(winnonaup) end
local function currentwoodieup(self,woodieup) self.inst.currentwoodieup:set(woodieup) end
local function currentwarlyup(self,warlyup) self.inst.currentwarlyup:set(warlyup) end
local function currentwormwoodup(self,wormwoodup) self.inst.currentwormwoodup:set(wormwoodup) end
local function currentwickerbottomup(self,wickerbottomup) self.inst.currentwickerbottomup:set(wickerbottomup) end
local function currentcallback(self,callback) self.inst.currentcallback:set(callback) end
local function currentpotion(self,potion) self.inst.currentpotion:set(potion) end
local function currentlightpower(self,lightpower) self.inst.currentlightpower:set(lightpower) end
local function currenthitattack(self,hitattack) self.inst.currenthitattack:set(hitattack) end
local function currentthrowrock(self,throwrock) self.inst.currentthrowrock:set(throwrock) end
local function currentquickshot(self,quickshot) self.inst.currentquickshot:set(quickshot) end

--商店
local function currentrespawnfromghost(self,respawnfromghost) self.inst.currentrespawnfromghost:set(respawnfromghost) end
local function currentresettempachiv(self,resettempachiv) self.inst.currentresettempachiv:set(resettempachiv) end
local function currentgoldnugget(self,goldnugget) self.inst.currentgoldnugget:set(goldnugget) end
local function currentgreengem(self,greengem) self.inst.currentgreengem:set(greengem) end
local function currentorangegem(self,orangegem) self.inst.currentorangegem:set(orangegem) end
local function currentyellowgem(self,yellowgem) self.inst.currentyellowgem:set(yellowgem) end
local function currentice(self,ice) self.inst.currentice:set(ice) end
local function currentgears(self,gears) self.inst.currentgears:set(gears) end
local function currentdug_grass(self,dug_grass) self.inst.currentdug_grass:set(dug_grass) end
local function currentdug_sapling(self,dug_sapling) self.inst.currentdug_sapling:set(dug_sapling) end
local function currentdug_rock_avocado_bush(self,dug_rock_avocado_bush) self.inst.currentdug_rock_avocado_bush:set(dug_rock_avocado_bush) end
local function currentdug_berrybush(self,dug_berrybush) self.inst.currentdug_berrybush:set(dug_berrybush) end
local function currentblowdart_pipe(self,blowdart_pipe) self.inst.currentblowdart_pipe:set(blowdart_pipe) end
local function currentgunpowder(self,gunpowder) self.inst.currentgunpowder:set(gunpowder) end
local function currentnightsword(self,nightsword) self.inst.currentnightsword:set(nightsword) end
local function currentslurtlehat(self,slurtlehat) self.inst.currentslurtlehat:set(slurtlehat) end
local function currentprayer_symbol(self,prayer_symbol) self.inst.currentprayer_symbol:set(prayer_symbol) end
local function currentpackage_staff(self,package_staff) self.inst.currentpackage_staff:set(package_staff) end
local function currentpotion_achiv(self,potion_achiv) self.inst.currentpotion_achiv:set(potion_achiv) end
local function currentrecycle(self,recycle) self.inst.currentrecycle:set(recycle) end
local function currentblueprint(self,blueprint) self.inst.currentblueprint:set(blueprint) end
local function currentpackage_ball(self, package_ball) self.inst.currentpackage_ball:set(package_ball) end

local function currentresurrectcd(self, resurrectcd) self.inst.currentresurrectcd:set(resurrectcd) end
local function currentcheatdeathcd(self, cheatdeathcd) self.inst.currentcheatdeathcd:set(cheatdeathcd) end
local function currentwescheatcd(self, wescheatcd) self.inst.currentwescheatcd:set(wescheatcd) end
local function currentcallbackcd(self, callbackcd) self.inst.currentcallbackcd:set(callbackcd) end
local function currenthits(self, hits) 
    self.inst.currenthits:set(hits) 
    if self.inst.prefab == "wathgrithr" and self.hitattack>0 then
        local currentDamageMult = 1 + hits * 0.05
        self.inst.components.combat.externaldamagemultipliers:SetModifier("hitsdamage", currentDamageMult)
    end
end
local function currentaoestatus(self, aoestatus) self.inst.currentaoestatus:set(aoestatus) end
local function currentmemorykill(self, memorykill) self.inst.currentmemorykill:set(memorykill) end

local function currentwaterwalkstatus(self, waterwalkstatus) 
    self.inst.currentwaterwalkstatus:set(waterwalkstatus)
    SetWereDrowning(self.inst, waterwalkstatus)
end


local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
end

local allachivcoin = Class(function(self, inst)
    self.inst = inst
    self.coinamount = 0

    self.hungerupamount = 0
    self.sanityupamount = 0
    self.healthupamount = 0

    self.speedupamount = 0
    self.absorbupamount = 0
    self.damageupamount = 0
    self.crit = 0
	self.lifestealupamount = 0
	self.fireflylightup = 0
	
	self.starsspent = 0

    self.doubledrop = 0
    self.nomoist = 0
    self.goodman = 0
	self.cheatdeath = 0
    self.refresh = 0
    self.fishmaster = 0
    self.cookmaster = 0
    self.chopmaster = 0
    self.pickmaster = 0
    self.buildmaster = 0
    self.icebody = 0
    self.firebody = 0
    self.reader = 0
    self.masterchef = 0
	self.minemaster = 0
	self.anicentstation = 0
	self.fastworker = 0

    self.fishtimemin = 4
    self.fishtimemax = 40
    self.maxMoistureRate = math.pi
    self.attackback = 0
    self.cheatdeathcd = 0
    self.stopregen = 0
    self.attackfrozen = 0
    self.attackdead = 0
    self.attackbroken = 0
    self.waterwalk = 0   --水上行走

    --特殊
    self.level120 = 0
    self.abigaillevelup = 0
    self.abigailclone = 0
    self.bloodangry = 0
    self.balloonlevelup = 0
    self.ballooninspire = 0
    self.wescheat = 0
    self.callspider = 0
    self.spiderstronger = 0
    self.bernielevelup = 0
    self.linghtermore = 0
    self.gearuse = 0
    self.callmerm = 0
    self.mermstronger = 0
    self.soulmore = 0
    self.strongeraoe = 0
    self.waxwellup = 0
    self.winnonaup = 0
    self.woodieup = 0
    self.warlyup = 0
    self.wormwoodup = 0
    self.wickerbottomup = 0
    self.callback = 0
    self.potion = 0
    self.lightpower = 0
    self.hitattack = 0
    self.memorykill = 0
    self.throwrock = 0
    self.quickshot = 0

    --商店
    self.respawnfromghost = 0
    self.resettempachiv = 0
    self.goldnugget = 0
    self.greengem = 0
    self.orangegem = 0
    self.yellowgem = 0
    self.ice = 0
    self.gears = 0
    self.dug_grass = 0
    self.dug_sapling = 0
    self.dug_rock_avocado_bush = 0
    self.dug_berrybush = 0
    self.blowdart_pipe = 0
    self.gunpowder = 0
    self.nightsword = 0
    self.slurtlehat = 0
    self.prayer_symbol = 0
    self.package_staff = 0
    self.potion_achiv = 0
    self.recycle = 0
    self.blueprint = 0
    self.package_ball = 0

    --过渡变量
    self.seasondamageup = 0
    self.freeresurrecttime = 0
    self.resurrectcd = 0
    self.wescheatcd = 0
    self.callbackcd = 0
    self.freetimes = 0
    self.hits = 0
    self.hitattackcd = 0
    self.aoestatus = 0
    self.abigailcd = 0
    self.memorykilldata = {}
    self.temphealthup = 0
    self.waterwalkstatus = 0
end,
nil,
{
    coinamount = getcoinamount,

    hungerupamount = currenthungerup,
    sanityupamount = currentsanityup,
    healthupamount = currenthealthup,
    speedupamount = currentspeedup,
    absorbupamount = currentabsorbup,
    damageupamount = currentdamageup,
    crit = currentcrit,
	lifestealupamount = currentlifesteal,
	
    doubledrop = currentdoubledrop,
    nomoist = currentnomoist,
    goodman = currentgoodman,
	cheatdeath = currentcheatdeath,
    refresh = currentrefresh,
    fishmaster = currentfishmaster,
    cookmaster = currentcookmaster,
    chopmaster = currentchopmaster,
    pickmaster = currentpickmaster,
    buildmaster = currentbuildmaster,
    icebody = currenticebody,
    firebody = currentfirebody,
    reader = currentreader,
    masterchef = currentmasterchef,
    attackback = currentattackback,
    stopregen = currentstopregen,
    attackfrozen = currentattackfrozen,
    attackdead = currentattackdead,
    attackbroken = currentattackbroken,
    waterwalk = currentwaterwalk,
	
	minemaster = currentminemaster,
	fastworker = currentfastworker,

    level120 = currentlevel120,
    abigaillevelup = currentabigaillevelup,
    abigailclone = currentabigailclone,
    bloodangry = currentbloodangry,
    balloonlevelup = currentballoonlevelup,
    ballooninspire = currentballooninspire,
    wescheat = currentwescheat,
    callspider = currentcallspider,
    spiderstronger = currentspiderstronger,
    bernielevelup = currentbernielevelup,
    linghtermore = currentlinghtermore,
    gearuse = currentgearuse,
    callmerm = currentcallmerm,
    mermstronger = currentmermstronger,
    soulmore = currentsoulmore,
    strongeraoe = currentstrongeraoe,
    waxwellup = currentwaxwellup,
    winnonaup = currentwinnonaup,
    woodieup = currentwoodieup,
    warlyup = currentwarlyup,
    wormwoodup = currentwormwoodup,
    wickerbottomup = currentwickerbottomup,
    hitattack = currenthitattack,
    memorykill = currentmemorykill,
    throwrock = currentthrowrock,
    quickshot = currentquickshot,

    respawnfromghost = currentrespawnfromghost,
    resettempachiv = currentresettempachiv,
    goldnugget = currentgoldnugget,
    greengem = currentgreengem,
    orangegem = currentorangegem,
    yellowgem = currentyellowgem,
    ice = currentice,
    gears = currentgears,
    dug_grass = currentdug_grass,
    dug_sapling = currentdug_sapling,
    dug_rock_avocado_bush=currentdug_rock_avocado_bush,
    dug_berrybush = currentdug_berrybush,
    blowdart_pipe = currentblowdart_pipe,
    gunpowder = currentgunpowder,
    nightsword = currentnightsword,
    slurtlehat = currentslurtlehat,
    prayer_symbol = currentprayer_symbol,
    package_staff = currentpackage_staff,
    potion_achiv = currentpotion_achiv,
    recycle = currentrecycle,
    blueprint = currentblueprint,
    package_ball = currentpackage_ball,

    resurrectcd = currentresurrectcd,
    wescheatcd = currentwescheatcd,
    cheatdeathcd = currentcheatdeathcd,

    callback = currentcallback,
    callbackcd = currentcallbackcd,
    potion = currentpotion,
    lightpower = currentlightpower,
    hits = currenthits,
    aoestatus = currentaoestatus,
    waterwalkstatus = currentwaterwalkstatus,
})

--保存
function allachivcoin:OnSave()
    local data = {
        coinamount = self.coinamount,
        hungerupamount = self.hungerupamount,
        sanityupamount = self.sanityupamount,
        healthupamount = self.healthupamount,
        speedupamount = self.speedupamount,
        absorbupamount = self.absorbupamount,
        damageupamount = self.damageupamount,
        crit = self.crit,
		lifestealupamount = self.lifestealupamount,
		fireflylightup = self.fireflylightup,
		starsspent = self.starsspent,
        doubledrop = self.doubledrop,
        nomoist = self.nomoist,
        goodman = self.goodman,
		cheatdeath = self.cheatdeath,
        refresh = self.refresh,
        fishmaster = self.fishmaster,
        cookmaster = self.cookmaster,
        chopmaster = self.chopmaster,
        pickmaster = self.pickmaster,
        buildmaster = self.buildmaster,
        icebody = self.icebody,
        firebody = self.firebody,
        reader = self.reader,
        masterchef = self.masterchef,
		minemaster = self.minemaster,
		fastworker = self.fastworker,
        attackback = self.attackback,
        cheatdeathcd = self.cheatdeathcd,
        stopregen = self.stopregen,
        attackfrozen = self.attackfrozen,
        attackdead = self.attackdead,
        attackbroken = self.attackbroken,
        waterwalk = self.waterwalk,

        level120 = self.level120,
        abigaillevelup = self.abigaillevelup,
        abigailclone = self.abigailclone,
        bloodangry = self.bloodangry,
        balloonlevelup = self.balloonlevelup,
        ballooninspire = self.ballooninspire,
        wescheat = self.wescheat,
        callspider = self.callspider,
        spiderstronger = self.spiderstronger,
        bernielevelup = self.bernielevelup,
        linghtermore = self.linghtermore,
        gearuse = self.gearuse,
        callmerm = self.callmerm,
        mermstronger = self.mermstronger,
        soulmore = self.soulmore,
        strongeraoe = self.strongeraoe,
        waxwellup = self.waxwellup,
        winnonaup = self.winnonaup,
        woodieup = self.woodieup,
        warlyup = self.warlyup,
        wormwoodup = self.wormwoodup,
        wickerbottomup = self.wickerbottomup,
        hitattack = self.hitattack,
        memorykill = self.memorykill,
        throwrock = self.throwrock,
        quickshot = self.quickshot,

        respawnfromghost = self.respawnfromghost,
        resettempachiv = self.resettempachiv,
        goldnugget = self.goldnugget,
        greengem = self.greengem,
        orangegem = self.orangegem,
        yellowgem = self.yellowgem,
        ice = self.ice,
        gears = self.gears,
        dug_grass = self.dug_grass,
        dug_sapling = self.dug_sapling,
        dug_rock_avocado_bush = self.dug_rock_avocado_bush,
        dug_berrybush = self.dug_berrybush,
        blowdart_pipe = self.blowdart_pipe,
        gunpowder = self.gunpowder,
        nightsword = self.nightsword,
        slurtlehat = self.slurtlehat,
        prayer_symbol = self.prayer_symbol,
        package_staff = self.package_staff,
        potion_achiv = self.potion_achiv,
        recycle = self.recycle,
        blueprint = self.blueprint,
        package_ball = self.package_ball,

        seasondamageup = self.seasondamageup,
        freeresurrecttime = self.freeresurrecttime,
        resurrectcd = self.resurrectcd,
        wescheatcd = self.wescheatcd,
        freetimes = self.freetimes,

        callback = self.callback,
        callbackcd = self.callbackcd,
        potion = self.potion,
        lightpower = self.lightpower,
        aoestatus = self.aoestatus,
        memorykilldata = self.memorykilldata,
    }
    return data
end

--载入
function allachivcoin:OnLoad(data)
    self.coinamount = data.coinamount or 0

    self.hungerupamount = data.hungerupamount or 0
    self.sanityupamount = data.sanityupamount or 0
    self.healthupamount = data.healthupamount or 0
    self.speedupamount = data.speedupamount or 0
    self.absorbupamount = data.absorbupamount or 0
    self.damageupamount = data.damageupamount or 0
    self.crit = data.crit or 0
	self.lifestealupamount = data.lifestealupamount or 0
	self.fireflylightup = data.fireflylightup or 0
	self.starsspent = data.starsspent or 0
    --bug fixed
    self.doubledrop = data.doubledrop==true and 1 or (data.doubledrop or 0)
    self.nomoist = data.nomoist==true and 1 or (data.nomoist or 0)
    self.goodman = data.goodman==true and 1 or (data.goodman or 0)
	self.cheatdeath = data.cheatdeath==true and 1 or (data.cheatdeath or 0)
    self.refresh = data.refresh==true and 1 or (data.refresh or 0)
    self.fishmaster = data.fishmaster==true and 1 or (data.fishmaster or 0)
    self.cookmaster = data.cookmaster==true and 1 or (data.cookmaster or 0)
    self.chopmaster = data.chopmaster==true and 1 or (data.chopmaster or 0)
    self.pickmaster = data.pickmaster==true and 1 or (data.pickmaster or 0)
    self.buildmaster = data.buildmaster==true and 1 or (data.buildmaster or 0)
    self.icebody = data.icebody==true and 1 or (data.icebody or 0)
    self.firebody = data.firebody==true and 1 or (data.firebody or 0)
    self.reader = data.reader==true and 1 or (data.reader or 0)
    self.masterchef = data.masterchef==true and 1 or (data.masterchef or 0)
	self.minemaster = data.minemaster==true and 1 or (data.minemaster or 0)
	self.fastworker = data.fastworker==true and 1 or (data.fastworker or 0)
    self.attackback = data.attackback==true and 1 or (data.attackback or 0)
    self.stopregen = data.stopregen==true and 1 or (data.stopregen or 0)
    self.attackfrozen = data.attackfrozen==true and 1 or (data.attackfrozen or 0)
    self.attackdead = data.attackdead==true and 1 or (data.attackdead or 0)
    self.attackbroken = data.attackbroken==true and 1 or (data.attackbroken or 0)
    self.waterwalk = data.waterwalk or 0

    self.level120 = data.level120 or 0
    self.abigaillevelup = data.abigaillevelup or 0
    self.abigailclone = data.abigailclone or 0
    self.bloodangry = data.bloodangry or 0
    self.balloonlevelup = data.balloonlevelup or 0
    self.ballooninspire = data.ballooninspire or 0
    self.wescheat = data.wescheat or 0
    self.callspider = data.callspider or 0
    self.spiderstronger = data.spiderstronger or 0
    self.bernielevelup = data.bernielevelup or 0
    self.linghtermore = data.linghtermore or 0
    self.gearuse = data.gearuse or 0
    self.callmerm = data.callmerm or 0
    self.mermstronger = data.mermstronger or 0
    self.soulmore = data.soulmore or 0
    self.strongeraoe = data.strongeraoe or 0
    self.waxwellup = data.waxwellup or 0
    self.winnonaup = data.winnonaup or 0
    self.woodieup = data.woodieup or 0
    self.warlyup = data.warlyup or 0
    self.wormwoodup = data.wormwoodup or 0
    self.wickerbottomup = data.wickerbottomup or 0
    self.hitattack = data.hitattack or 0
    self.memorykill = data.memorykill or 0
    self.throwrock = data.throwrock or 0
    self.quickshot = data.quickshot or 0

    self.respawnfromghost = data.respawnfromghost or 0
    self.resettempachiv = data.resettempachiv or 0
    self.goldnugget = data.goldnugget or 0
    self.greengem = data.greengem or 0
    self.orangegem = data.orangegem or 0
    self.yellowgem = data.yellowgem or 0
    self.ice = data.ice or 0
    self.gears = data.gears or 0
    self.dug_grass = data.dug_grass or 0
    self.dug_sapling = data.dug_sapling or 0
    self.dug_rock_avocado_bush = data.dug_rock_avocado_bush or 0
    self.dug_berrybush = data.dug_berrybush or 0
    self.blowdart_pipe = data.blowdart_pipe or 0
    self.gunpowder = data.gunpowder or 0
    self.nightsword = data.nightsword or 0
    self.slurtlehat = data.slurtlehat or 0
    self.prayer_symbol = data.prayer_symbol or 0
    self.package_staff = data.package_staff or 0
    self.cheatdeathcd = data.cheatdeathcd or 0
    self.potion_achiv = data.potion_achiv or 0
    self.recycle = data.recycle or 0
    self.blueprint = data.blueprint or 0
    self.package_ball = data.package_ball or 0

    self.seasondamageup = data.seasondamageup or 0
    self.freeresurrecttime = data.freeresurrecttime or 0
    self.resurrectcd = data.resurrectcd or 0
    self.wescheatcd = data.wescheatcd or 0
    self.callback = data.callback or 0
    self.callbackcd = data.callbackcd or 0
    self.potion = data.potion or 0
    self.lightpower = data.lightpower or 0
    self.freetimes = data.freetimes or 0
    self.aoestatus = data.aoestatus or 0
    self.memorykilldata = data.memorykilldata or {}

    --fixbug

end

--通用效果器 获取成功
function allachivcoin:ongetcoin(inst)
    inst.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
end


function allachivcoin:coinDoDelta(value)
    if value + self.coinamount < 0 then
        return false
    end
    self.coinamount = self.coinamount + value
    self.inst:PushEvent("coindelta", {value=value})
end

--提升饱腹获取
function allachivcoin:hungerupcoin(inst)
    if self.coinamount >= allachiv_coinuse["hungerup"] 
        and self.hungerupamount < allachiv_coindata_max["hungerup"] then
        self.hungerupamount = self.hungerupamount + 1
		self:coinDoDelta(-allachiv_coinuse["hungerup"])
		self.starsspent = self.starsspent + allachiv_coinuse["hungerup"]
		self:ongetcoin(inst)
    end
end

--提升精神获取
function allachivcoin:sanityupcoin(inst)
    if self.coinamount >= allachiv_coinuse["sanityup"] 
        and self.sanityupamount < allachiv_coindata_max["sanityup"] then
        self.sanityupamount = self.sanityupamount + 1
		self:coinDoDelta(-allachiv_coinuse["sanityup"])
		self.starsspent = self.starsspent + allachiv_coinuse["sanityup"]
		self:ongetcoin(inst)
    end
end

function allachivcoin:healthupcoin(inst)
    if self.coinamount >= allachiv_coinuse["healthup"] and inst.prefab ~= "wolfgang"
        and self.healthupamount < allachiv_coindata_max["healthup"]  then
        self.healthupamount = self.healthupamount + 1
		self:coinDoDelta(-allachiv_coinuse["healthup"])
		self.starsspent = self.starsspent + allachiv_coinuse["healthup"]
		self:ongetcoin(inst)
    end
end


--提升速度获取
function allachivcoin:speedupcoin(inst)
    if self.coinamount >= allachiv_coinuse["speedup"]
    and self.speedupamount < allachiv_coindata_max["speedup"] then
        self.speedupamount = self.speedupamount + 1
        self:coinDoDelta(-allachiv_coinuse["speedup"])
		self.starsspent = self.starsspent + allachiv_coinuse["speedup"]
		local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
		currentSpeedMult = currentSpeedMult + allachiv_coindata["speedup"]
		inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
		self:ongetcoin(inst)
    end
end


function allachivcoin:damageupcoin(inst)
    if self.coinamount >= allachiv_coinuse["damageup"]
        and self.damageupamount < allachiv_coindata_max["damageup"] then
        self.damageupamount = self.damageupamount + 1
        self:coinDoDelta(-allachiv_coinuse["damageup"])
		self.starsspent = self.starsspent + allachiv_coinuse["damageup"]
		local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
		currentDamageMult = currentDamageMult + allachiv_coindata["damageup"]
		inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
		self:ongetcoin(inst)
    end
end

function allachivcoin:absorbupcoin(inst)
	local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
	if currentAbsorbAdd > 0.95 then
		return
	end
    if self.coinamount >= allachiv_coinuse["absorbup"]
    and self.absorbupamount < allachiv_coindata_max["absorbup"] then
        self.absorbupamount = self.absorbupamount + 1
        self:coinDoDelta(-allachiv_coinuse["absorbup"])
		self.starsspent = self.starsspent + allachiv_coinuse["absorbup"]
		currentAbsorbAdd = currentAbsorbAdd + allachiv_coindata["absorbup"]
		inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)
		self:ongetcoin(inst)
    end
end

function allachivcoin:critcoin(inst)
    if self.coinamount >= allachiv_coinuse["crit"]
    and self.crit < allachiv_coindata_max["crit"] then
        self.crit = self.crit + 1
        self:coinDoDelta(-allachiv_coinuse["crit"])
		self.starsspent = self.starsspent + allachiv_coinuse["crit"]
		self:ongetcoin(inst)
    end
end

function allachivcoin:onhitfn(inst)
    inst:ListenForEvent("onattackother", function(inst, data)
        if self.hits < 20 then
            self.hits = self.hits + 1
        end
        self.hitattackcd = 3
        if inst:HasTag("shadow") then 
            inst:Show()
            inst:RemoveTag("shadow")
            inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
        end
    end)
    --[[inst:ListenForEvent("onhitother", function(inst, data)
        local shadowcrit = false
        if inst:HasTag("shadow") then 
            inst:Show()
            inst:RemoveTag("shadow")
            inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
            shadowcrit = true
        end
        if self.hits < 20 then
            self.hits = self.hits + 1
        end
        self.hitattackcd = 3
        
        local chance = allachiv_coindata["crit"]*self.crit*100
        local damage = data.damage
        local target = data.target
        local stimuli = data.stimuli

        if target.components.health == nil then return end
        local hp = target.components.health.currenthealth
        local maxhp = target.components.health.maxhealth

        local attackbrokenchance = 0.05
        local attackdeadchance = 0.001
        if maxhp <= 9999 then attackdeadchance = 0.01 end
        if stimuli == "book_kill" then
            attackbrokenchance = attackbrokenchance * 0.2
            attackdeadchance = attackdeadchance * 0.2
            chance = chance*0.2
        end
        if stimuli == "blood" then
            return
        end
        if inst.components.titlesystem and inst.components.titlesystem.titles[5] == 1 then
            chance = chance * (1+title_data["title5"]["crit"])
        end
        if target and math.random() <= attackdeadchance and not target:HasTag("wall") and self.attackdead and self.attackcheck ~= true then
            self.attackcheck = true
            local hp = target.components.health.currenthealth
            if maxhp <= 9999 then
                target.components.combat:GetAttacked(inst, 99999)
            else 
                target.components.combat:GetAttacked(inst, 99999)
            end
            target.AnimState:OverrideMultColour(1, 0.1, 0.1, 1)
            target:DoTaskInTime(0.5, function() target.AnimState:OverrideMultColour() end)
            inst:DoTaskInTime(.1, function() self.attackcheck = false end)
            if inst.components.talker then 
                inst.components.talker:Say(STRINGS.TALKER_ATTACKDEAD) 
            end
            return
        end
        
        if target and math.random() <= attackbrokenchance and not target:HasTag("wall") and self.attackbroken and self.attackcheck ~= true then
            self.attackcheck = true
            local hp = target.components.health.currenthealth
            target.components.combat:GetAttacked(inst, hp*0.1)
            target.AnimState:OverrideMultColour(0.1, 1, 0.1, 1)
            target:DoTaskInTime(0.5, function() target.AnimState:OverrideMultColour() end)
            inst:DoTaskInTime(.1, function() self.attackcheck = false end)
            return
        end

        local luck = inst.components.luck and inst.components.luck:GetLuck() or 0
        if luck > title_data["title10"]["luck"] and inst.components.titlesystem and inst.components.titlesystem.equip == 10 then 
            chance = 100
        end
        if target and (math.random(1,100) <= chance and not target:HasTag("wall") and self.crit > 0 or shadowcrit) and self.attackcheck ~= true then
            self.attackcheck = true
            local hittable = {1,1,1,1,1,1,2,2,2,3,3}
            if shadowcrit then 
                table.insert(hittable, 4)
            end
            if inst.components.titlesystem and inst.components.titlesystem.titles[5] == 1
             and inst.components.titlesystem.equip == 5 then
                for k=1,title_data["title5"]["hit"] do
                    table.insert(hittable, hittable[#hittable] + 1)
                end
            end
            local luck = inst.components.luck and inst.components.luck:GetLuck() or 0
            local hitnum = hittable[math.random(math.floor(luck/20) + 1, #hittable)]

            if inst.components.luck and inst.components.luck:GetLuck()>title_data["title10"]["luck"] and
             inst.components.titlesystem and inst.components.titlesystem.equip == 10 and hitnum < 2 then
                hitnum = 2
                inst.components.luck:DoDelta(-1)
            end
            target.components.combat:GetAttacked(inst, damage * hitnum)
            local snap = SpawnPrefab("impact")
            snap.Transform:SetScale(3, 3, 3)
            snap.Transform:SetPosition(target.Transform:GetWorldPosition())
            if target.SoundEmitter ~= nil then
                target.SoundEmitter:PlaySound("dontstarve/common/whip_large", nil, 0.3)
            end
            inst:DoTaskInTime(.1, function() self.attackcheck = false end)
        end
    end)]]
end

function allachivcoin:lifestealupcoin(inst)
    if self.coinamount >= allachiv_coinuse["lifesteal"]
    and self.lifestealupamount < allachiv_coindata_max["lifesteal"] then
        self.lifestealupamount = self.lifestealupamount + 1
        self:coinDoDelta(-allachiv_coinuse["lifesteal"])
		self.starsspent = self.starsspent + allachiv_coinuse["lifesteal"]
		self:ongetcoin(inst)
    end
end


function allachivcoin:attackfrozencoin(inst)
    if self.coinamount >= allachiv_coinuse["attackfrozen"] and self.attackfrozen < 1 then
        self.attackfrozen = 1
        self:coinDoDelta(-allachiv_coinuse["attackfrozen"])
        self.starsspent = self.starsspent + allachiv_coinuse["attackfrozen"]
        self:ongetcoin(inst)
    end
end

--冰冻攻击
function allachivcoin:attackfrozenfn(inst)
    inst:ListenForEvent("onhitother", function(inst,data)
        if math.random()<=0.2 and self.attackfrozen > 0 and data and data.target then
            local target = data.target
            if target.components and target.components.freezable then --只有有freezable组件的prefab才会被冰冻
                local coldness = 1 --(冰冻强度，每个可冰冻的prefab都有冰冻抗性，只有积累的强度超过抗性了才会被冰冻)
                local freezetime = 5--(冰冻时间)
                target.components.freezable:AddColdness(coldness, freezetime)
            end
        end
    end)
end

function allachivcoin:attackdeadcoin(inst)
    if self.coinamount >= allachiv_coinuse["attackdead"] and self.attackdead < 1 then
        self.attackdead = 1
        self:coinDoDelta(-allachiv_coinuse["attackdead"])
        self.starsspent = self.starsspent + allachiv_coinuse["attackfrozen"]
        self:ongetcoin(inst)
    end
end

function allachivcoin:attackbrokencoin(inst)
    if self.coinamount >= allachiv_coinuse["attackbroken"] and self.attackbroken < 1 then
        self.attackbroken = 1
        self:coinDoDelta(-allachiv_coinuse["attackbroken"])
        self.starsspent = self.starsspent + allachiv_coinuse["attackbroken"]
        self:ongetcoin(inst)
    end
end

function allachivcoin:waterwalkcoin(inst)
    if self.coinamount >= allachiv_coinuse["waterwalk"] and self.waterwalk < 1 then
        self.waterwalk = 1
        self:coinDoDelta(-allachiv_coinuse["waterwalk"])
        self.starsspent = self.starsspent + allachiv_coinuse["waterwalk"]
        self:ongetcoin(inst)
    end
end

function allachivcoin:waterwalkswitch(inst)
    if self.waterwalk > 0 then
        self.waterwalkstatus = math.abs(self.waterwalkstatus-1)
    end
end


function allachivcoin:fireflylightfn(inst)
	if inst._fireflylight then inst._fireflylight:Remove() end
    if self.fireflylightup > 0 then
        inst._fireflylight = SpawnPrefab("minerhatlight")
        inst._fireflylight.Light:SetRadius(0.5+self.fireflylightup-1)
        inst._fireflylight.Light:SetFalloff(.8)
        inst._fireflylight.Light:SetIntensity(.6)
        inst._fireflylight.Light:SetColour(255/255,255/255,255/255)
        inst._fireflylight.entity:SetParent(inst.entity)
        if TheWorld.components.worldstate.data.isday then
            inst._fireflylight.Light:SetIntensity(0)
            inst._fireflylight.Light:Enable(false)
        end
        inst:WatchWorldState("startday", function()
            for i=1, 100 do
                inst:DoTaskInTime(i/25, function()
                    inst._fireflylight.Light:SetIntensity(.5-i/100*.5)
                end)
            end
            inst:DoTaskInTime(4, function() inst._fireflylight.Light:Enable(false) end)
        end)
        inst:WatchWorldState("startdusk", function()
            inst._fireflylight.Light:Enable(true)
            for i=1, 100 do
                inst:DoTaskInTime(i/25, function()
                    inst._fireflylight.Light:SetIntensity(i/100*.5)
                end)
            end
        end)
    end
end

--雨水免疫获取
function allachivcoin:nomoistcoin(inst)
    if self.nomoist < 1 and self.coinamount >= allachiv_coinuse["nomoist"] then
        self.nomoist = 1
        inst.components.moisture.maxMoistureRate = 0
        self.maxMoistureRate = inst.components.moisture.maxMoistureRate
		self.starsspent = self.starsspent + allachiv_coinuse["nomoist"]
        self:coinDoDelta(-allachiv_coinuse["nomoist"])
        self:ongetcoin(inst)
    end
end

--双倍掉落获取
function allachivcoin:doubledropcoin(inst)
    if self.doubledrop < 1 and self.coinamount >= allachiv_coinuse["doubledrop"] then
        self.doubledrop = 1
		self.starsspent = self.starsspent + allachiv_coinuse["doubledrop"]
        self:coinDoDelta(-allachiv_coinuse["doubledrop"])
        self:ongetcoin(inst)
    end
end

--双倍掉落效果
function allachivcoin:doubledropfn(inst)
    inst:ListenForEvent("killedmonster", function(inst, data)
        if self.doubledrop > 0 and data.victim.components.lootdropper then
            if data.victim.prefab == "stalker" 
                and data.victim.prefab == "stalker_atrium" 
                and data.victim.prefab == "stalker_forest" then
                    return
            end
            if data.victim.components.freezable or data.victim:HasTag("monster") then
                data.victim.components.lootdropper:DropLoot()
            end
        end
    end)
end

		
function allachivcoin:goodmancoin(inst)
    if self.goodman < 1 and self.coinamount >= allachiv_coinuse["goodman"] then
        self.goodman = 1
		self.starsspent = self.starsspent + allachiv_coinuse["goodman"]
        self:coinDoDelta(-allachiv_coinuse["goodman"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:goodmanfn(inst)
    
end


--垂钓圣手获取
function allachivcoin:fishmastercoin(inst)
    if self.fishmaster < 1 and self.coinamount >= allachiv_coinuse["fishmaster"] then
        self.fishmaster = 1
		self.starsspent = self.starsspent + allachiv_coinuse["fishmaster"]
        self:coinDoDelta(-allachiv_coinuse["fishmaster"])
        self:ongetcoin(inst)

        if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).components
        and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).components.fishingrod then
            local fishingrod = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).components.fishingrod
            self.fishtimemin = fishingrod.minwaittime
            self.fishtimemax = fishingrod.maxwaittime
            fishingrod:SetWaitTimes(1, 1)
        end
    end
end

--垂钓圣手效果
function allachivcoin:fishmasterfn(inst)
    inst:ListenForEvent("equip", function(inst, data)
        if  self.fishmaster > 0 and data.item and data.item.components.fishingrod then
            self.fishtimemin = data.item.components.fishingrod.minwaittime
            self.fishtimemax = data.item.components.fishingrod.maxwaittime
            data.item.components.fishingrod:SetWaitTimes(1, 1)
        end
    end)
    inst:ListenForEvent("unequip", function(inst, data)
        if self.fishmaster > 0 and data.item and data.item.components.fishingrod then
            data.item.components.fishingrod:SetWaitTimes(self.fishtimemin, self.fishtimemax)
        end
    end)
end

--双倍采集获取
function allachivcoin:pickmastercoin(inst)
    if self.pickmaster < 1 and self.coinamount >= allachiv_coinuse["pickmaster"] then
        self.pickmaster = 1
		self.starsspent = self.starsspent + allachiv_coinuse["pickmaster"]
        self:coinDoDelta(-allachiv_coinuse["pickmaster"])
        self:ongetcoin(inst)
    end
end

--双倍采集效果
function allachivcoin:pickmasterfn(inst)
    inst:ListenForEvent("picksomething", function(inst, data)
        if self.pickmaster > 0 and data.object and data.object.components.pickable and not data.object.components.trader then
            if data.object.components.pickable.product ~= nil then
                local item = SpawnPrefab(data.object.components.pickable.product)
                if item.components.stackable then
                    item.components.stackable:SetStackSize(data.object.components.pickable.numtoharvest)
                end
                inst.components.inventory:GiveItem(item, nil, data.object:GetPosition())
            elseif data.object.components.lootdropper ~= nil then --新版没有产品product，变成战利品了
                for _, prefab in ipairs(data.object.components.lootdropper:GenerateLoot()) do
                    local item = data.object.components.lootdropper:SpawnLootPrefab(prefab)
                    inst.components.inventory:GiveItem(item, nil, data.object:GetPosition())
                end
            end
        end
    end)
end

--砍树圣手获取
function allachivcoin:chopmastercoin(inst)
    if self.chopmaster < 1 and self.coinamount >= allachiv_coinuse["chopmaster"] then
        self.chopmaster = 1
		self.starsspent = self.starsspent + allachiv_coinuse["chopmaster"]
        self:coinDoDelta(-allachiv_coinuse["chopmaster"])
        self:ongetcoin(inst)
    end
end

--砍树圣手效果
function allachivcoin:chopmasterfn(inst)
    inst:ListenForEvent("working", function(inst, data)
        if self.chopmaster > 0 and data.target and data.target:HasTag("tree") then
            local workable = data.target.components.workable
            --if workable.workleft >= 1 then
            --    if workable.onfinish then
                    workable.workleft = 0
            --    end
            --end
        end
    end)
end

--烹调圣手获取
function allachivcoin:cookmastercoin(inst)
    if self.cookmaster < 1 and self.coinamount >= allachiv_coinuse["cookmaster"] then
        self.cookmaster = 1
		self.starsspent = self.starsspent + allachiv_coinuse["cookmaster"]
        self:coinDoDelta(-allachiv_coinuse["cookmaster"])
        self:ongetcoin(inst)
        if inst:HasTag("expertchef") ~= true then
            inst:AddTag("expertchef")
        end
    end
end

--烹调圣手效果&煮食事件内置
function allachivcoin:cookmasterfn(inst)
    if self.cookmaster > 0 and inst:HasTag("expertchef") ~= true then
        inst:AddTag("expertchef")
    end
    local COOK = ACTIONS.COOK
    local old_cook_fn = COOK.fn
    COOK.fn = function(act, ...)
        local result = old_cook_fn(act)
        local stewer = act.target.components.stewer
        local allachivcoin = act.doer.components.allachivcoin
        local allachivevent = act.doer.components.allachivevent
        if result and stewer ~= nil then
            allachivevent:addOneJob(act.doer, "cook100")
            allachivevent:addOneJob(act.doer, "cook666")
            if stewer.product == "waffles" then
                allachivevent:addOneJob(act.doer, "cookwaffles")
            end
            if stewer.product == "bananapop" then
                allachivevent:addOneJob(act.doer, "cookbananapop")
            end
            if allachivcoin.cookmaster > 0 then
                local fn = stewer.task.fn
                stewer.task:Cancel()
                fn(act.target, stewer)
            end
            act.doer:PushEvent("docook", {product=stewer.product})
        end
    end
end

--节省材料获取
function allachivcoin:buildmastercoin(inst)
    if self.buildmaster < 1 and self.coinamount >= allachiv_coinuse["buildmaster"] then
        self.buildmaster = 1
        inst.components.builder.ingredientmod = .5
		self.starsspent = self.starsspent + allachiv_coinuse["buildmaster"]
        self:coinDoDelta(-allachiv_coinuse["buildmaster"])
        self:buildmasterfn(inst)
        inst.components.builder.ingredientmod = .5
        self:ongetcoin(inst)
    end
end

--节省材料效果
function allachivcoin:buildmasterfn(inst)
    if self.buildmaster > 0 then
        inst.components.builder.ingredientmod = .5
    end
    inst:ListenForEvent("equip", function(inst, data)
        if self.buildmaster > 0 and data.item and data.item.prefab == "greenamulet" then
            inst.components.builder.ingredientmod = .5
        end
    end)
    inst:ListenForEvent("unequip", function(inst, data)
        if self.buildmaster > 0 and data.item and data.item.prefab == "greenamulet" then
            inst.components.builder.ingredientmod = .5
        end
    end)
end


function allachivcoin:cheatdeathcoin(inst)
    if self.cheatdeath < 1 and self.coinamount >= allachiv_coinuse["cheatdeath"] then
        self.cheatdeath = 1
		self.starsspent = self.starsspent + allachiv_coinuse["cheatdeath"]
        self:coinDoDelta(-allachiv_coinuse["cheatdeath"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:cheatdeathfn(inst)
	inst:ListenForEvent("minhealth", function(player, data)
        if self.cheatdeathcd > 0 then
            return
        end
		if self.cheatdeath > 0 and player.components.health.currenthealth <= 0 then
			player.components.health.currenthealth = 1
			player.components.health:SetInvincible(true)
			if player._fx ~= nil then
				player._fx:kill_fx()
			end
			player._fx = SpawnPrefab("forcefieldfx")
			player._fx.entity:SetParent(player.entity)
			player._fx.Transform:SetPosition(0, 0.2, 0)
			
			player.SoundEmitter:PlaySound("dontstarve/common/lava_arena/spawn")
			player:DoTaskInTime(10, function(player) 
                player.components.talker:Say(STRINGS.ALLACHIVCURRENCY[20])
				if player._fx ~= nil then
					player._fx:kill_fx()
					player._fx = nil
				end
				player.components.health:SetInvincible(false)
			end)
            self.cheatdeathcd = allachiv_coindata["cheatdeath"]
		end
	end)
end

function allachivcoin:refreshcoin(inst)
    if self.refresh < 1 and self.coinamount >= allachiv_coinuse["refresh"] then
        self.refresh = 1
		self.starsspent = self.starsspent + allachiv_coinuse["refresh"]
        self:coinDoDelta(-allachiv_coinuse["refresh"])
        self:ongetcoin(inst)
    end
end

--携带反鲜效果
function allachivcoin:refreshfn(inst)
    inst:DoPeriodicTask(1, function()
        if self.refresh > 0 then
            --[[--物品栏反鲜
            for k,v in pairs(inst.components.inventory.itemslots) do
                if v and v.components.perishable then
                    v.components.perishable:ReducePercent(-.005)
                end
            end
            --装备栏反鲜
            for k,v in pairs(inst.components.inventory.equipslots) do
                if v and v.components.perishable then
                    v.components.perishable:ReducePercent(-.005)
                end
            end]]--
            --背包反鲜
            for k,v in pairs(inst.components.inventory.opencontainers) do
                if k and k:HasTag("backpack") and k.components.container then
                    for i,j in pairs(k.components.container.slots) do
                        if j and j.components.perishable then
                            j.components.perishable:ReducePercent(-.005)
                        end
                    end
                end
            end
        end
    end)
end

--低温免疫获取
function allachivcoin:icebodycoin(inst)
    if self.icebody < 1 and self.coinamount >= allachiv_coinuse["icebody"] then
        self.icebody = 1
		self.starsspent = self.starsspent + allachiv_coinuse["icebody"]
        self:coinDoDelta(-allachiv_coinuse["icebody"])
        self:icebodyfn(inst)
        self:ongetcoin(inst)
    end
end

--低温免疫效果
function allachivcoin:icebodyfn(inst)
    if self.icebody == 1 then
        inst.components.temperature.mintemp = 5
    end
end

--高温免疫获取
function allachivcoin:firebodycoin(inst)
    if self.firebody < 1 and self.coinamount >= allachiv_coinuse["firebody"] then
        self.firebody = 1
		self.starsspent = self.starsspent + allachiv_coinuse["firebody"]
        self:coinDoDelta(-allachiv_coinuse["firebody"])
        self:firebodyfn(inst)
        self:ongetcoin(inst)
    end
end

--高温免疫效果
function allachivcoin:firebodyfn(inst)
    if self.firebody == 1 then
        inst.components.temperature.maxtemp = 65
    end
end

--书籍阅读获取
function allachivcoin:readercoin(inst)
    if self.reader < 1 and self.coinamount >= allachiv_coinuse["reader"] and inst.prefab ~= "wickerbottom" then
        self.reader = 1
		self.starsspent = self.starsspent + allachiv_coinuse["reader"]
        self:coinDoDelta(-allachiv_coinuse["reader"])
        self:readerfn(inst)
--        local item1 = SpawnPrefab("papyrus")
--        item1.components.stackable:SetStackSize(6)
--        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end

--书籍阅读效果
function allachivcoin:readerfn(inst)
    if self.reader > 0 then
        inst:AddComponent("reader")
--        inst:AddTag("bookbuilder")
    end
end

function allachivcoin:masterchefcoin(inst)
    if self.masterchef < 1 and self.coinamount >= allachiv_coinuse["masterchef"] and inst.prefab ~= "warly" then
        self.masterchef = 1
		self.starsspent = self.starsspent + allachiv_coinuse["masterchef"]
        self:coinDoDelta(-allachiv_coinuse["masterchef"])
        self:mastercheffn(inst)
        local item1 = SpawnPrefab("spice_chili")
        item1.components.stackable:SetStackSize(2)
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        local item2 = SpawnPrefab("spice_garlic")
        item2.components.stackable:SetStackSize(2)
        inst.components.inventory:GiveItem(item2, nil, inst:GetPosition())
        local item3 = SpawnPrefab("spice_sugar")
        item3.components.stackable:SetStackSize(2)
        inst.components.inventory:GiveItem(item3, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end

function allachivcoin:mastercheffn(inst)
    if self.masterchef > 0 then
        inst:AddTag("perkchef")
        inst:AddTag("masterchef")
        inst:AddTag("professionalchef")
    end
end

function allachivcoin:minemastercoin(inst)
    if self.minemaster < 1 and self.coinamount >= allachiv_coinuse["minemaster"] then
        self.minemaster = 1
		self.starsspent = self.starsspent + allachiv_coinuse["minemaster"]
        self:coinDoDelta(-allachiv_coinuse["minemaster"])
        self:minemasterfn(inst)
        self:ongetcoin(inst)
    end
end

function allachivcoin:minemasterfn(inst)
    if self.minemaster > 0 then
        inst:ListenForEvent("working", function(inst, data)
			if self.minemaster > 0 and data.target and (data.target:HasTag("boulder") or data.target:HasTag("statue") or findprefab(rocklist, data.target.prefab)) then
				local workable = data.target.components.workable
				workable.workleft = 0
			end
		end)
    end
end

function allachivcoin:fastworkercoin(inst)
    if self.fastworker < 1 and self.coinamount >= allachiv_coinuse["fastworker"] then
        self.fastworker = 1
		self.starsspent = self.starsspent + allachiv_coinuse["fastworker"]
        self:coinDoDelta(-allachiv_coinuse["fastworker"])
        self:fastworkerfn(inst)
        self:ongetcoin(inst)
    end
end

function allachivcoin:fastworkerfn(inst)
    if self.fastworker > 0 then
		inst:AddTag("fastpick")
		if inst:HasTag("expertchef") ~= true then
            inst:AddTag("expertchef")
        end
        if inst:HasTag("fastbuilder") ~= true then
            inst:AddTag("fastbuilder")
        end
    end
end

--反伤
function allachivcoin:attackbackcoin(inst)
    if self.attackback < 1 and self.coinamount >= allachiv_coinuse["attackback"] then
        self.attackback = 1
        self.starsspent = self.starsspent + allachiv_coinuse["attackback"]
        self:coinDoDelta(-allachiv_coinuse["attackback"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:attackbackfn(inst)
    inst:ListenForEvent("attacked", function(inst, data)
        if self.attackback > 0 and inst.attackbackcd == nil and data ~= nil and not data.redirected then
            inst.attackbackcd = inst:DoTaskInTime(.3, function(inst)
                inst.attackbackcd = nil
            end)
            local back_attack = SpawnPrefab("bramblefx_armor")
            back_attack.damage = data.damage*0.5 + 10
            back_attack:SetFXOwner(inst)
            --SpawnPrefab("bramblefx_armor"):SetFXOwner(inst)--22
           
            if inst.SoundEmitter ~= nil then
                inst.SoundEmitter:PlaySound("dontstarve/common/together/armor/cactus")
            end
        end
    end)
end

function allachivcoin:stopregencoin(inst)
    if self.stopregen < 1 and self.coinamount >= allachiv_coinuse["stopregen"] then
        self.stopregen = 1
        self.starsspent = self.starsspent + allachiv_coinuse["stopregen"]
        self:coinDoDelta(-allachiv_coinuse["stopregen"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:stopregenfn(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
        if self.stopregen > 0 then
            local damage = data.damage
            local target = data.target
            if target:HasTag("monster") or 
                (target.components and 
                    target.components.health and
                     not target:HasTag("abigail")) then
                target.components.health:StopRegen()
            end
        end
    end)
end

--特殊
function allachivcoin:level120coin(inst)
    if self.level120 < allachiv_coindata_max["level120"] and self.coinamount >= allachiv_coinuse["level120"] then
        self.level120 = self.level120 + 1
        self.starsspent = self.starsspent + allachiv_coinuse["level120"]
        self:coinDoDelta(-allachiv_coinuse["level120"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:abigaillevelupcoin(inst)
    if self.abigaillevelup < 1 and self.coinamount >= allachiv_coinuse["abigaillevelup"] then
        self.abigaillevelup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["abigaillevelup"]
        self:coinDoDelta(-allachiv_coinuse["abigaillevelup"])
        self:ongetcoin(inst)
        self:aliveabigaillevelup(inst)
    end
end

local function addHit(inst, follower)
    follower:ListenForEvent("onhitother", function(follower, data) 
        --local damage = data.damage
        local target = data.target
        inst = follower.components.follower:GetLeader() or inst
        if inst ~= nil and not target:HasTag("wall") and (TheNet:GetPVPEnabled() or not target:HasTag("player")) then
            if target:IsValid() and target.components.combat then
                if inst:IsValid() and not inst:HasTag("playerghost") and inst.components.levelsystem then
                    local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                    local damage = inst.components.levelsystem.power or 10
                    local lifestealupamount = inst.components.allachivcoin.lifestealupamount or 0
                    --target.components.combat:GetAttacked(inst, 1)
                    if follower.hitcd ~= true then
                        follower.hitcd = true
                        target.components.combat:GetAttacked(follower, damage * 0.25 + 0.4*level)
                        if lifestealupamount > 0 then
                            follower.components.health:DoDelta(damage*lifestealupamount*allachiv_coindata["lifesteal"])
                        end
                        follower:DoTaskInTime(0.3, function() follower.hitcd=false end)
                    end
                    inst:PushEvent("onhitother", { target = target, damage = damage * 0.25 + 0.4*level})
                end
            end
        end
    end)
end

local function addHealthHelp(inst, follower, self)
    follower:ListenForEvent("healthdelta", function(follower, data)
        inst = follower.components.follower and follower.components.follower:GetLeader() or inst
        if not follower:IsValid() or not inst:IsValid() then
            return
        end
        local amount = data.amount
        local overtime = data.overtime
        local cause = data.cause
        local healthpercent = math.max(0, math.min(data.newpercent, 1)) 
        local player_healthpercent = inst.components.health:GetPercent() or 0
        if amount < -1 and healthpercent > 0 and healthpercent < 0.5 and player_healthpercent >0.5 then
            --local player_max = inst.components.health.maxhealth
            --local follower_max = follower.components.health.maxhealth
            --local health1 = (0.3-healthpercent)*follower_max
            --local health2 = (player_healthpercent-0.6)*player_max
            local regen_health = -amount*0.5
            if self.hpdel ~= true then
                self.hpdel = true
                follower.components.health:DoDelta(regen_health, overtime, cause)
                inst.components.health:DoDelta(-regen_health, overtime, cause)
                self.inst:DoTaskInTime(0.3, function() self.hpdel=false end)
            end
        end
    end)
end

function allachivcoin:aliveabigaillevelup(inst)
    local followers = inst.components.leader.followers
    local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
    for k,v in pairs(followers) do
        if k.prefab == "abigail" or k:HasTag("abigail") then
            if k.prefab == "abigail" then
                --follower.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", 0.7)
                k.components.health.absorb = 0.5 + math.floor(level*0.1) * 0.02
                addHealthHelp(inst, k, self)
                addHealthHelp(k, inst, self)
            else
                k.components.health.absorb = 0.3 + math.floor(level*0.1) * 0.02
            end
            --k.components.health:StartRegen(1 + 0.2*level, 1)
            addHit(inst, k)
        end
    end
end

function allachivcoin:addfollowerfn(inst)
    inst.components.leader.oldAddFollower = inst.components.leader.AddFollower
    function inst.components.leader:AddFollower(follower)
        if self.followers[follower] == nil and follower.components.follower ~= nil then
            local achiv = inst.components.allachivevent
            achiv:addOneTemp(inst, "refriend5")
            --Pigman
            if follower.prefab == "pigman" then
                achiv:addOneJob(inst, "goodman")
            end
            --Bunnyman
            if follower.prefab == "bunnyman" then
                achiv:addOneJob(inst, "brother")
            end
            --Catcoon
            if follower.prefab == "catcoon" then
                achiv:addOneJob(inst, "catperson")
            end
            --Spooders
            if (follower.prefab == "spider" or 
                follower.prefab == "spider_dropper" or 
                follower.prefab == "spider_warrior" or 
                follower.prefab == "spider_hider" or 
                follower.prefab == "spider_spitter") then
                achiv:addOneJob(inst, "spooder")
            end
            --Mandrake
            if follower.prefab == "mandrake_active" and not TheWorld.components.worldstate.data.isday then
                
                
            end
            --TallBirb
            if follower.prefab == "smallbird"  then
                achiv:addOneJob(inst, "birdclop")
            end
            --RockLobster
            if follower.prefab == "rocky" then
                achiv:addOneJob(inst, "rocklob")
            end
        end
        local allachivcoin = inst.components.allachivcoin
        if allachivcoin.abigaillevelup > 0 then
            if follower.prefab == "abigail" or follower:HasTag("abigail") then
                local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                --follower.components.health:StartRegen(1 + 0.2*level, 1)
                if follower.prefab == "abigail" then
                    --follower.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", 0.7)
                    follower.components.health.absorb = 0.5 + math.floor(level*0.1) * 0.02
                    addHealthHelp(inst, follower, self)
                    addHealthHelp(follower, inst, self)
                else
                    follower.components.health.absorb = 0.5
                end
                addHit(inst, follower)
            end
        end
        if allachivcoin.abigailclone > 0 then
            if follower.prefab == "abigail" and follower.components.clone == nil then
                follower:AddComponent("clone")
            end
        end
        if follower:HasTag("abigail") and inst.components.titlesystem and inst.components.titlesystem.titles[6] > 0 then
            follower:AddComponent("revenge")
        end
        if allachivcoin.spiderstronger > 0 then
            if follower:HasTag("spider") then
                local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                local maxhealth = follower.components.health.maxhealth + 15*level
                follower._oldhealth = follower.components.health.maxhealth
                follower.components.health:SetMaxHealth(math.min(maxhealth, 2000))
                local maxdamage = TUNING.SPIDER_DAMAGE + 1.2*level
                follower._olddamage = follower.components.combat.defaultdamage
                follower.components.combat.defaultdamage = math.random(TUNING.SPIDER_DAMAGE, maxdamage)
                local absorb = math.min(0.5, (0.1 + level/100))
                follower.components.health.absorb = absorb
                follower:DoTaskInTime(120, function()
                    follower.components.combat.defaultdamage = follower._olddamage or TUNING.SPIDER_DAMAGE
                    follower.components.health.maxhealth = follower._oldhealth or TUNING.SPIDER_HEALTH
                    follower.components.health.absorb = 0
                end)
                follower:ListenForEvent("attacked", function(follower, data) 
                    if follower.components.follower:GetLeader() == nil then
                        follower.components.combat.defaultdamage = TUNING.SPIDER_DAMAGE
                        follower.components.health.maxhealth = TUNING.SPIDER_HEALTH
                        follower.components.health.absorb = 0
                    end
                    if data.attacker ~= nil and data.attacker:HasTag("player")
                        and follower.components.follower:GetLeader() == data.attacker then
                        follower.components.health:Kill()
                    end
                end)
            end
        end
        if allachivcoin.mermstronger > 0 then
            if follower:HasTag("merm") then
                local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                local maxhealth = follower.components.health.maxhealth + 15*level
                follower.components.health:SetMaxHealth(math.min(maxhealth, 3000))
                local maxdamage = TUNING.MERM_DAMAGE + 2*level
                follower.components.combat.defaultdamage = math.random(TUNING.MERM_DAMAGE, maxdamage)
                local absorb = math.min(0.5, (0.1 + level/100))
                follower.components.health.absorb = absorb
                follower:DoTaskInTime(120, function()
                    follower.components.combat.defaultdamage = TUNING.MERM_DAMAGE
                    follower.components.health.maxhealth = TUNING.MERM_HEALTH
                    follower.components.health.absorb = 0
                end)
                follower:ListenForEvent("attacked", function(follower, data) 
                    if follower.components.follower:GetLeader() == nil then
                        follower.components.combat.defaultdamage = TUNING.MERM_DAMAGE
                        follower.components.health.maxhealth = TUNING.MERM_HEALTH
                        follower.components.health.absorb = 0
                    end
                    if data.attacker ~= nil and data.attacker:HasTag("player")
                        and follower.components.follower:GetLeader() == data.attacker then
                        follower.components.health:Kill()
                    end
                end)
            end
        end
        if allachivcoin.waxwellup > 0 then
            if follower.prefab == "shadowduelist" then
                local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                follower.components.health:SetMaxHealth(TUNING.SHADOWWAXWELL_LIFE + 200 + level*10)
                follower.components.health:StartRegen(TUNING.SHADOWWAXWELL_HEALTH_REGEN, TUNING.SHADOWWAXWELL_HEALTH_REGEN_PERIOD)
                follower.components.combat:SetDefaultDamage(TUNING.SHADOWWAXWELL_DAMAGE + 100 + level*2)
                follower.components.health.absorb = 0.5
            elseif follower:HasTag("shadowminion") then
                follower:AddTag("shadow")
                follower:DoTaskInTime(300, function() follower:RemoveTag("shadow") end)
            end
        end
        inst.components.leader:oldAddFollower(follower)
        follower:ListenForEvent("killed", function(follower, data)
            local player = follower.components.follower:GetLeader()
            if player ~= nil and (player._killedmonster == nil or player._killedmonster[data.victim] == nil) then
                player:PushEvent("killed", data)
            end
        end)
    end
    if self.abigaillevelup > 0 then
        self:aliveabigaillevelup(inst)
    end
    if self.abigailclone >0 then
        self:aliveabigailclone(inst)
    end
    if self.waxwellup > 0 then
        self:waxwellupalive(inst)
    end
    local followers = inst.components.leader.followers
    for k,v in pairs(followers) do
        if k.prefab == "abigail" then
            k:ListenForEvent("killed", function(k, data)
                local player = k.components.follower:GetLeader()
                if player ~= nil and (player._killedmonster == nil or player._killedmonster[data.victim] == nil) then
                    player:PushEvent("killed", data)
                end
            end)
        end
    end

    if inst.components.ghostlybond ~= nil then
        inst.components.ghostlybond.oldchangebehaviourfn = inst.components.ghostlybond.changebehaviourfn
        inst.components.ghostlybond.changebehaviourfn = function(inst, ghost)
            local res = inst.components.ghostlybond.oldchangebehaviourfn(inst, ghost)
            local allachivcoin = inst.components.allachivcoin
            if allachivcoin.abigaillevelup > 0 and allachivcoin.abigailcd <= 0 then
                local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                if ghost.is_defensive then
                    local x, y, z = ghost.Transform:GetWorldPosition()
                    SpawnPrefab("treat_fx").Transform:SetPosition(x, y, z)
                    ghost.components.health:DoDelta(50 + level)
                    local followers = inst.components.leader.followers
                    for k,v in pairs(followers) do
                        if k.prefab == "abigail_clone" then
                            local lx, ly, lz = k.Transform:GetWorldPosition()
                            SpawnPrefab("treat_fx").Transform:SetPosition(lx, ly, lz)
                            k.components.health:DoDelta(25 + level)
                        end
                    end
                    allachivcoin.abigailcd = 20
                else
                    local x, y, z = inst.Transform:GetWorldPosition()
                    SpawnPrefab("treat_fx").Transform:SetPosition(x, y, z)
                    inst.components.health:DoDelta(5)
                end
            end
            return res
        end
    end
end

function allachivcoin:abigailclonecoin(inst)
    if self.abigailclone < 1 and self.coinamount >= allachiv_coinuse["abigailclone"] then
        self.abigailclone = 1
        self.starsspent = self.starsspent + allachiv_coinuse["abigailclone"]
        self:coinDoDelta(-allachiv_coinuse["abigailclone"])
        self:ongetcoin(inst)
        self:aliveabigailclone(inst)
    end
end

function allachivcoin:aliveabigailclone(inst)
    local followers = inst.components.leader.followers
    for k,v in pairs(followers) do
        if k.prefab == "abigail" then
            k:AddComponent("clone")
        end
    end
end

function allachivcoin:bloodangrycoin(inst)
    if self.bloodangry < 1 and self.coinamount >= allachiv_coinuse["bloodangry"] then
        self.bloodangry = 1
        self.starsspent = self.starsspent + allachiv_coinuse["bloodangry"]
        self:coinDoDelta(-allachiv_coinuse["bloodangry"])
        self:ongetcoin(inst)
        self:bloodangrynow(inst)
    end
end

function allachivcoin:bloodangrynow(inst)
    local hp_percent = inst.components.health:GetPercent()
    if hp_percent > 0 then
        local bloodangry_damageup = (100-math.ceil(hp_percent*100))/100
        inst.components.combat.externaldamagemultipliers:SetModifier("bloodangry", 1 + bloodangry_damageup)
    end
end

function allachivcoin:bloodangryfn(inst)
    if self.bloodangry > 0 then
        self:bloodangrynow(inst)
    end
    inst:ListenForEvent("healthdelta", function(inst, data)
        if self.bloodangry > 0 then
            --local oldhealthpercent = math.max(0, math.min(data.oldpercent, 1))
            self:bloodangrynow(inst)
        end
    end)
    inst:ListenForEvent("death", function(inst)
        if self.bloodangry > 0 then
            inst.components.combat.externaldamagemultipliers:RemoveModifier("bloodangry")
        end
    end)
    inst:ListenForEvent("respawnfromghost", function(inst)
        if self.bloodangry > 0 then
            self:bloodangrynow(inst)
        end
    end)
end

function allachivcoin:hitattackcoin(inst)
    if self.hitattack < 1 and self.coinamount >= allachiv_coinuse["hitattack"] then
        self.hitattack = 1
        self.starsspent = self.starsspent + allachiv_coinuse["hitattack"]
        self:coinDoDelta(-allachiv_coinuse["hitattack"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:balloonlevelupcoin(inst)
    if self.balloonlevelup < 1 and self.coinamount >= allachiv_coinuse["balloonlevelup"] then
        self.balloonlevelup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["balloonlevelup"]
        self:coinDoDelta(-allachiv_coinuse["balloonlevelup"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:ballooninspirecoin(inst)
    if self.ballooninspire < 1 and self.coinamount >= allachiv_coinuse["ballooninspire"] then
        self.ballooninspire = 1
        self.starsspent = self.starsspent + allachiv_coinuse["ballooninspire"]
        self:coinDoDelta(-allachiv_coinuse["ballooninspire"])
        self:ongetcoin(inst)
    end
end


function allachivcoin:balloonfn(inst)
    if inst.prefab == "wes" then
        local balloonbrain = require("brains/balloonbrain")
        inst:ListenForEvent("makeballoon", function(inst, data)
            local balloon = data.balloon
            local balloonmaker = data.balloonmaker 
            local allachiv = inst.components.allachivcoin
            balloon._player = inst
            if allachiv.balloonlevelup > 0 then
                local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                local maxdamage = math.random(10, (50 + level*2))
                balloon.damage = maxdamage
                balloon.components.combat:SetDefaultDamage(maxdamage)
                balloon:SetBrain(balloonbrain)
                if math.random() < 0.05 and inst.components.leader:CountFollowers()<7 then
                    balloon.canbehuman = true
                    balloon.Transform:SetScale(1.5,1.5,1)
                end
                if math.random() < math.clamp(level*0.007, 0.25, 0.75) then
                    local angle = math.random()
                    inst:DoTaskInTime(.1, function()
                        local x,y,z = inst.Transform:GetWorldPosition() 
                        balloonmaker.components.balloonmaker:MakeBalloon(x + math.cos(angle), y, z - math.sin(angle))
                    end)
                end
            end 
        end)
    end

    --[[inst:DoPeriodicTask(0.5, function()
        if inst.prefab ~= "wes" then return end
        if self.balloonlevelup > 0 then
            if inst:HasTag("balloonomancer") then
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x,y,z, 30, nil,nil, {"balloon"})
                for k,v in pairs(ents) do
                    if v.prefab == "balloon" and not v:HasTag("hide") then
                        local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                        local maxdamage = math.random(10, (50 + level*2))
                        v.components.combat:SetDefaultDamage(maxdamage)
                        checkballboom(v)
                    end
                end
            end
        end
        if self.ballooninspire > 0 then
            if inst:HasTag("balloonomancer") then
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x,y,z, 25, nil,nil, {"balloon"})
                local balloonnum = 0
                if inst.lastballoonnum == nil then
                    inst.lastballoonnum = 0
                end
                for k,v in pairs(ents) do
                    if v.prefab == "balloon" then
                        balloonnum = math.min(balloonnum + 1, 10)
                    end
                end
                local currentDamageMult = 1 + 0.2*balloonnum 
                inst.components.combat.externaldamagemultipliers:SetModifier("ballooninspire", currentDamageMult)
            end
        end
    end)]]
end

function allachivcoin:wescheatfn(inst)
    --TheInput:AddKeyUpHandler(KEY_R, function() 
        --if inst.HUD.IsChatInputScreenOpen() then return end
        if self.wescheat > 0 then
            if self.wescheatcd > 0 or 
                inst:HasTag("playerghost") or 
                inst.components.freezable:IsFrozen() then 
                return 
            end
            inst:AddTag("shadow")
            inst.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
            if inst.components.talker then 
                --inst.components.talker:Say("Stealth !") 
            end
            inst.components.colourtweener:StartTween({0.3,0.3,0.3,1}, 0)
            local x, y, z = inst.Transform:GetWorldPosition()
            local ents = TheSim:FindEntities(x,y,z, 30, nil,nil, {"monster","animal","flying","crazy"})
            for k,v in pairs(ents) do
                if v.components.combat and v.components.combat.target == inst then
                    v.components.combat:SetTarget(nil)
                end
            end
            if inst.shadowtask ~= nil then inst.shadowtask:Cancel() end
            inst.shadowtask = inst:DoTaskInTime(5, function()
                inst:Show()
                inst:RemoveTag("shadow")
                inst.components.colourtweener:StartTween({1,1,1,1}, 0)
            end)
            self.wescheatcd = allachiv_coindata["wescheatcd"]
        end

        inst:ListenForEvent("onattackother", function(inst, data)
            if inst:HasTag("shadow") then
                inst:Show()
                inst:RemoveTag("shadow")
                inst.components.colourtweener:StartTween({1,1,1,1}, 0)
            end
        end)
    --end)
end

function allachivcoin:wescheatcoin(inst)
    if self.wescheat < 1 and self.coinamount >= allachiv_coinuse["wescheat"] then
        self.wescheat = 1
        self.starsspent = self.starsspent + allachiv_coinuse["wescheat"]
        self:coinDoDelta(-allachiv_coinuse["wescheat"])
        self:ongetcoin(inst)
    end
end

local function updatewebberspiderhat(inst, self)
    --temphealthup
    if self.callspider > 0 then
        local head = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if head and head.prefab == "spiderhat" then
            self.temphealthup = 200
            return
        end
    end
    if self.temphealthup > 0 then
        self.temphealthup = 0
    end
end

function allachivcoin:callspidercoin(inst)
    if self.callspider < 1 and self.coinamount >= allachiv_coinuse["callspider"] then
        self.callspider = 1
        self.starsspent = self.starsspent + allachiv_coinuse["callspider"]
        self:coinDoDelta(-allachiv_coinuse["callspider"])
        self:ongetcoin(inst)
        inst:AddComponent("clone")
        updatewebberspiderhat(inst, self)
    end
end

function allachivcoin:callspiderfn(inst)
    if self.callspider > 0 then
        inst:AddComponent("clone")
    end
    inst:ListenForEvent("equip", function(inst, data)
        local item = data.item
        if self.callspider > 0 and item and item.prefab == "spiderhat" then
            updatewebberspiderhat(inst, self)
        end
    end)
    inst:ListenForEvent("unequip", function(inst, data)
        local item = data.item
        if item and item.prefab == "spiderhat" then
            updatewebberspiderhat(inst, self)
        end
    end)
end

function allachivcoin:spiderstrongercoin(inst)
    if self.spiderstronger < 1 and self.coinamount >= allachiv_coinuse["spiderstronger"] then
        self.spiderstronger = 1
        self.starsspent = self.starsspent + allachiv_coinuse["spiderstronger"]
        self:coinDoDelta(-allachiv_coinuse["spiderstronger"])
        self:ongetcoin(inst)

    end
end


function allachivcoin:bernielevelupcoin(inst)
    if self.bernielevelup < 1 and self.coinamount >= allachiv_coinuse["bernielevelup"] then
        self.bernielevelup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["bernielevelup"]
        self:coinDoDelta(-allachiv_coinuse["bernielevelup"])
        self:ongetcoin(inst)
    end
end

local function addfirecircle(inst, r)
    if inst.components.aura == nil then
        inst:AddComponent("aura")
        inst.components.aura.radius = r or 3
        inst.components.aura.tickperiod = 2
        inst.components.aura.ignoreallies = true
        inst.components.aura.auraexcludetags = { "noauradamage", "INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost", "player", "abigail", "wall", "crazy" }
        inst.components.aura:Enable(true)

        inst._fire_fx = SpawnPrefab("fire_circle")
        inst._fire_fx.entity:SetParent(inst.entity)
        inst._fire_fx.Transform:SetPosition(0, 0, 0)
        if not inst:HasTag("player") then
            inst._fire_fx.Transform:SetScale(3,3,3)
        else
            inst._fire_fx.Transform:SetScale(2,2,2)
        end
    end
end

local function removefirecircle(inst)
    if inst.components.aura ~= nil then
        inst.components.aura:Enable(false)
        inst:RemoveComponent("aura")
    end
    if inst._fire_fx ~= nil then
        inst._fire_fx:Remove()
        inst._fire_fx = nil
    end
end

local function updatebernielevel(inst)
    local bigbernies = inst.bigbernies
    if bigbernies and next(bigbernies) ~= nil then
        local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
        for k,v in pairs(bigbernies) do
            if k and v then
                if inst.components.allachivcoin.linghtermore > 0 then
                    local current_hands = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    if current_hands and current_hands.prefab == "lighter" then
                        addfirecircle(k, 3)
                    else
                        removefirecircle(k)
                    end
                end
                if k.level ~= level then
                    k.components.combat:SetDefaultDamage(TUNING.BERNIE_BIG_DAMAGE + level * 0.5)
                    k.components.health:SetMaxHealth(TUNING.BERNIE_BIG_HEALTH + 500 + 10*level)
                    k.components.health:StartRegen(5 + 0.2*level, 1)
                    k.components.health.absorb = 0.6
                    k.level = level
                    break
                end
            end
        end
    end
end

function allachivcoin:bernielevelupfn(inst)
    inst:ListenForEvent("sanitydelta", function(inst,data)
        if self.bernielevelup > 0 then
            updatebernielevel(inst)
        end
    end)
end

function allachivcoin:linghtermorecoin(inst)
    if self.linghtermore < 1 and self.coinamount >= allachiv_coinuse["linghtermore"] then
        self.linghtermore = 1
        self.starsspent = self.starsspent + allachiv_coinuse["linghtermore"]
        self:coinDoDelta(-allachiv_coinuse["linghtermore"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:linghtermorefn(inst)
    inst:ListenForEvent("equip", function(inst, data)
        if self.linghtermore > 0 then
            if data.item and data.item.prefab == "lighter" and data.item.fires ~= nil then
                local lighter = data.item
                --[[lighter._fireflylight = SpawnPrefab("minerhatlight")
                lighter._fireflylight.Light:SetRadius(6)
                lighter._fireflylight.Light:SetFalloff(.8)
                lighter._fireflylight.Light:SetIntensity(.6)
                lighter._fireflylight.Light:SetColour(255/255,255/255,255/255)
                lighter._fireflylight.entity:SetParent(lighter.entity)]]
                lighter:RemoveComponent("fueled")
                addfirecircle(inst, 6)
                if self.bernielevelup > 0 then
                    updatebernielevel(inst, 3)
                end
            end
        end
    end)
    inst:ListenForEvent("unequip", function(inst, data)
        if self.linghtermore > 0 then
            if data.item and data.item.prefab == "lighter" then
                removefirecircle(inst)
                if self.bernielevelup > 0 then
                    updatebernielevel(inst)
                end
            end
        end
    end)
    if self.linghtermore > 0 then
        local current_hands = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if current_hands and current_hands.prefab == "lighter" then
            addfirecircle(inst, 3)
        end
    end
end

function allachivcoin:gearusecoin(inst)
    if self.gearuse < 1 and self.coinamount >= allachiv_coinuse["gearuse"] then
        self.gearuse = 1
        self.starsspent = self.starsspent + allachiv_coinuse["gearuse"]
        self:coinDoDelta(-allachiv_coinuse["gearuse"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:gearusefn(inst)
    local function onupdate(inst, dt)
        inst.charge_time = inst.charge_time - dt
        if inst.charge_time <= 0 then
            inst.charge_time = 0
            if inst.charged_task ~= nil then
                inst.charged_task:Cancel()
                inst.charged_task = nil
            end
            inst.SoundEmitter:KillSound("overcharge_sound")
            inst:RemoveTag("overcharge")
            inst.Light:Enable(false)
            inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED 
            inst.components.combat.damagemultiplier = inst.components.combat.damagemultiplier - 0.5
            inst.components.bloomer:PopBloom("overcharge")
            inst.components.temperature.mintemp = -20
            inst.components.talker:Say(GetString(inst, "ANNOUNCE_DISCHARGE"))
            inst.eat_charge = nil
        else
            local runspeed_bonus = .5
            local rad = 3
            if inst.charge_time < 60 then
                rad = math.max(.1, rad * (inst.charge_time / 60))
                runspeed_bonus = (inst.charge_time / 60)*runspeed_bonus
            end

            inst.Light:Enable(true)
            inst.Light:SetRadius(rad)
            --V2C: setting .runspeed does not stack with mount speed
            inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED*(1+runspeed_bonus)
            inst.components.temperature.mintemp = 10
        end
    end
    local function startovercharge(inst, duration)
        inst.charge_time = duration

        inst:AddTag("overcharge")
        inst:PushEvent("ms_overcharge")

        inst.SoundEmitter:KillSound("overcharge_sound")
        inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/charged", "overcharge_sound")
        inst.components.bloomer:PushBloom("overcharge", "shaders/anim.ksh", 50)

        if inst.charged_task == nil then
            inst.charged_task = inst:DoPeriodicTask(1, onupdate, nil, 1)
            onupdate(inst, 0)
        end
    end
    inst:ListenForEvent("oneat", function(inst, data)
        local food = data.food
        if self.gearuse > 0 then
            if food and food.components.edible and food.components.edible.foodtype == FOODTYPE.GEARS then
                inst.components.talker:Say(GetString(inst, "ANNOUNCE_CHARGE"))
                if inst.eat_charge ~= true then
                    inst.components.combat.damagemultiplier = inst.components.combat.damagemultiplier + 0.5
                    inst.eat_charge = true
                end
                startovercharge(inst, 600)
            end
        end
    end)
end

function allachivcoin:lightpowercoin(inst)
    if self.lightpower < 1 and self.coinamount >= allachiv_coinuse["lightpower"] then
        self.lightpower = 1
        self.starsspent = self.starsspent + allachiv_coinuse["lightpower"]
        self:coinDoDelta(-allachiv_coinuse["lightpower"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:lightpowerfn(inst)
    if inst.prefab == "wx78" then
        inst:ListenForEvent("moisturedelta", function(inst, data)
            local weapon = inst.components.combat:GetWeapon()
            if weapon == nil or weapon.prefab == "hambat" then return end 
            if weapon.components.weapon and weapon.components.weapon.projectile ~= "bishop_charge"
               and weapon.components.weapon.attackrange ~= nil then return end
            if weapon.components.finiteuses == nil then return end
            if self.lightpower > 0 then
                if inst.components.moisture.moisture>0 then
                    if weapon.components.weapon.projectile ~= nil then return end
                    local range, hit, per = 4, 5, 0.3
                    if inst.charge_time > 0 then
                        range, hit, per = 8, 10, 0.5
                    end
                    --weapon.components.weapon.olddmg = weapon.components.weapon.damage
                    --weapon.components.weapon.damage = weapon.components.weapon.damage * per
                    weapon.components.weapon:SetRange(range, hit)
                    weapon.components.weapon:SetProjectile("bishop_charge")
                else
                    --if weapon.components.weapon.olddmg ~= nil then
                        --weapon.components.weapon.damage = weapon.components.weapon.olddmg
                        weapon.components.weapon:SetRange(nil)
                        weapon.components.weapon:SetProjectile(nil)
                    --end
                end
            end
        end)
        inst:ListenForEvent("equip", function(inst, data)
            if self.lightpower > 0 then
                if inst.components.moisture:IsWet() then
                    local weapon = data.item
                    if weapon == nil or weapon.prefab == "hambat" then return end
                    if weapon.components.weapon and weapon.components.weapon.attackrange == nil then
                        local range, hit, per = 4, 5, 0.3
                        if inst.charge_time > 0 then
                            range, hit, per = 8, 10, 0.5
                        end
                        --weapon.components.weapon.olddmg = weapon.components.weapon.damage
                        --weapon.components.weapon.damage = weapon.components.weapon.damage * per
                        weapon.components.weapon:SetRange(range, hit)
                        weapon.components.weapon:SetProjectile("bishop_charge")
                    end
                end
            end
        end)
        inst:ListenForEvent("unequip", function(inst, data)
            if self.lightpower > 0 then
                local weapon = data.item
                if weapon and weapon.components.weapon then
                    --weapon.components.weapon.damage = weapon.components.weapon.olddmg
                    weapon.components.weapon:SetRange(nil)
                    weapon.components.weapon:SetProjectile(nil)
                end
            end
        end)
        inst:ListenForEvent("onhitother", function(inst, data)
            if self.lightpower > 0 then
                local weapon = data.weapon
                if weapon and weapon.components.weapon and weapon.components.weapon.projectile ~= nil then
                    inst.components.moisture:DoDelta(-2)
                end
            end
        end)
    end
end

function allachivcoin:callmermcoin(inst)
    if self.callmerm < 1 and self.coinamount >= allachiv_coinuse["callmerm"] then
        self.callmerm = 1
        self.starsspent = self.starsspent + allachiv_coinuse["callmerm"]
        self:coinDoDelta(-allachiv_coinuse["callmerm"])
        self:ongetcoin(inst)
        inst:AddComponent("clone")
    end
end

function allachivcoin:callmermfn(inst)
    if self.callmerm > 0 then
        inst:AddComponent("clone")
    end
end

function allachivcoin:mermstrongercoin(inst)
    if self.mermstronger < 1 and self.coinamount >= allachiv_coinuse["mermstronger"] then
        self.mermstronger = 1
        self.starsspent = self.starsspent + allachiv_coinuse["mermstronger"]
        self:coinDoDelta(-allachiv_coinuse["mermstronger"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:soulmorecoin(inst)
    if self.soulmore < 1 and self.coinamount >= allachiv_coinuse["soulmore"] then
        self.soulmore = 1
        self.starsspent = self.starsspent + allachiv_coinuse["soulmore"]
        self:coinDoDelta(-allachiv_coinuse["soulmore"])
        self:ongetcoin(inst)
    end
end

local function ClearRecentlyCharged(inst, other)
    inst.recentlycharged[other] = nil
end

local function OnDestroyOther(inst, other)
    if inst.recentlycharged == nil then inst.recentlycharged = {} end
    if other:HasTag("structure") or other:HasTag("wall") then return end
    if other:IsValid() and
        other.components.workable ~= nil and
        other.components.workable:CanBeWorked() and
        other.components.workable.action ~= ACTIONS.NET and
        not inst.recentlycharged[other] then
        SpawnPrefab("collapse_small").Transform:SetPosition(other.Transform:GetWorldPosition())
        if other.components.lootdropper ~= nil and (other:HasTag("tree") or other:HasTag("boulder")) then
            --other.components.lootdropper:SetLoot({})
        end
        other.components.workable:Destroy(inst)
        if other:IsValid() and other.components.workable ~= nil and other.components.workable:CanBeWorked() then
            inst.recentlycharged[other] = true
            inst:DoTaskInTime(3, ClearRecentlyCharged, other)
        end
    end
end

function allachivcoin:soulmorefn(inst)
    inst:ListenForEvent("soulhop", function(inst) --灵魂跳跃
        local function GetStackSize(item)
            return item.components.stackable ~= nil and item.components.stackable:StackSize() or 1
        end
        local function IsSoul(item)
            return item.prefab == "wortox_soul"
        end
        if self.soulmore > 0 then
            local souls = inst.components.inventory:FindItems(IsSoul)
            local count = 0
            for i, v in ipairs(souls) do
                count = count + GetStackSize(v)
            end

            local x, y, z = inst.Transform:GetWorldPosition()
            local ents = TheSim:FindEntities(x,y,z, 5, nil,{ "INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost", "player", "abigail", "wall"})
            for k,v in pairs(ents) do
                OnDestroyOther(inst, v)
            end
            local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
            local item = SpawnPrefab("balloon")
            item:ListenForEvent("killed", function(item, data) 
                if (inst._killedmonster == nil or inst._killedmonster[data.victim] == nil) then
                    inst:PushEvent("killed", data)
                end
            end)
            item:AddTag("hide")
            if inst.components.sanity:IsCrazy() then item:AddTag("crazy") end
            item.Transform:SetPosition(x,y,z)
            local power = inst.components.levelsystem and inst.components.levelsystem.power or 10
            item.components.combat:SetDefaultDamage((power + math.random(2*level, 4*level))*(1+count*0.02))
            item.components.combat:DoAreaAttack(inst, 6, nil, nil, nil, { "INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost", "player", "abigail", "wall"})
            SpawnPrefab("groundpoundring_fx").Transform:SetPosition(x,y,z)
            item:Remove()

            if math.random() < 0.5 then
                if count < TUNING.WORTOX_MAX_SOULS*0.5 then
                    local soul = SpawnPrefab("wortox_soul")
                    inst.components.inventory:GiveItem(soul)
                end
            end
        end
    end)
end

function allachivcoin:strongeraoecoin(inst)
    if self.strongeraoe < 1 and self.coinamount >= allachiv_coinuse["strongeraoe"] then
        self.strongeraoe = 1
        self.starsspent = self.starsspent + allachiv_coinuse["strongeraoe"]
        self:coinDoDelta(-allachiv_coinuse["strongeraoe"])
        self:ongetcoin(inst)
        self.aoestatus = 1
        inst.components.combat:EnableAreaDamage(true)
        inst.components.combat:SetAreaDamage(3, 0.6)
    end
end

function allachivcoin:strongeraoefn(inst)
    if self.strongeraoe > 0 and self.aoestatus == 1 then
        inst.components.combat:EnableAreaDamage(true)
        inst.components.combat:SetAreaDamage(3, 0.6)
    end
end

function allachivcoin:waxwellupcoin(inst)
    if self.waxwellup < 1 and self.coinamount >= allachiv_coinuse["waxwellup"] then
        self.waxwellup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["waxwellup"]
        self:coinDoDelta(-allachiv_coinuse["waxwellup"])
        self:ongetcoin(inst)
        self:waxwellupalive(inst)
    end
end

function allachivcoin:waxwellupalive(inst)
    local followers = inst.components.leader.followers
    for k,v in pairs(followers) do
        if k.prefab == "shadowduelist" then
            local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
            k.components.health:SetMaxHealth(TUNING.SHADOWWAXWELL_LIFE + 200 + level*10)
            k.components.health:StartRegen(TUNING.SHADOWWAXWELL_HEALTH_REGEN, TUNING.SHADOWWAXWELL_HEALTH_REGEN_PERIOD)
            k.components.combat:SetDefaultDamage(TUNING.SHADOWWAXWELL_DAMAGE + 100 + level*2)
            k.components.health.absorb = 0.5

            k:ListenForEvent("killed", function(k, data)
                local player = k.components.follower:GetLeader()
                if player ~= nil and (player._killedmonster == nil or player._killedmonster[data.victim] == nil) then
                    player:PushEvent("killed", data)
                end
            end)
        elseif k:HasTag("shadowminion") then
            if k.components.health then
                k.components.health.absorb = 1
            end
        end
    end
end

function allachivcoin:winnonaupcoin(inst)
    if self.winnonaup < 1 and self.coinamount >= allachiv_coinuse["winnonaup"] then
        self.winnonaup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["winnonaup"]
        self:coinDoDelta(-allachiv_coinuse["winnonaup"])
        self:ongetcoin(inst)
    end
end


local function CheckSpawnedLoot(loot)
    if loot.components.inventoryitem ~= nil then
        loot.components.inventoryitem:TryToSink()
    else
        local lootx, looty, lootz = loot.Transform:GetWorldPosition()
        if ShouldEntitySink(loot, true) or TheWorld.Map:IsPointNearHole(Vector3(lootx, 0, lootz)) then
            SinkEntity(loot)
        end
    end
end

local function SpawnLootPrefab(inst, lootprefab)
    if lootprefab == nil then
        return
    end

    local loot = SpawnPrefab(lootprefab)
    if loot == nil then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()

    if loot.Physics ~= nil then
        local angle = math.random() * 2 * PI
        loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))

        if inst.Physics ~= nil then
            local len = loot:GetPhysicsRadius(0) + inst:GetPhysicsRadius(0)
            x = x + math.cos(angle) * len
            z = z + math.sin(angle) * len
        end

        loot:DoTaskInTime(1, CheckSpawnedLoot)
    end

    loot.Transform:SetPosition(x, y, z)

    loot:PushEvent("on_loot_dropped", {dropper = inst})

    return loot
end

local NO_TAGS_PVP = { "INLIMBO", "ghost", "playerghost", "FX", "NOCLICK", "DECOR", "notarget", "companion", "shadowminion" }
local NO_TAGS = { "player" }
local COMBAT_TAGS = { "_combat" }
local function becomeweapon(inst, player)
        for i, v in ipairs(NO_TAGS_PVP) do
            table.insert(NO_TAGS, v)
        end
    --inst:DoTaskInTime(0, function() 
        local level = player.components.levelsystem and player.components.levelsystem.level or 0
        inst:AddTag("weapon")
        inst:AddTag("projectile")

        if not TheWorld.ismastersim then
            print("------client side-----")
            inst:ReplicateComponent("equippable")
            return
        end

        if inst.components.weapon == nil then
            inst:AddComponent("weapon")
        end
        local damage = throwable[inst.prefab] or 25
        inst.components.weapon:SetDamage(damage + level*.25)
        local range = math.ceil(7 + damage*0.04)
        inst.components.weapon:SetRange(range, range+2)

        if inst.components.projectile == nil then
            inst:AddComponent("projectile")
        end
        inst.components.projectile:SetSpeed(60)
        inst.components.projectile:SetOnHitFn(function(inst, attacker, target)
            local impactfx = SpawnPrefab("impact")
            if impactfx ~= nil then
                local follower = impactfx.entity:AddFollower()
                follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0)
                if attacker ~= nil then
                    impactfx:FacePoint(attacker.Transform:GetWorldPosition())
                end
            end
            if inst.prefab == "redgem" then
                if target~=nil and target.components.burnable then
                    target.components.burnable:Ignite()
                end
            end
            if inst.prefab == "bluegem" then
                if target~=nil and target.components.freezable then
                    target.components.freezable:AddColdness(2, 2)
                end
            end
            --inst:Remove()
            local recipe = AllRecipes[inst.prefab]
            if recipe ~= nil then
                for i, v in ipairs(recipe.ingredients) do
                    local amt = math.max(1, math.ceil(v.amount*0.5))
                    for n = 1, amt do
                        SpawnLootPrefab(inst, v.type)
                    end
                end
                --hit aoe
                local x, y, z = inst.Transform:GetWorldPosition()
                for i, v in ipairs(TheSim:FindEntities(x, y, z, 4, COMBAT_TAGS, TheNet:GetPVPEnabled() and NO_TAGS_PVP or NO_TAGS)) do
                    if v:IsValid() and v.entity:IsVisible() then
                        if attacker ~= nil and attacker.components.combat:CanTarget(v) then
                            --if target is not targeting a player, then use the catapult as attacker to draw aggro
                            --attacker.components.combat:DoAttack(v)
                            v.components.combat:GetAttacked(attacker, damage + level*.25)
                        end
                    end
                end

                inst:Remove()
                return
            else
                --if math.random() < 0.8 then
                    inst:Remove()
                    return
                --end
                --inst:RemoveTag("weapon")
                --inst:RemoveTag("projectile")
                --inst:RemoveComponent("weapon")
                --inst:RemoveComponent("projectile")
                --inst:RemoveTag("NOCLICK")
            end
            
            inst._attack = nil
        end)

        if inst.components.equippable == nil then
            inst:AddComponent("equippable")
        end
        inst.components.equippable:SetOnEquip(function(inst, owner)

        end)
        inst.components.equippable:SetOnUnequip(function(inst, owner)

        end)
        inst.components.equippable.equipstack = true

        inst.components.projectile:SetOnThrownFn(function(inst)
            --inst.AnimState:PlayAnimation("dart_pipe")
            inst:AddTag("NOCLICK")
            inst.persists = false
            inst._attack = true
        end)

        inst:PushEvent("becomeweapon", {owner=player})
    --end)
end

local function becomecommon(inst, player)
    inst:DoTaskInTime(0.1, function(inst)
        if not player.sg:HasStateTag("attack") and not inst:HasTag("NOCLICK") then
            inst:RemoveTag("weapon")
            inst:RemoveTag("projectile")
            inst:RemoveComponent("weapon")
            inst:RemoveComponent("projectile")
        end
    end)
    
    --inst:RemoveComponent("equippable")
end

local function stackablefix(inst, player)
    if inst.components.stackable.oldget then return end
    inst.components.stackable.oldget = inst.components.stackable.Get
    function inst.components.stackable:Get(num)
        local instance = inst.components.stackable:oldget(num)
        if inst:HasTag("weapon") and not instance:HasTag("weapon") then
            becomeweapon(instance, player)
            stackablefix(instance, player)
        end
        return instance
    end
end

local function updateinventoryrocks(player)
    local throwrock = player.components.allachivcoin.throwrock or 0
    for k,v in pairs(player.components.inventory.itemslots) do
        if v and throwable[v.prefab] then
            if throwrock > 0 then
                becomeweapon(v, player)
                stackablefix(v, player)
            else
                becomecommon(v, player)
            end
        end
    end
    for k,v in pairs(player.components.inventory.equipslots) do
        if v and throwable[v.prefab] then
            if throwrock > 0 then
                becomeweapon(v, player)
                stackablefix(v, player)
            else
                becomecommon(v, player)
            end
        end
    end
    for k,v in pairs(player.components.inventory.opencontainers) do
        if k and k:HasTag("backpack") and k.components.container then
            for i,j in pairs(k.components.container.slots) do
                if j and throwable[j.prefab] then
                    if throwrock > 0 then
                        becomeweapon(j, player)
                        stackablefix(j, player)
                    else
                        becomecommon(j, player)
                    end
                end
            end
        end
    end
end

local function becomecommonincontainer(item, player)
    for i,j in pairs(item.components.container.slots) do
        if j and throwable[j.prefab] then
            becomecommon(j, player)
        end
    end
end

local function becomeweaponincontainer(item, player)
    for i,j in pairs(item.components.container.slots) do
        if j and throwable[j.prefab] then
            becomeweapon(j, player)
            stackablefix(j, player)
        end
    end
end

function allachivcoin:throwrockcoin(inst)
    if self.throwrock < 1 and self.coinamount >= allachiv_coinuse["throwrock"] then
        self.throwrock = 1
        self.starsspent = self.starsspent + allachiv_coinuse["throwrock"]
        self:coinDoDelta(-allachiv_coinuse["throwrock"])
        self:ongetcoin(inst)
        updateinventoryrocks(inst)
        inst:AddTag("throwrock")
    end
end

function allachivcoin:winnonaupfn(inst)
    if inst.prefab == "winona" then
        inst:ListenForEvent("buildstructure", function(inst,data)
            if self.winnonaup > 0 then
                --print(data.item)
                local item = data.item
                local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                if item.prefab == "winona_catapult" then
                    item.components.health:SetMaxHealth(TUNING.WINONA_CATAPULT_HEALTH*2 + level*5)
                    item.components.combat:SetDefaultDamage(TUNING.WINONA_CATAPULT_DAMAGE*2 + level*2)
                    --item.components.combat:SetRange(TUNING.WINONA_CATAPULT_MAX_RANGE + 4)
                    --item.components.combat:SetAttackPeriod(1)
                    item.level = level
                end
            end
        end)
        inst:ListenForEvent("deployitem", function(inst, data) 
            if self.winnonaup > 0 then
                if data.prefab == "eyeturret_item" then
                    local item = c_find("eyeturret", 2, inst)
                    if item == nil then return end
                    local level = inst.components.levelsystem and inst.components.levelsystem.level or 0
                    item.components.health:SetMaxHealth(TUNING.EYETURRET_HEALTH*1.5 + level*5)
                    item.components.combat:SetDefaultDamage(TUNING.EYETURRET_DAMAGE*1.5 + level*0.5)
                    item.level = level
                end
            end
        end)

        inst:ListenForEvent("builditem", function(inst, data)
            local item = data.item
            if self.throwrock > 0 then
                if throwable[item.prefab] then
                    becomeweapon(item, inst)
                    stackablefix(item, inst)
                end
            end
        end)

        inst:ListenForEvent("onpickupitem", function(inst, data)
            local item = data.item
            if self.throwrock > 0 then
                if item and throwable[item.prefab] then
                    becomeweapon(item, inst)
                    stackablefix(item, inst)
                end
                if item and item:HasTag("backpack") and item.components.container then
                    becomeweaponincontainer(item, inst)
                end 
            end
        end)

        inst:ListenForEvent("dropitem", function(inst, data)
            local item = data.item
            if item and throwable[item.prefab] then
                becomecommon(item, inst)
            end
            if item and item:HasTag("backpack") and item.components.container then
                becomecommonincontainer(item, inst)
            end
        end)

        --[[inst:ListenForEvent("onattackother", function(inst, data)
            local weapon = data.weapon
            if weapon and throwable[weapon.prefab] then
                inst._attack = true
            end
        end)]]
        
        if self.throwrock > 0 then
            updateinventoryrocks(inst)
            inst:AddTag("throwrock")
        end
        --[[local oldactions = {}
        for k, v in pairs(ACTIONS) do
            oldactions[k] = v
            if v.fn then
                local oldfn = v.fn
                v.fn = function(...)
                    print("actions "..k.." did")
                    return oldfn(...)
                end
            end
        end]]
    end
end

local function randomdamage(weapon, inst)
    if weapon._randomtask ~= nil then
        weapon._randomtask:Cancel()
        weapon._randomtask = nil
    end
    weapon._randomtask = weapon:DoPeriodicTask(0.1, function() 
        local level = inst.components.levelsystem and inst.components.levelsystem.level or 1
        local damage = math.random() * math.random(100 + level*2)
        weapon.components.weapon:SetDamage(damage)
    end)
end

local function updatelucynow(inst, self)
    
    local current_hands = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if current_hands and current_hands.prefab == "lucy" then
        if self.woodieup > 0 then
            randomdamage(current_hands, inst)
        else
            if current_hands._randomtask ~= nil then
                current_hands._randomtask:Cancel()
                current_hands._randomtask = nil
            end
            current_hands.components.weapon:SetDamage(TUNING.AXE_DAMAGE * .5)
        end
    end
end

function allachivcoin:woodieupcoin(inst)
    if self.woodieup < 1 and self.coinamount >= allachiv_coinuse["woodieup"] then
        self.woodieup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["woodieup"]
        self:coinDoDelta(-allachiv_coinuse["woodieup"])
        self:ongetcoin(inst)
        updatelucynow(inst, self)
    end
end

function allachivcoin:woodieupfn(inst)
    if inst.prefab == "woodie" then
        inst:ListenForEvent("equip", function(inst, data)
            if self.woodieup > 0 then
                local weapon = data.item
                if weapon and weapon.prefab == "lucy" then
                    randomdamage(weapon, inst)
                end
            end
        end)
        inst:ListenForEvent("unequip", function(inst, data)
            if self.woodieup > 0 then
                local weapon = data.item
                if weapon and weapon.prefab == "lucy" then
                    if weapon._randomtask ~= nil then
                        weapon._randomtask:Cancel()
                        weapon._randomtask = nil
                    end
                    weapon.components.weapon:SetDamage(TUNING.AXE_DAMAGE * .5)
                end
            end
        end)
        if self.woodieup > 0 then
            updatelucynow(inst, self)
        end
    end
end

function allachivcoin:warlyupcoin(inst)
    if self.warlyup < 1 and self.coinamount >= allachiv_coinuse["warlyup"] then
        self.warlyup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["warlyup"]
        self:coinDoDelta(-allachiv_coinuse["warlyup"])
        self:ongetcoin(inst)
        --inst:AddTag("canflash")
    end
end

function allachivcoin:memorykillcoin(inst)
    if self.memorykill < 1 and self.coinamount >= allachiv_coinuse["memorykill"] then
        self.memorykill = 1
        self.starsspent = self.starsspent + allachiv_coinuse["memorykill"]
        self:coinDoDelta(-allachiv_coinuse["memorykill"])
        self:ongetcoin(inst)
    end
end

local function changeposition(inst, target)
    local x,y,z = target.Transform:GetWorldPosition()
    if TheWorld.Map:IsOceanTileAtPoint(x, y, z) or not TheWorld.Map:IsValidTileAtPoint(x, y, z) then
        return
    end
    local radius = 2*math.random()+0.5
    local angle = math.random()*2*PI
    local pt = Point(radius*math.cos(angle)+x, y, radius*math.sin(angle)+z)
    local tms = 0
    while(not TheWorld.Map:IsPassableAtPoint(pt:Get())) do
        angle = math.random()*2*PI
        pt = Point(radius*math.cos(angle)+x, y, radius*math.sin(angle)+z)
        tms = tms + 1
        if tms > 20 then
            return
        end    
    end
    inst.Transform:SetPosition(pt:Get())
    inst._canflash = false
end

local function debufftarget(inst, target, damage)
    if target == nil or target.components.health == nil or (not target:IsValid()) or
        target.components.combat == nil then 
            if target._bloodtask ~= nil then
                target._bloodtask:Cancel()
                target._bloodtask = nil
            end
            return end
    if target._bloodtask == nil then
        target._bloodtasktime = 10
        target._bloodtaskdamage = damage*0.05
        target._bloodtask = target:DoPeriodicTask(1, function(target) 
            if target.components.combat and inst ~= nil and inst.components.combat
                and not target.components.health:IsDead() then
                target.components.combat:GetAttacked(inst, target._bloodtaskdamage, nil, "blood")
            end
            target._bloodtasktime = target._bloodtasktime -1
            if target._bloodtasktime <= 0 or (not target:IsValid()) or target.components.health:IsDead() then
                target._bloodtask:Cancel()
                target._bloodtask = nil
            end
        end)
    else
        target._bloodtasktime = 10
        target._bloodtaskdamage = damage*0.05
    end
end

function allachivcoin:warlyupfn(inst)
    if inst.prefab == "warly" then
        if self.warlyup > 0 then
            --inst.components.combat.ignorehitrange = true
            --inst:AddTag("canflash")
        end
        --[[inst.components.playercontroller.OldGetAttackTarget = inst.components.playercontroller.GetAttackTarget
        function inst.components.playercontroller:GetAttackTarget(force_attack, force_target, isretarget)
            local achiv = inst.components.allachivcoin
            local target = inst.components.playercontroller:OldGetAttackTarget(force_attack, force_target, isretarget)
            if target ~=nil and achiv.warlyup > 0 then
                if not TheWorld.Map:IsPassableAtPoint(target.Transform:GetWorldPosition()) then
                    if inst._rangetask ~= nil and inst.components.combat.attackrange > 2 then
                        inst._rangetask:Cancel()
                        inst._rangetask = nil
                    end
                    inst.components.combat.ignorehitrange=false
                    inst._rangetask = inst:DoTaskInTime(1, function()
                        inst.components.combat.ignorehitrange=true
                    end)
                else
                    inst.components.combat:SetRange(10, 12)
                    inst._canflash = true
                end
            end
            return target
        end]]

        inst:ListenForEvent("onattackother", function(inst, data)
            local target = data.target
            local achiv = inst.components.allachivcoin
            if target and not target:HasTag("wall") and achiv.warlyup > 0 then
                local name = target.prefab
                local memorykilldamage = achiv.memorykilldata[name] or 0
                local level = inst.components.levelsystem.level or 1
                debufftarget(inst, target, memorykilldamage+level)
            end
        end)

        inst:ListenForEvent("onhitother", function(inst, data)
            local target = data.target
            local damage = data.damage
            local achiv = inst.components.allachivcoin
            if target and not target:HasTag("wall") then
                if achiv.warlyup > 0 and damage > 0.5 and data.stimuli ~= "blood" then
                    --inst.components.combat:SetRange(2)
                    --changeposition(inst, target)
                    if target.prefab == "beefalo" and achiv.attackcheck ~= true then
                        achiv.attackcheck = true
                        target.components.combat:GetAttacked(inst, 9999)
                        inst:DoTaskInTime(0.2, function() achiv.attackcheck=false end)
                    else
                        
                    end
                end
                
                if achiv.memorykill > 0 then
                    local name = target.prefab
                    local memorykilldamage = achiv.memorykilldata[name] or 0
                    if achiv.attackcheck ~= true and memorykilldamage > 0 then
                        achiv.attackcheck = true
                        target.components.combat:GetAttacked(inst, memorykilldamage)
                        inst:DoTaskInTime(0.2, function() achiv.attackcheck=false end)
                    end
                end
            end
        end)

        inst:ListenForEvent("killed", function(inst, data)
            if self.memorykill > 0 then
                local victim = data.victim
                if not victim:HasTag("invisible") and not victim:HasTag("INLIMBO") then
                    local hp = victim.components.health and victim.components.health.maxhealth or 0
                    local name = victim.prefab
                    if self.memorykilldata[name] == nil then
                        self.memorykilldata[name] = 0
                    end
                    self.memorykilldata[name] = self.memorykilldata[name] + 1 + math.floor(hp*0.0002)
                    if self.memorykilldata[name] > hp*100 then
                        self.memorykilldata[name] = hp*100
                    end
                end
            end
        end)
    end
end

local function OnSeasonChange(inst, season) 
    local allachivcoin = inst.components.allachivcoin
    if allachivcoin.wormwoodup > 0 then
        if season == "spring" then
            inst.components.health:StartRegen(5, 2)
        else
            inst.components.health:StopRegen()
        end
        if season == "autumn" or season == "summer" then
            local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("seasondamageup")
            if currentDamageMult ~= 1.8 then
                inst.components.combat.externaldamagemultipliers:SetModifier("seasondamageup", 1.8)
            end
        else
            inst.components.combat.externaldamagemultipliers:RemoveModifier("seasondamageup")
        end
        if season == "winter" then
            inst.components.locomotor:SetExternalSpeedMultiplier(inst,"seasonspeedup", 1.25)
        else
            inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "seasonspeedup")
        end
    end
end

function allachivcoin:wormwoodupcoin(inst)
    if self.wormwoodup < 1 and self.coinamount >= allachiv_coinuse["wormwoodup"] then
        self.wormwoodup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["wormwoodup"]
        self:coinDoDelta(-allachiv_coinuse["wormwoodup"])
        self:ongetcoin(inst)
        OnSeasonChange(inst, TheWorld.state.season) 
    end
end

function allachivcoin:wormwoodupfn(inst)
    if inst.prefab == "wormwood" then
        local currentDamageMult = 1
        inst.components.combat.externaldamagemultipliers:SetModifier("seasondamageup", currentDamageMult)

        inst:WatchWorldState("season", OnSeasonChange)
        inst:ListenForEvent("moisturedelta", function(inst, data) 
            local allachivcoin = inst.components.allachivcoin
            if data.new>10 and data.new<81 and allachivcoin.wormwoodup > 0 then
                if inst.moisture_regen_task == nil then
                    inst.moisture_regen_task = inst:DoPeriodicTask(5, function()
                        inst.components.hunger:DoDelta(1)
                        inst.components.health:DoDelta(1)
                        inst.components.sanity:DoDelta(1)
                    end)
                end
            else
                if inst.moisture_regen_task ~= nil then
                    inst.moisture_regen_task:Cancel()
                    inst.moisture_regen_task = nil
                end
            end
        end)
        OnSeasonChange(inst, TheWorld.state.season) 
    end
end

function allachivcoin:wickerbottomupcoin(inst)
    if self.wickerbottomup < 1 and self.coinamount >= allachiv_coinuse["wickerbottomup"] then
        self.wickerbottomup = 1
        self.starsspent = self.starsspent + allachiv_coinuse["wickerbottomup"]
        self:coinDoDelta(-allachiv_coinuse["wickerbottomup"])
        self:ongetcoin(inst)
        inst:AddTag("achivbookbuilder")
    end
end

function allachivcoin:wickerbottomupfn(inst)
    if self.wickerbottomup > 0 and not inst:HasTag("achivbookbuilder") then
        inst:AddTag("achivbookbuilder")
    end
end

function allachivcoin:potioncoin(inst)
    if self.potion < 1 and self.coinamount >= allachiv_coinuse["potion"] then
        self.potion = 1
        self.starsspent = self.starsspent + allachiv_coinuse["potion"]
        self:coinDoDelta(-allachiv_coinuse["potion"])
        self:ongetcoin(inst)
        inst:AddTag("potionbuilder")
    end
end

function allachivcoin:potionfn(inst)
    if self.potion > 0 and not inst:HasTag("potionbuilder") then
        inst:AddTag("potionbuilder")
    end
end

function allachivcoin:quickshotcoin(inst)
    if self.quickshot < 1 and self.coinamount >= allachiv_coinuse["quickshot"] then
        self.quickshot = 1
        self.starsspent = self.starsspent + allachiv_coinuse["quickshot"]
        self:coinDoDelta(-allachiv_coinuse["quickshot"])
        self:ongetcoin(inst)
        inst:AddTag("quickshot")
    end
end

function allachivcoin:quickshotfn(inst)
    if self.quickshot > 0 and not inst:HasTag("quickshot") then
        inst:AddTag("quickshot")
    end
end

function allachivcoin:callbackcoin(inst)
    if self.callback < 1 and self.coinamount >= allachiv_coinuse["callback"] then
        self.callback = 1
        self.starsspent = self.starsspent + allachiv_coinuse["callback"]
        self:coinDoDelta(-allachiv_coinuse["callback"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:callbackfn(inst, data)
    if self.callback > 0 then
        if self.callbackcd > 0 or 
            inst:HasTag("playerghost") or 
            inst.components.freezable:IsFrozen() then 
            return 
        end
        --print("Selected "..tostring(item or "<nil>") )
        local success = false
        local item = data
        local x,y,z = inst.Transform:GetWorldPosition()
        if item ~= nil and item.components and item.components.combat then
            if item.components.follower then
                if inst == item.components.follower:GetLeader() then
                    item.Transform:SetPosition(x,y,z)
                    if item.components.combat then
                        item.components.combat:SetTarget(nil)
                    end
                    success = true
                end
            end
            if inst.prefab == "willow" and item.prefab == "bernie_big" then
                item.components.combat:SetTarget(nil)
                item.Transform:SetPosition(x,y,z)
                success = true
            end
            if item == inst and inst.components.leader then
                local followers = inst.components.leader.followers
                for k,v in pairs(followers) do
                    if k.components.combat then
                       k.Transform:SetPosition(x,y,z)
                        k.components.combat:SetTarget(nil)
                        success = true 
                    end
                end
            end
        end
        if success then
            inst.SoundEmitter:PlaySound("dontstarve/common/staff_blink")
            self.callbackcd = allachiv_coindata["callbackcd"]
            return
        else
            self.callbackcd = 1
            if inst.components.talker then 
                inst.components.talker:Say(STRINGS.TALKER_CALLBACK_FAILED) 
            end
        end
    end
end

--成就商店
--买活
function allachivcoin:respawnfromghostfn(inst)
    local function IsDied(player)
        if player and player:HasTag("player") and player:HasTag("playerghost") then
            return true
        end
    end
    if TheWorld.ismastersim and inst and inst:IsValid() and IsDied(inst) then
        --判断免费cd
        if self.resurrectcd <= 0 then
            ExecuteConsoleCommand('local player = UserToPlayer("'..inst.userid..'") player:PushEvent("respawnfromghost")')
            inst.rezsource = STRINGS.ALLACHIVCURRENCY[27]
            self.resurrectcd = allachiv_coindata["resurrectcd"] + self.freetimes*5 --每使用一次免费，cd延长5秒
            local titles = inst.components.titlesystem and inst.components.titlesystem.titles or {}
            if titles[13] == 1 then
                self.resurrectcd = math.ceil(self.resurrectcd * (1-title_data["title13"]["resurrect"]))
            end
            self.freetimes = self.freetimes + 1
            return
        end

        if self.coinamount < allachiv_coinuse["respawnfromghost"] 
            or self.respawnfromghost >= allachiv_coindata_max["respawnfromghost"] then return end
    
        self.respawnfromghost = self.respawnfromghost + 1
        self:coinDoDelta(-allachiv_coinuse["respawnfromghost"])
        ExecuteConsoleCommand('local player = UserToPlayer("'..inst.userid..'") player:PushEvent("respawnfromghost")')
        inst.rezsource = STRINGS.ALLACHIVCURRENCY[21]
    end
end

function allachivcoin:getprefabs(inst, prefabname)
    if prefabname == "respawnfromghost" then
        self:respawnfromghostfn(inst)
        return
    end
    if prefabname == "resettempachiv" then
        if self.coinamount >= allachiv_coinuse["resettempachiv"] 
        and inst.components.allachivevent
        and self.resettempachiv < allachiv_coindata_max["resettempachiv"] then
            inst.components.allachivevent:resetTemp(inst)
            self.resettempachiv = self.resettempachiv + 1
            self:coinDoDelta(-allachiv_coinuse[prefabname])
        end
        return
    end
    if prefabname == "package_ball" then
        if self.coinamount >= allachiv_coinuse["package_ball"] 
            and self.package_ball < allachiv_coindata_max["package_ball"] then
            local tb = {"tumbleweedspawner", "oasislake", "pond_cave", "pond", "cavelight",
                "ancient_altar", "pigking", "pigtorch", "lava_pond", "moonbase", "catcoonden"}
            local package_ball = SpawnPrefab("package_ball")
            local target = SpawnPrefab(tb[math.random(#tb)])
            package_ball.components.packer:Pack(target)
            inst.components.inventory:GiveItem(package_ball)
            self.package_ball = self.package_ball + 1
            self:coinDoDelta(-allachiv_coinuse["package_ball"])
        end
        return
    end
    if prefabname == "potion_achiv" then
        if self.coinamount >= allachiv_coinuse["potion_achiv"] then
            local item = SpawnPrefab(prefabname)
            item._userid = inst.userid
            item._owner = inst:GetDisplayName()
            item.minachiv = 1
            item.maxachiv = 10
            inst.components.inventory:GiveItem(item)
            self.potion_achiv = self.potion_achiv + 1
            self:coinDoDelta(-allachiv_coinuse["potion_achiv"])
        end
        return
    end
    if prefabname == "recycle" then
        local function GetStackSize(item)
            return item.components.stackable ~= nil and item.components.stackable:StackSize() or 1
        end
        if self.coinamount >= allachiv_coinuse["recycle"] then
            local backnum = 0
            --物品栏
            for k,v in pairs(inst.components.inventory.itemslots) do
                if v and not v:HasTag("irreplaceable") then
                    local num = GetStackSize(v)
                    if recycle_table[v.prefab] then 
                        backnum = backnum + recycle_table[v.prefab] * num
                    else
                        backnum = backnum + 1 * num
                    end
                    v:Remove()
                end
            end
            --装备栏
            --[[for k,v in pairs(inst.components.inventory.equipslots) do
                if v and v.components.perishable then
                    
                end
            end]]
            --背包
            for k,v in pairs(inst.components.inventory.opencontainers) do
                if k and k:HasTag("backpack") and k.components.container then
                    for i,j in pairs(k.components.container.slots) do
                        if j and not j:HasTag("irreplaceable") then
                            local num = GetStackSize(j)
                            if recycle_table[j.prefab] then 
                                backnum = backnum + recycle_table[j.prefab] * num
                            else
                                backnum = backnum + 1 * num
                            end
                            j:Remove()
                        end
                    end
                end
            end

            local coin = math.floor(backnum*0.001)
            if coin > 0 then
                local item = SpawnPrefab("potion_achiv")
                item._userid = inst.userid
                item._owner = inst:GetDisplayName()
                item.minachiv = coin
                item.maxachiv = math.random(coin, coin*2)
                inst.components.inventory:GiveItem(item)
            end
            --[[if (backnum-coin*1000) >= 500 then
                local item = SpawnPrefab("potion_blue")
                inst.components.inventory:GiveItem(item)
            elseif (backnum-coin*1000) >= 100 then
                local item = SpawnPrefab("potion_green")
                inst.components.inventory:GiveItem(item)
            end]]--
            local left_coin = backnum-coin*1000
            if left_coin > 0 and inst.components.levelsystem then
                inst.components.levelsystem:xpDoDelta(left_coin, inst)
            end
            self.recycle = self.recycle + 1
            --self:coinDoDelta(-allachiv_coinuse["recycle"])
        end
        return
    end
    if self.coinamount < allachiv_coinuse[prefabname] 
        or self[prefabname] >= allachiv_coindata_max[prefabname] then return end
    for k=1, allachiv_coindata[prefabname] do
        local item = SpawnPrefab(prefabname)
        inst.components.inventory:GiveItem(item)
    end
    self[prefabname] = self[prefabname] + 1
    self:coinDoDelta(-allachiv_coinuse[prefabname])
end

function allachivcoin:switchaoe(inst)
    if self.strongeraoe > 0 then
        if self.aoestatus == 0 then
            self.aoestatus = 1
            inst.components.combat:EnableAreaDamage(true)
            inst.components.combat:SetAreaDamage(3, 0.6)
        else
            self.aoestatus = 0
            inst.components.combat:EnableAreaDamage(false)
        end
    end
end

function allachivcoin:skillfn(inst, skillname, data)
    --print("--switch--")
    if skillname == "wescheat" then 
        self:wescheatfn(inst)
        return
    end
    if skillname == "callback" then
        self:callbackfn(inst, data)
        return
    end
    if skillname == "strongeraoe" then
        self:switchaoe(inst)
    end
    if skillname == "waterwalk" then
        self:waterwalkswitch(inst)
    end
    if skillname == "changeposition" then
        --changeposition(inst, data)
        if data ~= nil then
            inst.components.combat.ignorehitrange = true
            inst._canflash = true
        else
            inst.components.combat.ignorehitrange = false
        end
    end
    if skillname == "email" then
        inst.components.titlesystem:recieveEmail(inst)
    end
end

function allachivcoin:killedfn(inst)
    inst:ListenForEvent("killedmonster", function(inst, data)
        local victim = data.victim
        if victim == nil then return end
        if victim:HasTag("ghost") or victim:HasTag("crazy") or victim:HasTag("cloned") 
            or victim:HasTag("player") or victim:HasTag("INLIMBO") or victim:HasTag("invisible")
            or victim:HasTag("shadow") or victim:HasTag("stalker") or victim:HasTag("limited") then return end
        if victim.components.combat and (victim.components.health and victim.components.health.maxhealth>99) 
            and victim.components.locomotor then
            if victim.components.freezable or victim:HasTag("monster") then
                if victim.prefab ~= nil and STRINGS.NAMES[string.upper(victim.prefab)] ~= nil then
                    local x,y,z = victim.Transform:GetWorldPosition()
                    if x~=nil and y~=nil and z~=nil then
                        local bone = SpawnPrefab("deadbone")
                        bone:SetDescription(victim.prefab)
                        bone.Transform:SetPosition(x, y, z)
                    end
                end
            end
        end
    end)
end


function allachivcoin:addcoins(inst)
	self.coinamount = self.coinamount + 100
end

--重置奖励
function allachivcoin:removecoin(inst)

    self.coinamount = self.coinamount + math.ceil(self.starsspent*reset_refund_percentage)
    self:resetbuff(inst)

    self.hungerupamount = 0
    self.sanityupamount = 0
    self.healthupamount = 0
    self.speedupamount = 0
    self.absorbupamount = 0
    self.damageupamount = 0
    self.crit = 0
	self.lifestealupamount = 0
	--self.fireflylightup = 0
    inst.components.allachivevent.starreset = 0
	
	self.starsspent = 0

    self.doubledrop = 0
    self.nomoist = 0
    self.goodman = 0
	self.cheatdeath = 0
    self.refresh = 0
    self.fishmaster = 0
    self.cookmaster = 0
    self.chopmaster = 0
    self.pickmaster = 0
    self.buildmaster = 0
    self.icebody = 0
    self.firebody = 0
    self.reader = 0
    self.masterchef = 0
	self.minemaster = 0
	self.fastworker = 0
    self.attackback = 0
    self.stopregen = 0
    self.attackfrozen = 0
    self.attackdead = 0
    self.attackbroken = 0
    self.abigaillevelup = 0
    self.abigailclone = 0
    self.bloodangry = 0
    self.balloonlevelup = 0
    self.ballooninspire = 0
    self.wescheat = 0
    self.gearuse = 0
    self.callspider = 0
    self.spiderstronger = 0
    self.callmerm = 0
    self.mermstronger = 0
    self.bernielevelup = 0
    self.linghtermore = 0
    self.level120 = 0
    self.soulmore = 0
    self.strongeraoe = 0
    self.waxwellup = 0
    self.winnonaup = 0
    self.woodieup = 0
    self.warlyup = 0
    self.wormwoodup = 0
    self.wickerbottomup = 0
    self.callback = 0
    self.potion = 0
    self.lightpower = 0
    self.hitattack = 0
    self.aoestatus = 0
    self.memorykill = 0
    self.throwrock = 0
    self.memorykilldata = {}
    self.temphealthup = 0
    self.waterwalk = 0
    self.waterwalkstatus = 0
    self.quickshot = 0

    if inst.components.health.currenthealth > 0 and not inst.components.rider:IsRiding() then
        inst.components.locomotor:Stop()
        inst.sg:GoToState("changeoutsidewardrobe")
    end
    SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition())
    SpawnPrefab("statue_transition_2").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.components.health:DeltaPenalty(TUNING.REVIVE_HEALTH_PENALTY)
end

--重置属性
function allachivcoin:resetbuff(inst)

	inst.components.hunger.burnratemodifiers:RemoveModifier("achievementperk")

    --if inst._fireflylight then inst._fireflylight:Remove() end
	
	--inst:ApplyScale("achievementScale", 1)

    inst.components.temperature.mintemp = TUNING.MIN_ENTITY_TEMP
    inst.components.temperature.maxtemp = TUNING.MAX_ENTITY_TEMP

    inst.components.health:StopRegen()

    inst:RemoveTag("achiveking")
    inst:RemoveTag("perkchef")
	inst:RemoveTag("fastpick")
    inst:RemoveTag("achivbookbuilder")
    inst:RemoveTag("potionbuilder")
    inst:RemoveComponent("clone")
    inst:RemoveTag("throwrock")
    inst:RemoveTag("quickshot")

    if inst.prefab ~= "wickerbottom" then
        inst:RemoveComponent("reader")
--        inst:RemoveTag("bookbuilder")
    end

    if inst.prefab ~= "warly" and inst.prefab ~= "willow" then
        inst:RemoveTag("expertchef")
		inst:RemoveTag("fastbuilder")
    end

    if inst.prefab ~= "warly" then
        inst:RemoveTag("masterchef")
        inst:RemoveTag("professionalchef")
    end

    if inst.prefab == "willow" then
        inst:RemoveComponent("aura")
    end

    if inst.prefab == "wes" then
        inst.components.combat.externaldamagemultipliers:RemoveModifier("ballooninspire")
    end

    if inst.prefab == "wolfgang" then
        inst.components.combat:EnableAreaDamage(false)
    end

    if inst.prefab == "wathgrithr" then
        inst.components.combat.externaldamagemultipliers:RemoveModifier("bloodangry")
        inst.components.combat.externaldamagemultipliers:RemoveModifier("hitsdamage")
    end

    if inst.prefab == "wormwood" then
        inst.components.combat.externaldamagemultipliers:RemoveModifier("seasondamageup")
        inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "seasonspeedup")
    end

    if inst.prefab == "wx78" then
        local weapon = inst.components.combat:GetWeapon()
        if weapon ~= nil then
            if weapon.components.weapon then
                --weapon.components.weapon.damage = weapon.components.weapon.olddmg
                weapon.components.weapon:SetRange(nil)
                weapon.components.weapon:SetProjectile(nil)
            end
        end
    end

    if inst.prefab == "woodie" then
        local current_hands = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if current_hands and current_hands.prefab == "lucy" then
            if current_hands._randomtask ~= nil then
                current_hands._randomtask:Cancel()
                current_hands._randomtask = nil
            end
            current_hands.components.weapon:SetDamage(TUNING.AXE_DAMAGE * .5)
        end
    end

    if inst.prefab == "webber" then

    end
    if inst.prefab == "walter" then

    end

    inst.components.moisture.maxMoistureRate = .75
    self.maxMoistureRate = inst.components.moisture.maxMoistureRate
	
	local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
	currentDamageMult = currentDamageMult - self.damageupamount*allachiv_coindata["damageup"]
	inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
	
	local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
	currentSpeedMult = currentSpeedMult - self.speedupamount*allachiv_coindata["speedup"]
	inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
	
	local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
	currentAbsorbAdd = currentAbsorbAdd - self.absorbupamount*allachiv_coindata["absorbup"]
	inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)

    inst.components.builder.ingredientmod = 1
end

--预运行
function allachivcoin:Init(inst)
	
	inst:DoTaskInTime(.1, function()
		self:firebodyfn(inst)
		self:icebodyfn(inst)
		self:cheatdeathfn(inst)
		self:refreshfn(inst)
		self:buildmasterfn(inst)
		self:cookmasterfn(inst)
		self:chopmasterfn(inst)
		self:pickmasterfn(inst)
		self:fishmasterfn(inst)
		self:goodmanfn(inst)
		self:doubledropfn(inst)
		self:fireflylightfn(inst)
		self:readerfn(inst)
		self:mastercheffn(inst)
		self:minemasterfn(inst)
		self:fastworkerfn(inst)
        self:attackbackfn(inst)
        self:addfollowerfn(inst)
        self:bloodangryfn(inst)
        self:callspiderfn(inst)
        self:bernielevelupfn(inst)
        self:linghtermorefn(inst)
        self:gearusefn(inst)
        self:callmermfn(inst)
        self:balloonfn(inst)
        self:strongeraoefn(inst)
        self:wormwoodupfn(inst)
        self:stopregenfn(inst)
        self:attackfrozenfn(inst)
        self:wickerbottomupfn(inst)
        self:soulmorefn(inst)
        --self:wescheatfn(inst)
        self:winnonaupfn(inst)
        self:potionfn(inst)
        self:lightpowerfn(inst)
        self:warlyupfn(inst)
        self:woodieupfn(inst)
        self:quickshotfn(inst)
        --self:killedfn(inst)
        self:onhitfn(inst)
	end)

	inst:DoTaskInTime(1.5, function()
		local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
		currentDamageMult = currentDamageMult + self.damageupamount*allachiv_coindata["damageup"]
		inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
		local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
		currentAbsorbAdd = currentAbsorbAdd + self.absorbupamount*allachiv_coindata["absorbup"]
		inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)
		local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
		currentSpeedMult = currentSpeedMult + self.speedupamount*allachiv_coindata["speedup"]
		inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
	end)

    inst:DoPeriodicTask(.5, function() self:onupdate(inst) end)
end

--实时更新数据
function allachivcoin:onupdate(inst)
    if self.maxMoistureRate ~= inst.components.moisture.maxMoistureRate then
        if self.nomoist > 0 then
            inst.components.moisture.maxMoistureRate = 0
        end
    end

    if self.resurrectcd > 0 then
        self.resurrectcd = self.resurrectcd - 0.5
    end
    if self.cheatdeathcd > 0 then
        self.cheatdeathcd = self.cheatdeathcd - 0.5
    end
    if self.wescheatcd > 0 then
        self.wescheatcd = self.wescheatcd - 0.5
    end
    if self.callbackcd > 0 then
        self.callbackcd = self.callbackcd - 0.5
    end
    if self.hits > 0 and self.hitattackcd == 0 then
        self.hits = self.hits - 1

        if self.hits < 0 then
            self.hits = 0
        end
    end
    if self.hitattackcd > 0 then
        self.hitattackcd = self.hitattackcd - 0.5
    end
    if self.abigailcd > 0 then
        self.abigailcd = self.abigailcd - 0.5
    end
    if self.waterwalkstatus > 0 then
        if inst.components.hunger:IsStarving() then
            self.waterwalkstatus = 0
        else
            inst.components.hunger:DoDelta(-0.5)
        end
    end
end


return allachivcoin