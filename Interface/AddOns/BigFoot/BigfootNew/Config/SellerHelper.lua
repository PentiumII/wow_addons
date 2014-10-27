
if (GetLocale() == "zhCN") then
	MOD_SELLER_HELPER_TITLE = {"售卖助手", "shoumaizhushou"}

	SELLER_HELPER_TITLE = "售卖助手";

	SELLER_HELPER_ENABLE_TEXT = "开启售卖助手";

	SELLER_HELPER_AUTO_SELL_POOR_TEXT = "自动售卖粗糙物品";

	SELLER_HELPER_SELL_ACCEPT_TEXT = "立刻出售售卖列表中的物品";

	SELLER_HELPER_AR_ACCEPT_TEXT = "自动购买物品时给予确认提示";

	SellerHelperNotSellSet ="设置例外物品";

	SELLER_HELPER_KEEP_DALARAN_COIN_TEXT = "不出售达拉然钓鱼硬币";

	SELLER_HELPER_KEEP_MINING_TOOL_TEXT = "不出售暗血矿工锄";

	SELLER_HELPER_ANNOUNCE_TEXT = "显示售卖统计";
	SELLER_HELPER_ANNOUNCE_TEXT_TOOLTIP="在交易完成后聊天窗口进行提示"

	SELLER_HELPER_AUTO_RECHARGE = "启用购买助手";
	SELLER_HELPER_AUTO_RECHARGE_TOOLTIP="在与NPC交易时自动购买NPC身上指定的物品"

elseif (GetLocale() == "zhTW") then
	MOD_SELLER_HELPER_TITLE = {"售賣助手", "shoumaizhushou"}

	SELLER_HELPER_TITLE = "售賣助手";

	SELLER_HELPER_ENABLE_TEXT = "開啟售賣助手";
	SellerHelperNotSellSet="設置例外物品"
	SELLER_HELPER_AUTO_SELL_POOR_TEXT = "自動出售粗糙物品";

	SELLER_HELPER_SELL_ACCEPT_TEXT = "立刻出售售賣列裱中的物品";

	SELLER_HELPER_AR_ACCEPT_TEXT = "自動購買物品時給予確認提示";

	SELLER_HELPER_KEEP_DALARAN_COIN_TEXT = "不出售達拉然釣魚硬幣";

	SELLER_HELPER_KEEP_MINING_TOOL_TEXT = "不出售暗血礦工鋤";

	SELLER_HELPER_ANNOUNCE_TEXT = "顯示售賣統計";
	SELLER_HELPER_ANNOUNCE_TEXT_TOOLTIP= "在交易完成后聊天窗口進行提示";

	SELLER_HELPER_AUTO_RECHARGE = "啟用購買助手";
	SELLER_HELPER_AUTO_RECHARGE_TOOLTIP= "在與NPC交易時自動購買NPC上指定的物品";
else
	MOD_SELLER_HELPER_TITLE = "Seller Helper"

	SELLER_HELPER_TITLE = "Seller Helper";
	SellerHelperNotSellSet = "SellerHelperNotSellSet"
	SELLER_HELPER_ENABLE_TEXT = "Enable Seller Helper";

	SELLER_HELPER_AUTO_SELL_POOR_TEXT = "Sell crappy items automatically";

	SELLER_HELPER_SELL_ACCEPT_TEXT = "Sell items in auto list";

	SELLER_HELPER_AR_ACCEPT_TEXT = "Need confirm when auto buy";

	SELLER_HELPER_KEEP_DALARAN_COIN_TEXT = "Do not sell Dalaran Coins";

	SELLER_HELPER_KEEP_MINING_TOOL_TEXT = "Do not sell mining tools";

	SELLER_HELPER_ANNOUNCE_TEXT = "Show trade gains";

	SELLER_HELPER_AUTO_RECHARGE = "Enable Auto Recharge";
end

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("SellerHelper",{BFNew_AddonTypeTable[7],BFNew_AddonTypeTable[8]},nil,nil,true)

-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("SellerHelper","CheckBox","EnableSellerHelper",SELLER_HELPER_ENABLE_TEXT,nil,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("SellerHelper")) then
				BigFoot_LoadAddOn("SellerHelper");
			end
		end
		if (BigFoot_IsAddOnLoaded("SellerHelper")) then
			if arg then
				SellHelper_EnableToggle(1)
			else
				SellHelper_EnableToggle(nil);
			end
		end
	end
	)

	BFNew_RegisterAddonConfig("SellerHelper","CheckBox","AutoSellPoor",SELLER_HELPER_AUTO_SELL_POOR_TEXT,nil,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("SellerHelper")) then
			if arg then
				SellHelper_SellGrayToggle(1);
			else
				SellHelper_SellGrayToggle(nil);
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("SellerHelper","Button","SellerHelperNotSellSet",SellerHelperNotSellSet,nil,
	false,-----默认值
	function(arg,init)
		if BigfootNewMainFrame:IsShown() then
			SellerHelperSetFrame:SetFrameStrata("DIALOG")
			SellerHelperSetFrame:SetFrameLevel(30)
		end
		SellerHelperSetFrame:Show();
	end,2
	)

	BFNew_RegisterAddonConfig("SellerHelper","CheckBox","SellAccept",SELLER_HELPER_SELL_ACCEPT_TEXT,nil,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("SellerHelper")) then
			if arg then
				SellHelper_SellAcceptToggle(1);
			else
				SellHelper_SellAcceptToggle(nil);
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("SellerHelper","CheckBox","ARAccept",SELLER_HELPER_AR_ACCEPT_TEXT,nil,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("SellerHelper")) then
			if arg then
				AR_AcceptToggle(1);
			else
				AR_AcceptToggle(nil);
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("SellerHelper","CheckBox","ShowTradeAnnounce",SELLER_HELPER_ANNOUNCE_TEXT,SELLER_HELPER_ANNOUNCE_TEXT_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("SellerHelper")) then
			if arg then
				SellHelper_SellAnnounceToggle(1);
			else
				SellHelper_SellAnnounceToggle(nil);
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("SellerHelper","CheckBox","EnableAutoRecharge",SELLER_HELPER_AUTO_RECHARGE,SELLER_HELPER_AUTO_RECHARGE_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("SellerHelper")) then
			if arg then
				AR_Toggle(1);
			else
				AR_Toggle(nil);
			end
		end
	end,1
	)

