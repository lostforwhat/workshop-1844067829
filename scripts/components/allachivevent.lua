local function StrToTable(str)
    if str == nil or type(str) ~= "string" then
        return
    end
    
    return loadstring("return " .. str)()
end

--current
local function currentruncount(self,runcount) self.inst.currentruncount:set(runcount) end

--check
local function checkall(self,all) self.inst.checkall:set(all) end
local function checktumfirst(self,tumfirst) local c = 0 if tumfirst then c=tumfirst end self.inst.checktumfirst:set(c) end
local function checktum88(self,tum88) local c = 0 if tum88 then c=tum88 end self.inst.checktum88:set(c) end
local function checktum288(self,tum288) local c = 0 if tum288 then c=tum288 end self.inst.checktum288:set(c) end
local function checktum888(self,tum888) local c = 0 if tum888 then c=tum888 end self.inst.checktum888:set(c) end
local function checktum1888(self,tum1888) local c = 0 if tum1888 then c=tum1888 end self.inst.checktum1888:set(c) end
local function checktum2888(self,tum2888) local c = 0 if tum2888 then c=tum2888 end self.inst.checktum2888:set(c) end
local function checktum8888(self,tum8888) local c = 0 if tum8888 then c=tum8888 end self.inst.checktum8888:set(c) end
local function checktumss(self,tumss) local c = 0 if tumss then c=tumss end self.inst.checktumss:set(c) end
local function checktums(self,tums) local c = 0 if tums then c=tums end self.inst.checktums:set(c) end
local function checktumd(self,tumd) local c = 0 if tumd then c=tumd end self.inst.checktumd:set(c) end
local function checktumdd(self,tumdd) local c = 0 if tumdd then c=tumdd end self.inst.checktumdd:set(c) end
local function checktumsss(self,tumsss) local c = 0 if tumsss then c=tumsss end self.inst.checktumsss:set(c) end
local function checktumout10(self,tumout10) local c = 0 if tumout10 then c=tumout10 end self.inst.checktumout10:set(c) end
local function checktumout100(self,tumout100) local c = 0 if tumout100 then c=tumout100 end self.inst.checktumout100:set(c) end

local function checkfirsteat(self,firsteat) local c = 0 if firsteat then c=firsteat end self.inst.checkfirsteat:set(c) end
local function checkeat100(self,eat100) local c = 0 if eat100 then c=eat100 end self.inst.checkeat100:set(c) end
local function checkeat666(self,eat666) local c = 0 if eat666 then c=eat666 end self.inst.checkeat666:set(c) end
local function checkeat2000(self,eat2000) local c = 0 if eat2000 then c=eat2000 end self.inst.checkeat2000:set(c) end
local function checkeat8888(self,eat8888) local c = 0 if eat8888 then c=eat8888 end self.inst.checkeat8888:set(c) end
local function checkeatvegetables88(self,eatvegetables88) local c = 0 if eatvegetables88 then c=eatvegetables88 end self.inst.checkeatvegetables88:set(c) end
local function checkeatmeat88(self,eatmeat88) local c = 0 if eatmeat88 then c=eatmeat88 end self.inst.checkeatmeat88:set(c) end
local function checkeatbeans66(self,eatbeans66) local c = 0 if eatbeans66 then c=eatbeans66 end self.inst.checkeatbeans66:set(c) end
local function checkeatmonstermeat20(self,eatmonstermeat20) local c = 0 if eatmonstermeat20 then c=eatmonstermeat20 end self.inst.checkeatmonstermeat20:set(c) end
local function checkeathot(self,eathot) local c = 0 if eathot then c=eathot end self.inst.checkeathot:set(c) end
local function checkeatcold(self,eatcold) local c = 0 if eatcold then c=eatcold end self.inst.checkeatcold:set(c) end
local function checkeatfish(self,eatfish) local c = 0 if eatfish then c=eatfish end self.inst.checkeatfish:set(c) end
local function checkeatturkey(self,eatturkey) local c = 0 if eatturkey then c=eatturkey end self.inst.checkeatturkey:set(c) end
local function checkeatpepper(self,eatpepper) local c = 0 if eatpepper then c=eatpepper end self.inst.checkeatpepper:set(c) end
local function checkeatbacon(self,eatbacon) local c = 0 if eatbacon then c=eatbacon end self.inst.checkeatbacon:set(c) end
local function checkeatmole(self,eatmole) local c = 0 if eatmole then c=eatmole end self.inst.checkeatmole:set(c) end

local function checkintogame(self,intogame) local c = 0 if intogame then c=intogame end self.inst.checkintogame:set(c) end
local function checkdeathblack(self,deathblack) local c = 0 if deathblack then c=deathblack end self.inst.checkdeathblack:set(c) end
local function checktooyoung(self,tooyoung) local c = 0 if tooyoung then c=tooyoung end self.inst.checktooyoung:set(c) end
local function checkwalk3600(self,walk3600) local c = 0 if walk3600 then c=walk3600 end self.inst.checkwalk3600:set(c) end
local function checkstop1800(self,stop1800) local c = 0 if stop1800 then c=stop1800 end self.inst.checkstop1800:set(c) end
local function checkdeath5(self,death5) local c = 0 if death5 then c=death5 end self.inst.checkdeath5:set(c) end
local function checksecondchance(self,secondchance) local c = 0 if secondchance then c=secondchance end self.inst.checksecondchance:set(c) end
local function checkmessiah(self,messiah) local c = 0 if messiah then c=messiah end self.inst.checkmessiah:set(c) end
local function checksleeptent(self,sleeptent) local c = 0 if sleeptent then c=sleeptent end self.inst.checksleeptent:set(c) end
local function checksleepsiesta(self,sleepsiesta) local c = 0 if sleepsiesta then c=sleepsiesta end self.inst.checksleepsiesta:set(c) end
local function checkreviveamulet(self,reviveamulet) local c = 0 if reviveamulet then c=reviveamulet end self.inst.checkreviveamulet:set(c) end
local function checkfeedplayer(self,feedplayer) local c = 0 if feedplayer then c=feedplayer end self.inst.checkfeedplayer:set(c) end

local function checkplant188(self,plant188) local c = 0 if plant188 then c=plant188 end self.inst.checkplant188:set(c) end
local function checkplant1000(self,plant1000) local c = 0 if plant1000 then c=plant1000 end self.inst.checkplant1000:set(c) end
local function checkpicker188(self,picker188) local c = 0 if picker188 then c=picker188 end self.inst.checkpicker188:set(c) end
local function checkpicker1000(self,picker1000) local c = 0 if picker1000 then c=picker1000 end self.inst.checkpicker1000:set(c) end
local function checkbuild30(self,build30) local c = 0 if build30 then c=build30 end self.inst.checkbuild30:set(c) end
local function checkbuild666(self,build666) local c = 0 if build666 then c=build666 end self.inst.checkbuild666:set(c) end
local function checkchop100(self,chop100) local c = 0 if chop100 then c=chop100 end self.inst.checkchop100:set(c) end
local function checkchop1000(self,chop1000) local c = 0 if chop1000 then c=chop1000 end self.inst.checkchop1000:set(c) end
local function checkmine66(self,mine66) local c = 0 if mine66 then c=mine66 end self.inst.checkmine66:set(c) end
local function checkmine666(self,mine666) local c = 0 if mine666 then c=mine666 end self.inst.checkmine666:set(c) end
local function checkcook100(self,cook100) local c = 0 if cook100 then c=cook100 end self.inst.checkcook100:set(c) end
local function checkcook666(self,cook666) local c = 0 if cook666 then c=cook666 end self.inst.checkcook666:set(c) end

local function checkattack5000(self,attack5000) local c = 0 if attack5000 then c=attack5000 end self.inst.checkattack5000:set(c) end
local function checktank5000(self,tank5000) local c = 0 if tank5000 then c=tank5000 end self.inst.checktank5000:set(c) end
local function checkkillmonster1000(self,killmonster1000) local c = 0 if killmonster1000 then c=killmonster1000 end self.inst.checkkillmonster1000:set(c) end
local function checkkillspider100(self,killspider100) local c = 0 if killspider100 then c=killspider100 end self.inst.checkkillspider100:set(c) end
local function checkkillhound100(self,killhound100) local c = 0 if killhound100 then c=killhound100 end self.inst.checkkillhound100:set(c) end
local function checkkillkoale5(self,killkoale5) local c = 0 if killkoale5 then c=killkoale5 end self.inst.checkkillkoale5:set(c) end
local function checkkillmonkey20(self,killmonkey20) local c = 0 if killmonkey20 then c=killmonkey20 end self.inst.checkkillmonkey20:set(c) end
local function checkkillleif5(self,killleif5) local c = 0 if killleif5 then c=killleif5 end self.inst.checkkillleif5:set(c) end
local function checkkillslurtle10(self,killslurtle10) local c = 0 if killslurtle10 then c=killslurtle10 end self.inst.checkkillslurtle10:set(c) end
local function checkkillbunnyman20(self,killbunnyman20) local c = 0 if killbunnyman20 then c=killbunnyman20 end self.inst.checkkillbunnyman20:set(c) end
local function checkkilltallbird50(self,killtallbird50) local c = 0 if killtallbird50 then c=killtallbird50 end self.inst.checkkilltallbird50:set(c) end
local function checkkillworm20(self,killworm20) local c = 0 if killworm20 then c=killworm20 end self.inst.checkkillworm20:set(c) end

local function checkkillglommer(self,killglommer) self.inst.checkkillglommer:set(killglommer) end
local function checkkilchester(self,kilchester) self.inst.checkkilchester:set(kilchester) end
local function checkkillhutch(self,killhutch) self.inst.checkkillhutch:set(killhutch) end
local function checkkllrabbit10(self,kllrabbit10) self.inst.checkkllrabbit10:set(kllrabbit10) end
local function checkkilltentacle50(self,killtentacle50) self.inst.checkkilltentacle50:set(killtentacle50) end
local function checkkillbirchnutdrake20(self,killbirchnutdrake20) self.inst.checkkillbirchnutdrake20:set(killbirchnutdrake20) end
local function checkkillterrorbeak20(self,killterrorbeak20) self.inst.checkkillterrorbeak20:set(killterrorbeak20) end
local function checkkilllightninggoat20(self,killlightninggoat20) self.inst.checkkilllightninggoat20:set(killlightninggoat20) end
local function checkkillspiderqueen10(self,killspiderqueen10) self.inst.checkkillspiderqueen10:set(killspiderqueen10) end
local function checkkillwarg5(self,killwarg5) self.inst.checkkillwarg5:set(killwarg5) end
local function checkkillcatcoon10(self,killcatcoon10) self.inst.checkkillcatcoon10:set(killcatcoon10) end
local function checkkillghost10(self,killghost10) self.inst.checkkillghost10:set(killghost10) end

