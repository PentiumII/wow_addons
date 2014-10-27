-------------------------------------------------------------------------------
local BIGFOOT_CLASS_MOD, ENABLE_AIMED_SHOT, AJUST_CAST_POSITION, ENABLE_MISDIRECT;
local ENABLE_ANTI_DAZE, ENABLE_ASPECT_BAR, ENABLE_DISTANCE,ENABLE_ATTACK_TIMER, CLASS_MOD_PATH;
local ENABLE_SHAMAN_ASSIST, SHAMAN_ASSIST_TOOLTIP, ENABLE_TOTOEM_TIMER,ENABLE_SHAMAN_TIMER,ENABLE_SHAMAN_TIMER_TOOLTIP,ENABLE_SHAMAN_TRACKER,ENABLE_SHAMAN_TRACKER_TOOLTIP,ENABLE_SHAMAN_ENHANCE,ENABLE_SHAMAN_ENHANCE_TOOLTIP
TotemTimers_switch = 0;

if (GetLocale() == "zhCN") then
	BIGFOOT_CLASS_MOD = {"职业助手", "zhiyezhushou",2};

	ENABLE_ANTI_DAZE = "自动取消猎豹守护";
	ENABLE_ANTI_DAZE_TOOLTIP= "当受到攻击时，自动取消猎豹守护";

	ENABLE_ASPECT_BAR = "启用守护动作条";
	ENABLE_ASPECT_BAR_TOOLTIP= "在经验条上方额外显示守护动作条";

	ENABLE_RUNE_ENHANCE = "启用符文条增强";

	ENABLE_CASTING_BAR = "启用自动射击条"

	ENABLE_MISDIRECT = "误导提示";
	ENABLE_MISDIRECT_TOOLTIP= "以喊话的方式提示误导";

	ENABLE_DISTANCE = "启用距离提示";				--可以所有职业都加上吧
	ENABLE_DISTANCE_TOOLTIP= "在屏幕中下方显示你与当前目标距离的提示框体";

	ENABLE_ATTACK_TIMER = "启用近战攻击计时器";
	ENABLE_ATTACK_TIMER_TOOLTIP= "在屏幕中下方显示下次普通攻击的剩余时间框体";

	ENABLE_AIMED_SHOT = "启用自动射击计时器";
	ENABLE_AIMED_SHOT_TOOLTIP = "在屏幕中下方显示下次普通射击的剩余时间框体";

	AJUST_CAST_POSITION = "调整位置";

	ENABLE_SHAMAN_ASSIST = "启用萨满助手";

	ENABLE_SHAMAN_TIMER = "启用图腾条增强";
	ENABLE_SHAMAN_TIMER_TOOLTIP = "增强，扩展系统图腾条功能";

	ENABLE_SHAMAN_TRACKER = "启用追踪器";
	ENABLE_SHAMAN_TRACKER_TOOLTIP = "监视萨满的重要技能(护盾,武器祝福等)";

	ENABLE_SHAMAN_ENHANCE = "启用萨满增强冷却计时器";
	ENABLE_SHAMAN_ENHANCE_TOOLTIP = "提供一个萨满当前天赋常用技能的快捷条";

	SHAMAN_ASSIST_TOOLTIP = "详细设置";
	SHAMAN_ASSIST_INFO = "|cff00c0c0<萨满助手>|r 你已经关闭萨满助手模块，该设置将在下次插件载入时生效。";

	ENABLE_TOTOEM_TIMER = "开启图腾计时器";
	ENABLE_TOTOEM_TIMER_TOOLTIP= "依赖于技能计时器";
	SHAMAN_TOTOEM_TIMER_INFO = "|cff00c0c0<萨满助手>|r 你已经关闭萨满图腾计时模块，该设置将在下次插件载入时生效。";

	ENABLE_FOCUS_BAR = "开启集中值监视";
	ENABLE_FOCUS_BAR_TOOLTIP = "在屏幕中监视集中值，在脱离战斗时变为透明"

	ENABLE_RAGE_BAR = "开启怒气值监视";
	ENABLE_RAGE_BAR_TOOLTIP = "在屏幕中监视怒气值，在脱离战斗时变为透明"

	ENABLE_ECLIPS_TRACKER = "开启日能和月能监视"
	ENABLE_ECLIPS_TRACKER_TOOLTIP = "在屏幕中监视日能和月能，在脱离战斗时变为透明(只在枭兽形态下显示)"
	HIDE_ECLIPS_TRACKER = "隐藏系统能量条框体"

	ENABLE_MONK_ENERGY = "开启能量监视"
	ENABLE_MONK_ENERGY_TOOLTIP = "监视武僧能量,在脱离战斗后变为透明"

	ENABLE_NUGCOMBOBAR = "开启术士碎片监视"

	NUGCOMBOBAR_OPTION = "配置"

	NEWPOWERBAR_OPTION = "配置"
