---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	MAP_PLUS_ENABLE_TEXT = "开启地图标记";
	MAP_PLUS_ENABLE_TEXT_TOOLTIP= "可在地图上需要标记的地方点击鼠标左键创建一个标记";
elseif GetLocale() == "zhTW" then
	MAP_PLUS_ENABLE_TEXT = "開啟地圖標記";
	MAP_PLUS_ENABLE_TEXT_TOOLTIP="可在地圖上需要標記的地方那個點擊鼠標鄒建左鍵創建一個標記"
else
	MAP_PLUS_ENABLE_TEXT = "Enable Map Note";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("MapPlus",{BFNew_AddonTypeTable[9]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("MapPlus","CheckBox","EnableMapPlus",MAP_PLUS_ENABLE_TEXT,MAP_PLUS_ENABLE_TEXT_TOOLTIP,
false,-----默认值
function(arg,init)
	if (arg)then
		if (not BigFoot_IsAddOnLoaded("MapPlus")) then
			BigFoot_LoadAddOn("MapPlus");
		end
	end
	if BigFoot_IsAddOnLoaded("MapPlus") then
		if arg then
			MapPlus_ToggleEnable(1)
		else
			MapPlus_ToggleEnable(nil)
		end
	end	 
end
)
 