local function checkkillwalrus10(self,killwalrus10) local c = 0 if killwalrus10 then c=killwalrus10 end self.inst.checkkillwalrus10:set(c) end
local function checkkillbutterfly20(self,killbutterfly20) local c = 0 if killbutterfly20 then c=killbutterfly20 end self.inst.checkkillbutterfly20:set(c) end
local function checkkillbat20(self,killbat20) local c = 0 if killbat20 then c=killbat20 end self.inst.checkkillbat20:set(c) end
local function checkkillmerm30(self,killmerm30) local c = 0 if killmerm30 then c=killmerm30 end self.inst.checkkillmerm30:set(c) end
local function checkkillbee100(self,killbee100) local c = 0 if killbee100 then c=killbee100 end self.inst.checkkillbee100:set(c) end
local function checkkillpenguin30(self,killpenguin30) local c = 0 if killpenguin30 then c=killpenguin30 end self.inst.checkkillpenguin30:set(c) end
local function checkkillfrog20(self,killfrog20) local c = 0 if killfrog20 then c=killfrog20 end self.inst.checkkillfrog20:set(c) end
local function checkkillperd10(self,killperd10) local c = 0 if killperd10 then c=killperd10 end self.inst.checkkillperd10:set(c) end
local function checkkillbird10(self,killbird10) local c = 0 if killbird10 then c=killbird10 end self.inst.checkkillbird10:set(c) end
local function checkkillpigman10(self,killpigman10) local c = 0 if killpigman10 then c=killpigman10 end self.inst.checkkillpigman10:set(c) end
local function checkkillmosquito20(self,killmosquito20) local c = 0 if killmosquito20 then c=killmosquito20 end self.inst.checkkillmosquito20:set(c) end
local function checkkillkrampus10(self,killkrampus10) local c = 0 if killkrampus10 then c=killkrampus10 end self.inst.checkkillkrampus10:set(c) end

local function checkkillmoose(self,killmoose) local c = 0 if killmoose then c=killmoose end self.inst.checkkillmoose:set(c) end
local function checkkilldragonfly(self,killdragonfly) local c = 0 if killdragonfly then c=killdragonfly end self.inst.checkkilldragonfly:set(c) end
local function checkkillbeager(self,killbeager) local c = 0 if killbeager then c=killbeager end self.inst.checkkillbeager:set(c) end
local function checkkilldeerclops(self,killdeerclops) local c = 0 if killdeerclops then c=killdeerclops end self.inst.checkkilldeerclops:set(c) end
local function checksinglekillspat(self,singlekillspat) local c = 0 if singlekillspat then c=singlekillspat end self.inst.checksinglekillspat:set(c) end
local function checkkillshadow(self,killshadow) local c = 0 if killshadow then c=killshadow end self.inst.checkkillshadow:set(c) end
local function checkkillstalker(self,killstalker) local c = 0 if killstalker then c=killstalker end self.inst.checkkillstalker:set(c) end
local function checkkillstalker_atrium(self,killstalker_atrium) local c = 0 if killstalker_atrium then c=killstalker_atrium end self.inst.checkkillstalker_atrium:set(c) end
local function checkkillklaus(self,killklaus) local c = 0 if killklaus then c=killklaus end self.inst.checkkillklaus:set(c) end
local function checkkillantlion(self,killantlion) local c = 0 if killantlion then c=killantlion end self.inst.checkkillantlion:set(c) end
local function checkkillminotaur(self,killminotaur) local c = 0 if killminotaur then c=killminotaur end self.inst.checkkillminotaur:set(c) end
local function checkkillbeequeen(self,killbeequeen) local c = 0 if killbeequeen then c=killbeequeen end self.inst.checkkillbeequeen:set(c) end
local function checkkilltoadstool(self,killtoadstool) local c = 0 if killtoadstool then c=killtoadstool end self.inst.checkkilltoadstool:set(c) end
local function checkkilltoadstool_dark(self,killtoadstool_dark) local c = 0 if killtoadstool_dark then c=killtoadstool_dark end self.inst.checkkilltoadstool_dark:set(c) end
local function checkkillmalbatross(self,killmalbatross) local c = 0 if killmalbatross then c=killmalbatross end self.inst.checkkillmalbatross:set(c) end
local function checkkillcrabking(self,killcrabking) local c = 0 if killcrabking then c=killcrabking end self.inst.checkkillcrabking:set(c) end
local function checkkillalterguardian_phase1(self,killalterguardian_phase1) local c = 0 if killalterguardian_phase1 then c=killalterguardian_phase1 end self.inst.checkkillalterguardian_phase1:set(c) end
local function checkkilleyeofterror(self,killeyeofterror) local c = 0 if killeyeofterror then c=killeyeofterror end self.inst.checkkilleyeofterror:set(c) end
local function checkkilltwinofterror1(self,killtwinofterror1) local c = 0 if killtwinofterror1 then c=killtwinofterror1 end self.inst.checkkilltwinofterror1:set(c) end
local function checkkilltwinofterror2(self,killtwinofterror2) local c = 0 if killtwinofterror2 then c=killtwinofterror2 end self.inst.checkkilltwinofterror2:set(c) end

local function checkpickcactus50(self,pickcactus50) self.inst.checkpickcactus50:set(pickcactus50) end
local function checkpickred_mushroom50(self,pickred_mushroom50) self.inst.checkpickred_mushroom50:set(pickred_mushroom50) end
local function checkpickblue_mushroom50(self,pickblue_mushroom50) self.inst.checkpickblue_mushroom50:set(pickblue_mushroom50) end
local function checkpickgreen_mushroom50(self,pickgreen_mushroom50) self.inst.checkpickgreen_mushroom50:set(pickgreen_mushroom50) end
local function checkpickflower_cave50(self,pickflower_cave50) self.inst.checkpickflower_cave50:set(pickflower_cave50) end
local function checkpicktallbirdnest10(self,picktallbirdnest10) self.inst.checkpicktallbirdnest10:set(picktallbirdnest10) end
local function checkpickrock_avocado_bush50(self,pickrock_avocado_bush50) self.inst.checkpickrock_avocado_bush50:set(pickrock_avocado_bush50) end
local function checkpickcave_banana_tree50(self,pickcave_banana_tree50) self.inst.checkpickcave_banana_tree50:set(pickcave_banana_tree50) end
local function checkpickwormlight_plant40(self,pickwormlight_plant40) self.inst.checkpickwormlight_plant40:set(pickwormlight_plant40) end
local function checkpickreeds50(self,pickreeds50) self.inst.checkpickreeds50:set(pickreeds50) end
local function checkcookwaffles(self,cookwaffles) self.inst.checkcookwaffles:set(cookwaffles) end
local function checkcookbananapop(self,cookbananapop) self.inst.checkcookbananapop:set(cookbananapop) end

local function checkbuildpumpkin_lantern(self,buildpumpkin_lantern) self.inst.checkbuildpumpkin_lantern:set(buildpumpkin_lantern) end
local function checkbuildruinshat(self,buildruinshat) self.inst.checkbuildruinshat:set(buildruinshat) end
local function checkbuildarmorruins(self,buildarmorruins) self.inst.checkbuildarmorruins:set(buildarmorruins) end
local function checkbuildruins_bat(self,buildruins_bat) self.inst.checkbuildruins_bat:set(buildruins_bat) end
local function checkbuildgunpowder(self,buildgunpowder) self.inst.checkbuildgunpowder:set(buildgunpowder) end
local function checkbuildhealingsalve(self,buildhealingsalve) self.inst.checkbuildhealingsalve:set(buildhealingsalve) end
local function checkbuildbandage(self,buildbandage) self.inst.checkbuildbandage:set(buildbandage) end
local function checkbuildblowdart_pipe(self,buildblowdart_pipe) self.inst.checkbuildblowdart_pipe:set(buildblowdart_pipe) end
local function checkbuildblowdart_sleep(self,buildblowdart_sleep) self.inst.checkbuildblowdart_sleep:set(buildblowdart_sleep) end
local function checkbuildblowdart_yellow(self,buildblowdart_yellow) self.inst.checkbuildblowdart_yellow:set(buildblowdart_yellow) end
local function checkbuildblowdart_fire(self,buildblowdart_fire) self.inst.checkbuildblowdart_fire:set(buildblowdart_fire) end
local function checkbuildnightsword(self,buildnightsword) self.inst.checkbuildnightsword:set(buildnightsword) end
local function checkbuildamulet(self,buildamulet) self.inst.checkbuildamulet:set(buildamulet) end
local function checkbuildpanflute(self,buildpanflute) self.inst.checkbuildpanflute:set(buildpanflute) end
local function checkbuildmolehat(self,buildmolehat) self.inst.checkbuildmolehat:set(buildmolehat) end
local function checkbuildlifeinjector(self,buildlifeinjector) self.inst.checkbuildlifeinjector:set(buildlifeinjector) end
local function checkbuildbatbat(self,buildbatbat) self.inst.checkbuildbatbat:set(buildbatbat) end
local function checkbuildmultitool_axe_pickaxe(self,buildmultitool_axe_pickaxe) self.inst.checkbuildmultitool_axe_pickaxe:set(buildmultitool_axe_pickaxe) end
local function checkbuildthulecite(self,buildthulecite) self.inst.checkbuildthulecite:set(buildthulecite) end
local function checkbuildyellowstaff(self,buildyellowstaff) self.inst.checkbuildyellowstaff:set(buildyellowstaff) end
local function checkbuildfootballhat(self,buildfootballhat) self.inst.checkbuildfootballhat:set(buildfootballhat) end
local function checkbuildarmorwood(self,buildarmorwood) self.inst.checkbuildarmorwood:set(buildarmorwood) end
local function checkbuildhambat(self,buildhambat) self.inst.checkbuildhambat:set(buildhambat) end
local function checkbuildglasscutter(self,buildglasscutter) self.inst.checkbuildglasscutter:set(buildglasscutter) end

local function checkgoodman(self,goodman) self.inst.checkgoodman:set(goodman) end
local function checkbrother(self,brother) self.inst.checkbrother:set(brother) end
local function checkcatperson(self,catperson) self.inst.checkcatperson:set(catperson) end
local function checkrocklob(self,rocklob) self.inst.checkrocklob:set(rocklob) end
local function checkspooder(self,spooder) self.inst.checkspooder:set(spooder) end
local function checkbirdclop(self,birdclop) self.inst.checkbirdclop:set(birdclop) end
local function checkfish50(self,fish50) self.inst.checkfish50:set(fish50) end
local function checkfish666(self,fish666) self.inst.checkfish666:set(fish666) end
local function checkpigking100(self,pigking100) self.inst.checkpigking100:set(pigking100) end
local function checkpigking888(self,pigking888) self.inst.checkpigking888:set(pigking888) end
local function checkbirdcage80(self,birdcage80) self.inst.checkbirdcage80:set(birdcage80) end
local function checkbirdcage666(self,birdcage666) self.inst.checkbirdcage666:set(birdcage666) end

