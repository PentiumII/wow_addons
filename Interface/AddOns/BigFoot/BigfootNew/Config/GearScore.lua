if GetLocale() =="zhCN" then
	MOD_INFO_ENABLE_GS = "启用装备计分(GS)"
	MOD_INFO_ENABLE_GS_TOOLTIP = "显示玩家装备的评分"
elseif GetLocale() == "zhTW" then
	MOD_INFO_ENABLE_GS = "啟用裝備計分(GS)"
	MOD_INFO_ENABLE_GS_TOOLTIP= "顯示玩家裝備的評分"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("GearScoreLite",{BFNew_AddonTypeTable[7]},nil,nil,false)
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

BFNew_RegisterAddonConfig("GearScoreLite","CheckBox","EnableGearScore2",MOD_INFO_ENABLE_GS,MOD_INFO_ENABLE_GS_TOOLTIP,
false,-----默认值
	function (arg)
		if ( arg ) then
			if (not BigFoot_IsAddOnLoaded("GearScoreLite")) then
				BigFoot_LoadAddOn("GearScoreLite");
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("GearScoreLite") then
				GS_Toggle(true);
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("GearScoreLite") then
				GS_Toggle(false);
			end
		end
	end
)