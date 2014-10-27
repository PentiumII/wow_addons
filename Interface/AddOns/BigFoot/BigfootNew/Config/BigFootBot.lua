---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	 ENABLE_BigFootBot_TEXT ="启用信息收集"
elseif GetLocale() == "zhTW" then
	ENABLE_BigFootBot_TEXT ="啟用信息收集"
	
else
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BigFootBot",{BFNew_AddonTypeTable[10]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("BigFootBot","CheckBox","EnableBigFootBot",ENABLE_BigFootBot_TEXT,nil,
true,-----默认值
function(arg,init)
	if (arg ) then
		if (not BigFoot_IsAddOnLoaded("BigFootBot")) then
			BigFoot_LoadAddOn("BigFootBot");
		end
	else
		if (BigFoot_IsAddOnLoaded("BigFootBot")) then
			--BigFoot_RequestReloadUI(function() BigFoot_Print(ARCHY_DISABLE_DELAY_TEXT); end);
		end
	end
end
)
 
