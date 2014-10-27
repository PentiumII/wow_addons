if GetLocale() == "zhCN" then
	BattleHapper_ENABLE_TEXT = "开启战场助手";
	BattleHapper_ENABLE_TEXT_TOOLTIP = "显示更多的战场信息";
	BattleHapper_Warning_ENABLE_TEXT = "开启托尔巴拉德开局提示";
	BattleHapper_DYWarning_ENABLE_TEXT = "开启冬拥湖开局提示";
elseif GetLocale() == "zhTW" then
	BattleHapper_ENABLE_TEXT = "開啟戰場助手";
	BattleHapper_ENABLE_TEXT_TOOLTIP = "顯示更多的戰場資訊";
	BattleHapper_Warning_ENABLE_TEXT = "開啟托爾巴拉德開局提示";
	BattleHapper_DYWarning_ENABLE_TEXT = "開啟冬握湖開局提示";
else
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BattleHapper",{BFNew_AddonTypeTable[2]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
BFNew_RegisterAddonConfig("BattleHapper","CheckBox","EnableBattleHapperWarning",BattleHapper_ENABLE_TEXT,BattleHapper_ENABLE_TEXT_TOOLTIP,
false,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("BattleHapper")) then
			BigFoot_LoadAddOn("BattleHapper");
		end
		if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
			BattleHapperToggle(arg)
		end
	else
		if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
			BattleHapperToggle(arg)
		end
	end
end
)
BFNew_RegisterAddonConfig("BattleHapper","CheckBox","EnableBattleHapperWarning",BattleHapper_Warning_ENABLE_TEXT,nil,
true,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("BattleHapper")) then
			BigFoot_LoadAddOn("BattleHapper");
		end
		if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
			BattleHapperToggle_warning(1)
		end
	else
		if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
			BattleHapperToggle_warning(0)
		end
	end
end,1
)
BFNew_RegisterAddonConfig("BattleHapper","CheckBox","EnableBattleHapperDYWarning",BattleHapper_DYWarning_ENABLE_TEXT,nil,
false,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("BattleHapper")) then
			BigFoot_LoadAddOn("BattleHapper");
		end
		if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
			BattleHapperToggle_DYwarning(1)
		end
	else
		if (BigFoot_IsAddOnLoadedFromBigFoot("BattleHapper")) then
			BattleHapperToggle_DYwarning(0)
		end
	end
end,1
)
 