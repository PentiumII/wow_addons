if GetLocale() =="zhCN" then
	EZICON_ENABLE_TEXT="启用双击标记"
	EZICON_ENABLE_TOOLTIP = "启用此选项以后你可以通过左键双击目标来为其指定团队标记"
elseif GetLocale() == "zhTW" then
	EZICON_ENABLE_TEXT="啟用團隊標記"
	EZICON_ENABLE_TOOLTIP = "啟用此選項以後你可以通過左鍵雙擊目標來為其指定團隊目標"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("ezIcons",{BFNew_AddonTypeTable[3]},nil,nil,false)
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

BFNew_RegisterAddonConfig("ezIcons","CheckBox","EnableezIcon",EZICON_ENABLE_TEXT,EZICON_ENABLE_TOOLTIP,
false,-----默认值
	function (__arg)
		if (__arg) then
			if (not BigFoot_IsAddOnLoaded("ezIcons")) then
				BigFoot_LoadAddOn("ezIcons");
			end
			if (BigFoot_IsAddOnLoaded("ezIcons")) then
				ezIcons:OnEnable();
				ezIcons:ToggleActive(true)
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("ezIcons")) then
				ezIcons:OnDisable();
				ezIcons:ToggleActive(false)
			end
		end
	end
)