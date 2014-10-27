if ( GetLocale() == "zhCN" ) then
	EnableTUnitFrame ="开启头像增强"
	MOD_ENHANCEMENT_TITLE={"头像增强", "touxiangzengqiang"};
	PORTRAIT_ENHANCEMENT_ENABLE_TEXT = "开启头像信息显示";
	PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR = "显示经验条";
	PORTRAIT_ENHANCEMENT_COLORIZE_TEXT = "根据血量改变血槽颜色";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT = "开启队友信息显示";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET = "开启队友目标";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR = "开启队友施法条";
	PORTRAIT_ENHANCEMENT_SHOW_PARTY_TEXT = "显示队友血量数值";
	PORTRAIT_ENHANCEMENT_FORMAT_TEXT = "以万为单位计算血量";
	PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO = "开启目标职业显示";
	PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT = "显示3D头像";
elseif (GetLocale() == "zhTW") then
	MOD_ENHANCEMENT_TITLE={"頭像增強", "touxiangzengqiang"};
	PORTRAIT_ENHANCEMENT_ENABLE_TEXT = "開啟頭像訊息顯示";
	PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR = "顯示經驗條";
	PORTRAIT_ENHANCEMENT_COLORIZE_TEXT = "根據血量改變血條顏色";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT = "開啟隊友信息顯示";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET = "開啟隊友目標";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR = "開啟隊友施法條";

	PORTRAIT_ENHANCEMENT_SHOW_PARTY_TEXT = "顯示隊友血量數值";
	PORTRAIT_ENHANCEMENT_FORMAT_TEXT = "以萬為單位計算血量";

	PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO = "開啓目標職業顯示";
	PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT = "顯示3D頭像";
else
	MOD_ENHANCEMENT_TITLE="Portrait Enhancment";
	PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR = "Show XP bar";
	PORTRAIT_ENHANCEMENT_ENABLE_TEXT="Enable expand portrait";
	PORTRAIT_ENHANCEMENT_COLORIZE_TEXT="Colorize health bar";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT = "Enable party Info panel";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET = "Enable party target frame";
	PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR = "Enable party cast bar";
	PORTRAIT_ENHANCEMENT_SHOW_PARTY_TEXT = "Show party members' hp and mp";
	PORTRAIT_ENHANCEMENT_FORMAT_TEXT = "Show formatted number";

	PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO = "Show class information";
	PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT = "Show 3D portrait";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------

BFNew_RegisterAddon("TUnitFrame",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[6]},nil,nil,true)

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
BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableTUnitFrame",EnableTUnitFrame,nil,
true,-----默认值
	function (arg)
		if (arg) then
			if not  BigFoot_IsAddOnLoaded("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end	
			if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
				LibStub("AceAddon-3.0"):GetAddon("TUnitFrame"):Enable()				
				BUnitFrame_Toggle(true);			
			end
		else
			if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
				TUnitFrame_ResetBuffSize()
				BUnitFrame_Toggle(false);
			end
		end
	end
)

-- BFNew_RegisterAddonConfig("TUnitFrame","Button","TUnitFrame_option",SPELL_TIMER_OPTION,nil,
-- nil,-----默认值
	-- function ()
		-- InterfaceOptionsFrame_OpenToCategory("SpellTimer") 
	-- end,1
-- )

BFNew_RegisterAddonConfig("TUnitFrame","SpinBox","BFCH_MYBUFF_SIZE",COOLDOWN_HELPER_MYBUFF_SIZE,nil,
			{{23, 40, 1},"23"},-----默认值
			function(arg,init)
				if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
					TUnitFrame_AdjustBuffSize(true,tonumber(arg))
				end
			end,1
)

BFNew_RegisterAddonConfig("TUnitFrame","SpinBox","BFCH_OTHERBUFF_SIZE",COOLDOWN_HELPER_OTHERBUFF_SIZE,nil,
			{{12, 20, 1},"17"},-----默认值
			function(arg,init)
				if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
					TUnitFrame_AdjustBuffSize(false,tonumber(arg))
				end
			end,1
)
 
BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnablePorEnhance",PORTRAIT_ENHANCEMENT_ENABLE_TEXT,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchPlayerInfoPane(true)
				TUnitFrame_SwitchExpBar(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchPlayerInfoPane(false)
				TUnitFrame_SwitchExpBar(false)
			end
		end
	end
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","ShowXPBar",PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchExpBar(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchExpBar(false)
			end
		end
	end
)


-- BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","ShowXPBar",PORTRAIT_ENHANCEMENT_ENABLE_XP_BAR,nil,
-- true,-----默认值
	-- function (arg)
		-- if arg then
			-- if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				-- BigFoot_LoadAddOn("TUnitFrame")
			-- end
			-- if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				-- TUnitFrame_SwitchExpBar(true)
			-- end
		-- else
			-- if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				-- TUnitFrame_SwitchExpBar(false)
			-- end
		-- end
	-- end,1
