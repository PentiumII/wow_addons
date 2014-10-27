---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	TEAMNOTICE_ENABLE_PARTY_TEXT="开启小队公告"
	TEAMNOTICE_ENABLE_PARTY_TOOLTIP = "当有新队员加入到小队中时自动发送消息。"

	TEAMNOTICE_PARTY_CONFIG="设置小队公告"

	TEAMNOTICE_ENABLE_RAID_TEXT="开启团队公告及密语"
	TEAMNOTICE_ENABLE_RAID_TOOLTIP = "当有新队员加入到团队中时自动发送可设置的消息。"

	TEAMNOTICE_RAID_CONFIG="设置团队公告";
	
	ENABLE_QUEST_LEVEL_TEXT = "显示任务等级";
	ENABLE_QUEST_LEVEL_TOOLTIP= "在任务面板内显示任务等级";

	ENABLE_QUEST_FastQuest_TEXT	= "小队任务公告";
	ENABLE_QUEST_FastQuest_TOOLTIP = "在小队模式下公布你的任务进度";

	ENABLE_QUEST_FastQuestInfo_TEXT	= "详细任务进度";
	ENABLE_QUEST_FastQuestInfo_TOOLTIP = "公布具体的任务更新进程";
elseif GetLocale() == "zhTW" then
	TEAMNOTICE_ENABLE_PARTY_TEXT="開啟小隊公告"
	TEAMNOTICE_ENABLE_PARTY_TOOLTIP = "當有新隊員加入到小隊中時自動發送消息"

	TEAMNOTICE_PARTY_CONFIG="設置小隊公告"

	TEAMNOTICE_ENABLE_RAID_TEXT="開啟團隊公告及密語"
	TEAMNOTICE_ENABLE_RAID_TOOLTIP = "當有新隊員加入到團隊中時自動發送可設置的消息"

	TEAMNOTICE_RAID_CONFIG="設置團隊公告";
	
	ENABLE_QUEST_LEVEL_TEXT = "顯示任務等級";
	ENABLE_QUEST_LEVEL_TOOLTIP= "在任務面板內顯示任務等級";

	ENABLE_QUEST_FastQuest_TEXT	= "小隊任務公告";
	ENABLE_QUEST_FastQuest_TOOLTIP = "在組隊模式下公佈你的任務進度";

	ENABLE_QUEST_FastQuestInfo_TEXT	= "詳細任務進度";
	ENABLE_QUEST_FastQuestInfo_TOOLTIP = "公佈具體的任務更新進程";
	
else
	TEAMNOTICE_ENABLE_PARTY_TEXT="Open squad announcement"
	TEAMNOTICE_ENABLE_PARTY_TOOLTIP = "When a new players to join squad automatic messaging."

	TEAMNOTICE_PARTY_CONFIG="Set Team announcement"

	TEAMNOTICE_ENABLE_RAID_TEXT="Open raid announcement and code"
	TEAMNOTICE_ENABLE_RAID_TOOLTIP = "When a new players join hitting send messages can be set."

	TEAMNOTICE_RAID_CONFIG="Setting Raid announcement";
	
	ENABLE_QUEST_LEVEL_TEXT = "Show Quest Level";
	ENABLE_QUEST_LEVEL_TOOLTIP= "Show Quest Level On QuestLog";

	ENABLE_QUEST_FastQuest_TEXT	= "Squad announcement task";
	ENABLE_QUEST_FastQuest_TOOLTIP = "In group mode to publish your task progress.";

	ENABLE_QUEST_FastQuestInfo_TEXT	= "Detailed task progress";
	ENABLE_QUEST_FastQuestInfo_TOOLTIP = "Announce specific mission update process.";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BFQuest",{BFNew_AddonTypeTable[3],BFNew_AddonTypeTable[9]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("BFQuest","CheckBox","EnableTeamNoticeParty",TEAMNOTICE_ENABLE_PARTY_TEXT,TEAMNOTICE_ENABLE_PARTY_TOOLTIP,
false,-----默认值
function(arg,init)
	if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
		BigFoot_LoadAddOn("BFQuest");
	end
	if (arg) then
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("TeamNotice")
	else
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("TeamNotice")
	end
	if arg then
		Auto_TeamNotice_Party(1)
	else
		Auto_TeamNotice_Party(nil);
	end
end
)
 
BFNew_RegisterAddonConfig("BFQuest","Button","EnableButtonPartyToolkit",TEAMNOTICE_PARTY_CONFIG,nil,
false,-----默认值
function(arg,init)
	if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
		BigFoot_LoadAddOn("BFQuest");
	end
	StaticPopup_Show("TEAMNOTICE_PARTY_COMMENT");
	PlaySound("igMainMenuOption");
end,1
)

BFNew_RegisterAddonConfig("BFQuest","CheckBox","EnableTeamNoticeRaid",TEAMNOTICE_ENABLE_RAID_TEXT,TEAMNOTICE_ENABLE_RAID_TOOLTIP,
true,-----默认值
function(arg,init)
	if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
		BigFoot_LoadAddOn("BFQuest");
	end
	if (arg) then
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("TeamNotice")
	else
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("TeamNotice")
	end
	if arg then
		Auto_TeamNotice_Raid(1)
	else
		Auto_TeamNotice_Raid(nil);
	end
end
)
BFNew_RegisterAddonConfig("BFQuest","Button","EnableButtonPartyToolkit1",TEAMNOTICE_RAID_CONFIG,nil,
false,-----默认值
function(arg,init)
	if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
		BigFoot_LoadAddOn("BFQuest");
	end
	StaticPopup_Show("TEAMNOTICE_SET_COMMENT");
	PlaySound("igMainMenuOption");
end,1
)

BFNew_RegisterAddonConfig("BFQuest","CheckBox","EnableQuestLvl",ENABLE_QUEST_LEVEL_TEXT,ENABLE_QUEST_LEVEL_TOOLTIP,
true,-----默认值
function(arg,init)
	if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
		BigFoot_LoadAddOn("BFQuest");
	end
	if (arg) then
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("Level")
	else
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("Level")
	end
end
)

BFNew_RegisterAddonConfig("BFQuest","CheckBox","EnableQuestBroad",ENABLE_QUEST_FastQuest_TEXT,ENABLE_QUEST_FastQuest_TOOLTIP,
true,-----默认值
function(arg,init)
	if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
		BigFoot_LoadAddOn("BFQuest");
	end
	if (arg) then
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("Broadcast")
	else
		LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("Broadcast")
	end
end
)

BFNew_RegisterAddonConfig("BFQuest","CheckBox","EnableQuestBroadInfo",ENABLE_QUEST_FastQuestInfo_TEXT,ENABLE_QUEST_FastQuestInfo_TOOLTIP,
false,-----默认值
function(arg,init)
	if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
		BigFoot_LoadAddOn("BFQuest");
	end
	if (arg) then
		Auto_FastQuestInfo(1)
	else
		Auto_FastQuestInfo(nil)
	end
end,1
)
