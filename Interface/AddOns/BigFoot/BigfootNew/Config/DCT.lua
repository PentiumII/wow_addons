
if GetLocale() =="zhCN" then
	COMBAT_INDICATOR_ENABLE_DCT = "使用DCT";
	COMBAT_INDICATOR_ENABLE_DCT_TOOLTIP= "自定义战斗信息及预警设置";
	COMBAT_INDICATOR_DCT_SETTINGS = "功能设置...";
elseif GetLocale() == "zhTW" then
	COMBAT_INDICATOR_ENABLE_DCT = "使用DCT";
	COMBAT_INDICATOR_ENABLE_DCT_TOOLTIP= "自定義戰鬥信息及法術預警設置";
	COMBAT_INDICATOR_DCT_SETTINGS = "功能設置...";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("dct",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2]},nil,nil,false)
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

BFNew_RegisterAddonConfig("dct","CheckBox","EnableDCT",COMBAT_INDICATOR_ENABLE_DCT,COMBAT_INDICATOR_ENABLE_DCT_TOOLTIP,
false,-----默认值
	function (arg)
		if (arg ) then
			if (not BigFoot_IsAddOnLoaded("dct")) then
				BigFoot_LoadAddOn("dct");
			end
			if (BigFoot_IsAddOnLoaded("dct")) then
				if(DCT_Toggle)then
					DCT_Toggle(true);
					if DCTD_Init then
						BigFoot_DelayCall(DCTD_Init,3)
					end
					if DCTOP_Init then
						BigFoot_DelayCall(DCTOP_Init,3)
					end
					if DCTSA_Init then
						BigFoot_DelayCall(DCTSA_Init,3)
					end
				end

				if (BigFoot_GetModVariable("CombatIndicator", "EnableCombatIndicator") ~= 0) then
					BigFoot_SetModVariable("CombatIndicator", "EnableCombatIndicator", 0);
					CombatIndicator_Enable(false);
				end
				ModManagement_Refresh();
			end
		else
			if (BigFoot_IsAddOnLoaded("dct")) then
				if(DCT_Toggle)then
					DCT_Toggle(false);
				end
			end
		end
	end
)
BFNew_RegisterAddonConfig("dct","Button","dct_option",COMBAT_INDICATOR_DCT_SETTINGS,nil,
nil,-----默认值
	function ()
		if (BigFoot_IsAddOnLoaded("dct") and BigFoot_HasAddon("dct_options")) then
			DCT_showMenu();
			PlaySound("igMainMenuOption");
		end
	end,1
)