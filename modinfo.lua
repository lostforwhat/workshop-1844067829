name = "tumbleweed of all"
description = [[
多种颜色的风滚草，获得各种物品，彩蛋及陷阱
怪物强化，难度提升
专用成就系统，为风滚草模式设计
人物专属技能，加强人物特色，提升可玩性
佩戴称号，各显风采
详情请看创意工坊说明
version:2.4 解决打蚁狮、温蒂激怒姐姐崩服问题
version:2.6.1 解决一些崩服问题，加入新掉落物品了
version:2.6.9 修复了双倍采集对作物失效问题
version:2.6.10 新增难度模式
version:2.6.11 修复旺达吸血技能无法生效的bug
version:2.6.12 新增风滚草掉落物、新任务、兼容神话boss、补充热冷食任务的食物

本mod最适合无资源世界开启,建议使用自带成就系统获得最大乐趣

月：部分新彩蛋和陷阱，参考了花样风滚草mod和能力勋章mod的代码，喜欢风滚草玩法的玩家不要错过了花样风滚草。
]]
author = "五年,月"

version = "2.6.12final"

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
			{description = "线性增强加强(ON)", data = 2, hover = "boss增强(随世界天数增强,增加难度)"},
			{description = "超级增强(ON)", data = 3, hover = "boss增强(慎用,无法单挑)"},
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