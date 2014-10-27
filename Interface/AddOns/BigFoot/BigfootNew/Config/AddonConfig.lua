BFNew_AddonTypeTable={}
if (GetLocale() == "zhCN") then
	BFNew_AddonTypeTable ={"战斗增强","PVP辅助","团队组队","聊天互动","","界面增强","物品装备","商业信息","地图任务","辅助杂项","",""}
	
	BF_SYSTEM_LASTER_LOAD="进入世界之后开始载入插件"
	BF_SYSTEM_LASTER_LOAD_TOOLTIP ="选中之后，会在玩家进入世界之后载入插件"
	
	BF_SYSTEM_LOADOUTDATE="加载过期插件"
	BF_SYSTEM_LOADOUTDATE_TOOLTIP="需要重载生效"

	BF_SYSTEM_ShowTextDlg ="开启插件建议提示框"
	
	BIGFOOTGADGET_CHANGE_FONT = "修改系统数字字体";
	BIGFOOTGADGET_CHANGE_FONT_TOOLTIP="使数字的显示变的更加清楚一些"
	
	BF_TORIALS="教程"
	BF_RESETTUTORIALS= "重置新手介绍"
elseif (GetLocale() == "zhTW") then
	BFNew_AddonTypeTable ={"戰鬥增強","PVP輔助","團隊組隊","聊天互動","","界面增強","物品裝備","商業信息","地圖任務","輔助雜項","",""}
	
	BF_SYSTEM_LASTER_LOAD="進入世界之後開始載入插件"
	BF_SYSTEM_LASTER_LOAD_TOOLTIP="選中之後，會在玩家進入世界之後載入插件"
	
	BF_SYSTEM_LOADOUTDATE="載入過期插件"
	BF_SYSTEM_LOADOUTDATE_TOOLTIP="需要重載生效"
	
	BF_SYSTEM_ShowTextDlg ="開啟插件建議提示框"
	
	BIGFOOTGADGET_CHANGE_FONT = "修改系統數字字體";
	BIGFOOTGADGET_CHANGE_FONT_TOOLTIP= "數數字的顯示變得更加清楚一些";
	
	BF_TORIALS="教程"
	BF_RESETTUTORIALS= "重置新手介紹"
else
	BFNew_AddonTypeTable ={"战斗增强","PVP辅助","团队组队","聊天互动","","界面增强","物品装备","商业信息","地图任务","辅助杂项","",""}
	BIGFOOTGADGET_CHANGE_FONT = "Change Default font";
	
	BF_SYSTEM_LASTER_LOAD="load Addon after player inter word"
	BF_SYSTEM_LASTER_LOAD_TOOLTIP ="load Addon after player inter word"
end



-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
-- BFNew_RegisterAddon("BigFoot",{"大型插件","团队插件","战斗"})
-- BFNew_RegisterAddon("ACP",{"大型插件","团队插件"})
-- BFNew_RegisterAddon("Recount",{"大型插件","战斗"})
-- BFNew_RegisterAddon("Skada",{"大型插件","战斗"})
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------------------------------------------------------------------
----------------------这是注册BigFoot主设置-------------------------------------------------

-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","EnableLoadLater",BF_SYSTEM_LASTER_LOAD,BF_SYSTEM_LASTER_LOAD_TOOLTIP,
-- false,-----默认值
-- function(value,init)
	-- if value then
		-- BigFoot_SysTemSetTab.BigFoot_LoadBefore =0;
	-- else
		-- BigFoot_SysTemSetTab.BigFoot_LoadBefore =1;
	-- end
-- end
-- )
BFNew_RegisterAddonConfig("BigFoot","CheckBox","EnableLoadLater",BF_SYSTEM_LASTER_LOAD,BF_SYSTEM_LASTER_LOAD_TOOLTIP,
true,-----默认值
function(value,init)
	if value then
		BigFoot_SysTemSetTab.BigFoot_LoadBefore =0;
	else
		BigFoot_SysTemSetTab.BigFoot_LoadBefore =1;
	end
end
)
BFNew_RegisterAddonConfig("BigFoot","CheckBox","EnableLoadDate",BF_SYSTEM_LOADOUTDATE,nil,
true,-----默认值
function(value)
	if value then
		SetCVar("checkAddonVersion","0")
		-- BigfootNewMainFrame_SetAnimation(true)
	else
		SetCVar("checkAddonVersion","1")
		-- BigfootNewMainFrame_SetAnimation(true)
	end
end
)

