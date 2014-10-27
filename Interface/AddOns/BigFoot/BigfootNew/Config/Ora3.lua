---------------------------------------------------------------------------------
local Ora3String ={}
Ora3String.colorText = "(|cff808080oRA3|r)"
if GetLocale()=='zhCN' then
	OPEN = "开启"
	Ora3String.Name = "团队助手 ";
elseif GetLocale()=='zhTW' then
	OPEN = "開啟"
	Ora3String.Name = "團隊助手 ";
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end
ORA2_ENABLE_TEXT = OPEN..(Ora3String.Name or "")..Ora3String.colorText;
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("oRA3",{BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("oRA3","CheckBox","EnableoRA3",ORA2_ENABLE_TEXT,nil,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("oRA3")) then
				BigFoot_LoadAddOn("oRA3");
			end
			oRA3__SetRaidBtn()
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("oRA3")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(ORA2_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
