---------------------------------------------------------------------------------
local GridString ={}
GridString.colorText = "(|cff808080Grid|r)"
if GetLocale()=='zhCN' then
	OPEN = "开启"
	GridString.Name = "团队框架 ";
elseif GetLocale()=='zhTW' then
	OPEN = "開啟"
	GridString.Name = "團隊框架 ";
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end
GRID_ENABLE_TEXT = OPEN..(GridString.Name or "")..GridString.colorText;
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Grid",{BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("Grid","CheckBox","EnableGrid",GRID_ENABLE_TEXT,nil,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Grid")) then
				BigFoot_LoadAddOn("Grid");
			end

			if (BigFoot_IsAddOnLoaded("Grid")) then
				Grid:Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Grid")) then
				Grid:Toggle(false);
				--BigFoot_RequestReloadUI(function() BigFoot_Print(GRID_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