BFNew_RegisterAddonConfig("BigFoot","CheckBox","EnableShowTextDlg",BF_SYSTEM_ShowTextDlg,nil,
true,-----默认值
function(value)	
	BFNew_SetShowTextDlgData(value)
end
)
BFNew_RegisterAddonConfig("BigFoot","CheckBox","ModifyNumFont",BIGFOOTGADGET_CHANGE_FONT,BIGFOOTGADGET_CHANGE_FONT_TOOLTIP,
false,-----默认值
function(arg)	
	if (arg) then
		BFGadget_FontName, BFGadget_FontHeight, BFGadget_FontFlags=NumberFontNormal:GetFont()
		NumberFontNormal:SetFont("Fonts\\ARKai_T.TTF",14,"OUTLINE")
		__BFG_Font_Modified=true
	else
		if __BFG_Font_Modified then
			NumberFontNormal:SetFont(BFGadget_FontName or "Fonts\\ARKai_C.ttf",BFGadget_FontHeight or 12,BFGadget_FontFlags or "OUTLINE")
		end
		__BFG_Font_Modified=false
	end
end
)
BFNew_RegisterAddonConfig("BigFoot","CheckBox","enableTutorials",BF_TORIALS,nil,
true,-----默认值
function(arg,init)
	if arg then
		BF_Gloable.EndTutorials = false
		TutorialsFrameStart("FirstLogin")
	else
		BigfootTutorialFrame:Hide()
		BF_Gloable.EndTutorials = true
	end
end
)
BFNew_RegisterAddonConfig("BigFoot","Button","ResetTutorials",BF_RESETTUTORIALS,nil,
nil,-----默认值
function(arg)	
	BF_Gloable.EndTutorials = false
	BigfootTutorialFrame:Hide()
	BigfootTutorialFrame.curStep = 1
	TutorialsFrameStart("FirstLogin")
end,1
)
---------------------------------------后续Cofig在此行以下添加--------------

-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","BigfootConfig2","我是BigFoot配置显示的文字2","我是配置的鼠标提示文字",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的  CheckBox_BigfootConfig2",value)
	-- else
		-- print("这是游戏内点击的时候做的 CheckBox_BigfootConfig2",value)
	-- end
-- end
-- )
-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","BigfootConfig3","我是BigFoot配置显示的文字3","我是配置的鼠标提示文字",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的  CheckBox_BigfootConfig3",value)
	-- else
		-- print("这是游戏内点击的时候做的 CheckBox_BigfootConfig3",value)
	-- end
-- end
-- )
-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","BigfootConfig4","我是BigFoot配置显示的文字4","我是配置的鼠标提示文字",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的  CheckBox_BigfootConfig4",value)
	-- else
		-- print("这是游戏内点击的时候做的 CheckBox_BigfootConfig4",value)
	-- end
-- end
-- )
-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","BigfootConfig5","我是BigFoot配置显示的文字5","我是配置的鼠标提示文字",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的  CheckBox_BigfootConfig5",value)
	-- else
		-- print("这是游戏内点击的时候做的 CheckBox_BigfootConfig5",value)
	-- end
-- end
-- )
-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","BigfootConfig6","我是BigFoot配置显示的文字6","我是配置的鼠标提示文字",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的  CheckBox_BigfootConfig6",value)
	-- else
		-- print("这是游戏内点击的时候做的 CheckBox_BigfootConfig6",value)
	-- end
-- end
-- )
-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","BigfootConfig7","我是BigFoot配置显示的文字7","我是配置的鼠标提示文字",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的  CheckBox_BigfootConfig7",value)
	-- else
		-- print("这是游戏内点击的时候做的 CheckBox_BigfootConfig7",value)
	-- end
-- end
-- )
-- BFNew_RegisterAddonConfig("BigFoot","CheckBox","BigfootConfig8","我是BigFoot配置显示的文字8","我是配置的鼠标提示文字",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的  CheckBox_BigfootConfig8",value)
	-- else
		-- print("这是游戏内点击的时候做的 CheckBox_BigfootConfig8",value)
	-- end
-- end
-- )
-- BFNew_RegisterAddonConfig("BigFoot","Button","BigfootConfig9","配置按纽","我是配置的鼠标提示文字5",
-- false,-----默认值
-- function(value,init)
	-- if init then
		-- print("这是导入配置的时候做的 Button_BigfootConfig39",value)
	-- else
		-- print("这是游戏内点击的时候做的 Button_BigfootConfig9",value)
	-- end
-- end
-- )

------------------------------------------------------------------------------------------------
