﻿-- -- ---------------------------------------------------------------------------------
-- if GetLocale() == "zhCN" then
	-- BUBBLECHAT_ENABLE_TEXT= "开启泡泡聊天";
	-- BUBBLECHAT_ENABLE_TEXT_TOOLTIP="在队友头像右边显示其小队中发送的信息"
-- elseif GetLocale() == "zhTW" then
	-- BUBBLECHAT_ENABLE_TEXT= "開啟泡泡聊天";
	-- BUBBLECHAT_ENABLE_TEXT_TOOLTIP= "在隊友頭像右邊顯示其小隊中發送的信息";
-- else
	-- BUBBLECHAT_ENABLE_TEXT= "Enable BubbleChat";
	-- SCROLL_CHATFRAME_TEXT = "Allow using mouse wheel to scroll chat window";
-- end


-- -------------------注册插件类型-----------------------------------
-- --------------参数1 插件的名字-----------------------------------
-- --------------参数2 插件的类型。-----------------------------------
-- --------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
-- BFNew_RegisterAddon("BubbleChat",{BFNew_AddonTypeTable[4],BFNew_AddonTypeTable[6]},nil,nil,false)
-- --------------------------------------------------------------
-- --------------------------------------------------------------
-- -------------------注册插件互斥信息-------------------------------------------
-- -------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- -- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
-- --------------------注册插件配置信息----------------------------------

-- BFNew_RegisterAddonConfig("BubbleChat","CheckBox","EnableBubbleChat",BUBBLECHAT_ENABLE_TEXT,BUBBLECHAT_ENABLE_TEXT_TOOLTIP,
-- false,-----默认值
-- function(arg,init)
	-- if (arg) then
		-- if (not BigFoot_IsAddOnLoaded("BubbleChat")) then
			-- BigFoot_LoadAddOn("BubbleChat");
		-- end

		-- if (BigFoot_IsAddOnLoaded("BubbleChat")) then
			-- BubbleChat_Toggle(true);
		-- end
	-- else
		-- if (BigFoot_IsAddOnLoaded("BubbleChat")) then
			-- BubbleChat_Toggle(false);
		-- end
	-- end
-- end
-- )