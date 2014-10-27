
if GetLocale() =="zhCN" then
	MOD_ARENA_PROXMIO_ENABLE_TEXT = "开启竞技助手(Gladius)";
	MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP="提供一个监测敌方职业，血量，种族，当前目标，技能提示，低血量报警及徽章使用(冷却)提示的框体";
	MOD_ARENA_PROXMIO = "设置";
elseif GetLocale() == "zhTW" then
	MOD_ARENA_PROXMIO_ENABLE_TEXT = "開啟競技助手(Gladius)";
	MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP="提供一個監測敵方職業，血量，種族，當前目標，技能提示，低血量報警及徽章使用(冷卻)提示的框體"
	MOD_ARENA_PROXMIO = "设置";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Gladius",{BFNew_AddonTypeTable[2]},nil,nil,false)
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
BFNew_RegisterAddonConfig("Gladius","CheckBox","EnableProximo",MOD_ARENA_PROXMIO_ENABLE_TEXT,MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP,
false,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Gladius")) then
				BigFoot_LoadAddOn("Gladius");
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Gladius")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(GLADIUS_DISABLE_DELAY_TEXT); end);
			end
		end
	end
)
BFNew_RegisterAddonConfig("Gladius","Button","Gladius_option",MOD_ARENA_PROXMIO,nil,
nil,-----默认值
	function ()
		if BigFoot_IsAddOnLoaded("Gladius")  then
			OpenGladius();
			PlaySound("igMainMenuOption");
		end
	end
)