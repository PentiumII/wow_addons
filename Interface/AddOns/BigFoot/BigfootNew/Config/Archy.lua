---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	 ENABLE_ARCHY_TEXT ="启用考古助手"
elseif GetLocale() == "zhTW" then
	ENABLE_ARCHY_TEXT ="啟用考古助手"
else
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Archy",{BFNew_AddonTypeTable[9]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("Archy","CheckBox","EnableArchy",ENABLE_ARCHY_TEXT,nil,
false,-----默认值
function(arg,init)
	if (arg ) then
		if (not BigFoot_IsAddOnLoaded("Archy")) then
			BigFoot_LoadAddOn("Archy");
		end
	else
		if (BigFoot_IsAddOnLoaded("Archy")) then
			--BigFoot_RequestReloadUI(function() BigFoot_Print(ARCHY_DISABLE_DELAY_TEXT); end);
		end
	end
end
)
 
