
if GetLocale() =="zhCN" then
	MOD_ARENA_GLADIATORLOSSA_ENABLE_TEXT = "开启竞技技能语音提示";
	MOD_ARENA_GLADIATORLOSSA_ALERTER = "开启被集火提示";
elseif GetLocale() == "zhTW" then
	MOD_ARENA_GLADIATORLOSSA_ENABLE_TEXT = "開啟競技技能語音提示";
	MOD_ARENA_GLADIATORLOSSA_ALERTER = "開啟被集火提示";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("GladiatorlosSA",{BFNew_AddonTypeTable[2]},nil,nil,false)
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

BFNew_RegisterAddonConfig("GladiatorlosSA","CheckBox","EnableGladiatorlosSA",MOD_ARENA_GLADIATORLOSSA_ENABLE_TEXT,nil,
false,-----默认值
	function (arg)
		if ( arg ) then
			if (not BigFoot_IsAddOnLoaded("GladiatorlosSA")) then
				BigFoot_LoadAddOn("GladiatorlosSA");
			end
			if (BigFoot_IsAddOnLoaded("GladiatorlosSA")) then
				GladiatorlosSA:Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("GladiatorlosSA")) then
				GladiatorlosSA:Toggle(false);
			end
		end
	end
)
BFNew_RegisterAddonConfig("GladiatorlosSA","Button","GladiatorlosSA_Option",MOD_ARENA_PROXMIO,nil,
nil,-----默认值
	function ()
		if BigFoot_IsAddOnLoaded("GladiatorlosSA")  then
			GladiatorlosSA:ShowConfig();
		end
	end,1
)