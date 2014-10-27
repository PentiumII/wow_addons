if GetLocale() == "zhCN" then
	PLAYER_LINK_ENABLE_TEXT = "增强聊天窗口";
	PLAYER_LINK_ENABLE_TEXT_TOOLTIP= "增强聊天窗口，如聊天时间显示，复制聊天内容等";
elseif GetLocale() == "zhTW" then
	PLAYER_LINK_ENABLE_TEXT = "增強聊天視窗";
	PLAYER_LINK_ENABLE_TEXT_TOOLTIP= "增強聊天窗口，如聊天時間顯示，複製聊天內容等";
else
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
--------------参数4 插件Enable默认值-----------------------------------
BFNew_RegisterAddon("PlayerLink",{BFNew_AddonTypeTable[4]},nil,nil,true)

--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})  -- 表示 skada 与 recount 互斥
--------------------注册插件配置信息----------------------------------
BFNew_RegisterAddonConfig("PlayerLink","CheckBox","EnablePlayerLink",PLAYER_LINK_ENABLE_TEXT,PLAYER_LINK_ENABLE_TEXT_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("PlayerLink")) then
			BigFoot_LoadAddOn("PlayerLink");
		end

		if (BigFoot_IsAddOnLoaded("PlayerLink")) then
			PlayerLink_Toggle(true);
		end
	else
		if (BigFoot_IsAddOnLoaded("PlayerLink")) then
			PlayerLink_Toggle(false);
		end
	end
end
)