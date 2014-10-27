if GetLocale() == "zhCN" then
	UnrealEquip_Title ="启用幻化助手";
	UnrealEquip_Title_TOOLTIP ="提供快捷的幻化帮助功能";
elseif GetLocale() == "zhTW" then
	UnrealEquip_Title="啟用幻化助手"
	UnrealEquip_Title_TOOLTIP="提供快捷的幻化幫助功能"
else
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
--------------参数4 插件Enable默认值-----------------------------------
BFNew_RegisterAddon("UnrealEquip",{BFNew_AddonTypeTable[7]},nil,true,false)

--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})  -- 表示 skada 与 recount 互斥
--------------------注册插件配置信息----------------------------------
BFNew_RegisterAddonConfig("UnrealEquip","CheckBox","EnableUnrealEquip",UnrealEquip_Title,UnrealEquip_Title_TOOLTIP,
false,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("UnrealEquip")) then
			BigFoot_LoadAddOn("UnrealEquip");
		end
		UnrealEquipFlyoutFrame_OnEnable()
	else
	end
end
)