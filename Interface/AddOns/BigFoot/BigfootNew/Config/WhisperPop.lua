---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	WP_ENABLE_TEXT = "启用密语管理";
	WP_ENABLE_TEXT_TOOLTIP= "记录并提示玩家密语聊天信息";
elseif GetLocale() == "zhTW" then
	WP_ENABLE_TEXT = "啟用密語管理";
	WP_ENABLE_TEXT_TOOLTIP= "記錄并提示玩家密語聊天信息";
else
	WP_ENABLE_TEXT = "Enable WhisperPop";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("WhisperPop",{BFNew_AddonTypeTable[4]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
local NewInfoStrName=[[
密语聊天管理器
]]

local NewInfoStr =[[
现在已经能够记录与战网好友（实名好友）和GM的对话了，
更加方便管理密聊记录。
]]

BFNew_RegisterAddonConfig("WhisperPop","CheckBox","EnableWhisperPop",WP_ENABLE_TEXT,WP_ENABLE_TEXT_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("WhisperPop")) then
			BigFoot_LoadAddOn("WhisperPop");
		end

		if (BigFoot_IsAddOnLoaded("WhisperPop")) then
			WhisperPop_Toggle(true);
		end
	else
		if (BigFoot_IsAddOnLoaded("WhisperPop")) then
			WhisperPop_Toggle(false);
		end
	end
	if init then
		BF_NewAddOnsPromotion("zhCN",313,NewInfoStrName,NewInfoStr,"ChatEnhancement","EnableWhisperPop")
	end
end
)