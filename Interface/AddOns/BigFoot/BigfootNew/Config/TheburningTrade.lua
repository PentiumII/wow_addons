if GetLocale() =="zhCN" then
	TRADE_HELPER_ENABLE_TEXT = "开启交易助手"
	TRADE_HELPER_ENABLE_TEXT_TOOLTIP="对交易物品进行提示，并可在小地图按键包中的交易助手显示详细交易记录"
elseif GetLocale() == "zhTW" then
	TRADE_HELPER_ENABLE_TEXT = "開啓交易助手"
	TRADE_HELPER_ENABLE_TEXT_TOOLTIP= "對交易物品進行提示，並可在小地圖按鍵包中的交易助手顯示詳細交易記錄"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("TheBurningTrade",{BFNew_AddonTypeTable[8]},nil,nil,true)
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

BFNew_RegisterAddonConfig("TheBurningTrade","CheckBox","EnableTradeHelper",TRADE_HELPER_ENABLE_TEXT,TRADE_HELPER_ENABLE_TEXT_TOOLTIP,
true,-----默认值
	function (__arg)
		if (__arg) then
			if (not BigFoot_IsAddOnLoaded("TheBurningTrade")) then
				BigFoot_LoadAddOn("TheBurningTrade");
			end
		elseif (BigFoot_IsAddOnLoaded("TheBurningTrade")) then
			--BigFoot_RequestReloadUI(function() BigFoot_Print(TRADE_HELPER_DISABLE_DELAY_TEXT); end);
		end
	end
)