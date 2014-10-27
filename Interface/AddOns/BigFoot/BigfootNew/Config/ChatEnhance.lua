---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	SCROLL_CHATFRAME_TEXT = "鼠标滚轮滚动查看聊天信息";
	SCROLL_CHATFRAME_TEXT_TOOLTIP= "当鼠标在聊天窗口上时，允许使用鼠标滚轮滚动查看聊天窗口中的信息";
elseif GetLocale() == "zhTW" then
	SCROLL_CHATFRAME_TEXT = "鼠標滾輪滾動查看聊天信息";
	SCROLL_CHATFRAME_TEXT_TOOLTIP= "當鼠標在聊天窗口上時，允許使用鼠標滾輪滾動查看聊天窗口中的信息";
else
	SCROLL_CHATFRAME_TEXT = "Allow using mouse wheel to scroll chat window";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
-- BFNew_RegisterAddon("ChatEnhance",{BFNew_AddonTypeTable[4]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

-- BFNew_RegisterAddonConfig("ChatEnhance","CheckBox","EnableScrollChatFrame",SCROLL_CHATFRAME_TEXT,SCROLL_CHATFRAME_TEXT_TOOLTIP,
-- false,-----默认值
-- function(arg,init)
	-- if (arg) then
		-- if (not BigFoot_IsAddOnLoaded("ChatEnhance")) then
			-- BigFoot_LoadAddOn("ChatEnhance");
		-- end

		-- if (BigFoot_IsAddOnLoaded("ChatEnhance")) then
			-- ChatEnahnce_Toggle(true);
		-- end
	-- else
		-- if (BigFoot_IsAddOnLoaded("ChatEnhance")) then
			-- ChatEnahnce_Toggle(false);
		-- end
	-- end
-- end
-- )