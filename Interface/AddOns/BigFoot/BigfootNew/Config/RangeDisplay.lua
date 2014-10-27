if GetLocale() =="zhCN" then
	ENABLE_RANGEDISPLAY_TEXT ="启用距离显示";
	ENABLE_RANGEDISPLAY_TEXT_TOOLTIP="显示玩家目标，焦点目标，鼠标悬停目标与玩家之间的距离数值";
	RANGEDISPLAY_DISABLE_DELAY_TEXT = "|cff00c0c0<距离显示>|r 你已经关闭距离显示(RangeDisplay)模块，该设置将在下次插件载入时生效。";
elseif GetLocale() == "zhTW" then
	ENABLE_RANGEDISPLAY_TEXT ="啟用距離顯示";
	ENABLE_RANGEDISPLAY_TEXT_TOOLTIP="顯示玩家目標，焦點目標，鼠標懸停目標與玩家之間的距離數值";
	RANGEDISPLAY_DISABLE_DELAY_TEXT = "|cff00c0c0<距離顯示>|r 你已經關閉距離顯示(RangeDisplay)模塊，該設置將在下次插件載入時生效。";
else
	ENABLE_RANGEDISPLAY_TEXT ="Enable Range Display";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("RangeDisplay",{BFNew_AddonTypeTable[1]},nil,nil,true)
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

BFNew_RegisterAddonConfig("RangeDisplay","CheckBox","EnableRangeDisplay",ENABLE_RANGEDISPLAY_TEXT,ENABLE_RANGEDISPLAY_TEXT_TOOLTIP,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("RangeDisplay")) then
				BigFoot_LoadAddOn("RangeDisplay");
				RangeDisplay:toggleLocked(true)
			end
		else
			if (BigFoot_IsAddOnLoaded("RangeDisplay")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(RANGEDISPLAY_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)

	-- BFNew_RegisterAddonConfig("RangeDisplay","SpinBox","SpinBoxRangeDisplay",ENABLE_RANGEDISPLAY_TEXT,ENABLE_RANGEDISPLAY_TEXT_TOOLTIP,
	-- {{11111,22222,3333,444,5555,66666,77777},1},-----默认值
	-- function(arg,init)
		-- print(arg)
	-- end,1
	-- )
	
	-- BFNew_RegisterAddonConfig("RangeDisplay","SpinBox","SpinBoxRangeDisplay11",ENABLE_RANGEDISPLAY_TEXT,ENABLE_RANGEDISPLAY_TEXT_TOOLTIP,
	-- {{11111,22222,3333,444,5555,66666,77777},1},-----默认值
	-- function(arg,init)
		-- print(arg)
	-- end,2
	-- )