local function checkdemage300(self,demage300) self.inst.checkdemage300:set(demage300) end
local function checkdemage1(self,demage1) self.inst.checkdemage1:set(demage1) end
local function checkdemage66(self,demage66) self.inst.checkdemage66:set(demage66) end
local function checkminotaurhurt6(self,minotaurhurt6) self.inst.checkminotaurhurt6:set(minotaurhurt6) end
local function checkbeargerhurt5(self,beargerhurt5) self.inst.checkbeargerhurt5:set(beargerhurt5) end
local function checkhurt1(self,hurt1) self.inst.checkhurt1:set(hurt1) end
local function checkvs10(self,vs10) self.inst.checkvs10:set(vs10) end
local function checkhealth1kill(self,health1kill) self.inst.checkhealth1kill:set(health1kill) end
local function checkspeed160(self,speed160) self.inst.checkspeed160:set(speed160) end
local function checkspeed50(self,speed50) self.inst.checkspeed50:set(speed50) end
local function checkusecoin300(self,usecoin300) self.inst.checkusecoin300:set(usecoin300) end
local function checkkillmoonpig10(self,killmoonpig10) self.inst.checkkillmoonpig10:set(killmoonpig10) end

local function checktempachiv(self, tempachiv) self.inst.checktempachiv:set(TableToStr(tempachiv)) end

--Basics
local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
    return false
end

