local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local AnimButton = require "widgets/animbutton"
local HoverText = require "widgets/hoverer"
local TextButton = require "widgets/textbutton"

require "AllAchiv/allachivbalance"

local function StrToTable(str)
    if str == nil or type(str) ~= "string" then
        return
    end
    
    return loadstring("return " .. str)()
end

local uiachievement = Class(Widget, function(self, owner)
	Widget._ctor(self, "uiachievement")
	self.owner = owner
	self.mainui = self:AddChild(Widget("mainui"))
	
	self.mainui.achievement_bg = self.mainui:AddChild(Image("images/hud/background.xml", "background.tex"))
	self.mainui.achievement_bg:SetPosition(-5, 40, 0)
	self.mainui.achievement_bg:SetScale(1.05,1.1,1)
	self.mainui.achievement_bg:MoveToFront()
	self.mainui.achievement_bg:Hide()
	
	self.mainui.achievement_bg.title = self.mainui.achievement_bg:AddChild(Text(TITLEFONT, 64))
	self.mainui.achievement_bg.title:SetPosition(-50, 415, 0)
	self.mainui.achievement_bg.title:SetString(STRINGS.GUI["achievementTitle"])
	
	self.mainui.achievement_bg.coinamount = self.mainui.achievement_bg:AddChild(Text(NUMBERFONT, 45, self.owner.currentcoinamount:value()))
	self.mainui.achievement_bg.coinamount:SetPosition(55, 415, 0)
	
	self.mainui.achievement_bg.star = self.mainui.achievement_bg:AddChild(ImageButton("images/hud/star.xml", "star.tex"))
	self.mainui.achievement_bg.star:SetPosition(90, 415, 0)
	self.mainui.achievement_bg.star:SetScale(.5,.5,1)

	self.cooldown = true
	self.mainui.achievement_bg.star:SetOnClick(function() 
		if TheInput:IsKeyDown(KEY_ALT) and TheInput:IsKeyDown(KEY_SHIFT) then
			if self.cooldown then
				if not self.mainui.allcoin.shown then
					TheNet:Say(STRINGS.ALLACHIVCURRENCY[24].."["..self.achivcomplete.."/"..self.allnum.."]", false)
				else 
					TheNet:Say(STRINGS.ALLACHIVCURRENCY[10]..self.owner.currentcoinamount:value()..STRINGS.ALLACHIVCURRENCY[21], false)
				end
				self.cooldown = false
				self.owner:DoTaskInTime(3, function() self.cooldown = true end)
			end
		end
	end)
	
	self.mainui.levelbg = self.mainui:AddChild(Image("images/hud/background.xml", "background.tex"))
	self.mainui.levelbg:SetPosition(-5, 40, 0)
	self.mainui.levelbg:SetScale(1.05,1.1,1)
	self.mainui.levelbg:MoveToFront()
	self.mainui.levelbg:Hide()
	
	self.mainui.levelbg.title = self.mainui.levelbg:AddChild(Text(TITLEFONT, 64))
	self.mainui.levelbg.title:SetPosition(0, 420, 0)
	self.mainui.levelbg.title:SetString(STRINGS.GUI["levelTitle"])
	
	self.mainui.achievement_bg.close = self.mainui.achievement_bg:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.achievement_bg.close:SetPosition(0, -355, 0)
	self.mainui.achievement_bg.close:SetScale(1,0.9,1)
	self.mainui.achievement_bg.close:SetOnClick(function()
		self.mainui.allachiv:Hide()
		self.mainui.allcoin:Hide()
		--self.mainui.bigtitle:Hide()
		self.mainui.achievement_bg:Hide()
		self.mainui.infobutton:Hide()
		self.mainui.perk_cat:Hide()
	end)
	self.mainui.achievement_bg.close.label = self.mainui.achievement_bg.close:AddChild(Text(BUTTONFONT, 45))
	--self.mainui.achievement_bg.close.label:SetString(STRINGS.GUI["close"])
	self.mainui.achievement_bg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	--self.mainui.achievement_bg.close.label:SetColour(0,0,0,1)
	
	self.mainui.allachiv = self.mainui:AddChild(Widget("allachiv"))
	self.mainui.allachiv:SetPosition(0, 460, 0)
	self.mainui.allachiv:Hide()
	
	self.mainui.allcoin = self.mainui:AddChild(Widget("allcoin"))
	self.mainui.allcoin:SetPosition(0, 460, 0)
	self.mainui.allcoin:Hide()
	
	self.mainui.achievement_bg.reset = self.mainui.achievement_bg:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.achievement_bg.reset:SetPosition(365, -355, 0)
	self.mainui.achievement_bg.reset:SetScale(1.1,0.75,1)
	self.mainui.achievement_bg.reset:SetOnClick(function()
		self.mainui.removeinfo:Show()
		self.mainui.removeinfo:MoveToFront()
	end)
	self.mainui.achievement_bg.reset.label = self.mainui.achievement_bg.reset:AddChild(Text(BUTTONFONT, 35))
	--self.mainui.achievement_bg.reset.label:SetString(STRINGS.GUI["reset"])
	self.mainui.achievement_bg.reset.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 100, 50, "", true)
	--self.mainui.achievement_bg.reset.label:SetColour(0,0,0,1)

	self.mainui.removeinfo = self.mainui:AddChild(Image("images/hud/reset_info.xml", "reset_info.tex"))
	self.mainui.removeinfo:SetPosition(0, -80, 0)
	self.mainui.removeinfo:SetScale(1.3,1.3,1)
	self.mainui.removeinfo:Hide()
	self.mainui.removeinfo.label = self.mainui.removeinfo:AddChild(Text(BODYTEXTFONT, 28))
	self.mainui.removeinfo.label:SetPosition(0, 30, 0)
	--self.mainui.removeinfo.label:SetRegionSize(400,100)
	self.mainui.removeinfo.label:SetMultilineTruncatedString(STRINGS.GUI["resetAchievments"], 5, 500, 500, "", true)
	--self.mainui.removeinfo.label:SetRegionSize(400,100)
	--self.mainui.removeinfo.label:SetString(STRINGS.GUI["resetAchievments"])

	self.mainui.removeinfo.removeyes = self.mainui.removeinfo:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.removeinfo.removeyes:SetPosition(-50, -60, 0)
	self.mainui.removeinfo.removeyes:SetNormalScale(0.6,0.5,1)
	self.mainui.removeinfo.removeyes:SetFocusScale(0.7,0.6,1)
	self.mainui.removeinfo.removeyes:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["removecoin"])
		self.owner:DoTaskInTime(.35, function()
			self:loadcoinlist()
			self:perk_build()
		end)
		self.mainui.removeinfo:Hide()
		self.mainui.allcoin:Hide()
		self.mainui.achievement_bg:Hide()
		self.mainui.infobutton:Hide()
		self.mainui.allachiv:Hide()
		self.mainui.perk_cat:Hide()
	end)
	self.mainui.removeinfo.removeyes.label = self.mainui.removeinfo.removeyes:AddChild(Text(BUTTONFONT, 27))
	self.mainui.removeinfo.removeyes.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 70, 50, "", true)
	--self.mainui.removeinfo.removeyes.label:SetString(STRINGS.GUI["reset"])
	--self.mainui.removeinfo.removeyes.label:SetColour(0,0,0,1)
	self.mainui.removeinfo.removeyes.label:SetScale(1,0.8,1)

	self.mainui.removeinfo.removeno = self.mainui.removeinfo:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.removeinfo.removeno:SetPosition(70, -60, 0)
	self.mainui.removeinfo.removeno:SetNormalScale(0.6,0.5,1)
	self.mainui.removeinfo.removeno:SetFocusScale(0.7,0.6,1)
	self.mainui.removeinfo.removeno:SetOnClick(function()
		self.mainui.removeinfo:Hide()
	end)
	self.mainui.removeinfo.removeno.label = self.mainui.removeinfo.removeno:AddChild(Text(BUTTONFONT, 27))
	--self.mainui.removeinfo.removeno.label:SetString("Close")
	self.mainui.removeinfo.removeno.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 70, 50, "", true)
	--self.mainui.removeinfo.removeno.label:SetColour(0,0,0,1)
	self.mainui.removeinfo.removeno.label:SetScale(1,0.8,1)
	
	self.mainbutton = self:AddChild(Widget("mainbutton"))
	self.mainbutton:SetHAnchor(ANCHOR_LEFT) 
	self.mainbutton:SetVAnchor(ANCHOR_TOP)

	local dragging = false
	self.mainbutton.OnMouseButton = function(inst, button, down, x, y)
		
		if button == 1001 then
			if down then
				dragging = true
				local mousepos = TheInput:GetScreenPosition()
				self.dragPosDiff = self.mainbutton:GetPosition() - mousepos
			else
				dragging = false
			end
		end	
	end
	
	--[[self.followhandler = TheInput:AddMoveHandler(function(x,y)
		if dragging then
			local initialPosition = self.mainbutton:GetPosition()
			local w,h = self.mainbutton.bg:GetSize()
			local margin = 20
			local threshold = h*self.mainbutton.bg:GetScale().y
			local screenw_full, screenh_full = _G.unpack({_G.TheSim:GetScreenSize()})
			if y < screenh_full-threshold-margin then dragging = false end
			local pos
			if type(x) == "number" then
				pos = Vector3(x, y, 1)
			else
				pos = x
			end
			--self.mainbutton:SetPosition(pos.x + self.dragPosDiff.x, initialPosition.y, initialPosition.z)
			--self.menuposition = self.mainbutton:GetPosition()
			SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveWidgetXPos"],pos.x + self.dragPosDiff.x)
		end
	end)
	
	self.mainbutton.bg = self.mainbutton:AddChild(Image("images/button/mainbutton_bg.xml", "mainbutton_bg.tex"))
	self.mainbutton.bg:MoveToFront()
	self.mainbutton.bg:SetClickable(true)
	self.mainbutton.bg:SetHRegPoint(ANCHOR_LEFT)
	self.mainbutton.bg:SetVRegPoint(ANCHOR_TOP)
	self.mainbutton.bg:SetScale(0.60,0.60,1)
	]]--
	--新增称号系统
	self.mainui.title = self.mainui:AddChild(Image("images/hud/background.xml", "background.tex"))
	self.mainui.title:SetPosition(-5, 40, 0)
	self.mainui.title:SetScale(1.05,1.1,1)
	self.mainui.title:MoveToFront()
	self.mainui.title:Hide()
	
	self.mainui.title.title = self.mainui.title:AddChild(Text(TITLEFONT, 64))
	self.mainui.title.title:SetPosition(0, 420, 0)
	self.mainui.title.title:SetString(STRINGS.GUI["titlesystem"])
	self.mainui.title.close = self.mainui.title:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.title.close:SetPosition(0, -422, 0)
	self.mainui.title.close:SetScale(0.8,0.7,1)
	self.mainui.title.close:SetOnClick(function()
		self.mainui.allachiv:Hide()
		self.mainui.allcoin:Hide()
		self.mainui.levelbg:Hide()
		self.mainui.achievement_bg:Hide()
		self.mainui.infobutton:Hide()
		self.mainui.perk_cat:Hide()
		self.mainui.title:Hide()
	end)
	self.mainui.title.close.label = self.mainui.title.close:AddChild(Text(BUTTONFONT, 45))
	self.mainui.title.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)

	self.mainbutton.titlebadge = self.mainbutton:AddChild(ImageButton("images/hud/title.xml", "title.tex"))
	self.mainbutton.titlebadge:MoveToFront()
    self.mainbutton.titlebadge:SetHoverText(STRINGS.ALLACHIVCURRENCY[29],{ size = 9, offset_x = 40, offset_y = -45, colour = {1,1,1,1}})
	self.mainbutton.titlebadge:SetScale(0.50,0.50,1)
	self.mainbutton.titlebadge:SetPosition(115, -23, 0)
	
	self.mainbutton.titlebadge:SetOnClick(function()
		if self.mainui.title.shown then
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Hide()
		else
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.allachiv:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Show()
		end
	end)

	--等级系统
	self.mainbutton.levelbadge = self.mainbutton:AddChild(ImageButton("images/hud/levelbadge.xml", "levelbadge.tex"))
    self.mainbutton.levelbadge:MoveToFront()
    self.mainbutton.levelbadge:SetHoverText(STRINGS.ALLACHIVCURRENCY[25],{ size = 9, offset_x = 90, offset_y = -45, colour = {1,1,1,1}})
	self.mainbutton.levelbadge:SetScale(0.60,0.60,1)
	--self.mainbutton.levelbadge:SetFocusScale(0.27,0.27,1)
	self.mainbutton.levelbadge:SetPosition(155, -23, 0)
	
	self.mainbutton.levelbadge:SetOnClick(function()
		if self.mainui.levelbg.shown then
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Hide()
		else
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.allachiv:Hide()
			self.mainui.title:Hide()
			self.mainui.levelbg:Show()
		end
	end)
	
	self.mainbutton.level = self.mainbutton.levelbadge:AddChild(Text(BODYTEXTFONT, 45))
	self.mainbutton.level:SetPosition(3, 0, 0)
	self.mainbutton.level:SetHAlign(ANCHOR_MIDDLE)
	

    self.mainbutton.checkbutton = self.mainbutton:AddChild(ImageButton("images/button/checkbutton.xml", "checkbutton.tex"))
    self.mainbutton.checkbutton:MoveToFront()
    self.mainbutton.checkbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -45, colour = {1,1,1,1}})
	self.mainbutton.checkbutton:SetScale(0.5,0.5,1)
	self.mainbutton.checkbutton:SetPosition(35, -23, 0)

	self.mainbutton.checkbutton:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.mainui.allachiv:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Hide()
			self.mainui.achievement_bg.reset:Hide()
		else
			self.mainui.allachiv:Show()
			self.mainui.achievement_bg.reset:Hide()
			self.mainui.achievement_bg:Show()
			self.mainui.infobutton:Show()
			self.mainui.perk_cat:Hide()
			self.mainui.allcoin:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Hide()
		end
		self.maxnumpage = 15
		self:setAllAchivCategoriesActive()
		
		local pagenum = self.numpage or 1
		if pagenum then
			self.mainui.infobutton["cat" .. pagenum]:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
		end
	end)

    self.mainbutton.coinbutton = self.mainbutton:AddChild(ImageButton("images/button/coinbutton.xml", "coinbutton.tex"))
    self.mainbutton.coinbutton:MoveToFront()
	self.mainbutton.coinbutton:SetPosition(75, -23, 0)
    self.mainbutton.coinbutton:SetScale(0.5,0.5,1)
    self.mainbutton.coinbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[8],{ size = 9, offset_x = 15, offset_y = -45, colour = {1,1,1,1}})

	self.mainbutton.coinbutton:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg.reset:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.title:Hide()
		else
			self.mainui.allcoin:Show()
			self.mainui.achievement_bg.reset:Show()
			self.mainui.achievement_bg:Show()
			self.mainui.perk_cat:Show()
			self.mainui.infobutton:Hide()
			self.mainui.allachiv:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Hide()
		end
		if self.perkpage == 1 then
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
		else
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
		if self.perkpage == 2 then
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
		else
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
		if self.perkpage == 3 then
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
		else
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
		if self.perkpage == 4 then
			self.mainui.perk_cat.perkcat4:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
		else
			self.mainui.perk_cat.perkcat4:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
	end)


	self.size = self.owner.currentzoomlevel:value() or 1
	self.mainui:SetScale(self.size, self.size, 1)
	self.mainbutton.configbigger = self.mainbutton:AddChild(ImageButton("images/button/config_bigger.xml", "config_bigger.tex"))
	self.mainbutton.configbigger:SetPosition(195, -27, 0)
