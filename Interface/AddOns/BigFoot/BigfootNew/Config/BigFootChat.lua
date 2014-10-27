---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	BFC_ENABLE_TEXT = "启用大脚聊天快捷条";
	BFC_ENABLE_TEXT_TOOLTIP= "添加聊天快捷条，如使用大脚表情，快捷频道切换等";
	BFC_CONFIG="聊天配置"
elseif GetLocale() == "zhTW" then
	BFC_ENABLE_TEXT = "啟用大腳聊天快捷條"
	BFC_ENABLE_TEXT_TOOLTIP= "添加聊天快捷條，如使用大腳表情，快捷頻道切換等"
	BFC_CONFIG="聊天配置"
else
	BFC_ENABLE_TEXT = "Enable BigFootChat"
	BFC_CONFIG="Config BFC"
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BigFootChat",{BFNew_AddonTypeTable[3],BFNew_AddonTypeTable[4]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

local NewInfoStrName=[[
地下城手册增强！
]]

local NewInfoStr =[[
大脚独家首发！将大脚团队一句话攻略添加至地下城手册！
所在位置：
大脚设置-聊天增强-【配置】一句话攻略。
]]

BFNew_RegisterAddonConfig("BigFootChat","CheckBox","EnableBFC",BFC_ENABLE_TEXT,BFC_ENABLE_TEXT_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("BigFootChat")) then
			BigFoot_LoadAddOn("BigFootChat");
		end

		if (BigFoot_IsAddOnLoaded("BigFootChat")) then
			BigFootChat:Enable();
		end
	else
		if (BigFoot_IsAddOnLoadedFromBigFoot("BigFootChat")) then
			BigFootChat:Disable();
			--BigFoot_RequestReloadUI(function() BigFoot_Print(BFC_DISABLE_DELAY_TEXT); end);
		end
	end
	if init then
		BF_NewAddOnsPromotion("zhCN",315,NewInfoStrName,NewInfoStr,"ChatEnhancement","EnableBFC")
	end
end
)

BFNew_RegisterAddonConfig("BigFootChat","Button","ButtonBigFootChat",BFC_CONFIG,nil,
true,-----默认值
function(arg,init)
	if BigFoot_IsAddOnLoaded("BigFootChat")  then
		BigFootChat:ShowOptions()
		PlaySound("igMainMenuOption");
	end
end,1
)