elseif (GetLocale() == "zhTW") then
	BIGFOOT_CLASS_MOD = {"職業助手", "zhiyezhushou",2};

	ENABLE_ANTI_DAZE = "自動取消獵豹守護";
	ENABLE_ANTI_DAZE_TOOLTIP= "當受到攻擊時，自動取消獵豹守護";

	ENABLE_ASPECT_BAR = "啟用守護動作條";
	ENABLE_ASPECT_BAR_TOOLTIP= "在經驗條上方額外顯示守護動作條";

	ENABLE_RUNE_ENHANCE = "啟用符文條增強";

	ENABLE_MISDIRECT = "誤導提示";
	ENABLE_MISDIRECT_TOOLTIP= "以喊話的方式誤導提示";

	ENABLE_CASTING_BAR = "啟用自動射擊條"

	ENABLE_DISTANCE = "啟用距離提示";
	ENABLE_DISTANCE_TOOLTIP= "在屏幕中下方顯示你與當前目標距離的提示框體";

	ENABLE_ATTACK_TIMER = "啟用近戰攻擊計時器";
	ENABLE_ATTACK_TIMER_TOOLTIP= "在屏幕中下方顯示下次普通攻擊的剩餘時間框體";

	ENABLE_AIMED_SHOT = "啟用自动射擊計時器";
	ENABLE_AIMED_SHOT_TOOLTIP= "在屏幕中下方顯示下次普通射擊的剩餘時間框體";

	AJUST_CAST_POSITION = "調整位置";

	ENABLE_SHAMAN_ASSIST = "啟用薩滿助手";

	ENABLE_SHAMAN_TIMER = "啟用圖騰條增強";
	ENABLE_SHAMAN_TIMER_TOOLTIP = "增強,擴展系統圖騰條功能";

	ENABLE_SHAMAN_TRACKER = "啟用追蹤器";
	ENABLE_SHAMAN_TRACKER_TOOLTIP = "監視薩滿的重要技能(護盾,武器祝福等)";

	ENABLE_SHAMAN_ENHANCE = "啟用薩術增強冷卻計時器";
	ENABLE_SHAMAN_ENHANCE_TOOLTIP = "提供一個薩滿當前天賦常用技能的快捷條";

	SHAMAN_ASSIST_TOOLTIP = "詳細設置";
	SHAMAN_ASSIST_INFO = "|cff00c0c0<薩滿助手>|r 你已經關閉薩滿助手模組，該設置將在下次插件載入時生效。";

	ENABLE_TOTOEM_TIMER = "開啟圖騰計時器";
	ENABLE_TOTOEM_TIMER_TOOLTIP= "依賴於技能計時器";
	SHAMAN_TOTOEM_TIMER_INFO = "|cff00c0c0<薩滿助手>|r 你已經關閉薩滿圖騰計時模組，該設置將在下次插件載入時生效。";

	ENABLE_FOCUS_BAR = "開啟集中值監視";
	ENABLE_FOCUS_BAR_TOOLTIP = "在屏幕中監視集中值，在脫戰後變為透明"

	ENABLE_RAGE_BAR = "開啟怒氣值監視";
	ENABLE_RAGE_BAR_TOOLTIP = "在屏幕中監視怒氣值，在脫戰後變為透明"

	ENABLE_ECLIPS_TRACKER = "開啟日能和月能監視"
	ENABLE_ECLIPS_TRACKER_TOOLTIP = "在屏幕中監視日能和月能，在脫戰後變為透明(只在梟獸形態下顯示)"
	HIDE_ECLIPS_TRACKER = "隱藏系統能量框體"

	ENABLE_MONK_ENERGY = "開啟真氣監視"
	ENABLE_MONK_ENERGY_TOOLTIP = "監視武僧真氣,在脫戰後變為透明"

	ENABLE_NUGCOMBOBAR = "開啟術士碎片監視"

	NUGCOMBOBAR_OPTION = "配置"

	NEWPOWERBAR_OPTION = "配置"
