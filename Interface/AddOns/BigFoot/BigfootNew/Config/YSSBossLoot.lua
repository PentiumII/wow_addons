
if GetLocale() =="zhCN" then
	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS = "开启YssBossLoot副本掉落查询";
	INSTANCE_MAPS_DISABLE_DELAY_TEXT = "|cff00c0c0<副本地图>|r 你已经关闭副本地图(YssBossLoot)模块，该设置将在下次插件载入时生效。";
elseif GetLocale() == "zhTW" then
	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS = "開啟YssBossLoot副本掉落查詢";
	INSTANCE_MAPS_DISABLE_DELAY_TEXT = "|cff00c0c0<副本地圖>|r 你已經關閉副本地圖(YssBossLoot)模組，該設置將在下次插件載入時生效。";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("YssBossLoot",{BFNew_AddonTypeTable[3],BFNew_AddonTypeTable[7],BFNew_AddonTypeTable[9]},nil,nil,true)
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
BFNew_RegisterAddonConfig("YssBossLoot","CheckBox","EnableYssBossLoot",MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS,nil,
	true,-----默认值
	function (arg)
		if (arg ) then
			if (not BigFoot_IsAddOnLoaded("YssBossLoot")) then
				BigFoot_LoadAddOn("YssBossLoot");
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("YssBossLoot")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(INSTANCE_MAPS_DISABLE_DELAY_TEXT); end);
			end
		end
	end
)