-- )

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnablePartyPor",PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TEXT,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchMemberInfoPane(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchMemberInfoPane(false)
			end
		end
	end
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnablePartyCastBar",PORTRAIT_ENHANCEMENT_ENABLE_PARTY_CASTBAR,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchPartyCastBar(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchPartyCastBar(false)
			end
		end
	end,1
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnablePartyTarget",PORTRAIT_ENHANCEMENT_ENABLE_PARTY_TARGET,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchPartyTarget(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchPartyTarget(false)
			end
		end
	end
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableColorize",PORTRAIT_ENHANCEMENT_COLORIZE_TEXT,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchColorize(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchColorize(false)
			end
		end
	end
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableFormatText",PORTRAIT_ENHANCEMENT_FORMAT_TEXT,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchFormat(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchFormat(false)
			end
		end
	end
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableTargetClassInfo",PORTRAIT_ENHANCEMENT_ENABLE_TARGET_CLASS_INFO,nil,
true,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchClassInfo(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_SwitchClassInfo(false)
			end
		end
	end
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","Show3DPortrait",PORTRAIT_ENHANCEMENT_SHOW_3D_PORTRAIT,nil,
false,-----默认值
	function (arg)
		if arg then
			if not BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				BigFoot_LoadAddOn("TUnitFrame")
			end
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_Switch3DPor(true)
			end
		else
			if BigFoot_IsAddOnLoadedFromBigFoot("TUnitFrame") then
				TUnitFrame_Switch3DPor(false)
			end
		end
	end
)




if (GetLocale() == "zhCN") then
	BF_UNITFRAME_TEXT = {"大脚头像", "dajiaotouxiang"};

	ENABLE_BF_UNITFRAME = "开启目标头像增强";

	ENABLE_FOCUS_UNITFRAME = "简单模式焦点目标";

	ENABLE_TARGETTARGET_UNITFRAME = "显示目标的目标头像";
	ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP= "在目标头像或焦点目标下显示其目标的小框体，与系统自带的目标的目标冲突";

	ENABLE_TARGETTARGETTARGET_UNITFRAME = "显示目标的目标的目标头像";
	ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP= "在目标的目标或焦点目标的目标头像下显示其目标的小框体";

	ENABLE_CASTING_SHINING = "开启施法闪光";
	ENABLE_CASTING_SHINING_TOOLTIP = "头像增强框体目标施法时头像高亮闪光";

	ENABLE_CASTING_ICON = "开启法术提示";
	ENABLE_CASTING_ICON_TOOLTIP = "头像增强框体目标施法时头像变为法术图标";
elseif (GetLocale() == "zhTW") then
	BF_UNITFRAME_TEXT = {"大腳頭像", "dajiaotouxiang"};

	ENABLE_BF_UNITFRAME = "開啟目標頭像增強";

	ENABLE_FOCUS_UNITFRAME = "簡單模式焦點頭像";

	ENABLE_TARGETTARGET_UNITFRAME = "顯示目標的目標頭像";
	ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP= "在目標頭像或焦點目標下顯示其目標的小框體，與系統自帶的目標的目標衝突";

	ENABLE_TARGETTARGETTARGET_UNITFRAME = "顯示目標的目標的目標頭像";
	ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP= "在目標的目標或焦點目標的目標頭像下顯示其目標的小框體";

	ENABLE_CASTING_SHINING = "開啟施法閃光";
	ENABLE_CASTING_SHINING_TOOLTIP = "頭像增強框體目標施法時頭像高亮閃光";

	ENABLE_CASTING_ICON = "開啟法術圖示";
	ENABLE_CASTING_ICON_TOOLTIP = "頭像增強框體目標施法時頭像變為法術圖標";
else
	BF_UNITFRAME_TEXT = "BigFoot UnitFrame";

	ENABLE_BF_UNITFRAME = "Enable Unit Frame";
	ENABLE_FOCUS_UNITFRAME = "Simple model focus Avatar";
	ENABLE_TARGETTARGET_UNITFRAME = "ToT Frame";
	ENABLE_TARGETTARGETTARGET_UNITFRAME = "ToToT Frame";
	ENABLE_CASTING_SHINING = "Shining when casting";
	ENABLE_CASTING_ICON = "Show spell icon when casting";
end


BFNew_RegisterAddon("BUnitFrame",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[6]})


-- BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableBUnitFrame",ENABLE_BF_UNITFRAME,nil,
-- true,-----默认值
	-- function (arg)
		-- if (arg) then
			-- if (BigFoot_LoadAddOn("BUnitFrame")) then
				-- BUnitFrame_Toggle(true);
			-- end
		-- else
			-- if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
				-- BUnitFrame_Toggle(false);
			-- end
		-- end
	-- end
-- )
BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableEasyFocusFrame",ENABLE_FOCUS_UNITFRAME,nil,
false,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_LoadAddOn("TUnitFrame")) then
				BUnitFrame_FocusFrame_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
				BUnitFrame_FocusFrame_Toggle(false);
			end
		end
	end
)

BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableTargetTarget",ENABLE_TARGETTARGET_UNITFRAME,ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP,
true,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_LoadAddOn("TUnitFrame")) then
				BUnitFrame_TargetTargetFrame_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
				BUnitFrame_TargetTargetFrame_Toggle(false);
			end
		end
	end
)
BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableTargetTargetTarget",ENABLE_TARGETTARGETTARGET_UNITFRAME,ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP,
true,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_LoadAddOn("TUnitFrame")) then
				BUnitFrame_TargetTargetTargetFrame_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
				BUnitFrame_TargetTargetTargetFrame_Toggle(false);
			end
		end
	end,1
)
BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableCastingShining",ENABLE_CASTING_SHINING,ENABLE_CASTING_SHINING_TOOLTIP,
true,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_LoadAddOn("TUnitFrame")) then
				BUnitFrame_CastingShining_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
				BUnitFrame_CastingShining_Toggle(false);
			end
		end
	end
)
 
BFNew_RegisterAddonConfig("TUnitFrame","CheckBox","EnableCastingIcon",ENABLE_CASTING_ICON,ENABLE_CASTING_ICON_TOOLTIP,
true,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_LoadAddOn("TUnitFrame")) then
				BUnitFrame_CastingIcon_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TUnitFrame")) then
				BUnitFrame_CastingIcon_Toggle(false);
			end
		end
	end
)




