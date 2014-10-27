
function ClassModConfigFunc()
	local ENABLE_AIMED_SHOT, AJUST_CAST_POSITION, ENABLE_MISDIRECT;
	local ENABLE_ANTI_DAZE, ENABLE_ASPECT_BAR,ENABLE_ATTACK_TIMER, CLASS_MOD_PATH;
	local ENABLE_SHAMAN_ASSIST, SHAMAN_ASSIST_TOOLTIP, ENABLE_TOTOEM_TIMER,ENABLE_SHAMAN_TIMER,ENABLE_SHAMAN_TIMER_TOOLTIP,ENABLE_SHAMAN_TRACKER,ENABLE_SHAMAN_TRACKER_TOOLTIP,ENABLE_SHAMAN_ENHANCE,ENABLE_SHAMAN_ENHANCE_TOOLTIP
	TotemTimers_switch = 0;

	if (GetLocale() == "zhCN") then
		BIGFOOT_CLASS_MOD = {"职业助手", "zhiyezhushou",2};

		ENABLE_ASPECT_BAR = "启用守护动作条";
		ENABLE_ASPECT_BAR_TOOLTIP= "在经验条上方额外显示守护动作条";

		ENABLE_RUNE_ENHANCE = "启用符文条增强";

		ENABLE_MISDIRECT = "误导提示";
		ENABLE_MISDIRECT_TOOLTIP= "以喊话的方式提示误导";

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

		ENABLE_BFTalent = "开启天赋助手"
	elseif (GetLocale() == "zhTW") then
		BIGFOOT_CLASS_MOD = {"職業助手", "zhiyezhushou",2};

		ENABLE_ASPECT_BAR = "啟用守護動作條";
		ENABLE_ASPECT_BAR_TOOLTIP= "在經驗條上方額外顯示守護動作條";

		ENABLE_RUNE_ENHANCE = "啟用符文條增強";

		ENABLE_MISDIRECT = "誤導提示";
		ENABLE_MISDIRECT_TOOLTIP= "以喊話的方式誤導提示";

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

		ENABLE_BFTalent = "開啟天賦助手"
	else
		BIGFOOT_CLASS_MOD = "Class Assist";
		ENABLE_AIMED_SHOT = "Enable Auto Shot Timer";
		ENABLE_ASPECT_BAR = "Enable Aspect Bar";
		ENABLE_RUNE_ENHANCE = "Enable Enhanced Rune Frame";

		ENABLE_MISDIRECT = "Yell when cast misdirect";
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

	if (playerclass == "HUNTER") then
		CLASS_MOD_PATH = "Interface\\ICONS\\Ability_Hunter_SniperShot.blp";
	elseif (playerclass == "WARRIOR") then
		CLASS_MOD_PATH = "Interface\\Icons\\Ability_Warrior_Charge.blp";
	elseif (playerclass == "PALADIN") then
		CLASS_MOD_PATH = "Interface\\Icons\\Spell_Holy_DivineIntervention.blp";
	elseif (playerclass == "SHAMAN") then
		CLASS_MOD_PATH = "Interface\\ICONS\\Spell_Nature_StoneSkinTotem.blp";
	else
		CLASS_MOD_PATH = "Interface\\ICONS\\Ability_Hunter_SniperShot.blp";
	end

	if IsConfigurableAddOn("BFClassMods") or (IsConfigurableAddOn("AttackTimer") and playerclass == "WARRIOR" or playerclass == "PALADIN" or playerclass == "MONK") or (IsConfigurableAddOn("NewPowerBar") and playerclass == "HUNTER" or playerclass == "WARRIOR" or playerclass == "DRUID" or playerclass == "MONK") then
		ModManagement_RegisterMod(
			"BigFootClassMod",
			CLASS_MOD_PATH,
			BIGFOOT_CLASS_MOD
		);
	end

	if IsConfigurableAddOn("BFTalent") then
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_BFTalent,
			nil,
			"EnaBFTalent",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BFTalent")) then
						BigFoot_LoadAddOn("BFTalent");
					end
					if (BigFoot_IsAddOnLoaded("BFTalent")) then
						BFTalent_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("BFTalent")) then
						BFTalent_Toggle(false);
					end
				end
			end
		);
	end

	if playerclass == "HUNTER" and IsConfigurableAddOn("BFClassMods") then
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_AIMED_SHOT,
			ENABLE_AIMED_SHOT_TOOLTIP,
			"EnableAimedShot",
			1,
			function (arg)
				if (arg == 1) then
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
		);
		ModManagement_RegisterButton(
			"BigFootClassMod",
			AJUST_CAST_POSITION,
			function ()
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					HunterAssistCasteBar_AjustPosition();
				end
			end,
			nil,
			1
		);
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_MISDIRECT,
			ENABLE_MISDIRECT_TOOLTIP,
			"EnablemisDirect",
			0,
			function (arg)
				if (arg == 1) then
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
		);
	end

	if ( (playerclass == "WARRIOR" and IsConfigurableAddOn("AttackTimer")) or (playerclass == "PALADIN" and IsConfigurableAddOn("AttackTimer")) or (playerclass == "MONK" and IsConfigurableAddOn("AttackTimer"))) then
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_ATTACK_TIMER,
			ENABLE_ATTACK_TIMER_TOOLTIP,
			"EnableAttackTimer",
			1,
			function (arg)
				if (arg == 1) then
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
		);
		ModManagement_RegisterButton(
			"BigFootClassMod",
			AJUST_CAST_POSITION,
			function ()
				if (BigFoot_IsAddOnLoaded("AttackTimer")) then
					AttackTimer_AjustPosition();
				end
			end,
			nil,
			1
		);
	end

	if playerclass == "DEATHKNIGHT" and (IsConfigurableAddOn("BFClassMods") or IsConfigurableAddOn("AttackTimer")) then
		if IsConfigurableAddOn("BFClassMods") then
			ModManagement_RegisterCheckBox(
				"BigFootClassMod",
				ENABLE_RUNE_ENHANCE,
				nil,
				"EnableRuneFrame",
				1,
				function (arg)
					if (arg == 1) then
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
			);
		end
		if IsConfigurableAddOn("AttackTimer") then
			ModManagement_RegisterCheckBox(
				"BigFootClassMod",
				ENABLE_ATTACK_TIMER,
				ENABLE_ATTACK_TIMER_TOOLTIP,
				"EnableAttackTimer",
				1,
				function (arg)
					if (arg == 1) then
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
			);
			ModManagement_RegisterButton(
				"BigFootClassMod",
				AJUST_CAST_POSITION,
				function ()
					if (BigFoot_IsAddOnLoaded("AttackTimer")) then
						AttackTimer_AjustPosition();
					end
				end,
				nil,
				1
			);
		end
	end

	if (playerclass == "SHAMAN" and IsConfigurableAddOn("TotemTimers")) then
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_SHAMAN_ASSIST,
			nil,
			"TotemTimers",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("TotemTimers")) then
						BigFoot_LoadAddOn("TotemTimers");
						TotemTimers_switch = arg;
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("TotemTimers")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(SHAMAN_ASSIST_INFO); end);
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"BigFootClassMod",
			SHAMAN_ASSIST_TOOLTIP,
			function ()
				if BigFoot_IsAddOnLoaded("TotemTimers")  then
					InterfaceOptionsFrame_OpenToCategory("TotemTimers")
					PlaySound("igMainMenuOption");
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);

		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_SHAMAN_TIMER,
			ENABLE_SHAMAN_TIMER_TOOLTIP,
			"TotemTimersTimer",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("TotemTimers")) then
						TT_Timer_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TotemTimers")) then
						TT_Timer_Toggle(false);
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_SHAMAN_TRACKER,
			ENABLE_SHAMAN_TRACKER_TOOLTIP,
			"TotemTimersTracker",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("TotemTimers")) then
						TT_Tracker_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TotemTimers")) then
						TT_Tracker_Toggle(false);
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_SHAMAN_ENHANCE,
			ENABLE_SHAMAN_ENHANCE_TOOLTIP,
			"TotemTimersEnhance",
			1,
			function (arg)
				if (arg == 1) then
					if (BigFoot_IsAddOnLoaded("TotemTimers")) then
						TT_EnhanceCD_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("TotemTimers")) then
						TT_EnhanceCD_Toggle(false);
					end
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_TOTOEM_TIMER,
			ENABLE_TOTOEM_TIMER_TOOLTIP,
			"EnableTotemTimer",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("SpellTimer")) then
						BigFoot_LoadAddOn("SpellTimer");
					end
					if (BigFoot_IsAddOnLoaded("SpellTimer")) then
						TotemFrameToggle();
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("SpellTimer")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(SHAMAN_TOTOEM_TIMER_INFO); end);
					end
				end
			end,
			1
		);
	end

	if (playerclass == "MAGE" or playerclass == "ROGUE" or playerclass == "WARLOCK") and IsConfigurableAddOn("BFClassMods") then
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_ASPECT_BAR,
			ENABLE_ASPECT_BAR_TOOLTIP,
			"EnableAspectBar",
			1,
			function (arg)
				if (arg == 1) then
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
			end	,
			nil,
			function (arg)
				if (arg == 1) then
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
			end
		);
	end

	local NewPowerBarInfoStr =[[Beta 4.2.0.298
	功能：职业能量监测
	分类：职业助手
	介绍：本次更新添加对猎人集中值、战士怒气值和德鲁伊能量的监测，框体颜色可以自行设置样式，快来启用你的新监测助手吧！

	]]

	if ( (playerclass == "HUNTER" or playerclass == "WARRIOR" or playerclass == "DRUID" or playerclass == "MONK") and IsConfigurableAddOn("NewPowerBar")) then
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
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			enableCheckBox,
			enableToolTip,
			"EnableNewPowerBar",
			nil,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("NewPowerBar")) then
						BigFoot_LoadAddOn("NewPowerBar");
						BigFoot_RegistMoveFrame("NewPowerBarStructFrame")
					end
				else
					if (BigFoot_IsAddOnLoaded("NewPowerBar")) then
						BigFoot_RequestReloadUI()
					end
				end
			end,nil,
			function(arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("NewPowerBar")) then
						BigFoot_LoadAddOn("NewPowerBar");
						BigFoot_RegistMoveFrame("NewPowerBarStructFrame")
					end
					if (BigFoot_IsAddOnLoaded("NewPowerBar")) then
					end
				end
				-- BF_NewAddOnsPromotion("zhCNb",298,"NewPowerBar",NewPowerBarInfoStr,"BigFootClassMod","EnableNewPowerBar")
			end
		);
	end

	if ( playerclass == "DRUID" and IsConfigurableAddOn("NewPowerBar")) then
		local enableCheckBox,enableToolTip;
		local f = CreateFrame'Frame';
		f:RegisterEvent("UPDATE_SHAPESHIFT_FORM");

		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			HIDE_ECLIPS_TRACKER,
			nil,
			"HideEclipsBar",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
						BigFoot_LoadAddOn("BFClassMods");
					end
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						EclipseBarFrame:Hide()
					end
				else
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						EclipseBarFrame:Show()
					end
				end
			end,
			1,
			function(arg)
				f:SetScript('OnEvent', function(self, event, ...)
					if arg == 1 and EclipseBarFrame:IsShown() then
						EclipseBarFrame:Hide()
					end
				end)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
						BigFoot_LoadAddOn("BFClassMods");
					end
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						BigFoot_DelayCall(function ()
							EclipseBarFrame:Hide()
						end,0.1)
					end
				else
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						EclipseBarFrame:Show()
					end
				end
			end
		);
	end

end

BigFoot_AddCollector(ClassModConfigFunc)