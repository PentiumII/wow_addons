---------------------------------------------------------------------------------
 
if GetLocale()=='zhCN' then
	MOD_PARTY_ASSIST_ENABLE_TEXT = "开启组队施法";
	MOD_PARTY_ASSIST_ENABLE_TEXT_TOOLTIP = "允许你在队友头像旁边设置法术的快捷按钮以方便施放针对队友的增益魔法。";

	MOD_PARTY_ASSIST_8_BUTTONS = "允许放置8种魔法";
	MOD_PARTY_ASSIST_LITE_TIPS = "精简鼠标提示信息";
	
elseif GetLocale()=='zhTW' then
	MOD_PARTY_ASSIST_ENABLE_TEXT = "開啟組隊施法";
	MOD_PARTY_ASSIST_ENABLE_TEXT_TOOLTIP = "允許你在隊友頭像旁邊設置法術的快捷按鈕以方便施放針對隊友的增益魔法。";

	MOD_PARTY_ASSIST_8_BUTTONS = "允許放置8種魔法";
	MOD_PARTY_ASSIST_LITE_TIPS = "精簡滑鼠提示信息";
else
	MOD_PARTY_ASSIST_ENABLE_TEXT = "Enable PartyAssist";
	MOD_PARTY_ASSIST_ENABLE_TIP_TEXT = "Allow you place some spell on the right of party member portraits.";

	MOD_PARTY_ASSIST_8_BUTTONS = "Set 8 spell buttons";
	MOD_PARTY_ASSIST_LITE_TIPS = "Simple Tips";
end
 
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("PartyAssist",{BFNew_AddonTypeTable[3]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
 
	BFNew_RegisterAddonConfig("PartyAssist","CheckBox","EnablePartyAssist",MOD_PARTY_ASSIST_ENABLE_TEXT,MOD_PARTY_ASSIST_ENABLE_TEXT_TOOLTIP,
	false,-----默认值
	function(arg,init)
		if ( arg ) then
			if (not BigFoot_IsAddOnLoaded("PartyAssist")) then
				BigFoot_LoadAddOn("PartyAssist");
			end

			if (BigFoot_IsAddOnLoaded("PartyAssist")) then
				PartyAssist_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("PartyAssist")) then
				PartyAssist_Toggle(false);
			end
		end
	end
	)
 
 
	BFNew_RegisterAddonConfig("PartyAssist","CheckBox","8Buttons",MOD_PARTY_ASSIST_8_BUTTONS,nil,
	false,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("PartyAssist")) then
			if (arg) then
				PartyAssist_Toggle8Buttons(true);
			else
				PartyAssist_Toggle8Buttons(false);
			end
		end
	end,1
	)
 
 
	BFNew_RegisterAddonConfig("PartyAssist","CheckBox","LiteTips",MOD_PARTY_ASSIST_LITE_TIPS,nil,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("PartyAssist")) then
			if (arg) then
				PartyAssist_ToggleTipMod(true);
			else
				PartyAssist_ToggleTipMod(false);
			end
		end
	end,1
	)
 