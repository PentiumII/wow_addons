---------------------------------------------------------------------------------
local SkadaString ={}
SkadaString.colorText = "(|cff808080Skada|r)"
if GetLocale()=='zhCN' then
	OPEN = "开启"
	SkadaString.Name = "战斗统计";
elseif GetLocale()=='zhTW' then
	OPEN = "開啟"
	SkadaString.Name = "戰鬥統計";
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end

Skada_ENABLE_TEXT = OPEN..(SkadaString.Name or "")..SkadaString.colorText;

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Skada",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("Skada","CheckBox","EnableSkada",Skada_ENABLE_TEXT,nil,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Skada")) then
				BigFoot_LoadAddOn("Skada");
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Skada")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(Skada_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
