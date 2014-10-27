if GetLocale() =="zhCN" then
	MOD_INFO_RATING_BUSTER = "开启装备属性分析"
	MOD_INFO_RATING_BUSTER_TOOLTIP= "根据人物当前等级将装备说明上的爆击等级、命中等级等换算成直观的百分比"
	
	RATING_BUSTER_SETTINGS = "装备属性设置"
elseif GetLocale() == "zhTW" then
	MOD_INFO_RATING_BUSTER = "開啟裝備屬性分析"
	MOD_INFO_RATING_BUSTER_TOOLTIP= "根據人物當前等級將裝備說明上的暴擊等級、命中等級等換算成直觀的百分比"
	
	RATING_BUSTER_SETTINGS = "裝備屬性設置"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("RatingBuster",{BFNew_AddonTypeTable[7]},nil,nil,false)
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

BFNew_RegisterAddonConfig("RatingBuster","CheckBox","EnableRatingBuster",MOD_INFO_RATING_BUSTER,MOD_INFO_RATING_BUSTER_TOOLTIP,
false,-----默认值
	function (arg)
		if ( arg ) then
			if (not BigFoot_IsAddOnLoaded("RatingBuster")) then
				BigFoot_LoadAddOn("RatingBuster");
			end

			if (BigFoot_IsAddOnLoaded("RatingBuster")) then
				RatingBuster:Enable();
			end
		else
			if (BigFoot_IsAddOnLoaded("RatingBuster")) then
				RatingBuster:Disable();
			end
		end
	end
)
BFNew_RegisterAddonConfig("RatingBuster","Button","RatingBuster_Option",RATING_BUSTER_SETTINGS,nil,
nil,-----默认值
	function()
		if BigFoot_IsAddOnLoaded("RatingBuster")  then
			RatingBuster:ShowConfig()
			PlaySound("igMainMenuOption");
		end
	end,1
)