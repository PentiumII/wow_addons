if GetLocale() == "zhCN" then
	CHANNELFILTER_ENABLE_TEXT = "开启频道过滤"
	CHANNELFILTER_OPTION_TEXT = "聊天过滤设置"
elseif GetLocale() == "zhTW" then
	CHANNELFILTER_ENABLE_TEXT = "開啟頻道過濾"
	CHANNELFILTER_OPTION_TEXT = "聊天过滤设置"
else
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
--------------参数4 插件Enable默认值-----------------------------------
BFNew_RegisterAddon("ChannelFilter",{BFNew_AddonTypeTable[4]},nil,nil,true)

--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})  -- 表示 skada 与 recount 互斥
--------------------注册插件配置信息----------------------------------
BFNew_RegisterAddonConfig("ChannelFilter","CheckBox","EnableChannelFilter",CHANNELFILTER_ENABLE_TEXT,nil,
true,-----默认值
function(arg)
	if arg then
		ChannelFilterOptionFrame.name = "ChannelFilter"
		if not BFN_IsCategoryHave(ChannelFilterOptionFrame) then
			InterfaceOptions_AddCategory(ChannelFilterOptionFrame)
		end
	else
		
	end
end
)
BFNew_RegisterAddonConfig("ChannelFilter","Button","ChannelFilterOptioin",CHANNELFILTER_OPTION_TEXT,nil,
true,-----默认值
function()
	InterfaceOptionsFrame_OpenToCategory("ChannelFilter") 
end,1
)