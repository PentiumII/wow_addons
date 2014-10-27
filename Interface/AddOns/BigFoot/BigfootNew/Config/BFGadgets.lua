if GetLocale() == "zhCN" then
	BIGFOOTGADGET_ENABLE_GPS = "开启坐标指示";
	BIGFOOTGADGET_ENABLE_GPS_TOOLTIP= "显示玩家当前坐标的一个小框体";
	
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE = "快速设置焦点";
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TOOLTIP = "可通过Shift加左键点击头像来设置焦点，Shift加右键点击来清除焦点";
elseif GetLocale() == "zhTW" then
	BIGFOOTGADGET_ENABLE_GPS = "開啟座標指示";
	BIGFOOTGADGET_ENABLE_GPS_TOOLTIP= "顯示玩家當前座標的一個小框體";
	
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE = "快速設置焦點";
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TOOLTIP = "可通過Shift加左鍵點擊頭像來設置焦點，Shift加右鍵點擊頭像來清除焦點";
else
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
--------------参数4 插件Enable默认值-----------------------------------
BFNew_RegisterAddon("BFGadgets",{BFNew_AddonTypeTable[10]},nil,nil,true)

--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})  -- 表示 skada 与 recount 互斥
--------------------注册插件配置信息----------------------------------
BFNew_RegisterAddonConfig("BFGadgets","CheckBox","EnableBigFootGPS",BIGFOOTGADGET_ENABLE_GPS,BIGFOOTGADGET_ENABLE_GPS_TOOLTIP,
true,-----默认值
function(arg)
	if arg then
		if (not BigFoot_IsAddOnLoaded("BFGadgets")) then
			BigFoot_LoadAddOn("BFGadgets");
		end
		if BigFoot_IsAddOnLoaded("BFGadgets") then
			BigFoot_EnableGPS(true)
		end
	else	
		if BigFoot_IsAddOnLoaded("BFGadgets") then
			BigFoot_EnableGPS(false)
		end
	end
end
)
BFNew_RegisterAddonConfig("BFGadgets","CheckBox","EnableFasyFocus",MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE,MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TOOLTIP,
true,-----默认值
function(arg)
	if arg then
		TargetFrame:SetAttribute("shift-type1", "focus");
		TargetFrame:SetAttribute("shift-type2", "macro");
		TargetFrame:SetAttribute("macrotext", "/CLEARFOCUS");
	else	
		TargetFrame:SetAttribute("shift-type1", nil);
		TargetFrame:SetAttribute("shift-type2", nil);
		TargetFrame:SetAttribute("macrotext", nil);
	end
end
)



