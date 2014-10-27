---------------------------------------------------------------------------------
local DBMString ={}
DBMString.colorText = "(|cff808080DBM|r)"
if GetLocale()=='zhCN' then
	OPEN = "开启"
	DBMString.Name = "首领报警 ";
elseif GetLocale()=='zhTW' then
	OPEN = "開啟"
	DBMString.Name = "首領報警 ";
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end
DBM_ENABLE_TEXT = OPEN..(DBMString.Name or "")..DBMString.colorText;
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("DBM-Core",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2],BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("DBM-Core","CheckBox","EnableDBM",DBM_ENABLE_TEXT,nil,
	false,-----默认值
	function(arg,init)
		if (arg ) then
			if (not BigFoot_IsAddOnLoaded("DBM-StatusBarTimers")) then
				BigFoot_LoadAddOn("DBM-StatusBarTimers");
			end
			if (not BigFoot_IsAddOnLoaded("DBM-Core")) then
				BigFoot_LoadAddOn("DBM-Core");
				BigFoot_DelayCall(function() if DBM then DBM.Options.SettingsMessageShown = true end end,5)
			end
			if (not BigFoot_IsAddOnLoaded("DBM-SpellTimers")) then
				BigFoot_LoadAddOn("DBM-SpellTimers");
			end
			if (not BigFoot_IsAddOnLoaded("DBM-RaidLeadTools")) then
				BigFoot_LoadAddOn("DBM-RaidLeadTools");
			end
			if (not BigFoot_IsAddOnLoaded("DBM-DefaultSkin")) then
				BigFoot_LoadAddOn("DBM-DefaultSkin");
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("DBM-Core")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(DBM_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
