
if GetLocale() =="zhCN" then
	ENABLE_TurnIn_TEXT = "自动交接任务";
	ENABLE_TurnIn_Switch= "配置";
elseif GetLocale() == "zhTW" then
	ENABLE_TurnIn_TEXT = "自动交接任务";
	ENABLE_TurnIn_Switch= "配置";
else
	ENABLE_TurnIn_TEXT = "Automatic handover task";
	ENABLE_TurnIn_Switch= "configuration";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("TurnIn",{BFNew_AddonTypeTable[9]},nil,nil,false)
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
BFNew_RegisterAddonConfig("TurnIn","CheckBox","EnableTurnIn",ENABLE_TurnIn_TEXT,nil,
	false,-----默认值
	function (arg)
		if not BigFoot_IsAddOnLoaded("TurnIn") then
			BigFoot_LoadAddOn("TurnIn")
		end
		if (arg) then
		else
		end
	end
)

BFNew_RegisterAddonConfig("TurnIn","Button","ButtonTurnIn",ENABLE_TurnIn_Switch,nil,
	true,-----默认值
	function (arg)
		if (BigFoot_IsAddOnLoaded("TurnIn")) then
			TI_SlashCmdHandler("window");
		end
	end,1
)