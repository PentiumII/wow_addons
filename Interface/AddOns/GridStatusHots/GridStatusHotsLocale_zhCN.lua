﻿--[[--------------------------------------------------------------------
	GridStatusHotsLocale_zhCN.lua
	Simplified Chinese (ç®€ä½“ä¸­æ–‡) localization for GridStatusHots.
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end
local _, GridStatusHots = ...
GridStatusHots.L = {
	["My HoTs"] = "我的HoTs(持续性治疗)",
	["Hots: Hot Count"] = "HoT: 总数",
	["Hots: My Renew"] = "HoT: 恢复",
	["Hots: My Rejuvenation"] = "HoT: 回春",
	["Hots: My Regrowth"] = "HoT: 愈合",
	["Hots: My Lifebloom"] = "HoT: 生命绽放",
	["Hots: My Lifebloom Stack Colored"] = "HoT: 生命绽放层数(染色)",
	["Hots: My Wild Growth"] = "HoT: 野性成长",
	["Hots: My Riptide"] = "HoT: 激流",
	["Hots: My Earthliving"] = "HoT: 大地生命",
	["Hots: My Earth Shield"] = "HoT: 大地之盾",
	["Hots: My Gift of the Naaru"] = "HoT: 纳鲁的赐福",
	["Hots: My Prayer of Mending"] = "HoT: 愈合祷言",
	["Hots: My Prayer of Mending - duration colored"] = "HoT: 愈合祷言(染色)",
	["Hots: Power Word: Shield"] = "HoT: 真言术：盾",
	["Hots: Weakened Soul"] = "HoT: 虚弱灵魂",
	["Hots: Divine Aegis"] = "HoT: 神圣庇护",
	["Hots: Inspiration"] = "HoT: 灵感",
	["Hots: Ancestral Fortitude"] = "HoT: 先祖坚韧", -- missing translation
	["Hots: My Beacon of Light"] = "HoT: 圣光道标",
	["Hots: My Eternal Flame"] = "HoT: 永恒之火",
	["Hots: My Sacred Shield"] = "HoT: 圣洁护盾",
	["Hots: My Grace Stack"] = "HoT: 恩赐层数",
	["Hots: My Grace Duration + Stack"] = "HoT: 恩赐计时+层数",
	["Hots: Ancestral Vigor"] = "HoT: 先祖活力",
	["Hots: My Renewing Mist"] = "HoT: 复苏之雾",
	["Hots: My Zen Sphere"] = "HoT: 禅意珠",
	["Hots: My Enveloping Mist"] = "HoT: 氤氲之雾",
	["Color when player has two charges of PoM."] = "当愈合祷言剩余次数为2的时候染色",
	["Color when player has three charges of PoM."] = "当愈合祷言剩余次数为3的时候染色",
	["Color when player has four charges of PoM."] = "当愈合祷言剩余次数为4的时候染色",
	["Color when player has five charges of PoM."] = "当愈合祷言剩余次数为5的时候染色",
	["Color when player has six charges of PoM."] = "当愈合祷言剩余次数为6的时候染色",
	["Color when player has 2 charges of Earth Shield."] = "当玩家身上的大地之盾剩2层时染色.",
	["Color when player has 3 charges of Earth Shield."] = "当玩家身上的大地之盾剩3层时染色.",
	["Color when player has 4 charges of Earth Shield."] = "当玩家身上的大地之盾剩4层时染色.",
	["Color when player has 5 or more charges of Earth Shield."] = "当玩家身上的大地之盾剩5层及以上时染色.",
	["Color when player has two charges of grace."] = "当玩家具有2层恩赐效果时染色.",
	["Color when player has three charges of grace."] = "当玩家具有3层恩赐效果时染色.",
	["Threshold to activate color 2"] = "启动颜色2临界值",
	["Threshold to activate color 3"] = "启动颜色3临界值",
	["Color 2"] = "颜色2",
	["Color 3"] = "颜色3",
	["Color 4"] = "颜色4",
	["Color 5"] = "颜色5",
	["Color 6"] = "颜色6",
	["Refresh frequency"] = "刷新频率",
	["Seconds between status refreshes"] = "两次状态刷新间的时间",
	["Count Lifebloom as 1 HoT per stack"] = "每层生命绽放统计为1个HoT",
	["Check, if you want each stack of Lifebloom to count as 1 HoT"]= "勾选后,每层生命绽放将作为1个Hot来统计",
	["Show HoT-Counter"] = "显示Hot计数器",
	["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"]= "勾选后,在你的Hot冷却计数后可以看到总的Hot数量",
	["Combine Timers"] = "合并计时",
	["Check, if you want to see the Weakened Soul Timer behind the Pw: Shield Timer(i.e. 13-5)"]= "选中此项，会把虚弱灵魂的时间显示在真言术盾的剩余时间后，例如13-5",
	["Show decimals"] = "显示一位小数",
	["Check, if you want to see one decimal place for your Lifebloom(i.e. 7.1)"] = "选中此项，你的生命绽放的剩余时间会精确到一位小数，例如7.1",
	["Only mine"] = "只显示我施放的",
	["Only show my PoM"] = "只显示我施放的愈合祷言",
}
