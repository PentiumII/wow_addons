---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	BIGFOOTGADGET_CASTING_BAR = "使用大脚施法条"
	BIGFOOTGADGET_CASTING_BAR_TOOLTIP="在原有的施法条基础上添加了施法时间与施法延迟提示"
elseif GetLocale() == "zhTW" then
	BIGFOOTGADGET_CASTING_BAR = "使用大腳施法條"
	BIGFOOTGADGET_CASTING_BAR_TOOLTIP= "在原有的施法條基礎上添加了施法時間與施法延遲提示"

else
	BIGFOOTGADGET_CASTING_BAR = "Use BFCastingBar"
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BFCastingBar",{BFNew_AddonTypeTable[1]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("BFCastingBar","CheckBox","BFCB",BIGFOOTGADGET_CASTING_BAR,BIGFOOTGADGET_CASTING_BAR_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFCastingBar")) then
				BigFoot_LoadAddOn("BFCastingBar");
			end
			if (BigFoot_IsAddOnLoaded("BFCastingBar")) then
				BFCB:Toggle(true)
			end
		else
			if (BigFoot_IsAddOnLoaded("BFCastingBar")) then
				BFCB:Toggle(false)
			end
		end
	end
	)
	
 
