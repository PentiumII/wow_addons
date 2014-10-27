---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	BFGOLDFRAME_ENABLE_TITLE = "开启金币统计"
	BFGOLDFRAME_ENABLE_TITLE_TOOLTIP= "快捷监视当前金币的框体，并可记录金币变化信息"
elseif GetLocale() == "zhTW" then
	BFGOLDFRAME_ENABLE_TITLE = "開啟金幣統計"
	BFGOLDFRAME_ENABLE_TITLE_TOOLTIP= "快捷監視當前金幣的框體，并可記錄金幣變化信息"
else
	BFGOLDFRAME_ENABLE_TITLE = "Enable GoldFrame"
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BFGoldFrame",{BFNew_AddonTypeTable[8]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("BFGoldFrame","CheckBox","EnableBFGoldFrame",BFGOLDFRAME_ENABLE_TITLE,BFGOLDFRAME_ENABLE_TITLE_TOOLTIP,
true,-----默认值
function(arg,init)
	if ( arg ) then
		if (not BigFoot_IsAddOnLoaded("BFGoldFrame")) then
			BigFoot_LoadAddOn("BFGoldFrame");					
		end	
		BFGoldFrame_Toggle(true)
	else
		if ( BigFoot_IsAddOnLoaded("BFGoldFrame")) then
			BFGoldFrame_Toggle(false)
		end
	end
end
)