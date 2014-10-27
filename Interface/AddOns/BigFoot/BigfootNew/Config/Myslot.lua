---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	BIGFOOTGADGET_MySlot = "开启按键设置保存功能";
	BIGFOOTGADGET_Myslot_TOOLTIP= "记忆、恢复、保存、载入您的按键设置";

	BIGFOOTGADGET_Myslot_PROXMIO = "设置";
elseif GetLocale() == "zhTW" then
	BIGFOOTGADGET_MySlot = "開啟按鍵設置保存功能";
	BIGFOOTGADGET_Myslot_TOOLTIP= "記憶、恢復、保存、載入您的按鍵設置";

	BIGFOOTGADGET_Myslot_PROXMIO = "設置";
else
	BIGFOOTGADGET_MySlot = "Open the Save function key settings";
	BIGFOOTGADGET_Myslot_TOOLTIP= "Memory, restore, save, load your key settings";

	BIGFOOTGADGET_Myslot_PROXMIO = "Set";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("MySlot",{BFNew_AddonTypeTable[10]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("MySlot","CheckBox","EnableMySlot",BIGFOOTGADGET_MySlot,BIGFOOTGADGET_Myslot_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if not BigFoot_IsAddOnLoadedFromBigFoot("MySlot") then
				BigFoot_LoadAddOn("MySlot")
			end
		end
	end
	)
	
	BFNew_RegisterAddonConfig("MySlot","Button","EnableButtonBigFootGadget",BIGFOOTGADGET_Myslot_PROXMIO,nil,
	false,-----默认值
	function(arg,init)
		if (BigFoot_IsAddOnLoadedFromBigFoot("MySlot")) then
			MYSLOT_ReportFrame:Show()
		end
	end,1
	)
