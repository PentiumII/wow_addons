
function MapToolkitConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_MAP_TOOLKIT = {"地图工具", "ditugongju"};

		MAP_PLUS_ENABLE_TEXT = "开启地图标记";
		MAP_PLUS_ENABLE_TEXT_TOOLTIP= "可在地图上需要标记的地方点击鼠标左键创建一个标记";

		MAP_PLUS_ACCEPT_MAP_NOTE = "接收其他玩家发送的标记"; 	---未测试

		MAP_MARK_ENABLE = "开启NPC位置";
		MAP_MARK_ENABLE_TOOLTIP= "在地图上以图标方式显示NPC位置";

		ENABLE_ARCHY_TEXT ="启用考古助手"
		ARCHY_DISABLE_DELAY_TEXT = "|cff00c0c0<考古助手>|r 你已经关闭考古助手(Archy)模块，该设置将在下次插件载入时生效。";

		ENABLE_EJLOOT_TEXT = "启用地下城手册的小怪掉落"

		ENABLE_RANGEDISPLAY_TEXT ="启用距离显示";
		ENABLE_RANGEDISPLAY_TEXT_TOOLTIP="显示玩家目标，焦点目标，鼠标悬停目标与玩家之间的距离数值";
		RANGEDISPLAY_DISABLE_DELAY_TEXT = "|cff00c0c0<距离显示>|r 你已经关闭距离显示(RangeDisplay)模块，该设置将在下次插件载入时生效。";

	elseif (GetLocale() == "zhTW") then
		MOD_MAP_TOOLKIT = {"地圖工具", "ditugongju"};

		MAP_PLUS_ENABLE_TEXT = "開啟地圖標記";
		MAP_PLUS_ENABLE_TEXT_TOOLTIP="可在地圖上需要標記的地方那個點擊鼠標鄒建左鍵創建一個標記"

		MAP_PLUS_ACCEPT_MAP_NOTE = "接收其他玩家發送的標記";

		MAP_MARK_ENABLE = "開啟NPC位置";
		MAP_MARK_ENABLE_TOOLTIP= "在地圖上以圖表方式顯示NPC位置";

		ENABLE_ARCHY_TEXT ="啟用考古助手"
		ARCHY_DISABLE_DELAY_TEXT = "|cff00c0c0<考古助手>|r 你已經關閉考古助手(Archy)模塊，該設置將在下次插件載入時生效。";

		ENABLE_EJLOOT_TEXT ="啟用地城手冊的小怪掉落"

		ENABLE_RANGEDISPLAY_TEXT ="啟用距離顯示";
		ENABLE_RANGEDISPLAY_TEXT_TOOLTIP="顯示玩家目標，焦點目標，鼠標懸停目標與玩家之間的距離數值";
		RANGEDISPLAY_DISABLE_DELAY_TEXT = "|cff00c0c0<距離顯示>|r 你已經關閉距離顯示(RangeDisplay)模塊，該設置將在下次插件載入時生效。";
	else
		MOD_MAP_TOOLKIT = "Map Toolkit";
		MAP_PLUS_ENABLE_TEXT = "Enable Map Note";
		MAP_PLUS_ACCEPT_MAP_NOTE = "Accept notes from other players";
		MAP_MARK_ENABLE = "Enable NPC locations";

		ENABLE_RANGEDISPLAY_TEXT ="Enable Range Display";
	end

	if IsConfigurableAddOn("MapPlus") or IsConfigurableAddOn("BigFootMark") or IsConfigurableAddOn("Archy")  or IsConfigurableAddOn("LootListPlus") or IsConfigurableAddOn("RangeDisplay") then
		ModManagement_RegisterMod(
			"MapToolkit",
			"Interface\\Icons\\INV_Misc_Toy_06",
			MOD_MAP_TOOLKIT,
			nil,
			nil,
			nil,
			{[6]=true}
		);
	end

	if (IsConfigurableAddOn("RangeDisplay")) then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			ENABLE_RANGEDISPLAY_TEXT,
			ENABLE_RANGEDISPLAY_TEXT_TOOLTIP,
			"EnableRangeDisplay",
			nil,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("RangeDisplay")) then
						BigFoot_LoadAddOn("RangeDisplay");
						RangeDisplay:toggleLocked(true)
					end
				else
					if (BigFoot_IsAddOnLoaded("RangeDisplay")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(RANGEDISPLAY_DISABLE_DELAY_TEXT); end);
					end
				end
			end
		);
	end

	if (IsConfigurableAddOn("Archy")) then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			ENABLE_ARCHY_TEXT,
			nil,
			"EnableArchy",
			nil,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("Archy")) then
						BigFoot_LoadAddOn("Archy");
					end
				else
					if (BigFoot_IsAddOnLoaded("Archy")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(ARCHY_DISABLE_DELAY_TEXT); end);
					end
				end
			end
		);
	end

	if (IsConfigurableAddOn("MapPlus")) then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			MAP_PLUS_ENABLE_TEXT,
			MAP_PLUS_ENABLE_TEXT_TOOLTIP,
			"EnableMapPlus",
			0,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("MapPlus")) then
						BigFoot_LoadAddOn("MapPlus");
					end
				end
				if BigFoot_IsAddOnLoaded("MapPlus") then
					MapPlus_ToggleEnable(__arg)
				end
			end
		);

		--[[
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			MAP_PLUS_ACCEPT_MAP_NOTE,
			nil,
			"AcceptMapNote",
			1,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("MapPlus")) then
						BigFoot_LoadAddOn("MapPlus");
					end
				end
				if BigFoot_IsAddOnLoaded("MapPlus") then
					MapPlus_ToggleReceive(__arg)
				end
			end,
			1
		);
		]]
	end

	if IsConfigurableAddOn("BigFootMark") and (GetLocale()=="zhCN" or GetLocale()=="zhTW") then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			MAP_MARK_ENABLE,
			MAP_MARK_ENABLE_TOOLTIP,
			"MapMarkEnable",
			1,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("BigFootMark")) then
						BigFoot_LoadAddOn("BigFootMark");
					end
					BFM_ToggleEnable(1)
				else
					if BigFoot_IsAddOnLoaded("BigFootMark") then
						BFM_ToggleEnable(0)
					end
				end
			end
		);
	end
	local NewInfoStrName=[[
	大脚也推地下城手册！
	]]

	local NewInfoStr =[[
	大脚将众多玩家提议添加的小怪掉落，加在了暴雪推出的地下城手册中。第三个标签就是咯！
	所在位置：
	大脚设置-地图工具-启用地下城手册的小怪掉落
	]]

	local NewInfoStrName1=[[
	坐骑来源显示
	]]

	local NewInfoStr1 =[[
	大脚今日独家首发！当你把鼠标移动到目标的坐骑Buff上去查看坐骑名称时，
	大脚也为玩家提供了坐骑的来源，比如：何种声望、哪位商人、哪个成就提供。快速的了解拉风坐骑的出处吧！
	]]

	if IsConfigurableAddOn("LootListPlus") and (GetLocale()=="zhCN" or GetLocale()=="zhTW") then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			ENABLE_EJLOOT_TEXT,
			nil,
			"LootListEnable",
			1,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("LootListPlus")) then
						BigFoot_LoadAddOn("LootListPlus");
					end
					__BfLootListToggle(1)
				else
					if BigFoot_IsAddOnLoaded("LootListPlus") then
						__BfLootListToggle(0)
					end
				end
			end,
			nil,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("LootListPlus")) then
						BigFoot_LoadAddOn("LootListPlus");
					end
					__BfLootListToggle(1)
				else
					if BigFoot_IsAddOnLoaded("LootListPlus") then
						__BfLootListToggle(0)
					end
				end
				-- BF_NewAddOnsPromotion("zhCN",307,NewInfoStrName,NewInfoStr,"MapToolkit","LootListEnable")
				BF_NewAddOnsPromotion("zhCN",313,NewInfoStrName1,NewInfoStr1,"MapToolkit","LootListEnable")
			end
		);
	end

end

BigFoot_AddCollector(MapToolkitConfigFunc)