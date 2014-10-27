
if GetLocale() =="zhCN" then
	BFCD_CoolLine_SHOW_BAR = "启用流线型法术冷却";
	BFCD_CoolLine_SHOW_BAR_TOOLTIP="在一个有时间刻度的计时条上显示冷却中的法术";
elseif GetLocale() == "zhTW" then
	BFCD_CoolLine_SHOW_BAR = "啟用流線型法術冷卻";
	BFCD_CoolLine_SHOW_BAR_TOOLTIP="在一個有時間刻度的計時條上顯示冷卻中的法術";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("CoolLine",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2]},nil,nil,false)
BFNew_RegisterAddonexclusiveTab({"CoolLine","BFCooldown"})
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

BFNew_RegisterAddonConfig("CoolLine","CheckBox","EnableCoolLine",BFCD_CoolLine_SHOW_BAR,BFCD_CoolLine_SHOW_BAR_TOOLTIP,
false,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("CoolLine")) then
				BigFoot_LoadAddOn("CoolLine");
			end
			CoolLine:Show();
			if (BigFoot_IsAddOnLoaded("CoolLine")) then
				if (BigFoot_IsAddOnLoaded("BFCooldown")) then
					if (BigFoot_GetModVariable("ActionButton", "ShowCenter") ~= 0) then
						BigFoot_SetModVariable("ActionButton", "ShowCenter", 0);
						BFCooldown:ToggleMiddle(false)
					end
					if (BigFoot_GetModVariable("ActionButton", "ToggleBar") ~= 0) then
						BigFoot_SetModVariable("ActionButton", "ToggleBar", 0);
						BFCooldown:ToggleBar(false)
					end
				end
				ModManagement_Refresh();
			end
		else
			if (BigFoot_IsAddOnLoaded("CoolLine")) then
				CoolLine:Hide();
			end
		end
	end
)