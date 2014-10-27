if GetLocale() =="zhCN" then
	AUTOEQUIP_ENABLE = "允许一键换装";
	AUTOEQUIP_ENABLE_TOOLTIP="在玩家头像上方显示一个快捷保存及换装的选项条"

	AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "团队隐藏";
	AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP="当玩家在团队中时隐藏换装选项条"

	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "启用增强模式";
	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP="强化一键换装，在屏幕中间显示一个按shift可移动的8套备选方案选项条"

	AUTOEQUIP_KEY_BINDING = "按键绑定";

elseif GetLocale() == "zhTW" then
	AUTOEQUIP_ENABLE = "允許一鍵換裝";
	AUTOEQUIP_ENABLE_TOOLTIP= "在玩家頭像上方顯示一個快捷保存及換裝的選項條";

	AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "團隊隱藏";
	AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP= "當玩家在團隊中時隱藏換裝選項條";

	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "啟用增強模式";
	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP= "強化一鍵換裝，在屏幕中間顯示一個按shift可移動的8套備選方案選項條";

	AUTOEQUIP_KEY_BINDING = "按鍵綁定";

end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("AutoEquip",{BFNew_AddonTypeTable[7]},nil,nil,false)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 配置的类型。-----------------------------------
--------------参数3 配置名字-----------------------------------
--------------参数4 配置显示的名字-----------------------------------
--------------参数5 配置的鼠标提示-----------------------------------
--------------参数6 （Checkbox）配置的默认值  ----  true false 不要为nil-----------------------------------
--------------参数7 （Checkbox）配置的CallBack函数  2个参数 第一个为 toggle_value  为 true or false  后一个为是否初始化的标识-----------------------------------
--------------参数8 配置的层级 默认0-----------------------------------

BFNew_RegisterAddonConfig("AutoEquip","CheckBox","EnableAutoEquip",AUTOEQUIP_ENABLE,AUTOEQUIP_ENABLE_TOOLTIP,
false,-----默认值
	function (__arg)
		if (__arg) then
			if (not BigFoot_IsAddOnLoaded("AutoEquip")) then
				BigFoot_LoadAddOn("AutoEquip");
			end

			if (BigFoot_IsAddOnLoaded("AutoEquip")) then
				AutoEquip_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("AutoEquip")) then
				AutoEquip_Toggle(false);
			end
		end
	end
)
BFNew_RegisterAddonConfig("AutoEquip","CheckBox","EnableAdvancedMode",AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE,AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP,
false,-----默认值
	function (__arg)
		if (BigFoot_IsAddOnLoaded("AutoEquip")) then
			if (__arg) then
				AutoEquip_ToggleMode("advance");
			else
				AutoEquip_ToggleMode("normal");
			end
		end
	end,1
)
BFNew_RegisterAddonConfig("AutoEquip","CheckBox","EnableAutoHide",AUTOEQUIP_ENABLE_RAID_AUTOHIDE,AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP,
false,-----默认值
	function (__arg)
		if (BigFoot_IsAddOnLoaded("AutoEquip")) then
			if (__arg) then
				AutoEquip_EnableAutoHide(true);
			else
				AutoEquip_EnableAutoHide(false);
			end
		end
	end,1
)
BFNew_RegisterAddonConfig("AutoEquip","Button","AutoEquip_Option",AUTOEQUIP_KEY_BINDING,nil,
nil,-----默认值
	function ()
		if (BigFoot_IsAddOnLoaded("AutoEquip")) then
			AutoEquip_KeyBinding();
		end
	end,1
)