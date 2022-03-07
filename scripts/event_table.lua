
-- local function spawnAtGround(name, x,y,z)
--     if TheWorld.Map:IsPassableAtPoint(x, y, z) then
--         local item = SpawnPrefab(name)
--         if item then
--             item.Transform:SetPosition(x, y, z)
--             return item
--         end
--     end
-- end

-- -- 圆心x, 圆心y, 半径, 几等分, 对象表, 将要执行的方法
-- local function circular(target,r,num,lsit,fn)
--     if target == nil or lsit == nil or #lsit <= 0 then return end 
--     local x,y,z = target.Transform:GetWorldPosition()
--     for k=1,num do
--         local angle = k * 2 * PI / num
--         local item = spawnAtGround(lsit[math.random(#lsit)], r*math.cos(angle)+x, 0, r*math.sin(angle)+z)
--         if item ~= nil and fn ~= nil and type(fn) == "function" then 
--             fn(item, target, k) 
--         end
--     end 
-- end

local function klaus(item, inst, player) 
    local klaus = SpawnPrefab("klaus")

    local pos = inst:GetPosition()
    local rot = inst.Transform:GetRotation()
    local theta = (rot - 90) * DEGREES
    local offset =
        FindWalkableOffset(pos, theta, klaus.deer_dist, 5, true, false) or
        FindWalkableOffset(pos, theta, klaus.deer_dist * .5, 5, true, false) or
        Vector3(0, 0, 0)

    local deer_red = SpawnPrefab("deer_red")
    deer_red.Transform:SetRotation(rot)
    deer_red.Transform:SetPosition(pos.x + offset.x, 0, pos.z + offset.z)
    deer_red.components.spawnfader:FadeIn()
    klaus.components.commander:AddSoldier(deer_red)


    theta = (rot + 90) * DEGREES
    offset =
        FindWalkableOffset(pos, theta, klaus.deer_dist, 5, true, false) or
        FindWalkableOffset(pos, theta, klaus.deer_dist * .5, 5, true, false) or
        Vector3(0, 0, 0)

    local deer_blue = SpawnPrefab("deer_blue")
    deer_blue.Transform:SetRotation(rot)
    deer_blue.Transform:SetPosition(pos.x + offset.x, 0, pos.z + offset.z)
    deer_blue.components.spawnfader:FadeIn()
    klaus.components.commander:AddSoldier(deer_blue)	

    klaus.Transform:SetPosition(pos.x, 0, pos.z)
	klaus.components.knownlocations:RememberLocation("spawnpoint", inst:GetPosition(), false) -- 重新记住位置
	klaus.components.spawnfader:FadeIn() -- 渐入效果

    if klaus.components.combat ~= nil and player ~= nil then
        klaus.components.combat:SuggestTarget(player)
    end    
end

local function getplayer(inst, player)
    inst:DoTaskInTime(180,function(inst) inst:Remove() end)
end

return {
	klaus = klaus, -- 钓到克劳斯
    getplayer = getplayer, --钓起个角色
}