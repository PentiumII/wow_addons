
if GetLocale() =="zhCN" then
	TRINKET_MENU_MOD_TEXT = {"饰品管理", "shipinguanli"};
	TRINKET_MENU_ENABLE_TEXT = "开启饰品管理";
	TRINKET_MENU_SETTINGS_TEXT = "设置饰品管理";
	TRINKET_MENU_KEY_BINDING_TEXT = "按键绑定";
elseif GetLocale() == "zhTW" then
	TRINKET_MENU_MOD_TEXT = {"飾品管理", "shipinguanli"};
	TRINKET_MENU_ENABLE_TEXT = "開啟飾品管理";
	TRINKET_MENU_SETTINGS_TEXT = "設置飾品管理";
	TRINKET_MENU_KEY_BINDING_TEXT = "按鍵綁定";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("TrinketMenu",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2],BFNew_AddonTypeTable[10]},nil,nil,false)
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

BFNew_RegisterAddonConfig("TrinketMenu","CheckBox","EnableTrinketMenu",TRINKET_MENU_ENABLE_TEXT,nil,
false,-----默认值
	function (arg)
		if ( arg  ) then
			if (not BigFoot_IsAddOnLoaded("TrinketMenu")) then
				BigFoot_LoadAddOn("TrinketMenu");
			end
			
			if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
				TrinketMenu_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
				TrinketMenu_Toggle(false);
			end
		end
	end
)
BFNew_RegisterAddonConfig("TrinketMenu","Button","TrinketMenu_Option",TRINKET_MENU_SETTINGS_TEXT,nil,
nil,-----默认值
	function ()
		if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
			PlaySound("GAMEGENERICBUTTONPRESS");
			TrinketMenu_OptFrame:SetFrameStrata("DIALOG")
			TrinketMenu.ToggleFrame(TrinketMenu_OptFrame);
		end
	end,1
)
BFNew_RegisterAddonConfig("TrinketMenu","Button","TrinketMenu_Binding",TRINKET_MENU_KEY_BINDING_TEXT,nil,
nil,-----默认值
	function ()
		if (BigFoot_IsAddOnLoaded("TrinketMenu")) then
			BigFoot_ShowKeyBindingFrame("HEADER_TRINKETMENU");
		end
	end,1
)