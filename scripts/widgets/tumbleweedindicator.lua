-- Based entirely on Klei's playerindicator.lua

local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text"

local ARROW_OFFSET = 65

local TOP_EDGE_BUFFER = 20
local BOTTOM_EDGE_BUFFER = 40
local LEFT_EDGE_BUFFER = 67
local RIGHT_EDGE_BUFFER = 80

local MIN_SCALE = .5
local MIN_ALPHA = .35

local MIN_INDICATOR_RANGE = 20 --最小指示灯范围
local MAX_INDICATOR_RANGE = 60 --最大指示灯范围

local function CancelIndicator(inst) --取消指示器
    inst.startindicatortask:Cancel()
    inst.startindicatortask = nil
    inst.OnRemoveEntity = nil
end

local function StartIndicator(target, self)--启动指示器
    self.inst.startindicatortask = nil
    self.inst.OnRemoveEntity = nil
    -- self.colour = BOSS_COLOURS[target.prefab]
    self:StartUpdating()  --开始更新
    self:OnUpdate()
    self:Show()  --显示
end

local TumbleweedIndicator = Class(Widget, function(self, owner, target, colour)  --自己 ，玩家 ，目标 ，颜色
    Widget._ctor(self, "TumbleweedIndicator") --实现父类构造
    self.owner = owner
    self.isFE = false
    self:SetClickable(true) --设置可点击 

    self.root = self:AddChild(Widget("root"))   --这个函数会将传递进来的对象设置成执行这个函数的对象

    self.icon = self.root:AddChild(Widget("target")) --偶像

    self.target = target --目标
    self.colour = colour --颜色

    self.icon:SetScale(.8)  --设置比例

    self.arrow = self.root:AddChild(Image("images/ui.xml", "scroll_arrow.tex")) --箭头,官方的吧
    self.arrow:SetScale(.5)

    self.name = target.name
    self.name_label = self.icon:AddChild(Text(UIFONT, 45, self.name))  --标签
    self.name_label:SetPosition(0, 40, 0)
    self.name_label:Hide()--隐藏

    self:Hide()
    self.inst.startindicatortask = target:DoTaskInTime(0, StartIndicator, self) --启动指示灯任务
    self.inst.OnRemoveEntity = CancelIndicator
end)

function TumbleweedIndicator:OnGainFocus() --聚焦
    TumbleweedIndicator._base.OnGainFocus(self) --父类方法
    self.name_label:Show()  --显示
end

function TumbleweedIndicator:OnLoseFocus() --失去注意力
    TumbleweedIndicator._base.OnLoseFocus(self) 
    self.name_label:Hide() --隐藏
end

function TumbleweedIndicator:GetTarget() --获取目标
    return self.target
end

function TumbleweedIndicator:GetTumbleweedIndicatorAlpha(dist) --alpha通道,透明通道
    if dist > TUNING.MAX_INDICATOR_RANGE*2 then  --超过最大指示器距离的两倍,120
        dist = TUNING.MAX_INDICATOR_RANGE*2
    end
                                -- 0-120 ,60 ,120 ,1 , 0.35  (i, a, b, x, y) --> (((i - a)/(b - a)) * (y - x)) + x
    local alpha = Remap(dist, TUNING.MAX_INDICATOR_RANGE, TUNING.MAX_INDICATOR_RANGE*2, 1, MIN_ALPHA)
    if dist <= TUNING.MAX_INDICATOR_RANGE then
        alpha = 1
    end
    return alpha
end

function TumbleweedIndicator:OnUpdate()
    -- figure out how far away they are and scale accordingly
    -- then grab the new position of the target and update the HUD elt's pos accordingly
    --找出它们的距离并相应地缩放
    --然后获取目标的新位置并相应地更新HUD elt的位置
    -- kill on this is rough: it just pops in/out. would be nice if it faded in/out...
	
	if not self.target:IsValid() then return end

    local dist = self.owner:GetDistanceSqToInst(self.target) --获取玩家与目标的距离的平方
    dist = math.sqrt(dist) --平方根

    local alpha = self:GetTumbleweedIndicatorAlpha(dist) 
    --self.headbg:SetTint(1, 1, 1, alpha)
    --self.head:SetTint(1, 1, 1, alpha) --设置色调
    --self.headframe:SetTint(self.colour[1], self.colour[2], self.colour[3], alpha)
    self.arrow:SetTint(self.colour[1], self.colour[2], self.colour[3], alpha)
    self.name_label:SetColour(self.colour[1], self.colour[2], self.colour[3], alpha) --设置颜色

    if dist < MIN_INDICATOR_RANGE then
        dist = MIN_INDICATOR_RANGE
    elseif dist > MAX_INDICATOR_RANGE then
        dist = MAX_INDICATOR_RANGE
    end
    local scale = Remap(dist, MIN_INDICATOR_RANGE, MAX_INDICATOR_RANGE, 1, MIN_SCALE)
    self:SetScale(scale) --设置比例

    local x, y, z = self.target.Transform:GetWorldPosition()
    self:UpdatePosition(x, z) --更新位置
