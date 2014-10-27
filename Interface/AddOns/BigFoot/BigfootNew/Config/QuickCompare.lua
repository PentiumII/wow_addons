
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("QuickCompare",{BFNew_AddonTypeTable[7]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
if GetLocale() == "zhCN" then
	QUICK_COMPARE_ENABLE = "启用装备比较";
	
	QuickCompare_AchievementEnable_Text= "启用成就对比";
	QuickCompare_AchievementEnable_Text_Tooltip= "";
elseif GetLocale() == "zhTW" then
	QUICK_COMPARE_ENABLE = "開啟裝備比較";
	
	QuickCompare_AchievementEnable_Text= "啟用成就對比";
	QuickCompare_AchievementEnable_Text_Tooltip= "";
end

BFNew_RegisterAddonConfig("QuickCompare","CheckBox","EnableQuickCompare",QUICK_COMPARE_ENABLE,nil,
true,-----默认值
function(arg,init)
	if (arg ) then
		if (not BigFoot_IsAddOnLoaded("QuickCompare")) then
			BigFoot_LoadAddOn("QuickCompare");
		end
		if (BigFoot_IsAddOnLoaded("QuickCompare")) then
			QuickCompare_Toggle(true,1);
		end
	else
		if (BigFoot_IsAddOnLoaded("QuickCompare")) then
			QuickCompare_Toggle(false,1);
		end
	end
end
)
BFNew_RegisterAddonConfig("QuickCompare","CheckBox","EnableAchievementCompare",QuickCompare_AchievementEnable_Text,nil,
true,-----默认值
function(arg,init)
	if (arg ) then
		if (not BigFoot_IsAddOnLoaded("QuickCompare")) then
			BigFoot_LoadAddOn("QuickCompare");
		end
		if (BigFoot_IsAddOnLoaded("QuickCompare")) then
			QuickCompare_Toggle(true,2);
		end
	else
		if (BigFoot_IsAddOnLoaded("QuickCompare")) then
			QuickCompare_Toggle(false,2);
		end
	end
end
)