local function findindex(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return index
        end
    end
end

local function copylist(list)
	local tmp = {}
	for index,value in pairs(list) do
		table.insert(tmp,list[index])
	end
	return tmp
end

local allachivevent = Class(function(self, inst)
    self.inst = inst
    self.all = 0
    --tum
    self.tumfirst = 0
    self.tum88 = 0
    self.tum288 = 0
    self.tum888 = 0
    self.tum1888 = 0
    self.tum2888 = 0
    self.tum8888 = 0
    self.tumss = 0
    self.tums = 0
    self.tumd = 0
    self.tumdd = 0
    self.tumsss = 0
    self.tumout10 = 0
    self.tumout100 = 0
    --Food
    self.firsteat = 0
    self.eat100 = 0
    self.eat666 = 0
    self.eat2000 = 0
    self.eat8888 = 0
    self.eatvegetables88 = 0
    self.eatmeat88 = 0
    self.eatbeans66 = 0
    self.eatmonstermeat20 = 0
    self.eathot = 0
    self.eatcold = 0
    self.eatfish = 0
    self.eatturkey = 0
    self.eatpepper = 0
    self.eatbacon = 0
    self.eatmole = 0--鳄梨酱
    --Life
    self.intogame = 0
    self.deathblack = 0
    self.tooyoung = 0
    self.walk3600 = 0
    self.stop1800 = 0
    self.death5 = 0
    self.secondchance = 0
    self.messiah = 0
    self.sleeptent = 0
    self.sleepsiesta = 0
    self.reviveamulet = 0
    self.feedplayer = 0
    --Work
    self.plant188 = 0
    self.plant1000 = 0
    self.picker188 = 0
    self.picker1000 = 0
    self.build30 = 0
    self.build666 = 0
    self.chop100 = 0
    self.chop1000 = 0
    self.mine66 = 0
    self.mine666 = 0
    self.cook100 = 0
    self.cook666 = 0
    --Fight
    self.attack5000 = 0
    self.tank5000 = 0
    self.killmonster1000 = 0
    self.killspider100 = 0
    self.killhound100 = 0
    self.killkoale5 = 0
    self.killmonkey20 = 0
    self.killleif5 = 0
    self.killslurtle10 = 0
    self.killbunnyman20 = 0
    self.killtallbird50 = 0
    self.killworm20 = 0

    self.killglommer = 0
    self.kilchester = 0
    self.killhutch = 0
    self.kllrabbit10 = 0
    self.killghost10 = 0
    self.killtentacle50 = 0
    self.killterrorbeak20 = 0
    self.killbirchnutdrake20 = 0
    self.killlightninggoat20 = 0
    self.killspiderqueen10 = 0
    self.killwarg5 = 0
    self.killcatcoon10 = 0

    self.killwalrus10 = 0
    self.killbutterfly20 = 0
    self.killbat20 = 0
    self.killmerm30 = 0
    self.killbee100 = 0
    self.killpenguin30 = 0
    self.killfrog20 = 0
    self.killperd10 = 0
    self.killbird10 = 0
    self.killpigman10 = 0
    self.killmosquito20 = 0
    self.killkrampus10 = 0
    --other

    --boss
    self.killmoose = 0
    self.killdragonfly = 0
    self.killbeager = 0
    self.killdeerclops = 0
    self.singlekillspat = 0
    self.killshadow = 0
    self.killstalker = 0
    self.killstalker_atrium = 0
    self.killklaus = 0
    self.killantlion = 0
    self.killminotaur = 0

    self.killbeequeen = 0
    self.killtoadstool = 0
    self.killtoadstool_dark = 0
    self.killmalbatross = 0
    self.killcrabking = 0
    self.killalterguardian_phase1 = 0
    self.killeyeofterror = 0
    self.killtwinofterror1 = 0
    self.killtwinofterror2 = 0

    self.pickcactus50 = 0
    self.pickred_mushroom50 = 0
    self.pickblue_mushroom50 = 0
    self.pickgreen_mushroom50 = 0
    self.pickflower_cave50 = 0
    self.picktallbirdnest10 = 0
    self.pickrock_avocado_bush50 = 0
    self.pickcave_banana_tree50 = 0
    self.pickwormlight_plant40 = 0
    self.pickreeds50 = 0
    self.cookwaffles = 0
    self.cookbananapop = 0
    self.buildpumpkin_lantern = 0
    self.buildruinshat = 0
    self.buildarmorruins = 0
    self.buildruins_bat = 0
    self.buildgunpowder = 0
    self.buildhealingsalve = 0
    self.buildbandage = 0
    self.buildblowdart_pipe = 0
    self.buildblowdart_sleep = 0
    self.buildblowdart_yellow = 0
    self.buildblowdart_fire = 0
    self.buildnightsword = 0
    self.buildamulet = 0
    self.buildpanflute = 0
    self.buildmolehat = 0
    self.buildlifeinjector = 0
    self.buildbatbat = 0
    self.buildmultitool_axe_pickaxe = 0
    self.buildthulecite = 0
    self.buildyellowstaff = 0
    self.buildfootballhat = 0
    self.buildarmorwood = 0
    self.buildhambat = 0
    self.buildglasscutter = 0

    self.goodman = 0
    self.brother = 0
    self.catperson = 0
    self.rocklob = 0
    self.spooder = 0
    self.birdclop = 0
    self.fish50 = 0
    self.fish666 = 0
    self.pigking100 = 0
    self.pigking888 = 0
    self.birdcage80 = 0
    self.birdcage666 = 0

    self.demage300 = 0
    self.demage1 = 0
    self.demage66 = 0
    self.minotaurhurt6 = 0
    self.beargerhurt5 = 0
    self.hurt1 = 0
    self.vs10 = 0
    self.health1kill = 0
    self.speed160 = 0
    self.speed50 = 0
    self.usecoin300 = 0
    self.killmoonpig10 = 0
    self.demage1000 = 0
    self.demagekill = 0

    self.tempachiv = nil
    self.killboss = 0
    
    self.complete_time = nil
    self.temp_total = 0
    self.tumbleweednum = 0
end,
nil,
{
    all = checkall,
    tumfirst = checktumfirst,
    tum88 = checktum88,
    tum288 = checktum288,
    tum888 = checktum888,
    tum1888 = checktum1888,
    tum2888 = checktum2888,
    tum8888 = checktum8888,
    tumss = checktumss,
    tums = checktums,
    tumd = checktumd,
    tumdd = checktumdd,
    tumsss = checktumsss,
    tumout10 = checktumout10,
    tumout100 = checktumout100,
    firsteat = checkfirsteat,
    eat100 = checkeat100,
    eat666 = checkeat666,
    eat2000 = checkeat2000,
    eat8888 = checkeat8888,
    eatvegetables88 = checkeatvegetables88,
    eatmeat88 = checkeatmeat88,
    eatbeans66 = checkeatbeans66,
    eatmonstermeat20 = checkeatmonstermeat20,
    eathot = checkeathot,
    eatcold = checkeatcold,
    eatfish = checkeatfish,
    eatturkey = checkeatturkey,
    eatpepper = checkeatpepper,
    eatbacon = checkeatbacon,
    eatmole = checkeatmole,--鳄梨酱
    intogame = checkintogame,
    deathblack = checkdeathblack,
    tooyoung = checktooyoung,
    walk3600 = checkwalk3600,
    stop1800 = checkstop1800,
    death5 = checkdeath5,
    secondchance = checksecondchance,
    messiah = checkmessiah,
    sleeptent = checksleeptent,
    sleepsiesta = checksleepsiesta,
    reviveamulet = checkreviveamulet,
    feedplayer = checkfeedplayer,
    plant188 = checkplant188,
    plant1000 = checkplant1000,
    picker188 = checkpicker188,
    picker1000 = checkpicker1000,
    build30 = checkbuild30,
    build666 = checkbuild666,
    chop100 = checkchop100,
    chop1000 = checkchop1000,
    mine66 = checkmine66,
    mine666 = checkmine666,
    cook100 = checkcook100,
    cook666 = checkcook666,
    attack5000 = checkattack5000,
    tank5000 = checktank5000,
    killmonster1000 = checkkillmonster1000,
    killspider100 = checkkillspider100,
    killhound100 = checkkillhound100,
    killkoale5 = checkkillkoale5,
    killmonkey20 = checkkillmonkey20,
    killleif5 = checkkillleif5,
    killslurtle10 = checkkillslurtle10,
    killbunnyman20 = checkkillbunnyman20,
    killtallbird50 = checkkilltallbird50,
    killworm20 = checkkillworm20,
    killwalrus10 = checkkillwalrus10,
    killbutterfly20 = checkkillbutterfly20,
    killbat20 = checkkillbat20,
    killmerm30 = checkkillmerm30,
    killbee100 = checkkillbee100,
    killpenguin30 = checkkillpenguin30,
    killfrog20 = checkkillfrog20,
    killperd10 = checkkillperd10,
    killbird10 = checkkillbird10,
    killpigman10 = checkkillpigman10,
    killmosquito20 = checkkillmosquito20,
    killkrampus10 = checkkillkrampus10,
    killmoose = checkkillmoose,
    killdragonfly = checkkilldragonfly,
    killbeager = checkkillbeager,
    killdeerclops = checkkilldeerclops,
    singlekillspat = checksinglekillspat,
    killshadow = checkkillshadow,
    killstalker = checkkillstalker,
    killstalker_atrium = checkkillstalker_atrium,
    killklaus = checkkillklaus,
    killantlion = checkkillantlion,
    killminotaur = checkkillminotaur,
    killbeequeen = checkkillbeequeen,
    killtoadstool = checkkilltoadstool,
    killtoadstool_dark = checkkilltoadstool_dark,
    killmalbatross = checkkillmalbatross,
    killcrabking = checkkillcrabking,
    killalterguardian_phase1 = checkkillalterguardian_phase1,
    killeyeofterror = checkkilleyeofterror,
    killtwinofterror1 = checkkilltwinofterror1,
    killtwinofterror2 = checkkilltwinofterror2,

    killglommer = checkkillglommer,
    kilchester = checkkilchester,
    killhutch = checkkillhutch,
    kllrabbit10 = checkkllrabbit10,
    killghost10 = checkkillghost10,
    killtentacle50 = checkkilltentacle50,
    killterrorbeak20 = checkkillterrorbeak20,
    killbirchnutdrake20 = checkkillbirchnutdrake20,
    killlightninggoat20 = checkkilllightninggoat20,
    killspiderqueen10 = checkkillspiderqueen10,
    killwarg5 = checkkillwarg5,
    killcatcoon10 = checkkillcatcoon10,

    pickcactus50 = checkpickcactus50,
    pickred_mushroom50 = checkpickred_mushroom50,
    pickblue_mushroom50 = checkpickblue_mushroom50,
    pickgreen_mushroom50 = checkpickgreen_mushroom50,
    pickflower_cave50 = checkpickflower_cave50,
    picktallbirdnest10 = checkpicktallbirdnest10,
    pickrock_avocado_bush50 = checkpickrock_avocado_bush50,
    pickcave_banana_tree50 = checkpickcave_banana_tree50,
    pickwormlight_plant40 = checkpickwormlight_plant40,
    pickreeds50 = checkpickreeds50,
    cookwaffles = checkcookwaffles,
    cookbananapop = checkcookbananapop,

    buildpumpkin_lantern = checkbuildpumpkin_lantern,
    buildruinshat = checkbuildruinshat,
    buildarmorruins = checkbuildarmorruins,
    buildruins_bat = checkbuildruins_bat,
    buildgunpowder = checkbuildgunpowder,
    buildhealingsalve = checkbuildhealingsalve,
    buildbandage = checkbuildbandage,
    buildblowdart_pipe = checkbuildblowdart_pipe,
    buildblowdart_sleep = checkbuildblowdart_sleep,
    buildblowdart_yellow = checkbuildblowdart_yellow,
    buildblowdart_fire = checkbuildblowdart_fire,
    buildnightsword = checkbuildnightsword,
    buildamulet = checkbuildamulet,
    buildpanflute = checkbuildpanflute,
    buildmolehat = checkbuildmolehat,
    buildlifeinjector = checkbuildlifeinjector,
    buildbatbat = checkbuildbatbat,
    buildmultitool_axe_pickaxe = checkbuildmultitool_axe_pickaxe,
    buildthulecite = checkbuildthulecite,
    buildyellowstaff = checkbuildyellowstaff,
    buildfootballhat = checkbuildfootballhat,
    buildarmorwood = checkbuildarmorwood,
    buildhambat = checkbuildhambat,
    buildglasscutter = checkbuildglasscutter,

    goodman = checkgoodman,
    brother = checkbrother,
    catperson = checkcatperson,
    rocklob = checkrocklob,
    spooder = checkspooder,
    birdclop = checkbirdclop,
    fish50 = checkfish50,
    fish666 = checkfish666,
    pigking100 = checkpigking100,
    pigking888 = checkpigking888,
    birdcage80 = checkbirdcage80,
    birdcage666 = checkbirdcage666,

    demage300 = checkdemage300,
    demage1 = checkdemage1,
    demage66 = checkdemage66,
    minotaurhurt6 = checkminotaurhurt6,
    beargerhurt5 = checkbeargerhurt5,
    hurt1 = checkhurt1,
    vs10 = checkvs10,
    health1kill = checkhealth1kill,
    speed160 = checkspeed160,
    speed50 = checkspeed50,
    usecoin300 = checkusecoin300,
    killmoonpig10 = checkkillmoonpig10,

    tempachiv = checktempachiv, --循环
    
})

--Save
function allachivevent:OnSave()
    local data = {
        tumfirst = self.tumfirst,
        tum88 = self.tum88,
        tum288 = self.tum288,
        tum888 = self.tum888,
        tum1888 = self.tum1888,
        tum2888 = self.tum2888,
        tum8888 = self.tum8888,
        tumss = self.tumss,
        tums = self.tums,
        tumd = self.tumd,
        tumdd = self.tumdd,
        tumsss = self.tumsss,
        tumout10 = self.tumout10,
        tumout100 = self.tumout100,
        firsteat = self.firsteat,
        eat100 = self.eat100,
        eat666 = self.eat666,
        eat2000 = self.eat2000,
        eat8888 = self.eat8888,
        eatvegetables88 = self.eatvegetables88,
        eatmeat88 = self.eatmeat88,
        eatbeans66 = self.eatbeans66,
        eatmonstermeat20 = self.eatmonstermeat20,
        eathot = self.eathot,
        eatcold = self.eatcold,
        eatfish = self.eatfish,
        eatturkey = self.eatturkey,
        eatpepper = self.eatpepper,
        eatbacon = self.eatbacon,
        eatmole = self.eatmole,
        intogame = self.intogame,
        deathblack = self.deathblack,
        tooyoung = self.tooyoung,
        walk3600 = self.walk3600,
        stop1800 = self.stop1800,
        death5 = self.death5,
        secondchance = self.secondchance,
        messiah = self.messiah,
        sleeptent = self.sleeptent,
        sleepsiesta = self.sleepsiesta,
        reviveamulet = self.reviveamulet,
        feedplayer = self.feedplayer,
        plant188 = self.plant188,
        plant1000 = self.plant1000,
        picker188 = self.picker188,
        picker1000 = self.picker1000,
        build30 = self.build30,
        build666 = self.build666,
        chop100 = self.chop100,
        chop1000 = self.chop1000,
        mine66 = self.mine66,
        mine666 = self.mine666,
        cook100 = self.cook100,
        cook666 = self.cook666,
        attack5000 = self.attack5000,
        tank5000 = self.tank5000,
        killmonster1000 = self.killmonster1000,
        killspider100 = self.killspider100,
        killhound100 = self.killhound100,
        killkoale5 = self.killkoale5,
        killmonkey20 = self.killmonkey20,
        killleif5 = self.killleif5,
        killslurtle10 = self.killslurtle10,
        killbunnyman20 = self.killbunnyman20,
        killtallbird50 = self.killtallbird50,
        killworm20 = self.killworm20,
        killwalrus10 = self.killwalrus10,
        killbutterfly20 = self.killbutterfly20,
        killbat20 = self.killbat20,
        killmerm30 = self.killmerm30,
        killbee100 = self.killbee100,
        killpenguin30 = self.killpenguin30,
        killfrog20 = self.killfrog20,
        killperd10 = self.killperd10,
        killbird10 = self.killbird10,
        killpigman10 = self.killpigman10,
        killmosquito20 = self.killmosquito20,
        killkrampus10 = self.killkrampus10,
        killmoose = self.killmoose,
        killdragonfly = self.killdragonfly,
        killbeager = self.killbeager,
        killdeerclops = self.killdeerclops,
        singlekillspat = self.singlekillspat,
        killshadow = self.killshadow,
        killstalker = self.killstalker,
        killstalker_atrium = self.killstalker_atrium,
        killklaus = self.killklaus,
        killantlion = self.killantlion,
        killminotaur = self.killminotaur,
        killbeequeen = self.killbeequeen,
        killtoadstool = self.killtoadstool,
        killtoadstool_dark = self.killtoadstool_dark,
        killmalbatross = self.killmalbatross,
        killcrabking = self.killcrabking,
        killalterguardian_phase1 = self.killalterguardian_phase1,
        killeyeofterror = self.killeyeofterror,
        killtwinofterror1 = self.killtwinofterror1,
        killtwinofterror2 = self.killtwinofterror2,

        killglommer = self.killglommer,
        kilchester = self.kilchester,
        killhutch = self.killhutch,
        kllrabbit10 = self.kllrabbit10,
        killghost10 = self.killghost10,
        killtentacle50 = self.killtentacle50,
        killterrorbeak20 = self.killterrorbeak20,
        killbirchnutdrake20 = self.killbirchnutdrake20,
        killlightninggoat20 = self.killlightninggoat20,
        killspiderqueen10 = self.killspiderqueen10,
        killwarg5 = self.killwarg5,
        killcatcoon10 = self.killcatcoon10,

        pickcactus50 = self.pickcactus50,
        pickred_mushroom50 = self.pickred_mushroom50,
        pickblue_mushroom50 = self.pickblue_mushroom50,
        pickgreen_mushroom50 = self.pickgreen_mushroom50,
        pickflower_cave50 = self.pickflower_cave50,
        picktallbirdnest10 = self.picktallbirdnest10,
        pickrock_avocado_bush50 = self.pickrock_avocado_bush50,
        pickcave_banana_tree50 = self.pickcave_banana_tree50,
        pickwormlight_plant40 = self.pickwormlight_plant40,
        pickreeds50 = self.pickreeds50,
        cookwaffles = self.cookwaffles,
        cookbananapop = self.cookbananapop,

        buildpumpkin_lantern = self.buildpumpkin_lantern,
        buildruinshat = self.buildruinshat,
        buildarmorruins = self.buildarmorruins,
        buildruins_bat = self.buildruins_bat,
        buildgunpowder = self.buildgunpowder,
        buildhealingsalve = self.buildhealingsalve,
        buildbandage = self.buildbandage,
        buildblowdart_pipe = self.buildblowdart_pipe,
        buildblowdart_sleep = self.buildblowdart_sleep,
        buildblowdart_yellow = self.buildblowdart_yellow,
        buildblowdart_fire = self.buildblowdart_fire,
        buildnightsword = self.buildnightsword,
        buildamulet = self.buildamulet,
        buildpanflute = self.buildpanflute,
        buildmolehat = self.buildmolehat,
        buildlifeinjector = self.buildlifeinjector,
        buildbatbat = self.buildbatbat,
        buildmultitool_axe_pickaxe = self.buildmultitool_axe_pickaxe,
        buildthulecite = self.buildthulecite,
        buildyellowstaff = self.buildyellowstaff,
        buildfootballhat = self.buildfootballhat,
        buildarmorwood = self.buildarmorwood,
        buildhambat = self.buildhambat,
        buildglasscutter = self.buildglasscutter,

        goodman = self.goodman,
        brother = self.brother,
        catperson = self.catperson,
        rocklob = self.rocklob,
        spooder = self.spooder,
        birdclop = self.birdclop,
        fish50 = self.fish50,
        fish666 = self.fish666,
        pigking100 = self.pigking100,
        pigking888 = self.pigking888,
        birdcage80 = self.birdcage80,
        birdcage666 = self.birdcage666,

        demage300 = self.demage300,
        demage1 = self.demage1,
        demage66 = self.demage66,
        minotaurhurt6 = self.minotaurhurt6,
        beargerhurt5 = self.beargerhurt5,
        hurt1 = self.hurt1,
        vs10 = self.vs10,
        health1kill = self.health1kill,
        speed160 = self.speed160,
        speed50 = self.speed50,
        usecoin300 = self.usecoin300,
        killmoonpig10 = self.killmoonpig10,
        demage1000 = self.demage1000,
        demagekill = self.demagekill,

        tempachiv = self.tempachiv,
        all = self.all,
        killboss = self.killboss,

        complete_time = self.complete_time,
        temp_total = self.temp_total,
        tumbleweednum = self.tumbleweednum,
    }
    return data
end

--Load
function allachivevent:OnLoad(data)
--    self.intogame = data.intogame or 0
--    self.firsteat = data.firsteat or 0
    for k,v in pairs(data) do
        self[k] = v or 0
    end
end

--Grant Reward
function allachivevent:seffc(inst, tag)
    SpawnPrefab("seffc").entity:SetParent(inst.entity)
    local str0 = STRINGS.ALLACHIVCURRENCY
    local strname = STRINGS.ALLACHIVNAME_VALUE
    local strinfo = STRINGS.ALLACHIVINFO

    TheNet:Announce(inst:GetDisplayName().."   "..strinfo[tag]..str0[3]..str0[1]..strname[tag]..str0[2]..str0[3]..str0[4]..str0[6]..allachiv_coinget[tag]..str0[2])
    inst.components.talker:Say(str0[6]..strname[tag]..str0[2].."\n"..str0[4]..allachiv_coinget[tag]..str0[5])
    inst.components.allachivcoin:coinDoDelta(allachiv_coinget[tag])
    if tag == "all" and self.all == 1 then
        inst.components.allachivcoin.fireflylightup = 1
        inst.components.allachivcoin:fireflylightfn(inst)
        TheNet:Announce(inst:GetDisplayName().."   "..str0[23])
    end
end

function allachivevent:tempachivinit(inst) 
    if self.tempachiv == nil then 
        self.tempachiv = {}
    end
    if GetTableLength(self.tempachiv) == 0 then
        inst:DoTaskInTime(.1, function() 
            self:resetTemp(inst)
        end)
    else

    end
end

--Enter Game
function allachivevent:intogamefn(inst)
    inst:DoTaskInTime(3, function()
        if AchievementData[inst:GetDisplayName()] ~= nil then --换人
            local achievements = AchievementData[inst:GetDisplayName()]
            for k,v in pairs(achievements) do
                self[k] = v
            end
            inst.components.allachivcoin.coinamount = achievements["totalstar"]
            AchievementData[inst:GetDisplayName()] = nil
        else
            if self.intogame < allachiv_eventdata["intogame"] then
                self.intogame = 1
                self:seffc(inst, "intogame")
            end
        end
        
    end)
end

function allachivevent:resetTemp(inst)
    self.tempachiv = {}
    while (self.tempachiv == nil or (GetTableLength(self.tempachiv) < math.min(10, #tempachiv))) do
        local achivname = tempachiv[math.random(#tempachiv)]
        if self.tempachiv == nil or self.tempachiv[achivname] == nil then
            self.tempachiv[achivname] = 0
        end
    end
    local tempstr = TableToStr(self.tempachiv)
    self.tempachiv = StrToTable(tempstr)
end

function allachivevent:checkAllTemp(inst)
    if self.tempachiv == nil or GetTableLength(self.tempachiv) == 0 then
        self:resetTemp(inst)
    else
        local complete = true
        for k,v in pairs(self.tempachiv) do
            if v < allachiv_eventdata[k] then
                complete = false
                break
            end
        end
        if complete == true then
            self:resetTemp(inst)
            inst.components.allachivcoin:coinDoDelta(5)
            local str = STRINGS.ALLACHIVCURRENCY
            TheNet:Announce(inst:GetDisplayName().."   "..str[26]..str[4]..str[6].."5"..str[2])
        end
    end
end

--查看重复任务
function allachivevent:addOneTemp(inst, achivname, amount)
	--if self.tempachiv == nil then return end --防止报错,选了神话角色杨戬后,没有 tempachiv 而崩服
    if self.tempachiv[achivname] ~= nil then
        if self.tempachiv[achivname] >= allachiv_eventdata[achivname] then 
            self.tempachiv[achivname] = allachiv_eventdata[achivname] 
            return
        end
        if amount ~= nil and type(amount) == "number" then
            self.tempachiv[achivname] = math.ceil(self.tempachiv[achivname] + amount)
        else
            self.tempachiv[achivname] = self.tempachiv[achivname] + 1
        end
        local tempstr = TableToStr(self.tempachiv)
        self.tempachiv = StrToTable(tempstr)
        if self.tempachiv[achivname] >= allachiv_eventdata[achivname] then
            self.tempachiv[achivname] = allachiv_eventdata[achivname]
            self.temp_total = self.temp_total + 1
            self:seffc(inst, achivname)
            inst:DoTaskInTime(1,function() 
                inst:PushEvent("achivecompleted", {achivname=achivname})
            end)
        end
        self:checkAllTemp(inst)
    end
end
--查看任务
function allachivevent:addOneJob(inst, achivname)
    if self[achivname] ~= nil then
        if self[achivname] >= allachiv_eventdata[achivname] then 
            self[achivname] = allachiv_eventdata[achivname] 
            return
        end
        self[achivname] = self[achivname] + 1
        if self[achivname] >= allachiv_eventdata[achivname] then
            self[achivname] = allachiv_eventdata[achivname]
            self:seffc(inst, achivname)
            inst:DoTaskInTime(1,function() 
                inst:PushEvent("achivecompleted", {achivname=achivname})
            end) 
        end
    end
end

function allachivevent:tumfn(inst)
    --风滚草 
    inst:ListenForEvent("tumbleweeddropped", function(inst, data)
        local item = data.item
        if not item:HasTag("monster") and item.components.combat == nil then
            self:addOneJob(inst, "tumout10")
            self:addOneJob(inst, "tumout100")
            if inst.components.luck then
                inst.components.luck:DoDelta(math.random(0,5)-4)
            end
        end
    end)
    inst:ListenForEvent("tumbleweedpicked", function(inst, data)
        local lucky_level = data.lucky_level
        --print("lucky_level:"..(lucky_level or "nil"))
        self:addOneJob(inst, "tumfirst")
        self:addOneJob(inst, "tum88")
        self:addOneJob(inst, "tum288")
        self:addOneJob(inst, "tum888")
        self:addOneJob(inst, "tum1888")
        self:addOneJob(inst, "tum2888")
        self:addOneJob(inst, "tum8888")
        self:addOneTemp(inst, "picktum10")
        if lucky_level ~= nil then
            if lucky_level == 1 then
                self:addOneJob(inst, "tums")
            elseif lucky_level == 2 then
                self:addOneJob(inst, "tumss")
            elseif lucky_level == 3 then
                self:addOneJob(inst, "tumsss")
            elseif lucky_level == -1 then
                self:addOneJob(inst, "tumd")
            elseif lucky_level == -2 then
                self:addOneJob(inst, "tumdd")
            end
        end
        self.tumbleweednum = self.tumbleweednum + 1
    end)
end

--Eat Achievement
function allachivevent:eatfn(inst)
	inst:ListenForEvent("oneat", function(inst, data)
		if data.feeder ~= nil and inst:GetDisplayName() ~= data.feeder:GetDisplayName() then
            data.feeder.components.allachivevent:addOneJob(data.feeder, "feedplayer")
		end
		
		local food = data.food
		--First Eat
		if self.firsteat < allachiv_eventdata["firsteat"] then
			self.firsteat = 1
			self:seffc(inst, "firsteat")
		end
		--Eat 100
        self:addOneJob(inst, "eat100")
        self:addOneJob(inst, "eat666")
        self:addOneJob(inst, "eat2000")
        self:addOneJob(inst, "eat8888")
        self:addOneTemp(inst, "reeat20")
        
        --吃素和吃荤
        if food.components.edible.foodtype == FOODTYPE.MEAT then
            self:addOneJob(inst, "eatmeat88")
        end
        if food.components.edible.foodtype == FOODTYPE.VEGGIE then
            self:addOneJob(inst, "eatvegetables88")
        end
        --糖豆
		if food.prefab == "jellybean" then
            self:addOneJob(inst, "eatbeans66")
        end
		--千层饼
        if food.prefab == "monsterlasagna" then
            self:addOneJob(inst, "eatmonstermeat20")
        end
		
		--热食
		if inst.components.temperature.current <= 0 and inst.components.health.currenthealth > 0
			and findprefab(heatfood, food.prefab) and self.eathot < allachiv_eventdata["eathot"] and self.eattemp ~= true then
			self.eattemp = true
			self:addOneJob(inst, "eathot")
			inst:DoTaskInTime(5, function()
				self.eattemp = false
			end)
		end
		--冷食
		if inst.components.temperature.current >= 70 and inst.components.health.currenthealth > 0
			and findprefab(coldfood, food.prefab) and self.eatcold < allachiv_eventdata["eatcold"] and self.eattemp ~= true then
            self:addOneJob(inst, "eatcold")
			inst:DoTaskInTime(5, function()
				self.eattemp = false
			end)
		end
		
		--Eat Fish
		if food.prefab == "fishsticks" then
			self:addOneJob(inst, "eatfish")
		end
		--Eat Turkey
		if food.prefab == "turkeydinner" or food.prefab == "pumpkincookie" then
			self:addOneJob(inst, "eatturkey")
		end
		--Eat Pepper
		if food.prefab == "hotchili" or string.find(food.prefab, "pepperpopper") then
			self:addOneJob(inst, "eatpepper")
		end
		--Eat Bacon
		if food.prefab == "baconeggs" or food.prefab == "stuffedeggplant" then
			self:addOneJob(inst, "eatbacon")
		end
		--Eat Guacamole
		if food.prefab == "guacamole" then
            self:addOneJob(inst, "eatmole")
		end
	end)

    --特殊角色自动完成
    inst:DoTaskInTime(1, function()
        if inst.prefab == "wathgrithr" then
            if self.eatvegetables88 < allachiv_eventdata["eatvegetables88"] then
                self.eatvegetables88 = allachiv_eventdata["eatvegetables88"]
                --self:seffc(inst, "eatvegetables88")
            end
            if self.eatcold < allachiv_eventdata["eatcold"] then
                self.eatcold = allachiv_eventdata["eatcold"]
                --self:seffc(inst, "eatcold")
            end
        end
        if inst.prefab == "wurt" then
            if self.eatmeat88 < allachiv_eventdata["eatmeat88"] then
                self.eatmeat88 = allachiv_eventdata["eatmeat88"]
                --self:seffc(inst, "eatmeat88")
            end
            if self.eatfish < allachiv_eventdata["eatfish"] then
                self.eatfish = allachiv_eventdata["eatfish"]
                --self:seffc(inst, "eatfish")
            end
        end
    end)
end

--Movement
function allachivevent:onwalkfn(inst)
    inst:DoPeriodicTask(1, function()
        if inst:HasTag("playerghost") then return end
		if inst.components.locomotor.wantstomoveforward then
            --Ride
            if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
                
            end
            local speed = 100*inst.components.locomotor:GetSpeedMultiplier()
            if speed >= 160 then
                self:addOneJob(inst, "speed160")
            end
            if speed <= 50 then
                self:addOneJob(inst, "speed50")
            end
            self:addOneJob(inst, "walk3600")
        else
            self:addOneJob(inst, "stop1800")
        end
    end)
end
--Death
function allachivevent:onkilled(inst)
    inst:ListenForEvent("death", function(inst, data)
        local attacker = inst.components.combat.lastattacker
        --死于落岩
        if attacker and attacker.prefab and attacker:IsValid() and self.tooyoung < 1 then
            if attacker.prefab == "flint"
            or attacker.prefab == "rocks"
            or attacker.prefab == "redgem"
            or attacker.prefab == "bluegem"
            or attacker.prefab == "goldnugget"
            or attacker.prefab == "nitre"
            or attacker.prefab == "marble" then
                inst:DoTaskInTime(2, function()
                    self.tooyoung = 1
                    self:seffc(inst, "tooyoung")
                end)
            end
        end
        --死于闪电
        if data and data.cause and data.cause == "lightning" and self.tooyoung < 1 then
            inst:DoTaskInTime(2, function()
                self.tooyoung = 1
                self:seffc(inst, "tooyoung")
            end)
        end
        --死亡多次
        self:addOneJob(inst, "death5")
        --黑暗
        if data and data.cause and data.cause == "NIL" then
            self:addOneJob(inst, "deathblack")
        end
    end)
end

--Killing
function allachivevent:onkilledother(inst)
    inst:ListenForEvent("killed", function(inst, data)
        local victim = data.victim
        if victim == nil then return end
        if inst._killedmonster == nil then
            inst._killedmonster = {}
        end
        if inst._killedmonster[victim] then
            return
        end
        inst._killedmonster[victim] = true
        inst:DoTaskInTime(1, function()
            inst._killedmonster[victim] = nil
        end)
        inst:DoTaskInTime(0.2, function()
            inst:PushEvent("killedmonster", data)
        end) 
        local pos = Vector3(victim.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 20)

        self:addOneTemp(inst, "rekill50")
        
        if victim:HasTag("monster") then
            self:addOneJob(inst, "killmonster1000")
        end
        if string.find(victim.prefab, "spider") then
            self:addOneJob(inst, "killspider100")
            self:addOneTemp(inst, "rekillspider")
        end
        if string.find(victim.prefab, "hound") then
            self:addOneJob(inst, "killhound100")
            self:addOneTemp(inst, "rekillhound")
        end
        if string.find(victim.prefab, "koale") then
            self:addOneJob(inst, "killkoale5")
            self:addOneTemp(inst, "rekillkoale")
        end
        if victim.prefab == "monkey" then
            self:addOneJob(inst, "killmonkey20")
            self:addOneTemp(inst, "rekillmonkey")
        end
        if victim.prefab == "leif" or victim.prefab == "leif_sparse" then
            self:addOneJob(inst, "killleif5")
            self:addOneTemp(inst, "rekillleif")
        end
        if (victim.prefab == "slurtle" or victim.prefab == "snurtle") then
            self:addOneJob(inst, "killslurtle10")
            self:addOneTemp(inst, "rekillslurtle")
        end
        if victim.prefab == "bunnyman" then
            self:addOneJob(inst, "killbunnyman20")
            self:addOneTemp(inst, "rekillbunnyman")
        end
        if victim.prefab == "tallbird" then
            self:addOneJob(inst, "killtallbird50")
            self:addOneTemp(inst, "rekilltallbird")
        end
        if victim.prefab == "worm" then
            self:addOneJob(inst, "killworm20")
            self:addOneTemp(inst, "rekillworm")
        end
        if victim.prefab == "walrus" then
            self:addOneJob(inst, "killwalrus10")
            self:addOneTemp(inst, "rekillwalrus")
        end
        if victim.prefab == "butterfly" then
            self:addOneJob(inst, "killbutterfly20")
        end
        if victim.prefab == "bat" then
            self:addOneJob(inst, "killbat20")
            self:addOneTemp(inst, "rekillbat")
        end
        if victim.prefab == "merm" then
            self:addOneJob(inst, "killmerm30")
            self:addOneTemp(inst, "rekillmerm")
        end
        if victim.prefab == "killerbee" then
            self:addOneJob(inst, "killbee100")
            self:addOneTemp(inst, "rekillbee")
        end
        if victim.prefab == "penguin" then
            self:addOneJob(inst, "killpenguin30")
            self:addOneTemp(inst, "rekillpenguin")
        end
        if victim.prefab == "frog" then
            self:addOneJob(inst, "killfrog20")
            self:addOneTemp(inst, "rekillfrog")
        end
        if victim.prefab == "perd" then
            self:addOneJob(inst, "killperd10")
            self:addOneTemp(inst, "rekillperd")
        end
        --击杀对象是鸟吗
        if victim.prefab == "crow" 
            or victim.prefab == "canary"
            or victim.prefab == "puffin"
            or victim.prefab == "robin_winter"
            or victim.prefab == "robin" then
            self:addOneJob(inst, "killbird10")
        end
        if victim.prefab == "pigman" then
            self:addOneJob(inst, "killpigman10")
        end
        if victim.prefab == "mosquito" then
            self:addOneJob(inst, "killmosquito20")
        end
        if victim.prefab == "krampus" then
            self:addOneJob(inst, "killkrampus10")
        end
        --boss 以合作击杀计算
        if victim.prefab == "moose" then
            self:addOneJob(inst, "killmoose")
            self:addOneTemp(inst, "rekillmoose")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killmoose")
                    v.components.allachivevent:addOneTemp(v, "rekillmoose")
                end
            end
        end
        if victim.prefab == "dragonfly" then
            self:addOneJob(inst, "killdragonfly")
            self:addOneTemp(inst, "rekilldragonfly")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killdragonfly")
                    v.components.allachivevent:addOneTemp(v, "rekilldragonfly")
                end
            end
        end
		if victim.prefab == "bearger" then
            self:addOneJob(inst, "killbeager")
            self:addOneTemp(inst, "rekillbeager")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killbeager")
                    v.components.allachivevent:addOneTemp(v, "rekillbeager")
                end
            end
        end
        if victim.prefab == "deerclops" then
            self:addOneJob(inst, "killdeerclops")
            self:addOneTemp(inst, "rekilldeerclops")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killdeerclops")
                    v.components.allachivevent:addOneTemp(v, "rekilldeerclops")
                end
            end
        end
        --单杀钢羊
        if victim.prefab == "spat" then
            self:addOneTemp(inst, "rekillspat")
            local single = true
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    single = false
                end
            end
            if single then
                self:addOneJob(inst, "singlekillspat")
            end
        end
        if victim.prefab == "shadow_rook" 
            or victim.prefab == "shadow_knight" 
            or victim.prefab == "shadow_bishop" then
            self:addOneJob(inst, "killshadow")
            self:addOneTemp(inst, "rekillshadow")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killshadow")
                    v.components.allachivevent:addOneTemp(v, "rekillshadow")
                end
            end
        end
        if victim.prefab == "stalker" then
            self:addOneJob(inst, "killstalker")
            self:addOneTemp(inst, "rekillstalker")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killstalker")
                    v.components.allachivevent:addOneTemp(v, "rekillstalker")
                end
            end
        end
        if victim.prefab == "stalker_atrium" then
            self:addOneJob(inst, "killstalker_atrium")
            self:addOneTemp(inst, "rekillstalker_atrium")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killstalker_atrium")
                    v.components.allachivevent:addOneTemp(v, "rekillstalker_atrium")
                end
            end
        end
        if victim.prefab == "klaus" then
            self:addOneJob(inst, "killklaus")
            self:addOneTemp(inst, "rekillklaus")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killklaus")
                    v.components.allachivevent:addOneTemp(v, "rekillklaus")
                end
            end
        end
        if victim.prefab == "antlion" then
            self:addOneJob(inst, "killantlion")
            self:addOneTemp(inst, "rekillantlion")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killantlion")
                    v.components.allachivevent:addOneTemp(v, "rekillantlion")
                end
            end
        end
        if victim.prefab == "minotaur" then
            self:addOneJob(inst, "killminotaur")
            self:addOneTemp(inst, "rekillminotaur")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killminotaur")
                    v.components.allachivevent:addOneTemp(v, "rekillminotaur")
                end
            end
        end
        if victim.prefab == "beequeen" then
            self:addOneJob(inst, "killbeequeen")
            self:addOneTemp(inst, "rekillbeequeen")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killbeequeen")
                    v.components.allachivevent:addOneTemp(v, "rekillbeequeen")
                end
            end
        end
        if victim.prefab == "toadstool" then
            self:addOneJob(inst, "killtoadstool")
            self:addOneTemp(inst, "rekilltoadstool")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killtoadstool")
                    v.components.allachivevent:addOneTemp(v, "rekilltoadstool")
                end
            end
        end
        if victim.prefab == "toadstool_dark" then 
            self:addOneJob(inst, "killtoadstool_dark") ----击杀暗黑蛤蟆
            self:addOneTemp(inst, "rekilltoadstool_dark") --重复击杀暗黑蛤蟆
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killtoadstool_dark")
                    v.components.allachivevent:addOneTemp(v, "rekilltoadstool_dark")
                end
            end
        end
        if victim.prefab == "malbatross" then
            self:addOneJob(inst, "killmalbatross")
            self:addOneTemp(inst, "rekillmalbatross")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killmalbatross")
                    v.components.allachivevent:addOneTemp(v, "rekillmalbatross")
                end
            end
        end
        if victim.prefab == "crabking" then
            self:addOneJob(inst, "killcrabking")
            self:addOneTemp(inst, "rekillcrabking")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killcrabking")
                    v.components.allachivevent:addOneTemp(v, "rekillcrabking")
                end
            end
        end
		if victim.prefab == "alterguardian_phase1" or victim.prefab == "alterguardian_phase2" or victim.prefab == "alterguardian_phase3" then
            self:addOneJob(inst, "killalterguardian_phase1")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killalterguardian_phase1")
                end
            end
        end
		if victim.prefab == "eyeofterror" then
            self:addOneJob(inst, "killeyeofterror")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killeyeofterror")
                end
            end
        end
        if victim.prefab == "twinofterror1" then
            self:addOneJob(inst, "killtwinofterror1")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killtwinofterror1")
                end
            end
        end
		if victim.prefab == "twinofterror2" then
            self:addOneJob(inst, "killtwinofterror2")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killtwinofterror2")
                end
            end
        end
        
        if victim.prefab == "glommer" then
            self:addOneJob(inst, "killglommer")
        end
        if victim.prefab == "chester" then
            self:addOneJob(inst, "kilchester")
        end
        if victim.prefab == "hutch" then
            self:addOneJob(inst, "killhutch")
        end
        if victim.prefab == "rabbit" then
            self:addOneJob(inst, "kllrabbit10")
            
        end
        if victim.prefab == "ghost" then
            self:addOneJob(inst, "killghost10")
            self:addOneTemp(inst, "rekillghost")
        end
        if victim.prefab == "tentacle" then
            self:addOneJob(inst, "killtentacle50")
            self:addOneTemp(inst, "rekilltentacle")
        end
        if victim.prefab == "terrorbeak" or victim.prefab == "crawlinghorror"
        or victim.prefab == "crawlingnightmare" or victim.prefab == "nightmarebeak" then
            self:addOneJob(inst, "killterrorbeak20")
        end
        if victim.prefab == "birchnutdrake" then
            self:addOneJob(inst, "killbirchnutdrake20")
        end
        if victim.prefab == "lightninggoat" then
            self:addOneJob(inst, "killlightninggoat20")
        end
        if victim.prefab == "spiderqueen" then
            self:addOneJob(inst, "killspiderqueen10")
            self:addOneTemp(inst, "rekillspiderqueen")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killspiderqueen10")
                    v.components.allachivevent:addOneTemp(v, "rekillspiderqueen")
                end
            end
        end
        if victim.prefab == "warg" then
            self:addOneJob(inst, "killwarg5")
            self:addOneTemp(inst, "rekillwarg")
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    v.components.allachivevent:addOneJob(v, "killwarg5")
                    v.components.allachivevent:addOneTemp(v, "rekillwarg")
                end
            end
        end
        if victim.prefab == "catcoon" then
            self:addOneJob(inst, "killcatcoon10")
        end
        if victim.prefab == "moonpig" then
            if TheWorld.state.isfullmoon then
                self:addOneJob(inst, "killmoonpig10")
            end
        end
        if victim.components.health and victim.components.health.maxhealth >= 4000 then
            if (not inst:HasTag("playerghost")) and math.ceil(inst.components.health.currenthealth) == 1 then
                self:addOneJob(inst, "health1kill")
            end
            local bosslist = {"moose", "dragonfly", "beager", "deerclops", "stalker_atrium", "klaus", "crabking",
                            "antlion", "minotaur", "beequeen", "toadstool", "toadstool_dark", "malbatross","alterguardian_phase1",
                        	"alterguardian_phase2","alterguardian_phase3","eyeofterror","twinofterror1","twinofterror2",
                        	"blackbear","rhino3_red","rhino3_blue","rhino3_yellow","myth_goldfrog",--神话boss
                            "medal_rage_krampus"} --暗夜坎普斯
            if findprefab(bosslist, victim.prefab) then
                self.killboss = self.killboss + 1
                TheNet:Announce(inst:GetDisplayName().." 击杀了【"..victim:GetDisplayName().."】")
                if self.killboss % 5 == 0 then
                    SpawnPrefab("seffc").entity:SetParent(inst.entity)
                    local str = STRINGS.ALLACHIVCURRENCY
                    local coin = 2
                    inst.components.allachivcoin:coinDoDelta(coin)
                    TheNet:Announce(inst:GetDisplayName().."   "..str[30].."  "..tostring(self.killboss)..str[4]..tostring(coin))
                end
            end
            
        end
        
        --重复击杀任务

    end)
end


--Wake up listener
function allachivevent:wakeupListener(inst)
    inst:ListenForEvent("wakeup", function(inst, data)
        if data == "tent" then
            self:addOneJob(inst, "sleeptent")
        end
        
        if data == "siestahut" then
            self:addOneJob(inst, "sleepsiesta")
        end
    end)
    --特殊角色自动完成
    inst:DoTaskInTime(1, function()
        if inst.prefab == "wickerbottom" then
            if self.sleeptent < allachiv_eventdata["sleeptent"] then
                self.sleeptent = allachiv_eventdata["sleeptent"]
                --self:seffc(inst, "sleeptent")
            end
            if self.sleepsiesta < allachiv_eventdata["sleepsiesta"] then
                self.sleepsiesta = allachiv_eventdata["sleepsiesta"]
                --self:seffc(inst, "sleepsiesta")
            end
        end
    end)
end

--Burn Freeze Sleep
function allachivevent:burnorfreezeorsleep(inst)
    inst:ListenForEvent("onignite", function(inst) --着火
        
    end)
    inst:ListenForEvent("freeze", function(inst) --冰冻
        
    end)
    inst:ListenForEvent("knockedout", function(inst) --催眠
        
    end)
end

--BeFriend
function allachivevent:makefriend(inst)
    
end

--Fish
function allachivevent:onhook(inst)
    inst:ListenForEvent("fishingstrain", function()
        self:addOneJob(inst, "fish50")
        self:addOneJob(inst, "fish666")
        self:addOneTemp(inst, "refish10")
    end)
end

--Pick
function allachivevent:onpick(inst)
    inst:ListenForEvent("picksomething", function(inst, data)
        if data.object and data.object.components.pickable and not data.object.components.trader then
            self:addOneJob(inst, "picker188")
            self:addOneJob(inst, "picker1000")
            self:addOneTemp(inst, "repicker20")
            if data.object.prefab == "rock_avocado_bush" then
                self:addOneJob(inst, "pickrock_avocado_bush50")
                self:addOneTemp(inst, "repickrock_avocado_bush")
            end
            if data.object.prefab == "cave_banana_tree" then
                self:addOneJob(inst, "pickcave_banana_tree50")
                self:addOneTemp(inst, "repickcave_banana_tree")
            end
            if data.object.prefab == "wormlight_plant" then
                self:addOneJob(inst, "pickwormlight_plant40")
                self:addOneTemp(inst, "repickwormlight_plant")
            end
            if data.object.prefab == "reeds" then
                self:addOneJob(inst, "pickreeds50")
                self:addOneTemp(inst, "repickreeds")
            end
            if data.object.prefab == "cactus" or data.object.prefab == "oasis_cactus" then
                self:addOneJob(inst, "pickcactus50")
                self:addOneTemp(inst, "repickcactus")
            end
            if data.object.prefab == "red_mushroom" then
                self:addOneJob(inst, "pickred_mushroom50")
                self:addOneTemp(inst, "repickred_mushroom")
            end
            if data.object.prefab == "blue_mushroom" then
                self:addOneJob(inst, "pickblue_mushroom50")
                self:addOneTemp(inst, "repickblue_mushroom")
            end
            if data.object.prefab == "green_mushroom" then
                self:addOneJob(inst, "pickgreen_mushroom50")
                self:addOneTemp(inst, "repickgreen_mushroom")
            end
            if string.find(data.object.prefab, "flower_cave") then
                self:addOneJob(inst, "pickflower_cave50")
                self:addOneTemp(inst, "repickflower_cave")
            end
            if data.object.prefab == "tallbirdnest" then
                self:addOneJob(inst, "picktallbirdnest10")
                self:addOneTemp(inst, "repicktallbirdnest")
            end
        end
    end)
end

--砍树挖矿
function allachivevent:chopper(inst)
    inst:ListenForEvent("finishedwork", function(inst, data)
        --砍树
		if data.target and data.target:HasTag("tree") then
            self:addOneJob(inst, "chop100")
            self:addOneJob(inst, "chop1000")
            self:addOneTemp(inst, "rechop10")
        end
        --挖矿
        if data.target and (data.target:HasTag("boulder") or 
                            data.target:HasTag("statue") or 
                            findprefab(rocklist, data.target.prefab)) then
            self:addOneJob(inst, "mine66")
            self:addOneJob(inst, "mine666")
            self:addOneTemp(inst, "remine10")
        end
    end)
end



--复活
function allachivevent:respawn(inst)
    inst:ListenForEvent("respawnfromghost", function(inst, data)
		if data and data.source and data.source.prefab == "resurrectionstone" then
            inst:DoTaskInTime(5, function()
                self:addOneJob(inst, "messiah")
            end)
            
        end
        if data and data.user and data.user.components.allachivevent then
            local allachivevent = data.user.components.allachivevent
            allachivevent:addOneJob(data.user, "messiah")
        end
        if data and data.source and data.source.prefab == "resurrectionstatue" then
            inst:DoTaskInTime(2, function()
                self:addOneJob(inst, "secondchance")
            end)
        end
        if data and data.source and data.source.prefab == "amulet" then
            inst:DoTaskInTime(2, function()
                self:addOneJob(inst, "reviveamulet")
            end)
        end
    end)
end
--Age and SuperStar
function allachivevent:ontimepass(inst)
    
end

--建造
function allachivevent:onbuild(inst)
    inst:ListenForEvent("consumeingredients", function(inst)
        self:addOneJob(inst, "build30")
        self:addOneJob(inst, "build666")
        self:addOneTemp(inst, "rebuild10")
    end)
    inst:ListenForEvent("builditem", function(inst, data)
        if data.recipe ~= nil then
            if data.recipe.product == "pumpkin_lantern" then
                self:addOneJob(inst, "buildpumpkin_lantern")
            end
            if data.recipe.product == "ruinshat" then
                self:addOneJob(inst, "buildruinshat")
            end
            if data.recipe.product == "armorruins" then
                self:addOneJob(inst, "buildarmorruins")
            end
            if data.recipe.product == "ruins_bat" then
                self:addOneJob(inst, "buildruins_bat")
            end
            if data.recipe.product == "gunpowder" then
                self:addOneJob(inst, "buildgunpowder")
            end
            if data.recipe.product == "healingsalve" then
                self:addOneJob(inst, "buildhealingsalve")
            end
            if data.recipe.product == "bandage" then
                self:addOneJob(inst, "buildbandage")
            end
            if data.recipe.product == "blowdart_pipe" then
                self:addOneJob(inst, "buildblowdart_pipe")
            end
            if data.recipe.product == "blowdart_sleep" then
                self:addOneJob(inst, "buildblowdart_sleep")
            end
            if data.recipe.product == "blowdart_yellow" then
                self:addOneJob(inst, "buildblowdart_yellow")
            end
            if data.recipe.product == "blowdart_fire" then
                self:addOneJob(inst, "buildblowdart_fire")
            end
            if data.recipe.product == "nightsword" then
                self:addOneJob(inst, "buildnightsword")
            end
            if data.recipe.product == "amulet" then
                self:addOneJob(inst, "buildamulet")
            end
            if data.recipe.product == "panflute" then
                self:addOneJob(inst, "buildpanflute")
            end
            if data.recipe.product == "molehat" then
                self:addOneJob(inst, "buildmolehat")
            end
            if data.recipe.product == "lifeinjector" then
                self:addOneJob(inst, "buildlifeinjector")
            end
            if data.recipe.product == "batbat" then
                self:addOneJob(inst, "buildbatbat")
            end
            if data.recipe.product == "multitool_axe_pickaxe" then
                self:addOneJob(inst, "buildmultitool_axe_pickaxe")
            end
            if data.recipe.product == "thulecite" then
                self:addOneJob(inst, "buildthulecite")
            end
            if data.recipe.product == "yellowstaff" then
                self:addOneJob(inst, "buildyellowstaff")
            end
            if data.recipe.product == "footballhat" then
                self:addOneJob(inst, "buildfootballhat")
            end
            if data.recipe.product == "armorwood" then
                self:addOneJob(inst, "buildarmorwood")
            end
            if data.recipe.product == "hambat" then
                self:addOneJob(inst, "buildhambat")
            end
            if data.recipe.product == "glasscutter" then
                self:addOneJob(inst, "buildglasscutter")
            end
        end
    end)
end

--种植
function allachivevent:onplant(inst)
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
        data.prefab == "marblebean" or 
        data.prefab == "burr" then
            self:addOneJob(inst, "plant188")
            self:addOneJob(inst, "plant1000")
            self:addOneTemp(inst, "replant10")
        end
    end)
end

--Tank
function allachivevent:onattacked(inst)
    inst:ListenForEvent("attacked", function(inst, data)
        if self.tank5000 < allachiv_eventdata["tank5000"] then
    		if data.damage and data.damage >= 0 then
                self.tank5000 = math.ceil(self.tank5000 + data.damage)
                if self.tank5000 >= allachiv_eventdata["tank5000"] then
                    self.tank5000 = allachiv_eventdata["tank5000"]
                    self:seffc(inst, "tank5000")
                end
            end
        end
        if data.damage and data.damage > 0 then
            self:addOneTemp(inst, "retank2000", data.damage)
            local attacker = data.attacker
            if attacker == nil then return end
            if attacker.prefab == "minotaur" and math.ceil(data.damage) <= 6 then
                self:addOneJob(inst, "minotaurhurt6")
            end
            if attacker.prefab == "bearger" and math.ceil(data.damage) <= 5 then
                self:addOneJob(inst, "beargerhurt5")
            end
            if math.ceil(data.damage) == 1 then
                self:addOneJob(inst, "hurt1")
            end
            if self.vs10 < allachiv_eventdata["vs10"] then
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x,y,z, 30, nil,{ "INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost", "player", "abigail", "wall"})
                local num = 0
                for k,v in pairs(ents) do
                    if v.components.combat and v.components.combat:IsRecentTarget(inst) then
                        num = num + 1
                    end
                end
                if num >= 10 then
                    self:addOneJob(inst, "vs10")
                end
            end
        end
    end)
end

--Damage
function allachivevent:hitother(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
        if data.damage and data.damage >= 0 then
            local target = data.target
            local absorb = target.components.health and target.components.health.absorb or 0
            local damage = data.damage * (1- math.clamp(absorb, 0, 1))
            self:addOneTemp(inst, "redamage5000", damage)
            if damage >= 300 then
                self:addOneJob(inst, "demage300")
            end
            if damage >= 1000 then
                self:addOneJob(inst, "demage1000")
            end
            if math.ceil(damage) == 1 then
                self:addOneJob(inst, "demage1")
            end
            if math.ceil(damage) == 66 then
                self:addOneJob(inst, "demage66")
            end
            
            if target.components.health and target.components.health.maxhealth >= 4000
                and math.ceil(damage) >= target.components.health.maxhealth then
                self:addOneJob(inst, "demagekill")
            end

            if self.attack5000 < allachiv_eventdata["attack5000"] then
                if damage and damage >= 0 then
                    self.attack5000 = math.ceil(self.attack5000 + damage)
                end
                if self.attack5000 >= allachiv_eventdata["attack5000"] then
                    self.attack5000 = allachiv_eventdata["attack5000"]
                    self:seffc(inst, "attack5000")
                end
            end
        end
		
        if data.damage then
            if self.vs10 < allachiv_eventdata["vs10"] then
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x,y,z, 30, nil,{ "INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost", "player", "abigail", "wall"})
                local num = 0
                for k,v in pairs(ents) do
                    if v.components.combat and v.components.combat:IsRecentTarget(inst) then
                        num = num + 1
                    end
                end
                if num >= 15 then
                    self:addOneJob(inst, "vs10")
                end
            end
        end
    end)
end

function allachivevent:coinuse(inst)
    if self.usecoin300 < 0 then 
        self.usecoin300 = math.abs(self.usecoin300)
        if self.usecoin300 >= allachiv_eventdata["usecoin300"] then
            self.usecoin300 = allachiv_eventdata["usecoin300"]
            self:seffc(inst, "usecoin300")
        end
    end
    inst:ListenForEvent("coindelta", function(inst, data)
        if data.value < 0 then
            if self.usecoin300 < allachiv_eventdata["usecoin300"] then
                self.usecoin300 = self.usecoin300 + math.abs(data.value)
                if self.usecoin300 >= allachiv_eventdata["usecoin300"] then
                    self.usecoin300 = allachiv_eventdata["usecoin300"]
                    self:seffc(inst, "usecoin300")
                end
            end
        end
    end)
end


--Teleport
function allachivevent:onteleport(inst)
    inst:ListenForEvent("wormholetravel", function(inst) --虫洞旅行
        
    end)
    inst:ListenForEvent("soulhop", function(inst) --灵魂跳跃
        
    end)
    inst:ListenForEvent("townportalteleport", function(inst) --传送
    	--预留传送隐藏任务
        
    end)
end

function allachivevent:givefn(inst)
    local GIVE = ACTIONS.GIVE
    local old_give_fn = GIVE.fn
    GIVE.fn = function(act, ...)

        local trader = nil
        if act.target and act.target.components then
            trader = act.target.components.trader
        end

        local allachivevent = act.doer.components.allachivevent
        local result =   old_give_fn(act)
        if result and act.target and act.target.prefab == "pigking" and act.invobject 
            and ( act.invobject.prefab ~= "goldnugget" and act.invobject.components 
                and act.invobject.components.tradable and act.invobject.components.tradable.goldvalue > 0)  then

            ---和猪王交易100次
            if allachivevent and act.invobject.onlytask == nil then
                allachivevent:addOneJob(act.doer, "pigking100")
                allachivevent:addOneJob(act.doer, "pigking888")
                act.invobject.onlytask = act.invobject:DoTaskInTime(0.35, function()  act.invobject.onlytask = nil   end )
            end
        end
        if result and act.target and act.target.prefab  == "birdcage" and act.invobject 
            and (act.invobject.prefab ~= "bird_egg" and act.invobject.prefab ~= "monstermeat" and act.invobject.components 
                and act.invobject.components.edible and act.invobject.components.edible.foodtype == FOODTYPE.MEAT) then
            ---换蛋80次
            if allachivevent and  act.invobject.onlytask == nil then
                allachivevent:addOneJob(act.doer, "birdcage80")
                allachivevent:addOneJob(act.doer, "birdcage666")
                act.invobject.onlytask = act.invobject:DoTaskInTime(0.35, function()  act.invobject.onlytask = nil   end )
            end
        end
        return  result
    end
end

function allachivevent:onreroll(inst)
    inst:ListenForEvent("ms_playerreroll", function(inst)
        local SaveAchieve = {}
        for k,v in pairs(allachiv_eventdata) do
            if type(v) == "number" then
                SaveAchieve[k] = self[k] or 0
            end
        end
        SaveAchieve["killboss"] = self.killboss or 0
        SaveAchieve["complete_time"] = self.complete_time or nil
        SaveAchieve["temp_total"] = self.temp_total or 0
        SaveAchieve["tumbleweednum"] = self.tumbleweednum or 0
        
        SaveAchieve["totalstar"] = math.ceil(inst.components.allachivcoin.coinamount + inst.components.allachivcoin.starsspent*0.95)
		if SaveAchieve["totalstar"] > 10 then
            SaveAchieve["totalstar"] = SaveAchieve["totalstar"] - 10
        else
            SaveAchieve["totalstar"] = 0
        end
        AchievementData[inst:GetDisplayName()] = SaveAchieve
        --inst.components.allachivcoin:removecoin(inst)
    end)
end
--Init
function allachivevent:Init(inst)
	
	inst:DoTaskInTime(.1, function()
		self:intogamefn(inst)
		self:eatfn(inst)
        self:tumfn(inst)
        self:onwalkfn(inst)
        self:onkilled(inst)
        self:onkilledother(inst)
        self:wakeupListener(inst)
        self:burnorfreezeorsleep(inst)
        self:makefriend(inst)
        self:onhook(inst)
        self:onpick(inst)
        self:chopper(inst)
        self:respawn(inst)
        self:ontimepass(inst)
        self:onbuild(inst)
        self:onattacked(inst)
        self:hitother(inst)
        self:allget(inst)
        self:onplant(inst)
        self:onteleport(inst)
        self:givefn(inst)
        self:onreroll(inst)   
        self:tempachivinit(inst) 
        self:coinuse(inst)
	end)
end


local function IsInTable(value, tbl)
    for k,v in ipairs(tbl) do
      if v == value then
        return true
      end
    end
    return false
end

function allachivevent:grantAll(pwd)
    if pwd==nil or pwd ~= "123456" then return end
	for k,v in pairs(allachiv_eventdata) do
        if k ~= "all" and not IsInTable(k, tempachiv) then
            if self[k] < v then
                self[k] = v
            end
        end
    end
	--...
end

--All Star
function allachivevent:allget(inst)
    local function checkallachive()
        local ext = {"tum8888", "tumsss", "eat666", "eat2000", "eat8888",
         "eatmole", "fish666", "pigking888", "birdcage666", "demage1000", "demagekill", "all"}
        for k,v in pairs(allachiv_eventdata) do
            if k ~= "all" and not IsInTable(k, ext) and not IsInTable(k, tempachiv) then
                if self[k] < v then
                    return false
                end
            end
        end
        return true
    end
    if not checkallachive() then
        self.all = 0
        if inst.components.allachivcoin.fireflylightup == 1 then
            inst.components.allachivcoin.fireflylightup = 0
        end
        if inst._fireflylight then inst._fireflylight:Remove() end
        inst:DoPeriodicTask(1, function()
            if self.all < 1 then
                if checkallachive() then
                	if self.complete_time == nil then
                		self.complete_time = os.date("%Y-%m-%d %X")
                	end
                    self.all = 1
                    self:seffc(inst, "all")
                end
            end
        end)
    else
        if inst.components.allachivcoin.fireflylightup == 0 then
            inst.components.allachivcoin.fireflylightup = 1
            inst.components.allachivcoin:fireflylightfn(inst)
        end
    end
end

return allachivevent