---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	INFOBOX_ENABLE_TITLE = "开启界面调整";
	INFOBOX_ENABLE_TITLE_TOOLTIP = "当鼠标移动到屏幕顶端弹出界面调整主菜单，通过该菜单你可以调整你所需要的界面";
	BT4_CONFIG_PANEL = "配置界面调整";
	BARTENDER4_DISABLE_DELAY_TEXT = "|cff00c0c0<界面调整>|r 你已经关闭界面调整模块，该设置将在下次插件载入时生效。";
	
	INFOBOX_ENABLE_ADDON ="开启插件";
elseif GetLocale() == "zhTW" then
	INFOBOX_ENABLE_TITLE = "開啟介面調整";
	INFOBOX_ENABLE_TITLE_TOOLTIP = "當鼠標移動到屏幕頂端彈出介面調整菜單，通過該菜單你可以調整你所需要的介面";
	BT4_CONFIG_PANEL = "配置介面調整";
	BARTENDER4_DISABLE_DELAY_TEXT = "|cff00c0c0<介面調整>|r 你已經關閉窗介面調整模組，該設置將在下次插件載入時生效。";
	
	INFOBOX_ENABLE_ADDON ="開啟插件";

else
	BLIZZMOVE_ENABLE_TITLE = "Enable BlizzMove";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Bartender4",{BFNew_AddonTypeTable[6]},nil,nil,false)
BFNew_RegisterAddon("Bartender4_BFMod",{BFNew_AddonTypeTable[6]},nil,nil,false)

--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("Bartender4_BFMod","CheckBox","EnableInfoBoxV2",INFOBOX_ENABLE_TITLE,INFOBOX_ENABLE_TITLE_TOOLTIP,
false,-----默认值
function(arg,init)
	if init then
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Bartender4")) then
				Bartender4DB = Bartender4DB or {};
				BigFoot_LoadAddOn("Bartender4");
			end
			if (not BigFoot_IsAddOnLoaded("Bartender4_BFMod")) then
				BigFoot_LoadAddOn("Bartender4_BFMod");
			end
			
		else
			---------插件没有载入的时候重置已设置的窗体-------------
			-- BigFoot_ResetUIFrames()
			-- BigFoot_LoadChatFrames()
		end
	else
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Bartender4")) then
				Bartender4DB = Bartender4DB or {};
				BigFoot_LoadAddOn("Bartender4");
			end
			if (not BigFoot_IsAddOnLoaded("Bartender4_BFMod")) then
				BigFoot_SaveUIFrames()
				BigFoot_SaveChatFrames()
				BigFoot_LoadAddOn("Bartender4_BFMod");
				-- LoadAddOn
			end
			
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Bartender4_BFMod")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(BARTENDER4_DISABLE_DELAY_TEXT); end);
			end
		end
	end
end
)
 



BFNew_RegisterAddonConfig("Bartender4","CheckBox","EnableBartender4",INFOBOX_ENABLE_ADDON,nil,
false,-----默认值
function(arg,init)
			---------插件没有载入的时候重置已设置的窗体-------------
			-- BigFoot_ResetUIFrames()
			-- BigFoot_LoadChatFrames()

		if (arg) then
				Bartender4DB = Bartender4DB or {};
				BigFoot_LoadAddOn("Bartender4");		
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Bartender4")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(BARTENDER4_DISABLE_DELAY_TEXT); end);
			end
		end

end
)
BFNew_RegisterAddonConfig("Bartender4","Button","ButtonBartender4Option",BT4_CONFIG_PANEL,nil,
false,-----默认值
function(arg,init)
	if (BigFoot_IsAddOnLoaded("Bartender4")) then
		LibStub("AceConfigDialog-3.0"):Open("Bartender4")
	end
end,1
)
BFNew_RegisterAddonConfig("Bartender4_BFMod","Button","ButtonBartender4Option",BT4_CONFIG_PANEL,nil,
false,-----默认值
function(arg,init)
	if (BigFoot_IsAddOnLoaded("Bartender4")) then
		LibStub("AceConfigDialog-3.0"):Open("Bartender4")
	end
end,1
)