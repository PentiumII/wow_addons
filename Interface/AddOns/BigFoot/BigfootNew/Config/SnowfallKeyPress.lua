if GetLocale() =="zhCN" then
	SnowfallKeyPress_Title = "启用动作条按钮加速";
	SnowfallKeyPress_Title_TOOLTIP = "启用动作条按钮加速";
elseif GetLocale() == "zhTW" then
	SnowfallKeyPress_Title = "啟用動作條按鈕加速";
	SnowfallKeyPress_Title_TOOLTIP = "啟用動作條按鈕加速";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("SnowfallKeyPress",{BFNew_AddonTypeTable[10]},nil,nil,true)
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

BFNew_RegisterAddonConfig("SnowfallKeyPress","CheckBox","Enable_SnowfallKeyPress",SnowfallKeyPress_Title,SnowfallKeyPress_Title_TOOLTIP,
true,-----默认值
	function (__arg)
		if (__arg) then
			if (not BigFoot_IsAddOnLoaded("SnowfallKeyPress")) then
				BigFoot_LoadAddOn("SnowfallKeyPress");
			end
			 
		else
			if (BigFoot_IsAddOnLoaded("SnowfallKeyPress")) then
			end
		end
	end
)