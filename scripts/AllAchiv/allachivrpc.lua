--SendModRPCToServer(MOD_RPC["DSTAchievement"]["healthup"])
--modname的名字不能有中文！！！

AddModRPCHandler("DSTAchievement", "hungerup", function(player)
	player.components.allachivcoin:hungerupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "sanityup", function(player)
	player.components.allachivcoin:sanityupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "healthup", function(player)
	player.components.allachivcoin:healthupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "speedup", function(player)
	player.components.allachivcoin:speedupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "damageup", function(player)
	player.components.allachivcoin:damageupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "absorbup", function(player)
	player.components.allachivcoin:absorbupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "crit", function(player)
	player.components.allachivcoin:critcoin(player)
end)

AddModRPCHandler("DSTAchievement", "lifesteal", function(player)
	player.components.allachivcoin:lifestealupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "nomoist", function(player)
	player.components.allachivcoin:nomoistcoin(player)
end)

AddModRPCHandler("DSTAchievement", "doubledrop", function(player)
	player.components.allachivcoin:doubledropcoin(player)
end)

AddModRPCHandler("DSTAchievement", "fishmaster", function(player)
	player.components.allachivcoin:fishmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "pickmaster", function(player)
	player.components.allachivcoin:pickmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "chopmaster", function(player)
	player.components.allachivcoin:chopmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "cookmaster", function(player)
	player.components.allachivcoin:cookmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "buildmaster", function(player)
	player.components.allachivcoin:buildmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "cheatdeath", function(player)
	player.components.allachivcoin:cheatdeathcoin(player)
end)

AddModRPCHandler("DSTAchievement", "refresh", function(player)
	player.components.allachivcoin:refreshcoin(player)
end)

AddModRPCHandler("DSTAchievement", "icebody", function(player)
	player.components.allachivcoin:icebodycoin(player)
end)

AddModRPCHandler("DSTAchievement", "firebody", function(player)
	player.components.allachivcoin:firebodycoin(player)
end)

AddModRPCHandler("DSTAchievement", "attackback", function(player)
	player.components.allachivcoin:attackbackcoin(player)
end)

AddModRPCHandler("DSTAchievement", "stopregen", function(player)
	player.components.allachivcoin:stopregencoin(player)
end)

AddModRPCHandler("DSTAchievement", "attackfrozen", function(player)
	player.components.allachivcoin:attackfrozencoin(player)
end)

AddModRPCHandler("DSTAchievement", "attackdead", function(player)
	player.components.allachivcoin:attackdeadcoin(player)
end)

AddModRPCHandler("DSTAchievement", "attackbroken", function(player)
	player.components.allachivcoin:attackbrokencoin(player)
end)

AddModRPCHandler("DSTAchievement", "waterwalk", function(player)
	player.components.allachivcoin:waterwalkcoin(player)
end)

AddModRPCHandler("DSTAchievement", "reader", function(player)
	player.components.allachivcoin:readercoin(player)
end)

AddModRPCHandler("DSTAchievement", "minemaster", function(player)
	player.components.allachivcoin:minemastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "fastworker", function(player)
	player.components.allachivcoin:fastworkercoin(player)
end)

AddModRPCHandler("DSTAchievement", "masterchef", function(player)
	player.components.allachivcoin:masterchefcoin(player)
end)

AddModRPCHandler("DSTAchievement", "removecoin", function(player)
	player.components.allachivcoin:removecoin(player)
end)

--商店
AddModRPCHandler("DSTAchievement", "purchase", function(player, prefabname)
	player.components.allachivcoin:getprefabs(player, prefabname)
end)


AddModRPCHandler("DSTAchievement", "saveZoomlevel", function(player, zoomlevel)
	player.components.levelsystem:saveZoomLevel(player, zoomlevel)
end)

--[[AddModRPCHandler("DSTAchievement", "saveWidgetXPos", function(player, xpos)
	player.components.levelsystem:savewidgetXPos(player, xpos)
end)]]

--称号切换
AddModRPCHandler("DSTAchievement", "equiptitle", function(player, id)
	if player and player.components.titlesystem then
		player.components.titlesystem:equiptitle(player, id)
	end
end)