else
	BIGFOOT_CLASS_MOD = "Class Assist";
	ENABLE_ANTI_DAZE = "Anti Daze";
	ENABLE_AIMED_SHOT = "Enable Auto Shot Timer";
	ENABLE_ASPECT_BAR = "Enable Aspect Bar";
	ENABLE_RUNE_ENHANCE = "Enable Enhanced Rune Frame";

	ENABLE_MISDIRECT = "Yell when cast misdirect";
	ENABLE_DISTANCE = "Enable Distance Meter";
	AJUST_CAST_POSITION = "Ajust position";
	ENABLE_ATTACK_TIMER = "Enable Attack Timer";
	ENABLE_SHAMAN_ASSIST = "Enable Shaman Assist";
	SHAMAN_ASSIST_TOOLTIP = "SET";
	SHAMAN_ASSIST_INFO = "|cff00c0c0<Shaman Assistant>|r Shaman helper module that you have turned off, the settings will take effect the next plug-in loaded.";
	ENABLE_TOTOEM_TIMER = "Enable totem timer";
	ENABLE_TOTOEM_TIMER_TOOLTIP= "Depends on the spell timers";
	SHAMAN_TOTOEM_TIMER_INFO = "|cff00c0c0<Shaman Assistant>|r You have closed the shaman totem timer module, the setting will take effect the next plug-in loaded.";
end

local playerclass = select(2, UnitClass("player"));
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------

BFNew_RegisterAddon("AttackTimer",{BFNew_AddonTypeTable[1]})
BFNew_RegisterAddon("BFClassMods",{BFNew_AddonTypeTable[1]},nil,nil,true)
BFNew_RegisterAddon("TotemTimers",{BFNew_AddonTypeTable[1]})
BFNew_RegisterAddon("SpellTimer",{BFNew_AddonTypeTable[1]},nil,nil,true)
BFNew_RegisterAddon("NewPowerBar",{BFNew_AddonTypeTable[1]},nil,nil,true)
BFNew_RegisterAddon("NugComboBar",{BFNew_AddonTypeTable[1]},nil,nil,false)

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
if playerclass == "HUNTER" then
BFNew_RegisterAddonConfig("BFClassMods","CheckBox","EnableAimedShot",ENABLE_AIMED_SHOT,ENABLE_AIMED_SHOT_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
				BigFoot_LoadAddOn("BFClassMods");
			end
			if (BigFoot_IsAddOnLoaded("BFClassMods")) then
				HunterAssistBar_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("BFClassMods")) then
				HunterAssistBar_Toggle(false);
			end
		end
	end
)

BFNew_RegisterAddonConfig("BFClassMods","Button","ButtonHunterAssist",AJUST_CAST_POSITION, nil,
	true,-----默认值
	function (arg)
		if (BigFoot_IsAddOnLoaded("BFClassMods")) then
			HunterAssistCasteBar_AjustPosition();
		end
	end,1
)

BFNew_RegisterAddonConfig("BFClassMods","CheckBox","EnablemisDirect",ENABLE_MISDIRECT,ENABLE_MISDIRECT_TOOLTIP,
	false,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
				BigFoot_LoadAddOn("BFClassMods");
			end
			if (BigFoot_IsAddOnLoaded("BFClassMods")) then
				HunterAssistMisdirect_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("BFClassMods")) then
				HunterAssistMisdirect_Toggle(false);
			end
		end
	end
)

