
if GetLocale() =="zhCN" then
	ENABLE_BIGFOOTBLACKBANK_TEXT = "启用黑市助手"
	ENABLE_BIGFOOTBLACKBANK_TOOLTIP = "启用黑市助手将与别人共享最新的黑市信息"
	BIGFOOTBLACKBANK_DISABLE_DELAY_TEXT = "|cff00c0c0<交易助手>|r 你已经关闭黑市助手模块，该设置将在下次插件载入时生效"
elseif GetLocale() == "zhTW" then
	ENABLE_BIGFOOTBLACKBANK_TEXT = "啟用黑市助手"
	ENABLE_BIGFOOTBLACKBANK_TOOLTIP = "啟用黑市助手將於別人共享最新的黑市信息"
	BIGFOOTBLACKBANK_DISABLE_DELAY_TEXT = "|cff00c0c0<交易助手>|r 你已經關閉黑市助手模組，該設置將在下次外掛城市載入時生效"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BigFootBank",{BFNew_AddonTypeTable[8]},nil,nil,true)
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
BFNew_RegisterAddonConfig("BigFootBank","CheckBox","EnableBigFootBank",ENABLE_BIGFOOTBLACKBANK_TEXT,ENABLE_BIGFOOTBLACKBANK_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg ) then
			if (not BigFoot_IsAddOnLoaded("BigFootBank")) then
				BigFoot_LoadAddOn("BigFootBank");
			end
		else
		
		end
	end
)