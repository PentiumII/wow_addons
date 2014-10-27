if GetLocale() =="zhCN" then
	SPELL_TRIGGER_ENABLE = "启用技能触发监控";
	EVENTALERT_TIPS = "关闭系统技能触发提示";
	SPELL_TRIGGER_CONFIG = "配置";
elseif GetLocale() == "zhTW" then
	SPELL_TRIGGER_ENABLE = "啟用技能觸發監控";
	EVENTALERT_TIPS = "關閉系統機能觸發提示";
	SPELL_TRIGGER_CONFIG = "配置";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("EventAlertMod",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2]},nil,nil,true)
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
BFNew_RegisterAddonConfig("EventAlertMod","CheckBox","EnableEventAlert",SPELL_TRIGGER_ENABLE,nil,
true,-----默认值
	function (arg)
		if (arg) then
			if not BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod") then
				BigFoot_LoadAddOn("EventAlertMod")
			end
			if (BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod")) then
				EventAlert_Toggle(true)
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod")) then
				EventAlert_Toggle(false)
			end
		end
	end
)
BFNew_RegisterAddonConfig("EventAlertMod","Button","EventAlert_Option",SPELL_TRIGGER_CONFIG,nil,
nil,-----默认值
	function()
		if (BigFoot_IsAddOnLoadedFromBigFoot("EventAlertMod")) then
			if BigfootNewMainFrame:IsShown()then
				-- EA_Options_Frame:SetPoint("LEFT",BigfootNewMainFrame,"RIGHT")
				EA_Options_Frame:SetFrameStrata("DIALOG")
			end
			EA_Options_Frame:Show();
		end
	end,1
)
local defaultValue  = false
do
	if GetCVarBool("displaySpellActivationOverlays") ==1 then
		defaultValue = false
	else
		defaultValue = true
	end
end
BFNew_RegisterAddonConfig("EventAlertMod","CheckBox","Disable_systemspellalert",EVENTALERT_TIPS,nil,
defaultValue,-----默认值
	function (arg)
		if(arg)then
			if (GetCVar("displaySpellActivationOverlays") == "1") then
				SetCVar("displaySpellActivationOverlays", "0");
			end
		else
			if (GetCVar("displaySpellActivationOverlays") == "0") then
				SetCVar("displaySpellActivationOverlays", "1");
			end
		end
	end,1
)