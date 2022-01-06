local RandomWeight = require("random").RandomWeight
local loots = {
    {chance = 0.01, item = "firestaff"},--火焰法杖
    {chance = 0.01, item = "icestaff"},--冰魔杖
    {chance = 0.005, item = "armorruins"},--远古护甲
    {chance = 0.01, item = "telestaff"},--传送魔杖
    {chance = 0.03, item = "tentaclespike"},--狼牙棒
    {chance = 0.03, item = "slurtlehat"},--蜗牛帽
    {chance = 0.03, item = "armorsnurtleshell"},--蜗牛盔甲
    {chance = 0.01, item = "armordragonfly"},--鳞甲
    {chance = 0.01, item = "staff_tornado"},--天气棒
    {chance = 0.01, item = "shieldofterror"},--恐怖盾牌
    {chance = 0.01, item = "eyemaskhat"},--眼面具
    {chance = 0.005, item = "ruins_bat"},--远古棒 
    {chance = 0.1, item = "footballhat"},--橄榄球头盔
    {chance = 0.1, item = "armorwood"},--木甲    
    {chance = 0.1, item = "blowdart_sleep"},--催眠吹箭
    {chance = 0.1, item = "blowdart_fire"},--火焰吹箭       
    {chance = 0.005, item = "hivehat"},--蜂后头冠
    {chance = 0.01, item = "glasscutter"},--玻璃刀
    {chance = 0.01, item = "whip"},--三尾猫鞭
    {chance = 0.01, item = "nightstick"},--晨星
    {chance = 0.01, item = "armor_sanity"},--暗影护甲
    {chance = 0.01, item = "nightsword"},--暗夜剑
    {chance = 0.01, item = "beehat"},--养蜂帽    
    {chance = 0.1, item = "spear"},--长矛    
    -- {chance = 0.1, item = "boomerang"},--回旋镖
    {chance = 0.1, item = "blowdart_pipe"},--吹箭
    {chance = 0.1, item = "blowdart_yellow"},--电箭
    {chance = 0.005, item = "ruinshat"},--远古皇冠
    {chance = 0.03, item = "wathgrithrhat"},--战斗头盔
    {chance = 0.03, item = "spear_wathgrithr"},--战斗长矛
    {chance = 0.01, item = "armormarble"},--大理石甲
    {chance = 0.01, item = "hambat"},--火腿棍
    {chance = 0.03, item = "batbat"},--蝙蝠棒
    {chance = 0.03, item="armor_bramble"},--荆棘甲

}

----------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)


    inst:AddTag("temporary")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem") --库存组件

    MakeHauntableLaunch(inst)

    inst:DoTaskInTime(0,function(inst)
        local items = RandomWeight(loots,1)
        if #items <= 0 then inst:Remove() return end
        local item = items[1].item
        local loot = SpawnPrefab(item)
        if loot == nil then inst:Remove() return end

        local owner = inst.components.inventoryitem.owner
        if owner ~= nil then
            inst.components.inventoryitem:RemoveFromOwner(true) -- 从所有者那里移除
            local container = owner.components.inventory or owner.components.container or nil
            if container ~= nil then
                container:GiveItem(loot)
            end
        else
            loot.Transform:SetPosition(inst.Transform:GetWorldPosition())
            if loot.Physics ~= nil then
                local angle = math.random() * 2 * PI
                loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
            end
        end

        inst:Remove()
    end)
    inst.persists=false -- 退出不保存
    return inst
end

return Prefab("fatemod", fn)