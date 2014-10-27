---------------------------------------------------------------------------------
local RecountString ={}
RecountString.colorText = "(|cff808080Recount|r)"
if GetLocale()=='zhCN' then
	OPEN = "开启"
	RecountString.Name = "伤害统计";
elseif GetLocale()=='zhTW' then
	OPEN = "開啟"
	RecountString.Name = "傷害統計";
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end
RECOUNT_ENABLE_TEXT = OPEN..(RecountString.Name or "")..RecountString.colorText;
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Recount",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("Recount","CheckBox","EnableRecount",RECOUNT_ENABLE_TEXT,nil,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Recount")) then
				BigFoot_LoadAddOn("Recount");
			end
			if (not BigFoot_IsAddOnLoaded("RecountFailBot")) then
				BigFoot_LoadAddOn("RecountFailBot");
			end
			if (not BigFoot_IsAddOnLoaded("RecountGuessedAbsorbs")) then
				BigFoot_LoadAddOn("RecountGuessedAbsorbs");
			end
			if (not BigFoot_IsAddOnLoaded("RecountThreat")) then
				BigFoot_LoadAddOn("RecountThreat");
			end
			if (not BigFoot_IsAddOnLoaded("RecountDeathTrack")) then
				BigFoot_LoadAddOn("RecountDeathTrack");
			end
			if (not BigFoot_IsAddOnLoaded("RecountHealAndGuessedAbsorbs")) then
				BigFoot_LoadAddOn("RecountHealAndGuessedAbsorbs");
			end

		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Recount")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(RECOUNT_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
