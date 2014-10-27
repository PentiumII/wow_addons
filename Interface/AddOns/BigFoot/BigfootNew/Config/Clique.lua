---------------------------------------------------------------------------------
 
if GetLocale()=='zhCN' then
	MOD_CLIQUE_ENABLE_TEXT = "开启一键施法(Clique)";
	MOD_CLIQUE_ENABLE_TOOLTIP = "开启一键施法后，你可以在法术书上找到一键施法的设置界面。";
	CLIQUE_DISABLE_DELAY_TEXT = "|cff00c0c0<一键施法>|r 你已经关闭一键施法模块，该设置将在下次插件载入时生效。";
elseif GetLocale()=='zhTW' then
	MOD_CLIQUE_ENABLE_TEXT = "開啟一鍵施法(Clique)";
	MOD_CLIQUE_ENABLE_TOOLTIP = "開啟一鍵施法後，你可以在法術書上找到一鍵施法的設置介面。";
	
	CLIQUE_DISABLE_DELAY_TEXT = "|cff00c0c0<一鍵施法>|r 你已經關閉一鍵施法模組，該設置將在下次外掛程式載入時生效。";
else
	MOD_CLIQUE_ENABLE_TEXT = "Enable Clique";
	MOD_CLIQUE_ENABLE_TOOLTIP = "After clique is enabled, you can find setting interface in your spellbook.";
end
 
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Clique",{BFNew_AddonTypeTable[1]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
 
	BFNew_RegisterAddonConfig("Clique","CheckBox","EnableClique",MOD_CLIQUE_ENABLE_TEXT,MOD_CLIQUE_ENABLE_TOOLTIP,
	false,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Clique")) then
				BigFoot_LoadAddOn("Clique");
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("Clique")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(CLIQUE_DISABLE_DELAY_TEXT); end);
			end
		end
	end
	)
 