---------------------------------------------------------------------------------
local DecursiveString ={}
DecursiveString.colorText = "(|cff808080Decursive|r)"
if GetLocale()=='zhCN' then
	OPEN = "开启"
	DecursiveString.Name = "一键驱散";
elseif GetLocale()=='zhTW' then
	OPEN = "開啟"
	DecursiveString.Name = "一鍵驅散";
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end
DECURSIVE_ENABLE_TEXT = OPEN..(DecursiveString.Name or "")..DecursiveString.colorText;
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Decursive",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
local playerClass = select(2, UnitClass("player"));
if (playerClass ~= "WARRIOR" and playerClass ~= "ROGUE" and playerClass ~= "DEATHKNIGHT" ) then
	BFNew_RegisterAddonConfig("Decursive","CheckBox","EnableDecursive",DECURSIVE_ENABLE_TEXT,nil,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Decursive")) then
				BigFoot_LoadAddOn("Decursive");
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Decursive")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(DECURSIVE_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
end