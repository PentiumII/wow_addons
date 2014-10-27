---------------------------------------------------------------------------------
if GetLocale()=='zhCN' then
	GDKP_ADDON_TITLE = "使用大脚金团助手"
elseif GetLocale()=='zhTW' then 
	GDKP_ADDON_TITLE = "使用大腳金團助手"
else
	GDKP_ADDON_TITLE = "Use GDKP"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("GDKP",{BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("GDKP","CheckBox","GDKPEnable",GDKP_ADDON_TITLE,nil,
	false,-----默认值
	function(arg,init)
		if arg then
			-- if not IsAddOnLoaded("GDKP") then
				-- LoadAddOn("GDKP")
			-- end
			if (not BigFoot_IsAddOnLoaded("GDKP")) then
				BigFoot_LoadAddOn("GDKP");
			end
			if BigFoot_IsAddOnLoaded("GDKP") then
				GDKP:Enable()
			end
		else
			if BigFoot_IsAddOnLoaded("GDKP") then
				GDKP:Disable()
			end
		end
	end
	)
