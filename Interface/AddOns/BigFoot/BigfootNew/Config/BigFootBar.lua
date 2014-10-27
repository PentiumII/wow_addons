---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	 ENABLE_BigFootBar_TEXT ="启用动作条增强"
	 
	BIGFOOTBAR_ENABLE = "开启大脚动作条";
	BIGFOOTBAR_RESET = "按鍵綁定";
	BIGFOOTBAR_HIDE_TAB = "隐藏动作条标题头";
	BIGFOOTBAR_HIDE_GRID = "隐藏未用的动作按钮";
	
	BF_DISTANCE_ALERT = "启用距离提示";
	BF_DISTANCE_ALERT_TOOLTIP="当对目标释放单体技能超出施法范围时，技能图标变为红色。";
elseif GetLocale() == "zhTW" then
	ENABLE_BigFootBar_TEXT ="啟用動作條增強"
	
	BIGFOOTBAR_ENABLE = "開啟大腳快捷列";
	BIGFOOTBAR_RESET = "按鍵綁定";
	BIGFOOTBAR_HIDE_TAB = "隱藏快捷列標題";
	BIGFOOTBAR_HIDE_GRID = "隱藏未用的動作按鈕";
	
	BF_DISTANCE_ALERT = "啟用距離提示";
	BF_DISTANCE_ALERT_TOOLTIP="當對目標釋放單體技能超出施法範圍時，技能圖標變為紅色。";
else
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BigFootBar",{BFNew_AddonTypeTable[6]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------


BFNew_RegisterAddonConfig("BigFootBar","CheckBox","EnableBigFootBar",ENABLE_BigFootBar_TEXT,nil,
false,-----默认值
function(arg,init)
	if (arg ) then
		if (not BigFoot_IsAddOnLoaded("BigFootBar")) then
			BigFoot_LoadAddOn("BigFootBar");
		end
	else
		if (BigFoot_IsAddOnLoaded("BigFootBar")) then
			--BigFoot_RequestReloadUI(function() BigFoot_Print(ARCHY_DISABLE_DELAY_TEXT); end);
		end
	end
end
)


BFNew_RegisterAddonConfig("BigFootBar","CheckBox","Enable_BigFootBar",BIGFOOTBAR_ENABLE,nil,
true,-----默认值
function(arg,init)
	if arg then
		if (not BigFoot_IsAddOnLoaded("BigFootBar")) then
			BigFoot_LoadAddOn("BigFootBar");
		end
		BigFootBar_Toggle(1);
	else
		BigFootBar_Toggle(0);
	end
end,1
)

BFNew_RegisterAddonConfig("BigFootBar","CheckBox","HideTab",BIGFOOTBAR_HIDE_TAB,nil,
false,-----默认值
function(arg,init)
	if ( arg  ) then
		local __index;
		for __index = 1, MAX_ACTIVE_BAR_COUNT, 1 do
			local __frame = _G["BigFootBarFrame"..__index.."Tab"]
			if ( __frame ) then
				__frame:Hide();
			end
		end
	else
		for __index = 1, MAX_ACTIVE_BAR_COUNT, 1 do
			local __frame = _G["BigFootBarFrame"..__index.."Tab"]
			if ( __frame ) then
				__frame:Show();
			end
		end
	end
end,2
)

BFNew_RegisterAddonConfig("BigFootBar","CheckBox","HideGrid",BIGFOOTBAR_HIDE_GRID,nil,
false,-----默认值
function(arg,init)
	if ( arg  ) then
		BigFootBar_ToggleShowGrid(false);
	else
		BigFootBar_ToggleShowGrid(true);
	end
end,2
)

BFNew_RegisterAddonConfig("BigFootBar","Button","ButtonBigFootBar",BIGFOOTBAR_RESET,nil,
false,-----默认值
function(arg,init)
	BigFoot_ShowKeyBindingFrame("HEADER_BIGFOOTBAR1");
end,2
)
BFNew_RegisterAddonConfig("BigFootBar","CheckBox","EnableDistanceAlert",BF_DISTANCE_ALERT,BF_DISTANCE_ALERT_TOOLTIP,
true,-----默认值
function(arg)
	if arg then
		DistanceAlert_Toggle(1)
	else
		DistanceAlert_Toggle(0)
	end
end,1
)