--	self.mainbutton.configbigger:Hide()
	self.mainbutton.configbigger:SetNormalScale(0.5,0.5,1)
	self.mainbutton.configbigger:SetFocusScale(0.6,0.6,1)
	self.mainbutton.configbigger:SetHoverText(STRINGS.ALLACHIVCURRENCY[16],{ size = 9, offset_x = 0, offset_y = -45, colour = {1,1,1,1}})
	self.mainbutton.configbigger:SetOnClick(function()
		if not self.mainui.allachiv.shown and not self.mainui.allcoin.shown and not self.mainui.levelbg.shown and not self.mainui.title.shown then
			self.mainui.allachiv:Show()
			self.mainui.achievement_bg:Show()
			self.mainui.infobutton:Show()
		end
		self.size = self.size + .02
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveZoomlevel"], self.size)
	end)

	self.mainbutton.configsmaller = self.mainbutton:AddChild(ImageButton("images/button/config_smaller.xml", "config_smaller.tex"))
	self.mainbutton.configsmaller:SetPosition(225, -27, 0)
--	self.mainbutton.configsmaller:Hide()
	self.mainbutton.configsmaller:SetNormalScale(0.5,0.5,1)
	self.mainbutton.configsmaller:SetFocusScale(0.6,0.6,1)
	self.mainbutton.configsmaller:SetHoverText(STRINGS.ALLACHIVCURRENCY[17],{ size = 9, offset_x = 0, offset_y = -45, colour = {1,1,1,1}})
	self.mainbutton.configsmaller:SetOnClick(function()
		if not self.mainui.allachiv.shown and not self.mainui.allcoin.shown and not self.mainui.levelbg.shown and not self.mainui.title.shown then
			self.mainui.allachiv:Show()
			self.mainui.achievement_bg:Show()
			self.mainui.infobutton:Show()
		end
		if self.size > 0.02 then
			self.size = self.size - .02
		end
		--self.mainui:SetScale(self.size, self.size, 1)
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveZoomlevel"],self.size)
	end)
	
	self.mainbutton.worldinfo = self.mainbutton:AddChild(Text(BODYTEXTFONT, 30))
	--self.mainbutton.worldinfo:SetMultilineTruncatedString(STRINGS.ALLACHIVCURRENCY[28]..TheShard:GetShardId(), 2, 120, 50, "", true)
	self.mainbutton.worldinfo:SetPosition(255,-24,0)
	self.mainbutton.worldinfo:SetColour(0.8,0.15,0.21,1)

	--email
	self.mainui.email = self.mainui:AddChild(Image("images/hud/reset_info.xml", "reset_info.tex"))
	self.mainui.email:SetPosition(0, 400, 0)
	self.mainui.email:SetScale(1.5,1.5,1)
	self.mainui.email:Hide()
	self.mainui.email.label = self.mainui.email:AddChild(Text(BODYTEXTFONT, 28))
	self.mainui.email.label:SetPosition(0, 30, 0)

	
	self.mainui.email.label:SetMultilineTruncatedString("", 5, 500, 500, "", true)

	self.mainui.email.btn = self.mainui.email:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.email.btn:SetPosition(0, -60, 0)
	self.mainui.email.btn:SetNormalScale(0.6,0.5,1)
	self.mainui.email.btn:SetFocusScale(0.7,0.6,1)
	self.mainui.email.btn:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["skills"], "email")
		self.mainui.email:Hide()
	end)
	self.mainui.email.btn.label = self.mainui.email.btn:AddChild(Text(BUTTONFONT, 27))
	self.mainui.email.btn.label:SetMultilineTruncatedString(STRINGS.GUI["recieve"], 2, 70, 50, "", true)
	--self.mainui.removeinfo.removeyes.label:SetString(STRINGS.GUI["reset"])
	--self.mainui.removeinfo.removeyes.label:SetColour(0,0,0,1)
	self.mainui.email.btn.label:SetScale(1,0.8,1)

	self.mainbutton.email = self.mainbutton:AddChild(ImageButton("images/hud/email.xml", "email.tex"))
	self.mainbutton.email:MoveToFront()
    self.mainbutton.email:SetHoverText(STRINGS.ALLACHIVCURRENCY[31],{ size = 9, offset_x = 40, offset_y = -45, colour = {1,1,1,1}})
	self.mainbutton.email:SetScale(0.50,0.50,1)
	self.mainbutton.email:SetPosition(35, -57, 0)
	
	self.mainbutton.email:SetOnClick(function()
		if self.mainui.email.shown then
			self.mainui.email:Hide()
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Hide()
		else
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.allachiv:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.title:Hide()
			self.mainui.email:Show()

			local giftdata = StrToTable(self.owner.currentgiftdata:value())
			local str = ""
			for k, v in pairs(giftdata) do
				if v and #v > 0 then
					str = str..k.."."..STRINGS.GUI["emailgift"]
					for m,n in pairs(v) do
						local prefab = n.prefab
						local num = n.num or 1
						local pack_prefab = n.package
						local msg = ""
						local pack_str = ""
						if n.msg then msg = "("..n.msg..")" end
						if pack_prefab and prefab == "package_ball" then pack_str = "["..(STRINGS.NAMES[string.upper(pack_prefab)] or "???").."]" end
						str = str.." "..(STRINGS.NAMES[string.upper(prefab)] or "???")..pack_str.."*"..num..msg..","
					end
					str = str.."\n"
				end
			end
			self.mainui.email.label:SetString(str)
		end
	end)

	self.mainui.infobutton = self.mainui:AddChild(Widget("infobutton"))
	self.mainui.infobutton:SetPosition(339, 85, 0)
	self.mainui.infobutton:Hide()
	
	self.mainui.perk_cat = self.mainui:AddChild(Widget("perk_cat"))
	self.mainui.perk_cat:SetPosition(500, 85, 0)
	self.mainui.perk_cat:Hide()

	--底部菜单
	for k=1,15 do
		self.mainui.infobutton["cat" .. k] = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_active.xml", "button_bg_active.tex"))
		self.mainui.infobutton["cat" .. k]:SetScale(0.4,0.6,1)
		self.mainui.infobutton["cat" .. k]:SetPosition(-780+(k-1)*63, -370, 0)
		self.mainui.infobutton["cat" .. k]:SetOnClick(function()
			if self.mainui.allachiv.shown then
				self.numpage = k
				self:build()
				self:setAllAchivCategoriesActive()
				self.mainui.infobutton["cat" .. k]:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
			end
		end)
		self.mainui.infobutton["cat" .. k].label = self.mainui.infobutton["cat" .. k]:AddChild(Text(BODYTEXTFONT, 55))
		self.mainui.infobutton["cat" .. k].label:SetScale(0.9,0.9,1)
		--self.mainui.infobutton["cat" .. k].label:SetColour(0,0,0,1)
		self.mainui.infobutton["cat" .. k].label:SetMultilineTruncatedString(STRINGS.GUI["cat" .. k], 2, 120, 50, "", true)
	end

	self.mainui.infobutton.info = self.mainui.infobutton:AddChild(Text(BODYTEXTFONT, 38))
	self.mainui.infobutton.info:SetPosition(-320, -500, 0)
	self.mainui.infobutton.info:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.infobutton.info:SetMultilineTruncatedString(STRINGS.GUI["recycletips"], 2, 800, 500, "", true)
	
	--奖励菜单
	self.mainui.perk_cat.perkcat1 = self.mainui.perk_cat:AddChild(ImageButton("images/button/button_bg_active.xml", "button_bg_active.tex"))
	self.mainui.perk_cat.perkcat1:SetPosition(-785, -370, 0)
	self.mainui.perk_cat.perkcat1:SetScale(1.4,0.7,1)
	self.mainui.perk_cat.perkcat1:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.perkpage = 1
			self:perk_build()
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat4:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
	end)
	self.mainui.perk_cat.perkcat1.label = self.mainui.perk_cat.perkcat1:AddChild(Text(BUTTONFONT, 45))
	self.mainui.perk_cat.perkcat1.label:SetMultilineTruncatedString(STRINGS.GUI["abilities1"], 2, 150, 50, "", true)
	--self.mainui.perk_cat.perkcat1.label:SetString(STRINGS.GUI["attributes"])
	self.mainui.perk_cat.perkcat1.label:SetScale(0.6,1,1)
	--self.mainui.perk_cat.perkcat1.label:SetColour(0,0,0,1)

	self.mainui.perk_cat.perkcat2 = self.mainui.perk_cat:AddChild(ImageButton("images/button/button_bg_active.xml", "button_bg_active.tex"))
	self.mainui.perk_cat.perkcat2:SetPosition(-785+190, -370, 0)
	self.mainui.perk_cat.perkcat2:SetScale(1.4,0.7,1)
	self.mainui.perk_cat.perkcat2:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.perkpage = 2
			self:perk_build()
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat4:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
	end)
	self.mainui.perk_cat.perkcat2.label = self.mainui.perk_cat.perkcat2:AddChild(Text(BUTTONFONT, 45))
	self.mainui.perk_cat.perkcat2.label:SetMultilineTruncatedString(STRINGS.GUI["abilities2"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat2.label:SetScale(0.6,1,1)
	--self.mainui.perk_cat.perkcat2.label:SetColour(0,0,0,1)

	self.mainui.perk_cat.perkcat3 = self.mainui.perk_cat:AddChild(ImageButton("images/button/button_bg_active.xml", "button_bg_active.tex"))
	self.mainui.perk_cat.perkcat3:SetPosition(-785+190*2, -370, 0)
	self.mainui.perk_cat.perkcat3:SetScale(1.4,0.7,1)
	self.mainui.perk_cat.perkcat3:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.perkpage = 3
			self:perk_build()
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
			self.mainui.perk_cat.perkcat4:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
	end)
	self.mainui.perk_cat.perkcat3.label = self.mainui.perk_cat.perkcat3:AddChild(Text(BUTTONFONT, 45))
	self.mainui.perk_cat.perkcat3.label:SetMultilineTruncatedString(STRINGS.GUI["abilities3"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat3.label:SetScale(0.6,1,1)
	--self.mainui.perk_cat.perkcat3.label:SetColour(0,0,0,1)

	self.mainui.perk_cat.perkcat4 = self.mainui.perk_cat:AddChild(ImageButton("images/button/button_bg_active.xml", "button_bg_active.tex"))
	self.mainui.perk_cat.perkcat4:SetPosition(-785+190*3, -370, 0)
	self.mainui.perk_cat.perkcat4:SetScale(1.4,0.7,1)
	self.mainui.perk_cat.perkcat4:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.perkpage = 4
			self:perk_build()
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat4:SetTextures("images/button/button_bg_active.xml", "button_bg_active.tex")
		end
	end)
	self.mainui.perk_cat.perkcat3.label = self.mainui.perk_cat.perkcat4:AddChild(Text(BUTTONFONT, 45))
	self.mainui.perk_cat.perkcat3.label:SetMultilineTruncatedString(STRINGS.GUI["abilities4"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat3.label:SetScale(0.6,1,1)
	--self.mainui.perk_cat.perkcat3.label:SetColour(0,0,0,1)

	-- Level Page
	self.mainui.levelbg.levelxp = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.levelxp:SetPosition(50, 208, 0)
	self.mainui.levelbg.levelxp:SetHAlign(ANCHOR_MIDDLE)
	
	
	self.mainui.levelbg.overallxp = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.overallxp:SetPosition(300, 300, 0)
	self.mainui.levelbg.overallxp:SetHAlign(ANCHOR_RIGHT)
	
	
	self.mainui.levelbg.levelbadge = self.mainui.levelbg:AddChild(Image("images/hud/levelbadge.xml", "levelbadge.tex"))
	self.mainui.levelbg.levelbadge:SetPosition(-140, 210, 0)
	self.mainui.levelbg.levelbadge:SetScale(2,2,1)
	self.mainui.levelbg.level = self.mainui.levelbg.levelbadge:AddChild(Text(BODYTEXTFONT, 55))
	self.mainui.levelbg.level:SetPosition(4, 0, 0)
	self.mainui.levelbg.level:SetHAlign(ANCHOR_MIDDLE)
	
	
	self.mainui.levelbg.attributelabels = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.attributelabels:SetPosition(-140, -55, 0)
	self.mainui.levelbg.attributelabels:SetHAlign(ANCHOR_RIGHT)
	self.mainui.levelbg.attributelabels:SetString(STRINGS.GUI["attributelabels"])
	
	self.mainui.levelbg.attributelevels = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.attributelevels:SetPosition(50, -55, 0)
	self.mainui.levelbg.attributelevels:SetHAlign(ANCHOR_RIGHT)
	
	self.mainui.levelbg.attributeunits = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.attributeunits:SetPosition(120, -35, 0)
	self.mainui.levelbg.attributeunits:SetHAlign(ANCHOR_RIGHT)
	self.mainui.levelbg.attributeunits:SetString(STRINGS.GUI["attributeunits"])
	
	self.mainui.levelbg.close = self.mainui.levelbg:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.levelbg.close:SetPosition(0, -355, 0)
	self.mainui.levelbg.close:SetScale(1,0.9,1)
	self.mainui.levelbg.close:SetOnClick(function()
		self.mainui.allachiv:Hide()
		self.mainui.allcoin:Hide()
		self.mainui.levelbg:Hide()
		self.mainui.achievement_bg:Hide()
		self.mainui.infobutton:Hide()
		self.mainui.perk_cat:Hide()
	end)
	self.mainui.levelbg.close.label = self.mainui.levelbg.close:AddChild(Text(BUTTONFONT, 45))
	--self.mainui.levelbg.close.label:SetString(STRINGS.GUI["close"])
	self.mainui.levelbg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	--self.mainui.levelbg.close.label:SetColour(0,0,0,1)
	
	self.mainui.levelbg.info = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 32))
	self.mainui.levelbg.info:SetPosition(0, -300, 0)
	self.mainui.levelbg.info:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.info:SetMultilineTruncatedString(STRINGS.GUI["iteminfo"], 2, 800, 500, "", true)--:SetString(STRINGS.GUI["iteminfo"])

	--titlesystem
	local titles = STRINGS.TITLE

	self.titlelist = {}
	self.titlelist_status = {}
	--self.mainui.title:KillAllChildren()
	for k,v in pairs(titles) do
		local level = v.level or 1
		self.titlelist[k] = self.mainui.title:AddChild(ImageButton("images/title/title_list.xml", "title_list.tex"))
		self.titlelist[k]:SetPosition(-350, 330-(k-1)*58, 0)
		self.titlelist[k]:SetImageNormalColour(1,1,1,0.95)
		self.titlelist[k]:SetOnClick(function()
			--SendModRPCToServer(MOD_RPC["DSTAchievement"][self.coinlist[pagenum][i].name])
			if self.cooldown then
				self.cooldown = false
				self:loadTitleInfo(k)
				self.owner:DoTaskInTime(0.3, function() self.cooldown = true end)
			end
		end)
		self.titlelist[k]:SetNormalScale(1.3,1,1)
		self.titlelist[k]:SetFocusScale(1.32,1.02,1)
		self.titlelist[k]:SetHoverText("")
		
		self.titlelist[k].name = self.titlelist[k]:AddChild(Text(NEWFONT, 45))
		self.titlelist[k].name:SetPosition(0, 0, 0)
		self.titlelist[k].name:SetHAlign(ANCHOR_MIDDLE)
		self.titlelist[k].name:SetTruncatedString(v.name, 220, 500, "")
		level = level - 1
		local r,g,b,t = 1,1,1,1
		r = 1-(9-level)*0.1
		g = level*level*0.01
		b = 1-level*0.1

		self.titlelist[k].name:SetColour(r,g,b,t)
		self.titlelist[k].name:SetRegionSize(300,60)

		self.titlelist_status[k] = self.mainui.title:AddChild(ImageButton("images/title/equip.xml", "equip.tex"))
		self.titlelist_status[k]:SetPosition(-230, 330-(k-1)*58, 0)
		self.titlelist_status[k]:SetNormalScale(1,1,1)
		self.titlelist_status[k]:SetFocusScale(1.02,1.02,1)
		self.titlelist_status[k]:SetOnClick(function()
			if self.cooldown then
				self.cooldown = false
				SendModRPCToServer(MOD_RPC["DSTAchievement"]["equiptitle"], k)
				self.owner:DoTaskInTime(0.3, function() self.cooldown = true end)
			end
		end)
		--self.titlelist_status[k]:Hide()
		self.titlelist_status[k].name = self.titlelist_status[k]:AddChild(Text(NEWFONT, 32))
		self.titlelist_status[k].name:SetPosition(0, 0, 0)
		self.titlelist_status[k].name:SetHAlign(ANCHOR_MIDDLE)
		local equip_text = STRINGS.GUI["equip"]
		r,g,b = 0.2,0.88,0.33
		local player = self.owner
		if player["currenttitle"..tostring(k)] and player["currenttitle"..tostring(k)]:value() > 0 then
			self.titlelist_status[k]:Show()
			if player.currentequip:value() == k then
				equip_text = STRINGS.GUI["unequip"]
				r,g,b = 0.9,0.4,0.33
			end
		end
		self.titlelist_status[k].name:SetColour(r,g,b,t)
		self.titlelist_status[k].name:SetTruncatedString(equip_text, 220, 500, "")
		
	end
	self:loadTitleInfo(1)
	

	--skills images
	self.skillbutton = self:AddChild(Widget("skillbutton"))
	self.skillbutton:SetHAnchor(ANCHOR_LEFT) 
	self.skillbutton:SetVAnchor(ANCHOR_BOTTOM)
	self.skillbutton.resurrect = self.skillbutton:AddChild(ImageButton("images/skills/resurrect.xml", "resurrect.tex"))
    self.skillbutton.resurrect:MoveToFront()
	self.skillbutton.resurrect:SetPosition(150,100,0)
    self.skillbutton.resurrect:SetScale(0.5,0.5,1)
    self.skillbutton.resurrect:SetHoverText(STRINGS.PERKNAME["respawnfromghost"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    --self.skillbutton.cheatdeath:SetTooltip("CD : " .. 20)
    self.skillbutton.resurrect.cd = self.skillbutton.resurrect:AddChild(Text(BODYTEXTFONT, 40))
	self.skillbutton.resurrect.cd:SetPosition(1, 0, 0)
	self.skillbutton.resurrect.cd:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.resurrect.cd:Hide()
	self.skillbutton.resurrect:SetOnClick(function() 
		local skillcd = self.owner.currentresurrectcd:value()
		if skillcd > 0 then return end
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["purchase"], "respawnfromghost")
	end)

	self.skillbutton.cheatdeath = self.skillbutton:AddChild(ImageButton("images/skills/cheatdeath.xml", "cheatdeath.tex"))
    self.skillbutton.cheatdeath:MoveToFront()
	self.skillbutton.cheatdeath:SetPosition(200,100,0)
    self.skillbutton.cheatdeath:SetScale(0.5,0.5,1)
    self.skillbutton.cheatdeath:SetHoverText(STRINGS.PERKNAME["cheatdeath"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    --self.skillbutton.cheatdeath:SetTooltip("CD : " .. 20)
    self.skillbutton.cheatdeath.cd = self.skillbutton.cheatdeath:AddChild(Text(BODYTEXTFONT, 40))
	self.skillbutton.cheatdeath.cd:SetPosition(1, 0, 0)
	self.skillbutton.cheatdeath.cd:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.cheatdeath.cd:Hide()
	self.skillbutton.cheatdeath:SetOnClick(nil)
	self.skillbutton.cheatdeath:Hide()

	self.skillbutton.shadow = self.skillbutton:AddChild(ImageButton("images/skills/shadow.xml", "shadow.tex"))
    self.skillbutton.shadow:MoveToFront()
	self.skillbutton.shadow:SetPosition(250,100,0)
    self.skillbutton.shadow:SetScale(0.5,0.5,1)
    self.skillbutton.shadow:SetHoverText(STRINGS.PERKNAME["wescheat"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    --self.skillbutton.shadow:SetTooltip("CD : " .. 20)
    self.skillbutton.shadow.cd = self.skillbutton.shadow:AddChild(Text(BODYTEXTFONT, 40))
	self.skillbutton.shadow.cd:SetPosition(1, 0, 0)
	self.skillbutton.shadow.cd:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.shadow.cd:Hide()
	self.skillbutton.shadow:SetOnClick(nil)
	self.skillbutton.shadow:Hide()

	self.skillbutton.callback = self.skillbutton:AddChild(ImageButton("images/skills/callback.xml", "callback.tex"))
    self.skillbutton.callback:MoveToFront()
	self.skillbutton.callback:SetPosition(300,100,0)
    self.skillbutton.callback:SetScale(0.5,0.5,1)
    self.skillbutton.callback:SetHoverText(STRINGS.PERKNAME["callback"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    self.skillbutton.callback.cd = self.skillbutton.callback:AddChild(Text(BODYTEXTFONT, 40))
	self.skillbutton.callback.cd:SetPosition(1, 0, 0)
	self.skillbutton.callback.cd:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.callback.cd:Hide()
	self.skillbutton.callback:SetOnClick(nil)
	self.skillbutton.callback:Hide()

	--状态技能
	--local debuff_skills = {}
	self.skillbutton.nextdamage = self.skillbutton:AddChild(ImageButton("images/skills/nextdamage.xml", "nextdamage.tex"))
    self.skillbutton.nextdamage:MoveToFront()
	self.skillbutton.nextdamage:SetPosition(150,150,0)
    self.skillbutton.nextdamage:SetScale(0.5,0.5,1)
    self.skillbutton.nextdamage:SetHoverText(STRINGS.PERKNAME["nextdamage"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    self.skillbutton.nextdamage.detail = self.skillbutton.nextdamage:AddChild(Text(BODYTEXTFONT, 35))
	self.skillbutton.nextdamage.detail:SetPosition(1, 0, 0)
	self.skillbutton.nextdamage.detail:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.nextdamage.detail:Hide()
	self.skillbutton.nextdamage:SetOnClick(nil)
	self.skillbutton.nextdamage:Hide()

	self.skillbutton.hitattack = self.skillbutton:AddChild(ImageButton("images/skills/hitattack.xml", "hitattack.tex"))
    self.skillbutton.hitattack:MoveToFront()
	self.skillbutton.hitattack:SetPosition(200,150,0)
    self.skillbutton.hitattack:SetScale(0.5,0.5,1)
    self.skillbutton.hitattack:SetHoverText(STRINGS.PERKNAME["hitattack"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    self.skillbutton.hitattack.detail = self.skillbutton.hitattack:AddChild(Text(BODYTEXTFONT, 40))
	self.skillbutton.hitattack.detail:SetPosition(1, 0, 0)
	self.skillbutton.hitattack.detail:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.hitattack.detail:Hide()
	self.skillbutton.hitattack:SetOnClick(nil)
	self.skillbutton.hitattack:Hide()

	self.skillbutton.strongeraoe = self.skillbutton:AddChild(ImageButton("images/skills/strongeraoe.xml", "strongeraoe.tex"))
    self.skillbutton.strongeraoe:MoveToFront()
	self.skillbutton.strongeraoe:SetPosition(250,150,0)
    self.skillbutton.strongeraoe:SetScale(0.5,0.5,1)
    self.skillbutton.strongeraoe:SetHoverText(STRINGS.PERKNAME["strongeraoe"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    self.skillbutton.strongeraoe.detail = self.skillbutton.strongeraoe:AddChild(Text(BODYTEXTFONT, 40))
	self.skillbutton.strongeraoe.detail:SetPosition(1, 0, 0)
	self.skillbutton.strongeraoe.detail:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.strongeraoe.detail:Hide()
	self.skillbutton.strongeraoe:SetOnClick(function() 
		if self.cooldown then
			self.cooldown = false
			SendModRPCToServer(MOD_RPC["DSTAchievement"]["skills"], "strongeraoe")
			self.owner:DoTaskInTime(0.3, function() self.cooldown = true end)
		end
	end)
	self.skillbutton.strongeraoe:Hide()

	self.skillbutton.waterwalk = self.skillbutton:AddChild(ImageButton("images/skills/waterwalk.xml", "waterwalk.tex"))
    self.skillbutton.waterwalk:MoveToFront()
	self.skillbutton.waterwalk:SetPosition(300,150,0)
    self.skillbutton.waterwalk:SetScale(0.5,0.5,1)
    self.skillbutton.waterwalk:SetHoverText(STRINGS.PERKNAME["waterwalk"],{ size = 9, offset_x = 15, offset_y = 30, colour = {1,1,1,1}})
    self.skillbutton.waterwalk.detail = self.skillbutton.waterwalk:AddChild(Text(BODYTEXTFONT, 40))
	self.skillbutton.waterwalk.detail:SetPosition(1, 0, 0)
	self.skillbutton.waterwalk.detail:SetHAlign(ANCHOR_MIDDLE)
	self.skillbutton.waterwalk.detail:Hide()
	self.skillbutton.waterwalk:SetOnClick(function() 
		if self.cooldown then
			self.cooldown = false
			SendModRPCToServer(MOD_RPC["DSTAchievement"]["skills"], "waterwalk")
			self.owner:DoTaskInTime(0.3, function() self.cooldown = true end)
		end
	end)
	self.skillbutton.waterwalk:Hide()
	
	self.inst:DoTaskInTime(.2, function()
		self.numpage = 1
		self.perkpage = 1
		self:loadlist()
		self:loadcoinlist()
		self.maxnumpage = 15
		self.achivlisttile = {}
		self.coinlistbutton = {}
		self:build()
		self:perk_build()
		self:StartUpdating()
	
		
	end)

	--skills
	TheInput:AddKeyUpHandler(KEY_R, function() 
		if self.owner and self.owner.HUD and self.owner.HUD.IsChatInputScreenOpen() then return end
		local data = {skillname="wescheat"}
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["skills"], "wescheat")
	end)
	--[[TheInput:AddKeyUpHandler(KEY_G, function() 
		if self.owner and self.owner.HUD and self.owner.HUD.IsChatInputScreenOpen() then return end
		local data = {}
		local ent = TheInput:GetWorldEntityUnderMouse()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["skills"], "callback", ent)
	end)]]

	TheInput:AddKeyUpHandler(KEY_T, function()
		if self.owner and TheInput:IsKeyDown(KEY_CTRL) then
			local equip = self.owner.currentequip:value() or 1
			local nextequip = equip + 1
			--if equip == 13 then nextequip=0 end
			while (self.owner["currenttitle"..tostring(nextequip)] == nil or self.owner["currenttitle"..tostring(nextequip)]:value() ~= 1) do
				if nextequip < 14 then
					nextequip = nextequip + 1
				else
					nextequip = 1
				end
				if nextequip == equip then
					return
				end
			end
			SendModRPCToServer(MOD_RPC["DSTAchievement"]["equiptitle"], nextequip)
		end
	end)
	
end)

function uiachievement:updatetitles()
	for k,v in pairs(self.titlelist_status) do
		local equip_text = STRINGS.GUI["equip"]
		local r,g,b = 0.2,0.88,0.33
		local player = self.owner
		if player["currenttitle"..tostring(k)] and player["currenttitle"..tostring(k)]:value() > 0 then
			self.titlelist_status[k]:Show()
			if player.currentequip:value() == k then
				equip_text = STRINGS.GUI["unequip"]
				r,g,b = 0.9,0.4,0.33
			end
		else
			self.titlelist_status[k]:Hide()
		end
		self.titlelist_status[k].name:SetColour(r,g,b,1)
		self.titlelist_status[k].name:SetTruncatedString(equip_text, 220, 500, "")
	end
	if self.owner.currenttitle14 then
		if self.owner.currenttitle14:value() < 1 then
			self.titlelist[14]:Hide()
		else
			self.titlelist[14]:Show()
		end
	end
end

function uiachievement:loadTitleInfo(index)
	if self.titlecontent == nil then
		self.titlecontent = self.mainui.title:AddChild(Image("images/title/title_content.xml", "title_content.tex"))
		self.titlecontent:SetPosition(150, -28, 0)
		self.titlecontent:SetScale(2.5,3.0,1)
		self.titlecontent.desc = {}
		self.titlecontent.common = {}
		self.titlecontent.equip = {}
		self.titlecontent.name = self.titlecontent:AddChild(Text(BODYTEXTFONT, 22))
		self.titlecontent.name:SetPosition(0, 103, 0)
		self.titlecontent.name:SetHAlign(ANCHOR_MIDDLE)
		self.titlecontent.desc[1] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.desc[1]:SetPosition(0, 80, 0)
		self.titlecontent.desc[1]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.desc[2] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.desc[2]:SetPosition(0, 60, 0)
		self.titlecontent.desc[2]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.desc[3] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.desc[3]:SetPosition(0, 40, 0)
		self.titlecontent.desc[3]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.desc[4] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.desc[4]:SetPosition(0, 20, 0)
		self.titlecontent.desc[4]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.desc[5] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.desc[5]:SetPosition(0, 0, 0)
		self.titlecontent.desc[5]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.common[1] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.common[1]:SetPosition(0, -20, 0)
		self.titlecontent.common[1]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.common[2] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.common[2]:SetPosition(0, -40, 0)
		self.titlecontent.common[2]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.common[3] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.common[3]:SetPosition(0, -60, 0)
		self.titlecontent.common[3]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.equip[1] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.equip[1]:SetPosition(0, -80, 0)
		self.titlecontent.equip[1]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.equip[2] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.equip[2]:SetPosition(0, -100, 0)
		self.titlecontent.equip[2]:SetHAlign(ANCHOR_LEFT)
		self.titlecontent.equip[3] = self.titlecontent:AddChild(Text(BODYTEXTFONT, 12))
		self.titlecontent.equip[3]:SetPosition(0, -120, 0)
		self.titlecontent.equip[3]:SetHAlign(ANCHOR_LEFT)

		self.titlecontent.visit = self.titlecontent:AddChild(TextButton())
		self.titlecontent.visit:SetPosition(-90, 103, 0)
		self.titlecontent.visit:SetText(STRINGS.GUI["visit"])
		self.titlecontent.visit:SetTextSize(12)
		self.titlecontent.visit:SetColour(0.95,0.2,0.9,1)
		self.titlecontent.visit:SetOnClick(function() 
			if self.cooldown then
				self.cooldown = false
				if not TUNING.vipurl then
					TUNING.vipurl = "http://vip.tumbleweedofall.xyz:8008"
				end
				VisitURL(TUNING.vipurl)
				self.owner:DoTaskInTime(0.3, function() self.cooldown = true end)
			end
		end)
		self.titlecontent.visit:Hide()
	end

	local title = STRINGS.TITLE[index]
	local name = title.name
	local desc = title.desc
	local common = title.common
	local equip = title.equip
	local level = title.level
	level = level - 1
	local r,g,b,t = 1,1,1,1
	r = 1-(9-level)*0.1
	g = level*level*0.01
	b = 1-level*0.1
	self.titlecontent.name:SetString(name)
	self.titlecontent.name:SetColour(r,g,b,t)

	if title.id == "title13" and level == 8 then
		self.titlecontent.visit:Show()
	else
		self.titlecontent.visit:Hide()
	end
	for k=1,5 do
		self.titlecontent.desc[k]:SetString("")
		self.titlecontent.desc[k]:SetRegionSize(225,15)
		self.titlecontent.desc[k]:SetColour(0.6,0.6,0.6,1)
		if self.titlecontent.common[k] then
			self.titlecontent.common[k]:SetString("")
			self.titlecontent.common[k]:SetRegionSize(225,15)
			self.titlecontent.common[k]:SetColour(0.2,0.75,0.1,1)
		end
		if self.titlecontent.equip[k] then
			self.titlecontent.equip[k]:SetString("")
			self.titlecontent.equip[k]:SetRegionSize(225,15)
			self.titlecontent.equip[k]:SetColour(0.8,0.55,0.3,1)
		end
	end
	local player = self.owner
	for k,v in pairs(desc) do
		local text = STRINGS.GUI["need"]..v
		local desc_val = player["current"..title.id.."_desc"..tostring(k)] and player["current"..title.id.."_desc"..tostring(k)]:value() or 0
		if desc_val > 0 then
			text = text..STRINGS.GUI["completed"]
			self.titlecontent.desc[k]:SetColour(0.2,0.9,0.7,1)
		end
		self.titlecontent.desc[k]:SetTruncatedString(text,250,500)
	end
	for k,v in pairs(common) do
		self.titlecontent.common[k]:SetTruncatedString(STRINGS.GUI["common"]..v,250,500)
	end
	for k,v in pairs(equip) do
		self.titlecontent.equip[k]:SetTruncatedString(STRINGS.GUI["equip"]..v,250,500)
	end
end

function uiachievement:updateskills()
	local player = self.owner

	local skillcd = player.currentresurrectcd:value()
	if skillcd > 0 then
		self.skillbutton.resurrect.cd:SetString(skillcd)
		self.skillbutton.resurrect.cd:SetColour(1,1,1,1)
		self.skillbutton.resurrect.cd:Show()
	else
		self.skillbutton.resurrect.cd:Hide()
	end
	
	if player.currentcheatdeath:value() > 0 then
		self.skillbutton.cheatdeath:Show()
		skillcd = player.currentcheatdeathcd:value()
		if skillcd > 0 then
			--self.skillbutton.cheatdeath:SetTooltip("CD : " .. skillcd)
			self.skillbutton.cheatdeath.cd:SetString(skillcd)
			self.skillbutton.cheatdeath.cd:SetColour(1,1,1,1)
			self.skillbutton.cheatdeath.cd:Show()
		else
			self.skillbutton.cheatdeath.cd:Hide()
		end
	else
		self.skillbutton.cheatdeath:Hide()
	end
	if player.currentwescheat:value() > 0 then
		self.skillbutton.shadow:Show()
		skillcd = player.currentwescheatcd:value()
		if skillcd > 0 then
			--self.skillbutton.shadow:SetTooltip("CD : " .. skillcd)
			self.skillbutton.shadow.cd:SetString(skillcd)
			self.skillbutton.shadow.cd:SetColour(1,1,1,1)
			self.skillbutton.shadow.cd:Show()
		else
			self.skillbutton.shadow.cd:Hide()
		end
	else
		self.skillbutton.shadow:Hide()
	end
	if player.currentcallback:value() > 0 then
		self.skillbutton.callback:Show()
		skillcd = player.currentcallbackcd:value()
		if skillcd > 0 then
			self.skillbutton.callback.cd:SetString(skillcd)
			self.skillbutton.callback.cd:SetColour(1,1,1,1)
			self.skillbutton.callback.cd:Show()
		else
			self.skillbutton.callback.cd:Hide()
		end
	else
		self.skillbutton.callback:Hide()
	end
	if player.currentnextdamage:value() > 0 then
		self.skillbutton.nextdamage:Show()
		local detail = player.currentnextdamage:value()
		self.skillbutton.nextdamage.detail:SetString(detail)
		self.skillbutton.nextdamage.detail:SetColour(1,1,1,1)
		self.skillbutton.nextdamage.detail:Show()
	else
		self.skillbutton.nextdamage:Hide()
	end
	if player.currenthitattack:value() > 0 then
		self.skillbutton.hitattack:Show()
		local detail = player.currenthits:value()
		self.skillbutton.hitattack.detail:SetString(detail)
		self.skillbutton.hitattack.detail:SetColour(1,1,1,1)
		if detail > 0 then
			self.skillbutton.hitattack.detail:Show()
		else
			self.skillbutton.hitattack.detail:Hide()
		end
	else
		self.skillbutton.hitattack:Hide()
	end
	if player.currentstrongeraoe:value() > 0 then
		self.skillbutton.strongeraoe:Show()
		local status = player.currentaoestatus:value()
		local detail = "OFF"
		if status == 1 then detail="ON" end
		self.skillbutton.strongeraoe.detail:SetString(detail)
		self.skillbutton.strongeraoe.detail:SetColour(1,status,0,1)
		self.skillbutton.strongeraoe.detail:Show()
	else
		self.skillbutton.strongeraoe:Hide()
	end
	if player.currentwaterwalk:value() > 0 then
		self.skillbutton.waterwalk:Show()
		local status = player.currentwaterwalkstatus:value()
		local detail = "OFF"
		if status == 1 then detail="ON" end
		self.skillbutton.waterwalk.detail:SetString(detail)
		self.skillbutton.waterwalk.detail:SetColour(1,status,0,1)
		self.skillbutton.waterwalk.detail:Show()
	else
		self.skillbutton.waterwalk:Hide()
	end
	--currentaoestatus
	local skills = {"resurrect", "cheatdeath", "shadow", "callback", "nextdamage",
	"hitattack","strongeraoe","waterwalk"}
	local currentpos = 150
	for k, v in pairs(skills) do
		if k and v then
			--print("k....:"..tostring(k))
			if self.skillbutton[v] and self.skillbutton[v].shown then
				self.skillbutton[v]:SetPosition(currentpos, 100, 0)
				currentpos = currentpos + 50
			end
		end
	end
end

function uiachievement:setAllAchivCategoriesActive()
	self.mainui.infobutton.cat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat4:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat5:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat6:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat7:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat8:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat9:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat10:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat11:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat12:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat13:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat14:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat15:SetTextures("images/button/button_bg.xml", "button_bg.tex")
end

function uiachievement:updatepage(i)
	local achieve = self.achivlist["cat" .. self.numpage][i]
	local active = ""
    if achieve.check >= (allachiv_eventdata[achieve.name] or 1) then active = "_active" end

	self.achivlisttile[i]:SetTexture("images/button/achievement"..active..".xml", "achievement"..active..".tex")
	
    if allachiv_eventdata[achieve.name] ~= nil then
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..achieve.check.."/"..allachiv_eventdata[achieve.name])
    else
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..achieve.check.."/1")
    end

    local progress = achieve.check.."/1"
    if allachiv_eventdata[achieve.name] ~= nil then
    	progress = achieve.check.."/"..allachiv_eventdata[achieve.name]
    end
    self.achivlisttile[i].desc:SetTruncatedString(STRINGS.ALLACHIVDESC[achieve.name].."["..progress.."]", 350, 500, "")
	local line = self.achivlisttile[i].desc:GetString()
	while #line < #STRINGS.ALLACHIVDESC[achieve.name] do
		self.achivlisttile[i].desc:SetSize( self.achivlisttile[i].desc:GetSize() - 1 )
		self.achivlisttile[i].desc:SetTruncatedString(STRINGS.ALLACHIVDESC[achieve.name], 350, 500, "")
		line = self.achivlisttile[i].desc:GetString()
	end	
end


function uiachievement:OnUpdate(dt)
	local zoomlevel = self.owner.currentzoomlevel:value()
	if zoomlevel ~= self.size then
		self.size = zoomlevel
		self.mainui:SetScale(zoomlevel, zoomlevel, 1)
	end
	local savedxpos = self.owner.currentwidgetxpos:value()
	local pos = self.mainbutton:GetPosition()
	if savedxpos ~= -1 and pos.x ~= savedxpos then
		self.mainbutton:SetPosition(savedxpos, pos.y, pos.z)
	end
	
	
	if not self.mainui.allcoin.shown then
		self.mainui.removeinfo:Hide()
	end
	
	self.mainui.achievement_bg.coinamount:SetString(self.owner.currentcoinamount:value())
	self.mainbutton.level:SetString(self.owner.currentlevel:value())
	self.mainbutton.level:SetColour(1,1,1,1)
	self.mainui.levelbg.level:SetColour(1,1,1,1)

	local worldid = self.owner.currentworld:value()
	if worldid and worldid ~= 0 then
		self.mainbutton.worldinfo:SetString(self.owner.currentworld:value())
		self.mainbutton.worldinfo:Show()
	else
		self.mainbutton.worldinfo:Hide()
	end

	local hasgift = self.owner.currenthasgift:value() or 0
	if hasgift > 0 then
		self.mainbutton.email:Show()
	else
		self.mainbutton.email:Hide()
	end

	self.mainui.levelbg.levelxp:SetString(self.owner.currentlevelxp:value().."/"..(math.min(levelxpcap,self.owner.currentlevel:value()*200)))
	self.mainui.levelbg.overallxp:SetString(STRINGS.GUI["overallxp"]..self.owner.currentoverallxp:value())
	self.mainui.levelbg.level:SetString(self.owner.currentlevel:value())
	
	local percent = self.owner.currentlevelxp:value() / math.min(levelxpcap,self.owner.currentlevel:value()*200)
--	self.mainbutton.xpbar_filled:SetScale(5.1*percent,0.15,1)
--	self.mainui.levelbg.xpbar_filled:SetScale(44.5*percent,0.78,1)
	
	local hunger = math.floor(self.owner.currenthungermax:value()+0.5)
	local sanity = math.floor(self.owner.currentsanitymax:value()+0.5)
	local health = math.floor(self.owner.currenthealthmax:value()+0.5)
	local damage = math.floor(self.owner.currentdamagemax:value()+0.5)
	local defence = math.floor(self.owner.currentabsorbmax:value()+0.5)
	local speed = math.floor(self.owner.currentspeedmax:value()+0.5)
	local heat = math.floor(self.owner.currentinsulationsummermax:value()+0.5)
	local cold = math.floor(self.owner.currentinsulationmax:value()+0.5)
	local power = math.ceil(self.owner.currentpower:value()*10)*0.1
	local luck = self.owner.currentluck:value()
	self.mainui.levelbg.attributelevels:SetString(hunger.."\n"..sanity.."\n"..health.."\n".."("..power..")"..damage.."\n"..defence.."\n"..speed.."\n"..luck.."\n"..heat.."\n"..cold)

	self:loadlist()
	
	if self.numpage ~= 1 or not self.mainui.allachiv.shown then
		
		self.infoopen = false
	end

	--self.mainui.allachiv:KillAllChildren()
	local y = GetTableLength(self.achivlist["cat" .. self.numpage])
	for i=1,y do
		self:updatepage(i)
	end

	if self.perkpage == 4 then
		for i=1, GetTableLength(self.coinlist[4]) do
			local perkname = self.coinlist[4][i].name
			local cost = allachiv_coinuse[perkname]
			if perkname == "respawnfromghost" then
				if self.owner.currentresurrectcd:value() <= 0 then
					cost = 0
				end
				self.coinlistbutton[i].cost:SetString("-".. cost)
			end
		end
	end

	self:updateskills()
	self:updatetitles()

end

function uiachievement:buildpage(j,i)
	local numpage = self.numpage or 1
	--print("当前页:".. numpage)
	local achieve = self.achivlist["cat" .. self.numpage][i]
	local x = 240
	local y = 110- (105 * (math.ceil(j/2) + 1))

	if math.ceil(j/2) ~= j/2 then x = -240 else x = 240 end

	local active = ""
	if achieve == nil then return end
    if achieve.check >= (allachiv_eventdata[achieve.name] or 1) then active = "_active" end

    self.achivlisttile[i] = self.mainui.allachiv:AddChild(Image("images/button/achievement"..active..".xml", "achievement"..active..".tex"))
	self.achivlisttile[i]:SetPosition(x-8, y, 0)
    self.achivlisttile[i]:SetTint(1,1,1,1)

    --print("check:".. achieve.name .."--" .. allachiv_eventdata[achieve.name] .. "--" .. achieve.current)
    local progress = achieve.check.."/1"
    if allachiv_eventdata[achieve.name] ~= nil then
    	progress = achieve.check.."/"..allachiv_eventdata[achieve.name]
    end
    self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..progress)

	self.infoopen = false
	
	self.achivlisttile[i].name = self.achivlisttile[i]:AddChild(Text(NEWFONT, 45))
	self.achivlisttile[i].name:SetPosition(0, 18, 0)
	self.achivlisttile[i].name:SetHAlign(ANCHOR_LEFT)
	self.achivlisttile[i].name:SetColour(0,0,0,1)

	self.achivlisttile[i].name:SetTruncatedString(STRINGS.ALLACHIVNAME_VALUE[achieve.name], 250, 500, "")

	local line = self.achivlisttile[i].name:GetString()
	while #line < #STRINGS.ALLACHIVNAME_VALUE[achieve.name] do
		self.achivlisttile[i].name:SetSize( self.achivlisttile[i].name:GetSize() - 1 )
		self.achivlisttile[i].name:SetTruncatedString(STRINGS.ALLACHIVNAME_VALUE[achieve.name], 250, 500, "")
		line = self.achivlisttile[i].name:GetString()
	end	
	self.achivlisttile[i].name:SetRegionSize(300,60)
	
	self.achivlisttile[i].desc = self.achivlisttile[i]:AddChild(Text(NEWFONT, 30))
	self.achivlisttile[i].desc:SetPosition(0, -19, 0)
	self.achivlisttile[i].desc:SetHAlign(ANCHOR_LEFT)
	--self.achivlisttile[i].desc:SetRegionSize(300,60)
	--self.achivlisttile[i].desc:SetString(STRINGS.ALLACHIVDESC[achieve.name])
	self.achivlisttile[i].desc:SetColour(0.3,0.3,0.3,1)
	self.achivlisttile[i].desc:SetTruncatedString(STRINGS.ALLACHIVDESC[achieve.name].."["..progress.."]", 350, 500, "")
	line = self.achivlisttile[i].desc:GetString()
	while #line < #STRINGS.ALLACHIVDESC[achieve.name] do
		self.achivlisttile[i].desc:SetSize( self.achivlisttile[i].desc:GetSize() - 1 )
		self.achivlisttile[i].desc:SetTruncatedString(STRINGS.ALLACHIVDESC[achieve.name], 350, 500, "")
		line = self.achivlisttile[i].desc:GetString()
	end	
	self.achivlisttile[i].desc:SetRegionSize(300,60)
	
	self.achivlisttile[i].cost = self.achivlisttile[i]:AddChild(Text(NEWFONT, 40))
	self.achivlisttile[i].cost:SetPosition(142, 0, 0)
	self.achivlisttile[i].cost:SetHAlign(ANCHOR_RIGHT)
	self.achivlisttile[i].cost:SetRegionSize(60,60)
	self.achivlisttile[i].cost:SetString("+"..allachiv_coinget[achieve.name])
	self.achivlisttile[i].cost:SetColour(0,0,0,1)
end

function uiachievement:build()
	self.mainui.allachiv:KillAllChildren()
	--self:loadlist()
	local y = GetTableLength(self.achivlist["cat" .. self.numpage])
--	x = x + y* (self.numpage -1)
	for i = 1,y do
		self:buildpage(i ,i)
	end
end



function uiachievement:perk_build()
	self.mainui.allcoin:KillAllChildren()
	-- Achievements Categories
	local numpage = self.perkpage
	for i=1, GetTableLength(self.coinlist[numpage]) do
		self:build_perkpage(i, i)
	end
end

function uiachievement:build_perkpage(j,i)
	local x = -325 + ((j-1)%3)*320 
	local y = 110 - (105 * (math.ceil(j/3) + 1))
	local pagenum = self.perkpage
	--if math.ceil(j/3) ~= j/3 then x = -240 else x = x + 240*j/3 end
	if self.coinlist[pagenum] == nil or self.coinlist[pagenum][i] == nil then return end
	local currentlyObtained = self.coinlist[pagenum][i].current
	local active = ""
	if currentlyObtained > 0 then
		active = "_active"
	end
	if pagenum == 4 then
		active = "_shop"
	end
	local totalnum = "/1"
	if allachiv_coindata_max[self.coinlist[pagenum][i].name] then
		totalnum = "/"..allachiv_coindata_max[self.coinlist[pagenum][i].name]
	end
	self.coinlistbutton[i] = self.mainui.allcoin:AddChild(ImageButton("images/button/perk"..active..".xml", "perk"..active..".tex"))
	self.coinlistbutton[i]:SetPosition(x, y, 0)
	self.coinlistbutton[i]:SetImageNormalColour(1,1,1,0.95)
	self.coinlistbutton[i]:SetOnClick(function()

		if pagenum == 4 then
			SendModRPCToServer(MOD_RPC["DSTAchievement"]["purchase"], self.coinlist[pagenum][i].name)
		else 
			SendModRPCToServer(MOD_RPC["DSTAchievement"][self.coinlist[pagenum][i].name])
		end
		self.owner:DoTaskInTime(.3, function()
			self:loadcoinlist()
			self.coinlistbutton[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[10]..self.coinlist[pagenum][i].current..totalnum)
			self:perk_build()
		end)
	end)
	self.coinlistbutton[i]:SetNormalScale(1,1,1)
	self.coinlistbutton[i]:SetFocusScale(1.02,1.02,1)
	self.coinlistbutton[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[10]..self.coinlist[pagenum][i].current..totalnum)
	
	self.coinlistbutton[i].name = self.coinlistbutton[i]:AddChild(Text(NEWFONT, 45))
	self.coinlistbutton[i].name:SetPosition(11, 25, 0)
	self.coinlistbutton[i].name:SetHAlign(ANCHOR_LEFT)
	--self.coinlistbutton[i].name:SetRegionSize(300,60)
	--self.coinlistbutton[i].name:SetMultilineTruncatedString(STRINGS.PERKNAME[self.coinlist[pagenum][i].name], 2, 300, 50, "", true)
	--self.coinlistbutton[i].name:SetString(STRINGS.PERKNAME[self.coinlist[pagenum][i].name])
	self.coinlistbutton[i].name:SetTruncatedString(STRINGS.PERKNAME[self.coinlist[pagenum][i].name], 220, 500, "")
	local line = self.coinlistbutton[i].name:GetString()
	while #line < #STRINGS.PERKNAME[self.coinlist[pagenum][i].name] do
		self.coinlistbutton[i].name:SetSize( self.coinlistbutton[i].name:GetSize() - 1 )
		self.coinlistbutton[i].name:SetTruncatedString(STRINGS.PERKNAME[self.coinlist[pagenum][i].name], 220, 500, "")
		line = self.coinlistbutton[i].name:GetString()
	end	
	self.coinlistbutton[i].name:SetColour(0,0,0,1)
	self.coinlistbutton[i].name:SetRegionSize(300,60)
	
	self.coinlistbutton[i].desc = self.coinlistbutton[i]:AddChild(Text(NEWFONT, 30))
	self.coinlistbutton[i].desc:SetPosition(11, -19, 0)
	self.coinlistbutton[i].desc:SetHAlign(ANCHOR_LEFT)
	
	--self.coinlistbutton[i].desc:SetString(STRINGS.PERKDESC[self.coinlist[pagenum][i].name])
	self.coinlistbutton[i].desc:SetMultilineTruncatedString(STRINGS.PERKDESC[self.coinlist[pagenum][i].name], 2, 260, 500, "", true)
	self.coinlistbutton[i].desc:SetColour(0,0,0,1)
	self.coinlistbutton[i].desc:SetRegionSize(300,60)
	
	self.coinlistbutton[i].cost = self.coinlistbutton[i]:AddChild(Text(NEWFONT, 36))
	self.coinlistbutton[i].cost:SetPosition(85, 25, 0)
	self.coinlistbutton[i].cost:SetHAlign(ANCHOR_RIGHT)
	self.coinlistbutton[i].cost:SetRegionSize(50,30)
	local perkname = self.coinlist[pagenum][i].name
	local cost = allachiv_coinuse[perkname]
	if perkname == "respawnfromghost" and self.owner.currentresurrectcd:value() <= 0 then
		cost = 0
	end
	self.coinlistbutton[i].cost:SetString("-".. cost)
	self.coinlistbutton[i].cost:SetColour(0,0,0,1)
	
	
end


function uiachievement:loadlist()
	local allachivlist = {
		cat1 = {
			"tumfirst",
			"tum88",
			"tum288",
			"tum888",
			"tum1888",
			"tum2888",
			"tumss",
			"tums",
			"tumd",
			"tumdd",
			"tumout10",
			"tumout100",
		},
		cat2 = {
			"firsteat",
			"eat100",
			"eatvegetables88",
			"eatmeat88",
			"eatbeans66",
			"eatmonstermeat20",
			"eathot",
			"eatcold",
			"eatfish",
			"eatturkey",
			"eatpepper",
			"eatbacon",
		},
		cat3 = {
			"intogame",
			"deathblack",
			"tooyoung",
			"walk3600",
			"stop1800",
			"death5",
			"secondchance",
			"messiah",
			"sleeptent",
			"sleepsiesta",
			"reviveamulet",
			"feedplayer",
		},
		cat4 = {
			"plant188",
			"plant1000",
			"picker188",
			"picker1000",
			"build30",
			"build666",
			"chop100",
			"chop1000",
			"mine66",
			"mine666",
			"cook100",
			"cook666",
		},
		cat5 = {
			"pickcactus50",
			"pickred_mushroom50",
			"pickblue_mushroom50",
			"pickgreen_mushroom50",
			"pickflower_cave50",
			"picktallbirdnest10",
			"pickrock_avocado_bush50",
			"pickcave_banana_tree50",
			"pickwormlight_plant40",
			"pickreeds50",
			"cookwaffles",
			"cookbananapop",
		},
		cat6 = {
			"attack5000",
			"tank5000",
			"killmonster1000",
			"killspider100",
			"killhound100",
			"killkoale5",
			"killmonkey20",
			"killleif5",
			"killslurtle10",
			"killbunnyman20",
			"killtallbird50",
			"killworm20",
		},
		cat7 = {
			"killglommer",
			"kilchester",
			"killhutch",
			"kllrabbit10",
			"killghost10",
			"killtentacle50",
			"killterrorbeak20",
			"killbirchnutdrake20",
			"killlightninggoat20",
			"killspiderqueen10",
			"killwarg5",
			"killcatcoon10",
		},
		cat8 = {
			"killwalrus10",
			"killbutterfly20",
			"killbat20",
			"killmerm30",
			"killbee100",
			"killpenguin30",
			"killfrog20",
			"killperd10",
			"killbird10",
			"killpigman10",
			"killmosquito20",
			"killkrampus10",
		},
		cat9 = {
			"killmoose",
			"killdragonfly",
			"killbeager",
			"killdeerclops",
			"singlekillspat",
			"killshadow",
			"killstalker",
			"killstalker_atrium",
			"killklaus",
			"killantlion",
			"killminotaur",
			"killbeequeen",
		},
		cat10 = {
			"killtoadstool",
			"killtoadstool_dark",
			"killmalbatross",
			"killcrabking",
			"killeyeofterror",
			"killtwinofterror1",
			"killtwinofterror2",
			"killalterguardian_phase1",		
		},
		cat11 = {
			"buildpumpkin_lantern",
			"buildruinshat",
			"buildarmorruins",
			"buildruins_bat",
			"buildgunpowder",
			"buildhealingsalve",
			"buildbandage",
			"buildblowdart_pipe",
			"buildblowdart_sleep",
			"buildblowdart_yellow",
			"buildblowdart_fire",
			"buildnightsword",
			
		},
		cat12 = {
			"buildamulet",
			"buildpanflute",
			"buildmolehat",
			"buildlifeinjector",
			"buildbatbat",
			"buildmultitool_axe_pickaxe",
			"buildthulecite",
			"buildyellowstaff",
			"buildfootballhat",
			"buildarmorwood",
			"buildhambat",
			"buildglasscutter",
		},
		cat13 = {
			"goodman",
		    "brother",
		    "catperson",
		    "rocklob",
		    "spooder",
		    "birdclop",
		    "fish50",
		    --"fish666",
		    "pigking100",
	        "birdcage80",
		},
		cat14 = {
			"demage300",
			"demage1",
			"demage66",
			"minotaurhurt6",
			"beargerhurt5",
			"hurt1",
			"vs10",
			"health1kill",
			"speed160",
			"speed50",
			"usecoin300",
			"killmoonpig10",
		},
		cat15 = {},
	}
	local tb = nil
	if self.owner.checktempachiv:value() then
		tb = StrToTable(self.owner.checktempachiv:value())
		if tb and GetTableLength(tb) > 0 then
			for m,n in pairs(tb) do
				table.insert(allachivlist["cat15"], m)
			end
		end
	end
	self.achivlist = {}
	local achivvalue = 0
	self.allnum = 0
	for k,v in pairs(allachivlist) do
		self.achivlist[k] = {}
		for i,j in pairs(v) do
			local achivitem = {
				name = j,
				check = self.owner["check" .. j] and self.owner["check" .. j]:value() or (tb and tb[j]),
				--current = self.owner["current" .. j] and self.owner["current" .. j]:value() or 0
			}
			if k == "cat15" then
				achivitem = {
					name = j,
					check = tb[j],
				}
			end
			table.insert(self.achivlist[k], achivitem)
		end
		if self.achivlist[k] and k ~= "cat15" and #self.achivlist[k] > 0 then
			for i=1, #self.achivlist[k] do
				if self.achivlist[k][i].name ~= "all" then
					self.allnum = self.allnum + 1
					if self.achivlist[k][i].check and self.achivlist[k][i].check >= (allachiv_eventdata[self.achivlist[k][i].name]) then
						achivvalue = achivvalue + 1
					end
				end
			end
		end
		self.achivcomplete = achivvalue
	end
end

function uiachievement:loadcoinlist()
	self.coinlist = {
		[1] = {
			{
				name = "hungerup",
				current = self.owner.currenthungerup:value(),
			},
			{
				name = "sanityup",
				current = self.owner.currentsanityup:value(),
			},
			{
				name = "healthup",
				current = self.owner.currenthealthup:value(),
			},
			{
				name = "damageup",
				current = self.owner.currentdamageup:value(),
			},
			{
				name = "crit",
				current = self.owner.currentcrit:value(),
			},
			{
				name = "lifesteal",
				current = self.owner.currentlifesteal:value(),
			},
			{
				name = "speedup",
				current = self.owner.currentspeedup:value(),
			},
			{
				name = "absorbup",
				current = self.owner.currentabsorbup:value(),
			},
			{
				name = "level120",
				current = self.owner.currentlevel120:value(),
			},
			{
				name = "attackfrozen",
				current = self.owner.currentattackfrozen:value(),
			},
			{
				name = "attackdead",
				current = self.owner.currentattackdead:value(),
			},
			{
				name = "attackbroken",
				current = self.owner.currentattackbroken:value(),
			},
			--{
			--	name = "fireflylightup",
			--	current = self.owner.currentfireflylightup:value(),
			--},
			{
				name = "attackback",
				current = self.owner.currentattackback:value(),
			},
			{
				name = "stopregen",
				current = self.owner.currentstopregen:value(),
			},
		},
		[2] = {
			{
				name = "fishmaster",
				current = self.owner.currentfishmaster:value(),
			},
			{
				name = "chopmaster",
				current = self.owner.currentchopmaster:value(),
			},
			{
				name = "minemaster",
				current = self.owner.currentminemaster:value(),
			},
			{
				name = "fastworker",
				current = self.owner.currentfastworker:value(),
			},
			{
				name = "cookmaster",
				current = self.owner.currentcookmaster:value(),
			},
			{
				name = "pickmaster",
				current = self.owner.currentpickmaster:value(),
			},
			{
				name = "nomoist",
				current = self.owner.currentnomoist:value(),
			},
			{
				name = "icebody",
				current = self.owner.currenticebody:value(),
			},
			{
				name = "firebody",
				current = self.owner.currentfirebody:value(),
			},
			{
				name = "doubledrop",
				current = self.owner.currentdoubledrop:value(),
			},
			{
				name = "buildmaster",
				current = self.owner.currentbuildmaster:value(),
			},
			{
				name = "refresh",
				current = self.owner.currentrefresh:value(),
			},
			{
				name = "cheatdeath",
				current = self.owner.currentcheatdeath:value(),
			},
			{
				name = "reader",
				current = self.owner.currentreader:value(),
			},
			{
				name = "wescheat",
				current = self.owner.currentwescheat:value(),
			},
			{
				name = "waterwalk",
				current = self.owner.currentwaterwalk:value(),
			},
			
		},
		[3] = { --角色专有

		},
		[4] = { --成就商店
			{
				name = "respawnfromghost",
				current = self.owner.currentrespawnfromghost:value(),
			},
			{
				name = "resettempachiv",
				current = self.owner.currentresettempachiv:value(),
			},
			{
				name = "goldnugget",
				current = self.owner.currentgoldnugget:value(),
			},
			{
				name = "greengem",
				current = self.owner.currentgreengem:value(),
			},
			{
				name = "orangegem",
				current = self.owner.currentorangegem:value(),
			},
			{
				name = "yellowgem",
				current = self.owner.currentyellowgem:value(),
			},
			{
				name = "ice",
				current = self.owner.currentice:value(),
			},
			{
				name = "gears",
				current = self.owner.currentgears:value(),
			},
			{
				name = "dug_grass",
				current = self.owner.currentdug_grass:value(),
			},
			{
				name = "dug_sapling",
				current = self.owner.currentdug_sapling:value(),
			},
			{
				name = "dug_rock_avocado_bush",
				current = self.owner.currentdug_rock_avocado_bush:value(),
			},
			{
				name = "dug_berrybush",
				current = self.owner.currentdug_berrybush:value(),
			},
			{
				name = "blowdart_pipe",
				current = self.owner.currentblowdart_pipe:value(),
			},
			{
				name = "blueprint",
				current = self.owner.currentblueprint:value(),
			},
			--[[{
				name = "gunpowder",
				current = self.owner.currentgunpowder:value(),
			},
			{
				name = "nightsword",
				current = self.owner.currentnightsword:value(),
			},
			{
				name = "slurtlehat",
				current = self.owner.currentslurtlehat:value(),
			},]]
			{
				name = "potion_achiv",
				current = self.owner.currentpotion_achiv:value(),
			},
			{
				name = "recycle",
				current = self.owner.currentrecycle:value(),
			}
		}
	}

	if TUNING.new_items then
		table.insert(self.coinlist[4], {name = "prayer_symbol",current = self.owner.currentprayer_symbol:value(),})
		--table.insert(self.coinlist[4], {name = "package_staff",current = self.owner.currentpackage_staff:value(),})
		table.insert(self.coinlist[4], {name="package_ball", current = self.owner.currentpackage_ball:value(),})
	end
	
	local specialcoin = {
		--wendy
		wendy = {
			{
				name = "abigaillevelup",
				current = self.owner.currentabigaillevelup:value(),
			},
			{
				name = "abigailclone",
				current = self.owner.currentabigailclone:value(),
			}
		},
		--Wigfrid
		wathgrithr = {
			{
				name = "bloodangry",
				current = self.owner.currentbloodangry:value(),
			},
			{
				name = "hitattack",
				current = self.owner.currenthitattack:value(),
			}
		},
		--wes
		wes = {
			{
				name = "balloonlevelup",
				current = self.owner.currentballoonlevelup:value(),
			},
			{
				name = "ballooninspire",
				current = self.owner.currentballooninspire:value(),
			},
		},
		--webber
		webber = {
			{
				name = "callspider",
				current = self.owner.currentcallspider:value(),
			},
			{
				name = "spiderstronger",
				current = self.owner.currentspiderstronger:value(),
			}
		},
		--maxwell
		waxwell = {
			{
				name = "waxwellup",
				current = self.owner.currentwaxwellup:value(),
			}
		},
		--willow
		willow = {
			{
				name = "bernielevelup",
				current = self.owner.currentbernielevelup:value(),
			},
			{
				name = "linghtermore",
				current = self.owner.currentlinghtermore:value(),
			}
		},
		--winona
		winona = {
			{
				name = "winnonaup",
				current = self.owner.currentwinnonaup:value(),
			},
			{
				name = "throwrock",
				current = self.owner.currentthrowrock:value(),
			}
		},
		--willson
		wilson = {
			{
				name = "potion",
				current = self.owner.currentpotion:value(),
			}
		},
		--wx-78
		wx78 = {
			{
				name = "gearuse",
				current = self.owner.currentgearuse:value(),
			},
			{
				name = "lightpower",
				current = self.owner.currentlightpower:value(),
			},
		},
		--wurt
		wurt = {
			{
				name = "callmerm",
				current = self.owner.currentcallmerm:value(),
			},
			{
				name = "mermstronger",
				current = self.owner.currentmermstronger:value(),
			},
			{
				name = "callback",
				current = self.owner.currentcallback:value(),
			}
		},
		--wortox
		wortox = {
			{
				name = "soulmore",
				current = self.owner.currentsoulmore:value(),
			},
		},
		--woodie
		woodie = {
			{
				name = "woodieup",
				current = self.owner.currentwoodieup:value(),
			},
		},
		--warly
		warly = {
			{
				name = "warlyup",
				current = self.owner.currentwarlyup:value(),
			},
			{
				name = "memorykill",
				current = self.owner.currentmemorykill:value(),
			}
		},
		--wormwood
		wormwood = {
			{
				name = "wormwoodup",
				current = self.owner.currentwormwoodup:value(),
			},
		},
		wolfgang = {
			{
				name = "strongeraoe",
				current = self.owner.currentstrongeraoe:value(),
			},
		},
		wickerbottom = {
			{
				name = "wickerbottomup",
				current = self.owner.currentwickerbottomup:value(),
			}
		},
		walter = {
			{
				name = "quickshot",
				current = self.owner.currentquickshot:value(),
			}
		},
	}
	if ThePlayer ~= nil and ThePlayer.prefab ~= nil then
		if specialcoin[ThePlayer.prefab] ~= nil and #specialcoin[ThePlayer.prefab] > 0 then
			for k,v in pairs(specialcoin[ThePlayer.prefab]) do
				table.insert(self.coinlist[3], v)
			end
		end
	end
end

function uiachievement:updateAllStrings()
	self.mainbutton.checkbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.coinbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[8],{ size = 9, offset_x = 15, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configact:SetHoverText(STRINGS.ALLACHIVCURRENCY[15],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configbigger:SetHoverText(STRINGS.ALLACHIVCURRENCY[16],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configsmaller:SetHoverText(STRINGS.ALLACHIVCURRENCY[17],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	
	self.mainui.achievement_bg.title:SetString(STRINGS.GUI["achievementTitle"])
	self.mainui.levelbg.title:SetString(STRINGS.GUI["levelTitle"])
	self.mainui.achievement_bg.close.label:SetSize(45)
	self.mainui.achievement_bg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	self.mainui.achievement_bg.reset.label:SetSize(35)
	self.mainui.achievement_bg.reset.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 100, 50, "", true)
	self.mainui.removeinfo.label:SetSize(28)
	self.mainui.removeinfo.label:SetMultilineTruncatedString(STRINGS.GUI["resetAchievments"], 5, 330, 500, "", true)
	self.mainui.removeinfo.removeyes.label:SetSize(27)
	self.mainui.removeinfo.removeyes.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 70, 50, "", true)
	self.mainui.removeinfo.removeno.label:SetSize(27)
	self.mainui.removeinfo.removeno.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 70, 50, "", true)
	self.mainui.infobutton.cat1.label:SetSize(55)
	self.mainui.infobutton.cat2.label:SetSize(55)
	self.mainui.infobutton.cat3.label:SetSize(55)
	self.mainui.infobutton.cat4.label:SetSize(55)
	self.mainui.infobutton.cat5.label:SetSize(55)
	self.mainui.infobutton.cat6.label:SetSize(55)
	self.mainui.infobutton.cat7.label:SetSize(55)
	self.mainui.infobutton.cat8.label:SetSize(55)
	self.mainui.infobutton.cat9.label:SetSize(55)
	self.mainui.infobutton.cat10.label:SetSize(55)
	self.mainui.infobutton.cat11.label:SetSize(55)
	self.mainui.infobutton.cat12.label:SetSize(55)
	self.mainui.infobutton.cat13.label:SetSize(55)
	self.mainui.infobutton.cat14.label:SetSize(55)
	self.mainui.infobutton.cat15.label:SetSize(55)
	self.mainui.infobutton.cat1.label:SetMultilineTruncatedString(STRINGS.GUI["cat1"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat2.label:SetMultilineTruncatedString(STRINGS.GUI["cat2"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat3.label:SetMultilineTruncatedString(STRINGS.GUI["cat3"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat4.label:SetMultilineTruncatedString(STRINGS.GUI["cat4"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat5.label:SetMultilineTruncatedString(STRINGS.GUI["cat5"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat6.label:SetMultilineTruncatedString(STRINGS.GUI["cat6"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat7.label:SetMultilineTruncatedString(STRINGS.GUI["cat7"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat8.label:SetMultilineTruncatedString(STRINGS.GUI["cat8"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat9.label:SetMultilineTruncatedString(STRINGS.GUI["cat9"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat10.label:SetMultilineTruncatedString(STRINGS.GUI["cat10"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat11.label:SetMultilineTruncatedString(STRINGS.GUI["cat11"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat12.label:SetMultilineTruncatedString(STRINGS.GUI["cat12"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat13.label:SetMultilineTruncatedString(STRINGS.GUI["cat13"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat14.label:SetMultilineTruncatedString(STRINGS.GUI["cat14"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat15.label:SetMultilineTruncatedString(STRINGS.GUI["cat15"], 2, 120, 50, "", true)
	self.mainui.perk_cat.perkcat1.label:SetSize(45)
	self.mainui.perk_cat.perkcat2.label:SetSize(45)
	self.mainui.perk_cat.perkcat3.label:SetSize(45)
	self.mainui.perk_cat.perkcat4.label:SetSize(45)
	self.mainui.perk_cat.perkcat1.label:SetMultilineTruncatedString(STRINGS.GUI["abilities1"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat2.label:SetMultilineTruncatedString(STRINGS.GUI["abilities2"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat3.label:SetMultilineTruncatedString(STRINGS.GUI["abilities3"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat4.label:SetMultilineTruncatedString(STRINGS.GUI["abilities4"], 2, 150, 50, "", true)

	self.mainui.levelbg.attributelabels:SetString(STRINGS.GUI["attributelabels"])
	self.mainui.levelbg.attributeunits:SetString(STRINGS.GUI["attributeunits"])
	self.mainui.levelbg.close.label:SetSize(45)
	self.mainui.levelbg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	self.mainui.levelbg.info:SetMultilineTruncatedString(STRINGS.GUI["iteminfo"], 2, 800, 500, "", true)
	self.mainui.levelbg.overallxp:SetString(STRINGS.GUI["overallxp"]..self.owner.currentoverallxp:value())
	self:build()
	self:perk_build()
end

return uiachievement