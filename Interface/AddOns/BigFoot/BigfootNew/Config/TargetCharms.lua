if GetLocale() =="zhCN" then
	TargetCharms_ENABLE_TEXT = "启用标记助手"
	TargetCharms_ENABLE_TOOLTIP = "启用此选项以后你可以快速放置光柱标记,当你身为队长时还可以使用团队标记"
	TargetCharms_Set_Text = "配置"
elseif GetLocale() == "zhTW" then
	TargetCharms_ENABLE_TEXT = "啟用標記助手"
	TargetCharms_ENABLE_TOOLTIP = "啟用此選項以後你可以快速放置光柱標記,當你身為隊長時還可以使用團隊標記"
	TargetCharms_Set_Text = "配置"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("TargetCharms",{BFNew_AddonTypeTable[3]},nil,nil,false)
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

BFNew_RegisterAddonConfig("TargetCharms","CheckBox","EnableTargetCharms",TargetCharms_ENABLE_TEXT,TargetCharms_ENABLE_TOOLTIP,
false,-----默认值
	function (__arg,init)
		if (__arg) then
			if (not BigFoot_IsAddOnLoaded("TargetCharms")) then
				BigFoot_LoadAddOn("TargetCharms");
			end
			if (BigFoot_IsAddOnLoaded("TargetCharms")) then
				TopCharm_Toggle(1)
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("TargetCharms")) then
				TopCharm_Toggle();
			end
		end
		if init then
			BF_NewAddOnsPromotion("zhCN",316,NewInfoStrName,NewInfoStr,"MarkAssistant","EnableTargetCharms")
		end
	end
)
BFNew_RegisterAddonConfig("TargetCharms","Button","TargetCharmsOption",TargetCharms_Set_Text,nil,
nil,-----默认值
	function ()
		if (BigFoot_IsAddOnLoadedFromBigFoot("TargetCharms")) then
			ShowSetup();
		end
	end
)