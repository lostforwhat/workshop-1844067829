AddModRPCHandler("DSTAchievement", "skills", function(player, skillname, data)
	if player and player.components.allachivcoin then
		player.components.allachivcoin:skillfn(player, skillname, data)
	end
end)