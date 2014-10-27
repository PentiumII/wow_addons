-- if ( GetLocale() == "zhCN" ) then
	-- ENABLE_EclipseBarFrame = "移动鸟德能量框体";
	
	-- ENABLE_FOCUS_BAR = "开启集中值监视";
	-- ENABLE_FOCUS_BAR_TOOLTIP = "在屏幕中监视集中值，在脱离战斗时变为透明"

	-- ENABLE_RAGE_BAR = "开启怒气值监视";
	-- ENABLE_RAGE_BAR_TOOLTIP = "在屏幕中监视怒气值，在脱离战斗时变为透明"

	-- ENABLE_ECLIPS_TRACKER = "开启日能和月能监视"
	-- ENABLE_ECLIPS_TRACKER_TOOLTIP = "在屏幕中监视日能和月能，在脱离战斗时变为透明(只在枭兽形态下显示)"
	-- HIDE_ECLIPS_TRACKER = "隐藏系统能量条框体"
-- elseif (GetLocale() == "zhTW") then
	-- ENABLE_FOCUS_BAR = "開啟集中值監視";
	-- ENABLE_FOCUS_BAR_TOOLTIP = "在屏幕中監視集中值，在脫戰後變為透明"

	-- ENABLE_RAGE_BAR = "開啟怒氣值監視";
	-- ENABLE_RAGE_BAR_TOOLTIP = "在屏幕中監視怒氣值，在脫戰後變為透明"

	-- ENABLE_ECLIPS_TRACKER = "開啟日能和月能監視"
	-- ENABLE_ECLIPS_TRACKER_TOOLTIP = "在屏幕中監視日能和月能，在脫戰後變為透明(只在梟獸形態下顯示)"
	-- HIDE_ECLIPS_TRACKER = "隱藏系統能量框體"
	
	-- ENABLE_EclipseBarFrame = "移動鳥德能量框體";
-- else
	
-- end
-- ---------------注册插件类型-----------------------------------
-- ----------参数1 插件的名字-----------------------------------
-- ----------参数2 插件的类型。-----------------------------------
-- ----------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------

-- BFNew_RegisterAddon("NewPowerBar",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[6]},nil,nil,true)

-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- ---------------注册插件互斥信息-------------------------------------------
-- ---------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
-- ----------------注册插件配置信息----------------------------------
-- ----------参数1 插件的名字-----------------------------------
-- ----------参数2 配置的类型。-----------------------------------
-- ----------参数3 配置名字-----------------------------------
-- ----------参数4 配置显示的名字-----------------------------------
-- ----------参数5 配置的鼠标提示-----------------------------------
-- ----------参数6 （Checkbox）配置的默认值  ----  true false 不要为nil-----------------------------------
-- ----------参数7 （Checkbox）配置的CallBack函数  2个参数 第一个为 toggle_value  为 true or false  后一个为是否初始化的标识-----------------------------------
-- ----------参数8 配置的层级 默认0-----------------------------------
 -- playerclass = select(2, UnitClass("player"));
-- if (playerclass == "HUNTER" or playerclass == "WARRIOR" or playerclass == "DRUID") then
	-- local enableCheckBox,enableToolTip;
	-- if playerclass == "HUNTER" then
		-- enableCheckBox = ENABLE_FOCUS_BAR
		-- enableToolTip = ENABLE_FOCUS_BAR_TOOLTIP
	-- elseif playerclass == "WARRIOR" then
		-- enableCheckBox = ENABLE_RAGE_BAR
		-- enableToolTip = ENABLE_RAGE_BAR_TOOLTIP
	-- elseif playerclass == "DRUID" then
		-- enableCheckBox = ENABLE_ECLIPS_TRACKER
		-- enableToolTip = ENABLE_ECLIPS_TRACKER_TOOLTIP
	-- end
	-- BFNew_RegisterAddonConfig("NewPowerBar","CheckBox","EnableNewPowerBar",enableCheckBox,enableToolTip,
	-- true,-----默认值
		-- function (arg)
			-- if (arg) then
				-- if (not BigFoot_IsAddOnLoaded("NewPowerBar")) then
					-- BigFoot_LoadAddOn("NewPowerBar");
				-- end
			-- end
		-- end
	-- )
-- end
-- if ( playerclass == "DRUID") then
	-- BFNew_RegisterAddonConfig("NewPowerBar","CheckBox","HideEclipsBar",HIDE_ECLIPS_TRACKER,nil,
	-- true,-----默认值
		-- function (arg)
			-- if (arg) then
				-- if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
					-- BigFoot_LoadAddOn("BFClassMods");
				-- end
				-- if (BigFoot_IsAddOnLoaded("BFClassMods")) then	
					-- EclipseBarFrame:Hide()
				-- end
			-- else
				-- if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					-- EclipseBarFrame:Show()
				-- end
			-- end
		-- end,1
	-- )
	
-- end