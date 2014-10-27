---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	ENABLE_EJLOOT_TEXT = "启用地下城手册的小怪掉落"
elseif GetLocale() == "zhTW" then
	ENABLE_EJLOOT_TEXT ="啟用地城手冊的小怪掉落"
else

end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("LootListPlus",{BFNew_AddonTypeTable[3],BFNew_AddonTypeTable[7],BFNew_AddonTypeTable[9]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
local NewInfoStrName1=[[
坐骑来源显示
]]

local NewInfoStr1 =[[
大脚今日独家首发！当你把鼠标移动到目标的坐骑Buff上去查看坐骑名称时，
大脚也为玩家提供了坐骑的来源，比如：何种声望、哪位商人、哪个成就提供。快速的了解拉风坐骑的出处吧！
]]
if (GetLocale()=="zhCN" or GetLocale()=="zhTW") then
	BFNew_RegisterAddonConfig("LootListPlus","CheckBox","LootListEnable",ENABLE_EJLOOT_TEXT,nil,
	true,-----默认值
	function(arg,init)
		if (arg)then
			if (not BigFoot_IsAddOnLoaded("LootListPlus")) then
				BigFoot_LoadAddOn("LootListPlus");
			end
			__BfLootListToggle(1)
		else
			if BigFoot_IsAddOnLoaded("LootListPlus") then
				__BfLootListToggle(0)
			end
		end
		if init then
			BF_NewAddOnsPromotion("zhCN",313,NewInfoStrName1,NewInfoStr1,"MapToolkit","LootListEnable")
		end
	end
	)
end
