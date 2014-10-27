---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	ENABLE_QUESTHELPER_TEXT = "启用任务指引(QuestHelperLite)";
	ENABLE_QUESTHELPER_TEXT_TOOLTIP= "为你提供一个最佳的任务参考路线";
elseif GetLocale() == "zhTW" then
	ENABLE_QUESTHELPER_TEXT = "使用任務指引(QuestHelperLite)";
	ENABLE_QUESTHELPER_TEXT_TOOLTIP= "為你提供一個最佳的任務參考路線";
else
	ENABLE_QUESTHELPER_TEXT = "Enable QuestHelperLite";
	ENABLE_QUESTINFO_TEXT = "Enable QuestHubber";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("QuestHelperLite",{BFNew_AddonTypeTable[9]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("QuestHelperLite","CheckBox","EnableQuestHelperLite",ENABLE_QUESTHELPER_TEXT,ENABLE_QUESTHELPER_TEXT_TOOLTIP,
	false,-----默认值
	function(arg,init)
		if (arg) then
			BigFoot_LoadAddOn("QuestHelperLite");
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("QuestHelperLite")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(BF_DISABLE_QH_TIP); end);
			end
		end
	end
	)
