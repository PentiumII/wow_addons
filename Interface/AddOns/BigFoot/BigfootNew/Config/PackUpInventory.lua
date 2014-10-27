if GetLocale() =="zhCN" then
	PUI_ENABLE_TEXT = "背包整理";
	PUI_ENABLE_TEXT_TOOLTIP = "将你背包里的物品按种类整理好。";
	
	PUI_REVERSE_TEXT = "反序整理";
	PUI_REVERSE_TEXT_TOOLTIP = "按照相反的顺序整理背包里的物品。";
elseif GetLocale() == "zhTW" then
	PUI_ENABLE_TEXT = "背包整理";
	PUI_ENABLE_TOOLTIP = "將你背包裏的物品按種類整理好";
	
	PUI_REVERSE_TEXT = "反序整理";	
	PUI_REVERSE_TOOLTIP = "按照相反的順序整理背包裏的物品";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("PackUpInventory",{BFNew_AddonTypeTable[7]},nil,nil,true)
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

BFNew_RegisterAddonConfig("PackUpInventory","CheckBox","Enable_PUI",PUI_ENABLE_TEXT,PUI_ENABLE_TEXT_TOOLTIP,
true,-----默认值
	function (arg)	          
		if (arg) then				
			if (not BigFoot_IsAddOnLoaded("PackUpInventory")) then
				BigFoot_LoadAddOn("PackUpInventory");
			end
			if (BigFoot_IsAddOnLoaded("PackUpInventory")) then
				PUI_Toggle(true);
			end							
		else
			if (BigFoot_IsAddOnLoaded("PackUpInventory")) then
				PUI_Toggle(false);
			end
		end
	end
)
BFNew_RegisterAddonConfig("PackUpInventory","CheckBox","ReverseMode",PUI_REVERSE_TEXT,PUI_REVERSE_TEXT_TOOLTIP,
false,-----默认值
	function (arg)	          
		if (arg) then				
			if (BigFoot_IsAddOnLoaded("PackUpInventory")) then
				PUI_SetOrder("desc");
			end
		else
			if (BigFoot_IsAddOnLoaded("PackUpInventory")) then
				PUI_SetOrder("asc");
			end
		end
	end,1
)