---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	MAP_MARK_ENABLE = "开启NPC位置";
	MAP_MARK_ENABLE_TOOLTIP= "在地图上以图标方式显示NPC位置";
elseif GetLocale() == "zhTW" then
	MAP_MARK_ENABLE = "開啟NPC位置";
	MAP_MARK_ENABLE_TOOLTIP= "在地圖上以圖表方式顯示NPC位置";
else
	MAP_MARK_ENABLE = "Enable NPC locations";
end


-----------------注册插件类型-----------------------------------
------------参数1 插件的名字-----------------------------------
------------参数2 插件的类型。-----------------------------------
------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BigFootMark",{BFNew_AddonTypeTable[9]},nil,nil,true)
------------------------------------------------------------
------------------------------------------------------------
-----------------注册插件互斥信息-------------------------------------------
-----------------参数1 互斥的插件名字列表的Tab-------------------------------------------
BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("BigFootMark","CheckBox","MapMarkEnable",	MAP_MARK_ENABLE,MAP_MARK_ENABLE_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg)then
		if (not BigFoot_IsAddOnLoaded("BigFootMark")) then
			BigFoot_LoadAddOn("BigFootMark");
		end
		-- BFM_ToggleEnable(1)
	else
		if BigFoot_IsAddOnLoaded("BigFootMark") then
			-- BFM_ToggleEnable(0)
		end
	end
end
)
 
