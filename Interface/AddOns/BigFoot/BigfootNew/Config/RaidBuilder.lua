
if GetLocale() == "zhCN" then
	ENABLE_RaidBuilder_TEXT ="启用组队系统"
	RaidBuilder_DISABLE_DELAY_TEXT = "|cff00c0c0<大脚插件>|r 你已经关闭组队系统(RaidBuilder)模块，该设置将在下次插件载入时生效。";
elseif GetLocale() == "zhTW" then
	ENABLE_RaidBuilder_TEXT ="啟用組隊系統"
	RaidBuilder_DISABLE_DELAY_TEXT = "|cff00c0c0<組隊系統>|r 你已經關閉組隊系統(RaidBuilder)模組，該設置將在下次外掛程式載入時生效。";
else
end

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("RaidBuilder",{BFNew_AddonTypeTable[3]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("RaidBuilder","CheckBox","EnableRaidBuilder",ENABLE_RaidBuilder_TEXT,nil,
true,-----默认值
function(arg,init)
	if (arg ) then
		if (not BigFoot_IsAddOnLoaded("RaidBuilder")) then
			BigFoot_LoadAddOn("RaidBuilder");
		end
	else
		if (BigFoot_IsAddOnLoaded("RaidBuilder")) then
			BigFoot_RequestReloadUI(function() BigFoot_Print(RaidBuilder_DISABLE_DELAY_TEXT); end);
		end
	end
end
)

