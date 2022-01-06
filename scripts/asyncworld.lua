---此功能直接使用mod [workshop-1396615817] 的功能
---由于原mod在旧神版本后未更新无法使用，所以直接将此功能拿出来修改后使用

-- 参考文档:https://wiki.luatos.com/_static/lua53doc/manual.html#pdf-debug.getlocal
-- ...\scripts\components\seasons.lua

local function RetrieveLastEventListener(source, event, inst)
	local temp
	for i,v in ipairs(source.event_listeners[event][inst]) do -- 获取世界对应名称的事件监听器
		temp = v
	end
	return temp
end

local function getval(fn, path)
	local val = fn
	for entry in path:gmatch("[^%.]+") do -- 正则: 取一个或多个任意字符的补集
		local i=1
		while true do
			local name, value = GLOBAL.debug.getupvalue(val, i) -- 此函数返回函数 val 的第 i 个上值的名字和值。 如果该函数没有那个上值，返回 nil 。 值为任意类型
			if name == entry then 
				val = value
				break
			elseif name == nil then -- 到最后，也没有找到
				return
			end
			i=i+1
		end
	end
	return val
end

local function setval(fn, path, new)
	local val = fn
	local prev = nil
	local i
	for entry in path:gmatch("[^%.]+") do
		i = 1
		prev = val
		while true do
			local name, value = GLOBAL.debug.getupvalue(val, i)
			if name == entry then
				val = value
				break
			elseif name == nil then
				return
			end
			i=i+1
		end
	end
	GLOBAL.debug.setupvalue(prev, i ,new) -- 这个函数将 new 设为函数 prev 的第 i 个上值。 如果函数没有那个上值，返回 nil 否则，返回该上值的名字。 
end

local function isslave()
	return GLOBAL.TheWorld.ismastersim and not GLOBAL.TheWorld.ismastershard
end

local function ClockConverter(self)
	local world = GLOBAL.TheWorld
	if isslave() then
		local _segs = getval(self.OnUpdate, "_segs")
		local OldOnClockUpdate = RetrieveLastEventListener(world, "secondary_clockupdate", self.inst)
		self.inst:RemoveEventCallback("secondary_clockupdate", OldOnClockUpdate, world)
		
		local function OnClockUpdate(src, data)
			local totalsegs = 0
			local remainsegs = 0
			
			for i, v in ipairs(data.segs) do
				if i < data.phase then totalsegs = totalsegs + v end
			end
			totalsegs = totalsegs + (data.totaltimeinphase - data.remainingtimeinphase) / TUNING.SEG_TIME
			
			for i, v in ipairs(_segs) do
				local old_totalsegs = totalsegs
				data.segs[i] = v:value()
				totalsegs = totalsegs - v:value()
				if totalsegs < 0 then
					if old_totalsegs >= 0 then
						data.phase = i
						remainsegs = -totalsegs
					end
				end
			end
			
			data.totaltimeinphase = _segs[data.phase]:value() * TUNING.SEG_TIME
			data.remainingtimeinphase = remainsegs * TUNING.SEG_TIME
			OldOnClockUpdate(src, data)
		end
		self.inst:ListenForEvent("secondary_clockupdate", OnClockUpdate, world)
		setval(self.OnUpdate, "_ismastershard", true)
	end
end
AddComponentPostInit("clock", ClockConverter)

local function SeasonsConverter(self)
	local world = GLOBAL.TheWorld
	if isslave() then -- 是服务器或者主碎片
		local PushSeasonClockSegs = getval(self.OnLoad, "PushSeasonClockSegs") -- 获取到 更新当前世界季节时钟
		setval(PushSeasonClockSegs, "_ismastershard", true) -- 修改局部变量，为true, 表示这个世界是主世界，使其中代码完全执行
		
		local DEFAULT_CLOCK_SEGS = getval(self.OnLoad, "DEFAULT_CLOCK_SEGS") -- 季节昼夜长短表
		local SEASON_NAMES = getval(self.OnLoad, "SEASON_NAMES")			 -- 季节表
		local _segs = getval(self.OnLoad, "_segs") 							 -- 当前世界季节信息表
		
		local function OnSetSeasonClockSegs(src, segs) -- 设置季节时钟间隔
			local default = nil
			for k, v in pairs(segs) do
				default = v
				break
			end

			if default == nil then
				if segs ~= DEFAULT_CLOCK_SEGS then
					OnSetSeasonClockSegs(DEFAULT_CLOCK_SEGS)
				end
				return
			end

			for i, v in ipairs(SEASON_NAMES) do 
				segs[i] = _segs[v] or default
			end

			PushSeasonClockSegs()
		end
		
		local function OnSetSeasonSegModifier(src, mod)
			setval(PushSeasonClockSegs, "_segmod", mod)
			PushSeasonClockSegs()
		end
		
		self.inst:ListenForEvent("ms_setseasonclocksegs", OnSetSeasonClockSegs, world)
		self.inst:ListenForEvent("ms_setseasonsegmodifier", OnSetSeasonSegModifier, world)
		
		-- 对组件内的网络变量其对应监听器进行调整
		-- 1、 获取对应监听器的方法
		-- 2、 PushMasterSeasonData 这个方法是主世界推送季节数据到其他碎片世界的，这里直接修改为空方法，就不会执行被推送了
		local OnSeasonDirty = RetrieveLastEventListener(self.inst, "seasondirty", self.inst)
		local OnLengthsDirty = RetrieveLastEventListener(self.inst, "lengthsdirty", self.inst)
		setval(OnSeasonDirty, "PushMasterSeasonData", function() end)
		setval(OnLengthsDirty, "PushMasterSeasonData", function() end)

		local OnSeasonsUpdate = RetrieveLastEventListener(world, "secondary_seasonsupdate", self.inst)
		self.inst:RemoveEventCallback("secondary_seasonsupdate", OnSeasonsUpdate, world)
	end
end
AddComponentPostInit("seasons", SeasonsConverter)