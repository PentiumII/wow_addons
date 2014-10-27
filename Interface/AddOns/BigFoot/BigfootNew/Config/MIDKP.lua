---------------------------------------------------------------------------------
if GetLocale()=='zhCN' then
	MiDKP_ADDON_TITLE = "使用MiDKP插件"
elseif GetLocale()=='zhTW' then 
	MiDKP_ADDON_TITLE = "使用MiDKP插件"
else
	MiDKP_ADDON_TITLE = "Use GDKP"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("MiDKP",{BFNew_AddonTypeTable[3]},true,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("MiDKP","CheckBox","MiDKPEnable",MiDKP_ADDON_TITLE,nil,
	true,-----默认值
	function(arg,init)
		if (arg and not __MIDKP_Enable) then
			__MIDKP_Enable = 1;	
			if (not __mikdp_isHooked) then
				-- self:DoHook()
				MiDKP.S:DoHook()
				MiDKP.UI.Frame:OnAddOnLoaded()
				__mikdp_isHooked = true;
			end
		elseif ( (not arg)  and __MIDKP_Enable) then
			-- self:DoUnhook();	
				MiDKP.S:DoUnhook()			
			__mikdp_isHooked=false;
			__MIDKP_Enable = nil;				
		end
	end
)
