local function RandomWeight(weight_table, expect_val, fn, ...)
	local totalchance = 0
	local number = expect_val
	local result = {}

    for m, n in ipairs(weight_table) do
        totalchance = totalchance + n.chance
    end

    while number > 0 do
	    local next_chance = math.random()*totalchance
	    local next = nil
	    for m, n in ipairs(weight_table) do
	        next_chance = next_chance - n.chance
	        if next_chance <= 0 then
	            next = n
	            break
	        end
	    end
	    if next ~= nil then
	        table.insert(result, next)
	        number = number - 1
	    end
	end

	if fn ~= nil then
		return fn(result, ...)
	end

	return result
end


return {
	RandomWeight = RandomWeight,
}