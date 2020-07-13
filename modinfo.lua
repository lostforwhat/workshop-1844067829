name = "tumbleweed of all"
description = [[
多种颜色的风滚草，获得各种物品，彩蛋及陷阱
怪物强化，难度提升
专用成就系统，为风滚草模式设计
人物专属技能，加强人物特色，提升可玩性
佩戴称号，各显风采
详情请看创意工坊说明
version:2.3.5 优化及重做部分专属
version:2.3.6 修复开草有时候崩溃的bug
version:2.3.7 修复女工2技能bug
version:2.3.9 修复部分小型bug,角色平衡微调
version:2.3.10 bug fixed
version:2.3.11 新增部分技能
version:2.3.14 调整厨子，奶奶，沃尔特专属

本mod最适合无资源世界开启,建议使用自带成就系统获得最大乐趣
]]
author = "五年"

version = "2.3.15"

api_version = 10

all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

forumthread = ""

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
	{
		name = "start_protect",
		label = "开局保护(protect)",
		hover = "防止开局开出厉害boss打不过",
		options =
		{
			{description = "开启(ON)", data = true, hover = "开启开局保护(3天内不会开出特殊怪物,送开局物品)"},
			{description = "关闭(OFF)", data = false, hover = "关闭开局保护"},
		},
		default = true,
	},
	{
		name = "drop_chance",
		label = "物品掉落(drop chance)",
		hover = "特殊风滚草物品掉落率",
		options =
		{
			{description = "正常(normal)", data = 1, hover = "物品正常掉落率"},
			{description = "增强(more)", data = 2, hover = "掉率增强"},
			{description = "疯狂(most)", data = 10, hover = "掉率大幅增强"},
		},
		default = 1,
	},
	{
		name = "boss_chance",
		label = "boss调整(boss chance)",
		hover = "风滚草boss调整",
		options =
		{
			{description = "有(ON)", data = true, hover = "有boss"},
			{description = "无(OFF)", data = false, hover = "无boss"}
		},
		default = false,
	},
	{
		name = "stronger_boss",
		label = "boss增强(stronger boss)",
		hover = "boss增强",
		options =
		{
			{description = "线性增强(ON)", data = 1, hover = "boss增强(随世界天数增强)"},
			{description = "超级增强(ON)", data = 2, hover = "boss增强(慎用,无法单挑)"},
			{description = "关闭(OFF)", data = 0, hover = "boss正常"},
		},
		default = 0,
	},
	{
		name = "more_blueprint",
		label = "蓝图模式(blueprint mode)",
		hover = "无科技蓝图模式",
		options =
		{
			{description = "开启(ON)", data = true, hover = "锁科技蓝图模式(blueprint mode)"},
			{description = "关闭(OFF)", data = false, hover = "正常"},
		},
		default = false,
	},
	{
		name = "worldregrowth_enabled",
		label = "资源再生(worldregrowth)",
		hover = "资源再生",
		options =
		{
			{description = "开启(ON)", data = true, hover = "资源再生(worldregrowth)"},
			{description = "关闭(OFF)", data = false, hover = "禁止(disabled)"},
		},
		default = false,
	},
	{
		name = "new_items",
		label = "新物品(new items)",
		options = 
		{
			{description = "开启(ON)", data = true, hover = "新物品(new items)"},
			{description = "关闭(OFF)", data = false, hover = "关闭(disabled)"},
		},
		default = false,
	},
	{
		name = "achievement_system",
		label = "专用成就系统(achievement system)",
		options = {
			{description = "开启(ON)", data = true, hover = "使用专用成就系统(use achievement system)"},
			{description = "关闭(OFF)", data = false, hover = "关闭(disabled)"},
		},
		default = false,
	},
	{
		name = "vip",
		options = {}
	},
	{
		name = "vipurl"
	}
}