end

if ( playerclass == "WARRIOR" or (playerclass == "PALADIN" )) then
	BFNew_RegisterAddonConfig("AttackTimer","CheckBox","EnableAttackTimer",ENABLE_ATTACK_TIMER,	ENABLE_ATTACK_TIMER_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("AttackTimer")) then
				BigFoot_LoadAddOn("AttackTimer");
			end
			if (BigFoot_IsAddOnLoaded("AttackTimer")) then
				AttackTimer_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("AttackTimer")) then
				AttackTimer_Toggle(false);
			end
		end
	end
	)

	BFNew_RegisterAddonConfig("AttackTimer","Button","ButtonAttackTimer",AJUST_CAST_POSITION, nil,
	true,-----默认值
	function (arg)
		if (BigFoot_IsAddOnLoaded("AttackTimer")) then
			AttackTimer_AjustPosition();
		end
	end,1
	)

end

if playerclass == "DEATHKNIGHT" then
	BFNew_RegisterAddonConfig("BFClassMods","CheckBox","EnableRuneFrame",ENABLE_RUNE_ENHANCE,nil,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
				BigFoot_LoadAddOn("BFClassMods");
			end
			if (BigFoot_IsAddOnLoaded("BFClassMods")) then
				ToggleRuneFrame(true)
			end
		else
			if (BigFoot_IsAddOnLoaded("BFClassMods")) then
				ToggleRuneFrame(false)
			end
		end
	end
	)

	BFNew_RegisterAddonConfig("AttackTimer","CheckBox","EnableAttackTimer",ENABLE_ATTACK_TIMER,ENABLE_ATTACK_TIMER_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("AttackTimer")) then
				BigFoot_LoadAddOn("AttackTimer");
			end
			if (BigFoot_IsAddOnLoaded("AttackTimer")) then
				AttackTimer_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("AttackTimer")) then
				AttackTimer_Toggle(false);
			end
		end
	end
	)

	BFNew_RegisterAddonConfig("AttackTimer","Button","ButtonAttackTimer",AJUST_CAST_POSITION, nil,
	true,-----默认值
	function (arg)
		if (BigFoot_IsAddOnLoaded("AttackTimer")) then
			AttackTimer_AjustPosition();
		end
	end,1
	)
end

if playerclass == "SHAMAN" then
	BFNew_RegisterAddonConfig("TotemTimers","CheckBox","TotemTimers",ENABLE_SHAMAN_ASSIST,nil,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("TotemTimers")) then
				BigFoot_LoadAddOn("TotemTimers");
				TotemTimers_switch = arg;
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("TotemTimers")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(SHAMAN_ASSIST_INFO); end);
			end
		end
	end
	)
	BFNew_RegisterAddonConfig("TotemTimers","Button","ButtonTotemTimers",SHAMAN_ASSIST_TOOLTIP, nil,
	true,-----默认值
	function (arg)
		if BigFoot_IsAddOnLoaded("TotemTimers")  then
			InterfaceOptionsFrame_OpenToCategory("TotemTimers")
			PlaySound("igMainMenuOption");
		end
	end,1
	)

	BFNew_RegisterAddonConfig("TotemTimers","CheckBox","TotemTimersTimer",ENABLE_SHAMAN_TIMER,ENABLE_SHAMAN_TIMER_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_IsAddOnLoaded("TotemTimers")) then
				TT_Timer_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TotemTimers")) then
				TT_Timer_Toggle(false);
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("TotemTimers","CheckBox","TotemTimersTracker",ENABLE_SHAMAN_TRACKER,ENABLE_SHAMAN_TRACKER_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_IsAddOnLoaded("TotemTimers")) then
				TT_Tracker_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TotemTimers")) then
				TT_Tracker_Toggle(false);
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("TotemTimers","CheckBox","TotemTimersEnhance",ENABLE_SHAMAN_ENHANCE,ENABLE_SHAMAN_ENHANCE_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (BigFoot_IsAddOnLoaded("TotemTimers")) then
				TT_EnhanceCD_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("TotemTimers")) then
				TT_EnhanceCD_Toggle(false);
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("SpellTimer","CheckBox","EnableTotemTimer",ENABLE_TOTOEM_TIMER,ENABLE_TOTOEM_TIMER_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("SpellTimer")) then
				BigFoot_LoadAddOn("SpellTimer");
			end
			if (BigFoot_IsAddOnLoaded("SpellTimer")) then
				TotemFrameToggle();
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("SpellTimer")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(SHAMAN_TOTOEM_TIMER_INFO); end);
			end
		end
	end,1
	)
