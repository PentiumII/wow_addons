---------------------------------------------------------------------------------
local ThreatString ={}
ThreatString.colorText = "(|cff808080Omen3|r)"
if GetLocale()=='zhCN' then
	OPEN = "开启"
	ThreatString.Name = "仇恨统计 ";
	
	DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭首领报警(DBM)模块，该设置将在下次插件载入时生效。";
	GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭团队框架(Grid)模块，该设置将在下次插件载入时生效。";
	ORA2_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭团队助手(oRA3)模块，该设置将在下次插件载入时生效。";
	DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭一键驱散(Decursive)模块，该设置将在下次插件载入时生效。";
	Skada_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭战斗统计(Skada)模块，该设置将在下次插件载入时生效。";
	THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭仇恨统计(Omen3)模块，该设置将在下次插件载入时生效。";
	RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭团队报警(RaidAlerter)模块，该设置将在下次插件载入时生效。";
	
elseif GetLocale()=='zhTW' then
	OPEN = "開啟"
	ThreatString.Name = "仇恨統計 ";
	
	DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<首領報警>|r 你已經關閉首領報警(DBM)模組，該設置將在下次外掛程式載入時生效。";
	GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊框架>|r 你已經關閉團隊框架(Grid)模組，該設置將在下次外掛程式載入時生效。";
	ORA2_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊助手>|r 你已經關閉團隊助手(oRA3)模組，該設置將在下次外掛程式載入時生效。";
	DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<一鍵驅散>|r 你已經關閉一鍵驅散(Decursive)模組，該設置將在下次外掛程式載入時生效。";
	Skada_DISABLE_DELAY_TEXT = "|cff00c0c0<傷害統計>|r 你已經關閉戰鬥統計(Skada)模組，該設置將在下次外掛程式載入時生效。";
	THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<仇恨統計>|r 你已經關閉仇恨統計(Omen3)模組，該設置將在下次外掛程式載入時生效。";
	RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊報警>|r 你已經關閉團隊報警(RaidAlerter)模組，該設置將在下次外掛程式載入時生效。";
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end
THREAT_ENABLE_TEXT = OPEN..(ThreatString.Name or "")..ThreatString.colorText;
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Omen",{BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
 
	BFNew_RegisterAddonConfig("Omen","CheckBox","EnableThreat",THREAT_ENABLE_TEXT,nil,
	false,-----默认值
	function(arg,init)
		if (arg ) then
			if (not BigFoot_IsAddOnLoaded("Omen")) then
				BigFoot_LoadAddOn("Omen");
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Omen")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(THREAT_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
 