end

local function GetXCoord(angle, width)  --获取x坐标 (角,宽度)
    if angle >= 90 and angle <= 180 then -- left side
        return 0
    elseif angle <= 0 and angle >= -90 then -- right side
        return width
    else -- middle somewhere
        if angle < 0 then
            angle = -angle - 90
        end
        local pctX = 1 - (angle / 90)
        return pctX * width
    end
end

local function GetYCoord(angle, height)
    if angle <= -90 and angle >= -180 then -- top side
        return height
    elseif angle >= 0 and angle <= 90 then -- bottom side
        return 0
    else -- middle somewhere
        if angle < 0 then
            angle = -angle
        end
        if angle > 90 then
            angle = angle - 90
        end
        local pctY = (angle / 90)
        return pctY * height
    end
end

function TumbleweedIndicator:UpdatePosition(targX, targZ)  --更新位置
    local angleToTarget = self.owner:GetAngleToPoint(targX, 0, targZ) --获取玩家指向点的角度
    local downVector = TheCamera:GetDownVec() --照相机:下向量
    local downAngle = -math.atan2(downVector.z, downVector.x) / DEGREES  --下倾角
    local indicatorAngle = (angleToTarget - downAngle) + 45  --指示器角度
    while indicatorAngle > 180 do indicatorAngle = indicatorAngle - 360 end
    while indicatorAngle < -180 do indicatorAngle = indicatorAngle + 360 end

    local scale = self:GetScale() --获取比例
    local w = 0
    local h = 0
    local w0, h0 = 16, 16 --self.head:GetSize()
    local w1, h1 = self.arrow:GetSize()  --获取箭头大小
    if w0 and w1 then
        w = (w0 + w1)
    end
    if h0 and h1 then
        h = (h0 + h1)
    end

    local screenWidth, screenHeight = TheSim:GetScreenSize()  --当前设备:获取屏幕大小

    local x = GetXCoord(indicatorAngle, screenWidth)
    local y = GetYCoord(indicatorAngle, screenHeight)

    if x <= LEFT_EDGE_BUFFER + (.5 * w * scale.x) then 
        x = LEFT_EDGE_BUFFER + (.5 * w * scale.x)
    elseif x >= screenWidth - RIGHT_EDGE_BUFFER - (.5 * w * scale.x) then
        x = screenWidth - RIGHT_EDGE_BUFFER - (.5 * w * scale.x)
    end

    if y <= BOTTOM_EDGE_BUFFER + (.5 * h * scale.y) then 
        y = BOTTOM_EDGE_BUFFER + (.5 * h * scale.y)
    elseif y >= screenHeight - TOP_EDGE_BUFFER - (.5 * h * scale.y) then
        y = screenHeight - TOP_EDGE_BUFFER - (.5 * h * scale.y)
    end

    self:SetPosition(x,y,0) --设置位置
    self.x = x
    self.y = y
    self.angle = indicatorAngle --指示器角度
    self:PositionArrow() --箭头位置
    self:PositionLabel() --标签位置
end

function TumbleweedIndicator:PositionArrow()  --更新箭头位置
    if not self.x and self.y and self.angle then return end

    local angle = self.angle + 45
    self.arrow:SetRotation(angle)
    local x = math.cos(angle*DEGREES) * ARROW_OFFSET
    local y = -(math.sin(angle*DEGREES) * ARROW_OFFSET)
    self.arrow:SetPosition(x, y, 0)
end

function TumbleweedIndicator:PositionLabel() --更新标签位置
    if not self.x and self.y and self.angle then return end

    local angle = self.angle + 45 - 180
    local x = math.cos(angle*DEGREES) * ARROW_OFFSET * 1.75
    local y = -(math.sin(angle*DEGREES) * ARROW_OFFSET  * 1.25)
    self.name_label:SetPosition(x, y, 0)
end

return TumbleweedIndicator