end

if (playerclass == "MAGE" or playerclass == "ROGUE" or playerclass == "WARLOCK") then
	BFNew_RegisterAddonConfig("BFClassMods","CheckBox","EnableAspectBar",ENABLE_ASPECT_BAR,ENABLE_ASPECT_BAR_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if init then
			if (arg ) then
				if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
					BigFoot_LoadAddOn("BFClassMods");
				end
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					BigFoot_DelayCall(function()
							ToggleBFAspectBar(true)
						end,
						5)
				end
			else
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					ToggleBFAspectBar(false)
				end
			end

		else
			if (arg) then
				if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
					BigFoot_LoadAddOn("BFClassMods");
				end
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					ToggleBFAspectBar(true)
				end
			else
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					ToggleBFAspectBar(false)
				end
			end
		end
	end
	)
end

if ( (playerclass == "HUNTER" or playerclass == "WARRIOR" or playerclass == "DRUID") or playerclass=="MONK" )then
	local enableCheckBox,enableToolTip;
	if playerclass == "HUNTER" then
		enableCheckBox = ENABLE_FOCUS_BAR
		enableToolTip = ENABLE_FOCUS_BAR_TOOLTIP
	elseif playerclass == "WARRIOR" then
		enableCheckBox = ENABLE_RAGE_BAR
		enableToolTip = ENABLE_RAGE_BAR_TOOLTIP
	elseif playerclass == "DRUID" then
		enableCheckBox = ENABLE_ECLIPS_TRACKER
		enableToolTip = ENABLE_ECLIPS_TRACKER_TOOLTIP
	elseif playerclass == "MONK" then
		enableCheckBox = ENABLE_MONK_ENERGY
		enableToolTip = ENABLE_MONK_ENERGY_TOOLTIP
	end

	BFNew_RegisterAddonConfig("NewPowerBar","CheckBox","EnableNewPowerBar",enableCheckBox,enableToolTip,
	true,-----默认值
	function(arg,init)
		if (arg ) then
			if (not BigFoot_IsAddOnLoaded("NewPowerBar")) then
				BigFoot_LoadAddOn("NewPowerBar");
				BigFoot_RegistMoveFrame("NewPowerBarStructFrame")
			end
		end
	end
	)
	BFNew_RegisterAddonConfig("NewPowerBar","Button","NewPowerBarOption",NEWPOWERBAR_OPTION,nil,
	nil,-----默认值
		function ()
			-- InterfaceOptionsFrame_OpenToCategory("NewPowerBar")
		end,1
	)
end

if (playerclass == "WARLOCK") then
	BFNew_RegisterAddonConfig("NugComboBar","CheckBox","NugComboBar",ENABLE_NUGCOMBOBAR,nil,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("NugComboBar")) then
				BigFoot_LoadAddOn("NugComboBar");
				BigFoot_LoadAddOn("NugComboBarClassic")
			end
			Nug_Toggle(true)
			ShardBarFrame:Hide()
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("NugComboBar")) then
				Nug_Toggle(false)
				ShardBarFrame:Show()
			end
		end
		if arg and init then
			BigFoot_DelayCall(
				function ()
					ShardBarFrame:Hide()
				end,0.5
			)
		end
	end
	)
	BFNew_RegisterAddonConfig("NugComboBar","Button","NugComboBarOption",NUGCOMBOBAR_OPTION,nil,
	nil,-----默认值
		function ()
			InterfaceOptionsFrame_OpenToCategory("NugComboBar")
		end,1
	)
end