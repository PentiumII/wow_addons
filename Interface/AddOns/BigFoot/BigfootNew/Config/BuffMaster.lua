if (GetLocale() == "zhCN") then
	BM_ACTION_BUTTON_TITLE = {"增益法术", "zengyifashu"};
	
	COOLDOWN_HELPER_ADJ_BUFF_SIZE = "调整目标Buff尺寸";
	COOLDOWN_HELPER_ADJ_BUFF_SIZE_TOOLTIP= "设置一个你喜欢的目标BUFF大小，使你施放的BUFF与其他BUFF区分开"
	
	COOLDOWN_HELPER_MYBUFF_SIZE = "你释放的";			--目标头像下你施放技能图标的大小
	COOLDOWN_HELPER_OTHERBUFF_SIZE = "其他人的";		--目标头像下其他图标的大小
	
	BUFFMASTER_SHOW_BUFF_INFO = "显示自身BUFF信息"
	BUFFMASTER_SHOW_DETAIL_TIMELEFT = "时间精确到秒";
	
	
	BFCD_COOLDOWN_SHOW_TARGET = "显示目标时间";
	BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP="显示目标头像下各种(DE)BUFF的持续(剩余)时间";
	
	BUFFMASTER_SHOW_PARTY_BUFF = "增强显示队友BUFF";
	BUFFMASTER_SHOW_PARTY_BUFF_TOOLTIP= "在小队成员头像下显示其身上的BUFF";
	
	BUFFMASTER_SHOW_MY_BUFF = "仅显示我施放的增益"
	
elseif (GetLocale() == "zhTW") then
	BM_ACTION_BUTTON_TITLE = {"增益法術", "zengyifashu"};
	
	COOLDOWN_HELPER_ADJ_BUFF_SIZE = "調整目標Buff尺寸";
	COOLDOWN_HELPER_ADJ_BUFF_SIZE_TOOLTIP= "設置一個你喜歡的目標BUFF大小，使你釋放的BUFF與其他BUFF區分開";
	
	COOLDOWN_HELPER_MYBUFF_SIZE = "你釋放的";
	COOLDOWN_HELPER_OTHERBUFF_SIZE = "其他人的";
	
	BUFFMASTER_SHOW_BUFF_INFO = "顯示自身BUFF信息"
	BUFFMASTER_SHOW_DETAIL_TIMELEFT = "時間精確到秒";
	
	BFCD_COOLDOWN_SHOW_TARGET = "顯示目標時間";
	BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP= "顯示目標頭像下各種(DE)BUFF的持續(剩餘)時間";
	
	BUFFMASTER_SHOW_PARTY_BUFF = "增強顯示隊友BUFF";
	BUFFMASTER_SHOW_PARTY_BUFF_TOOLTIP= "在小隊成員頭像下顯示其身上的BUFF";
	BUFFMASTER_SHOW_MY_BUFF = "僅顯示我施放的增益"
else
	BM_ACTION_BUTTON_TITLE = "Buff Adjustments";
	
	COOLDOWN_HELPER_ADJ_BUFF_SIZE = "Adjust Buff Size"
	COOLDOWN_HELPER_MYBUFF_SIZE = "My Buff Size";
	COOLDOWN_HELPER_OTHERBUFF_SIZE = "Other Buff Size";
	BUFFMASTER_SHOW_BUFF_INFO = "Show player's buff info"
	BUFFMASTER_SHOW_DETAIL_TIMELEFT = "Show time left of buff";
	BFCD_COOLDOWN_SHOW_TARGET = "Show small icon cooldown";
	BUFFMASTER_SHOW_PARTY_BUFF = "Show party members' buffs";
	BUFFMASTER_SHOW_MY_BUFF = "Only show my buffs"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BuffMaster",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[6]},nil,nil,true)
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
BFNew_RegisterAddonConfig("BuffMaster","CheckBox","EnablePartyBuffer",BUFFMASTER_SHOW_PARTY_BUFF,BUFFMASTER_SHOW_PARTY_BUFF_TOOLTIP,
true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
				BigFoot_LoadAddOn("BuffMaster");
			end	
		end	
		if (BigFoot_IsAddOnLoaded("BuffMaster")) then-- callback
			if arg then
				BuffMaster_ToggleShowParty(1)
			else
				BuffMaster_ToggleShowParty(nil)
			end
		end
	end
)

BFNew_RegisterAddonConfig("BuffMaster","CheckBox","EnablePartyShortBuffer",BUFFMASTER_SHOW_MY_BUFF,nil,
true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
				BigFoot_LoadAddOn("BuffMaster");
			end	
		end	
		if (BigFoot_IsAddOnLoaded("BuffMaster")) then									-- callback
			if arg then
				BuffMaster_ToggleMyBuffs(1)
			else
				BuffMaster_ToggleMyBuffs(nil)
			end
		end
	end,1
)
BFNew_RegisterAddonConfig("BuffMaster","CheckBox","BuffMasterShowTimeLeft",BUFFMASTER_SHOW_BUFF_INFO,nil,
true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
				BigFoot_LoadAddOn("BuffMaster");
			end	
		end	
		if (BigFoot_IsAddOnLoaded("BuffMaster")) then									-- callback
			if arg then
				BuffMaster_ToggleBuffInfo(1)
			else
				BuffMaster_ToggleBuffInfo(nil)
			end
		end
	end
)
BFNew_RegisterAddonConfig("BuffMaster","CheckBox","BuffMasterShowDetailTimeLeft",BUFFMASTER_SHOW_DETAIL_TIMELEFT,nil,
true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BuffMaster")) then
				BigFoot_LoadAddOn("BuffMaster");
			end	
		end	
		if (BigFoot_IsAddOnLoaded("BuffMaster")) then									-- callback
			if arg then
				BuffMaster_ToggleDetailTimeLeft(1)
			else
				BuffMaster_ToggleDetailTimeLeft(nil)
			end
		end
	end
)
