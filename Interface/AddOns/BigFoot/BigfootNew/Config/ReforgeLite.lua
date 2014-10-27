if GetLocale() =="zhCN" then
	ReforgeLite_Title = "启用重铸助手"
	ReforgeLite_Title_TOOLTIP = "根据提供的属性参数计算优化人物当前的装备属性"
elseif GetLocale() == "zhTW" then
	ReforgeLite_Title = "啟用重鑄助手"
	ReforgeLite_Title_TOOLTIP = "根據提供的屬性參數計算優化人物當前的裝備屬性"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("ReforgeLite",{BFNew_AddonTypeTable[7]},nil,nil,false)
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

BFNew_RegisterAddonConfig("ReforgeLite","CheckBox","EnableReforgeLite",ReforgeLite_Title,ReforgeLite_Title_TOOLTIP,
false,-----默认值
	function (arg)
		if ( arg ) then
			if (not BigFoot_IsAddOnLoaded("ReforgeLite")) then
				BigFoot_LoadAddOn("ReforgeLite");
			end
		else
			if (BigFoot_IsAddOnLoaded("ReforgeLite")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(ReforgeLite_DISABLE_DELAY_TEXT); end);
			end
		end
	end
)