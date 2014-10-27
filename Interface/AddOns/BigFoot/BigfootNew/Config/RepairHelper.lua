
if (GetLocale() == "zhCN") then
	MOD_REPAIR_HELPER_TITLE = {"修理助手", "xiulizhushou"}

	REPAIRHELPER_ENABLE_TEXT = "开启修理助手"
	REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP="与可修理的NPC对话自动修理所有的破损装备"

	REPAIRHELPER_USE_GUILD_MONEY_TEXT = "优先使用公会资金"
	REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO ="超过限额使用玩家金币"
	REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP ="超过公会限额之后使用玩家金币自动修理"
elseif (GetLocale() == "zhTW") then
	MOD_REPAIR_HELPER_TITLE = {"修理助手", "xiulizhushou"}

	REPAIRHELPER_ENABLE_TEXT = "開啓修理助手"
	REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP= "開啟與可修理的NPC對話自動修理當所有的破損裝備"

	REPAIRHELPER_USE_GUILD_MONEY_TEXT = "優先使用公會資金"
	REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO ="超過限額使用自動修理"
	REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP="超过公会限额之后使用玩家金币自动修理"
else
	MOD_REPAIR_HELPER_TITLE = "Repair Helper"

	REPAIRHELPER_ENABLE_TEXT = "Enable Repair Helper"

	REPAIRHELPER_USE_GUILD_MONEY_TEXT = "Use Guild Gold"
	REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO ="REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO"
	REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP ="REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP"

end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("RepairHelper",{BFNew_AddonTypeTable[7]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("RepairHelper","CheckBox","EnableRepairHelper",REPAIRHELPER_REPAIR_ALL_TEXT,REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("RepairHelper")) then
				BigFoot_LoadAddOn("RepairHelper");
			end
		end
		if (BigFoot_IsAddOnLoaded("RepairHelper")) then
			if arg then
				RepairHelper_ToggleEnable(1);
			else
				RepairHelper_ToggleEnable(nil);
			end
		end
	end
	)

	BFNew_RegisterAddonConfig("RepairHelper","CheckBox","RepairHelper_UseGuildMoney",REPAIRHELPER_USE_GUILD_MONEY_TEXT,nil,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("RepairHelper")) then
			if arg then
				RepairHelper_ToggleUseGuild(1)
			else
				RepairHelper_ToggleUseGuild(nil);
			end
		end
	end,1
	)


	BFNew_RegisterAddonConfig("RepairHelper","CheckBox","RepairHelper_Enable_Used_SelfMoney_Auto",REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO,REPAIRHELPER_ENABLE_USED_SELFMONEY_AUTO_TIP,
	false,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("RepairHelper")) then
			if arg then
				RepairHelper_ToggleUseSelfMoneyAuto(1);
			else
				RepairHelper_ToggleUseSelfMoneyAuto(nil);
			end

		end
	end,2
	)
