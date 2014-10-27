if GetLocale() == "zhCN" then
	COMBAT_INDICATOR_ENABLE_TEXT = "开启战斗指示器";
	COMBAT_INDICATOR_ENABLE_TOOLTIP= "为你提供即时战斗信息显示";

	COMBAT_INDICATOR_SHOW_COMBAT_LEAVE = "开启战斗提示";
	COMBAT_INDICATOR_SHOW_COMBAT_LEAVE_TOOLTIP= "进入或离开战斗时进行提示";

	COMBAT_INDICATOR_SPELL_MOB_TEXT = "开启法术预警";
	COMBAT_INDICATOR_SPELL_MOB_TOOLTIP= "显示敌对目标正在对你释放技能的提示";

	COMBAT_INDICATOR_PLAYER_STATUS = "显示状态信息";
	COMBAT_INDICATOR_PLAYER_STATUS_TOOLTIP= "躲闪/招架/未击中..等等";
elseif GetLocale() == "zhTW" then
	COMBAT_INDICATOR_ENABLE_TEXT = "開啟戰鬥指示器";
	COMBAT_INDICATOR_ENABLE_TOOLTIP= "為你提供即時戰鬥信息顯示";

	COMBAT_INDICATOR_SHOW_COMBAT_LEAVE = "戰鬥提示";
	COMBAT_INDICATOR_SHOW_COMBAT_LEAVE_TOOLTIP= "進入或離開戰鬥時進行提示";

	COMBAT_INDICATOR_SPELL_MOB_TEXT = "開啟法術預警";
	COMBAT_INDICATOR_SPELL_MOB_TOOLTIP= "顯示敵對目標正在對你釋放技能的提示";

	COMBAT_INDICATOR_PLAYER_STATUS = "顯示狀態訊息";
	COMBAT_INDICATOR_PLAYER_STATUS_TOOLTIP= "躲閃/招架/未擊中..等等";
else
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
--------------参数4 插件Enable默认值-----------------------------------
BFNew_RegisterAddon("CombatIndicator",{BFNew_AddonTypeTable[2],BFNew_AddonTypeTable[1]},nil,nil,true)
BFNew_RegisterAddonexclusiveTab({"CombatIndicator","dct"})

--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})  -- 表示 skada 与 recount 互斥
--------------------注册插件配置信息----------------------------------
BFNew_RegisterAddonConfig("CombatIndicator","CheckBox","EnableCombatIndicator",COMBAT_INDICATOR_ENABLE_TEXT,COMBAT_INDICATOR_ENABLE_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("CombatIndicator")) then
			BigFoot_LoadAddOn("CombatIndicator");
			
		end
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_Enable(true);
		end
	else
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_Enable(false);
		end
	end
end
)
BFNew_RegisterAddonConfig("CombatIndicator","CheckBox","EnableCombatLeave",COMBAT_INDICATOR_SHOW_COMBAT_LEAVE,COMBAT_INDICATOR_SHOW_COMBAT_LEAVE_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_EnableLeaveCombat(true);
		end
	else
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_EnableLeaveCombat(false);
		end
	end
end,1
)
BFNew_RegisterAddonConfig("CombatIndicator","CheckBox","EnableShowSpell",COMBAT_INDICATOR_SPELL_MOB_TEXT,COMBAT_INDICATOR_SPELL_MOB_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_EnableShowSpell(true);
		end
	else
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_EnableShowSpell(false);
		end
	end
end,1
)
BFNew_RegisterAddonConfig("CombatIndicator","CheckBox","EnableSpell",COMBAT_INDICATOR_PLAYER_STATUS,COMBAT_INDICATOR_PLAYER_STATUS_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_EnableStatus(true);
		end
	else
		if (BigFoot_IsAddOnLoaded("CombatIndicator")) then
			CombatIndicator_EnableStatus(false);
		end
	end
end,1
)
 