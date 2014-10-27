
if (GetLocale() == "zhCN") then
	ENABLE_QUESTINFO_TEXT = "启用任务搜索(QuestHubber)";
	ENABLE_QUESTINFO_TEXT_TOOLTIP= "可以在世界地图上标记你尚未完成的任务";
	BF_DISABLE_QI_TIP = "|cff00c0c0<任务查询>|r 你已经关闭任务查询(QuestHubber)模块，该设置将在下次插件载入时生效。";
elseif (GetLocale() == "zhTW") then
	ENABLE_QUESTINFO_TEXT = "啟用任務搜索(QuestHubber)";
	ENABLE_QUESTINFO_TEXT_TOOLTIP= "可以在世界地圖上標記你尚未完成的任務";
	BF_DISABLE_QI_TIP = "|cff00c0c0<任務查詢>|r 你已经關閉任務查詢(QuestHubber)模块，該設置將在下次外掛程式載入時生效。";
else
	ENABLE_QUESTINFO_TEXT = "Enable QuestHubber";
end

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("QuestHubber",{BFNew_AddonTypeTable[9]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 配置的类型。-----------------------------------
--------------参数3 配置名字-----------------------------------
--------------参数4 配置显示的名字-----------------------------------
--------------参数5 配置的鼠标提示-----------------------------------
--------------参数6 （Checkbox）配置的默认值  ----  true false 不要为nil-----------------------------------
--------------参数7 （Checkbox）配置的CallBack函数  2个参数 第一个为 toggle_value  为 true or false  后一个为是否初始化的标识-----------------------------------
--------------参数8 配置的层级 默认0-----------------------------------
BFNew_RegisterAddonConfig("QuestHubber","CheckBox","EnableQuestHubber",ENABLE_QUESTINFO_TEXT,ENABLE_QUESTINFO_TEXT_TOOLTIP,
	false,-----默认值
	function (arg)
		if (arg ) then
			BigFoot_LoadAddOn("QuestHubber");
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("QuestHubber")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(BF_DISABLE_QI_TIP); end);
			end
		end
	end
)