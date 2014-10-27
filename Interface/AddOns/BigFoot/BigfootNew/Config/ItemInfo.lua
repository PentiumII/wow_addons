---------------------------------------------------------------------------------
local __L = BLocal("ItemInfo");

if (GetLocale() == "zhCN") then
	__L["Item Info"]					= {"物品信息", "wupinxinxi"};

	__L["Enable Item Info"]			= "启用物品信息";
	Enable_Item_Info_TOOLTIP="扩展物品的相关信息"

	__L["Show Sell Value"]			= "物品价格";
	Show_Sell_Value_TOOLTIP="显示物品出售价格及可堆叠物品的总价"

	__L["Show Auction Info"]		= "物品AH信息";
	Show_Auction_Info_TOOLTIP="统计物品在拍卖行中的价格"

	__L["Show Additional Info"]		= "物品等级|堆叠|用途";
	Show_Additional_Info_TOOLTIP="显示物品等级，可堆叠的数量及用提提示"

	__L["Show Gem Info"]			= "宝石信息";
	Show_Gem_Info_TOOLTIP="显示镶嵌在当前装备上的宝石名称"

	__L["Show Item Qulity"]			= "物品质量及颜色";
	Show_Item_Qulity_TOOLTIP="用文字方式说明物品质量及在背包中显示装备颜色"

	__L["Enable Auction Helper"]	= "启用拍卖助手";
	Enable_Auction_Helper_TOOLTIP="开启一些在拍卖行的小功能，如显示可堆叠物品的单价 、右击物品直接拍卖等功能"

	__L["Clear Dada"]					= "清除拍卖信息";
	Enable_AlreadyKnown = "启用已学物品染色"

elseif (GetLocale() == "zhTW") then
	__L["Item Info"]					= {"物品信息", "wupinxinxi"};

	__L["Enable Item Info"]			= "啟用物品信息";
	Enable_Item_Info_TOOLTIP="擴展物品的相關信息"

	__L["Show Sell Value"]			= "物品價格";
	Show_Sell_Value_TOOLTIP="顯示物品出售價格及可堆疊物品的總價"

	__L["Show Auction Info"]		= "物品AH信息";
	Show_Auction_Info_TOOLTIP="統計物品在拍賣行中的價格"

	__L["Show Additional Info"]	= "物品等級|堆疊|用途";
	Show_Additional_Info_TOOLTIP="顯示物品等級，可堆疊數量及用途提示"

	__L["Show Gem Info"]			= "寶石信息";
	Show_Gem_Info_TOOLTIP="顯示鑲嵌在當前裝備上的寶石名稱"

	__L["Show Item Qulity"]			= "物品質量及顏色";
	Show_Item_Qulity_TOOLTIP="用文字方式說明物品質量及在背包中顯示裝備顏色"

	__L["Enable Auction Helper"]	= "啟用拍賣助手";
	Enable_Auction_Helper_TOOLTIP="開啟一些在拍賣行的小功能，如顯示可堆疊物品的單價、右擊物品直接拍賣等功能"

	__L["Clear Dada"]					= "清除拍賣資訊";
	Enable_AlreadyKnown = "啟用已學物品染色"
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("ItemInfo",{BFNew_AddonTypeTable[7],BFNew_AddonTypeTable[8]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableItemInfo",__L["Enable Item Info"],Enable_Item_Info_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("ItemInfo")) then
				BigFoot_LoadAddOn("ItemInfo");
			end

			if (BigFoot_IsAddOnLoaded("ItemInfo")) then
				ItemInfo_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("ItemInfo")) then
				ItemInfo_Toggle(false);
			end
		end
	end
	)

	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableSellValue",__L["Show Sell Value"],Show_Sell_Value_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("ItemInfo")) then
			if (arg) then
				II_Config['SellValue'] = 1;
			else
				II_Config['SellValue'] = nil;
			end
		end
	end,1
	)


	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableAuctionInfo",__L["Show Auction Info"],Show_Auction_Info_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("ItemInfo")) then
			if (arg) then
				II_Config['AuctionInfo'] = 1;
			else
				II_Config['AuctionInfo'] = nil;
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableAdditionalInfo",__L["Show Additional Info"],Show_Additional_Info_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("ItemInfo")) then
			if (arg) then
				II_Config['ItemLevel'] = 1;
				II_Config['StackCount'] = 1;
				II_Config['UseInfo'] = 1;
			else
				II_Config['ItemLevel'] = nil;
				II_Config['StackCount'] = nil;
				II_Config['UseInfo'] = nil;
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableGemInfo",__L["Show Gem Info"],Show_Gem_Info_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("ItemInfo")) then
			if (arg) then
				II_Config['GemInfo'] = 1;
			else
				II_Config['GemInfo'] = nil;
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableItemQulity",__L["Show Item Qulity"],Show_Item_Qulity_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoaded("ItemInfo")) then
			if (arg) then
				II_Config['ItemQulity'] = 1;
			else
				II_Config['ItemQulity'] = nil;
			end
		end
	end,1
	)

	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableAuctionHelper",__L["Enable Auction Helper"],Enable_Auction_Helper_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("ItemInfo")) then
				BigFoot_LoadAddOn("ItemInfo");
			end

			if (BigFoot_IsAddOnLoaded("ItemInfo")) then
				ItemInfo_AuctionToggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("ItemInfo")) then
				ItemInfo_AuctionToggle(false);
			end
		end
	end
	)

	BFNew_RegisterAddonConfig("ItemInfo","Button","ItemInfoButton",__L["Clear Dada"],nil,
	true,-----默认值
	function(arg,init)
		ItemInfo_ClearAcutionInfomation();
	end,1
	)
	BFNew_RegisterAddonConfig("ItemInfo","CheckBox","EnableAlreadyKnown",Enable_AlreadyKnown,nil,
		true,-----默认值
		function(arg,init)
			if (arg) then
				if (not BigFoot_IsAddOnLoaded("ItemInfo")) then
					BigFoot_LoadAddOn("ItemInfo");
				end
				if (BigFoot_IsAddOnLoaded("ItemInfo")) then
					AlreadyKnown_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("ItemInfo")) then
					AlreadyKnown_Toggle(false);
				end
			end
		end
	)