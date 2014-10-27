if GetLocale() =="zhCN" then
	MOD_INFO_COMPARISON_STAT_COMPARE = "开启装备属性统计";

	MOD_INFO_COMPARISON_TIPFRAME = "开启装备统计面板";
	MOD_INFO_COMPARISON_TIPFRAME_TOOLTIP = "在装备栏右边显示统计当前装备属性总和";

	MDO_INFO_ENABLE_DURABILITY = "显示装备耐久度";
	MDO_INFO_ENABLE_DURABILITY_TOOLTIP= "在人物装备图标右下角显示装备剩余耐久度";

	MDO_INFO_ENABLE_HIGHLIGHT = "高亮装备栏边框";
	MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP= "根据装备品质高亮显示装备栏边框";
elseif GetLocale() == "zhTW" then
	MOD_INFO_COMPARISON_STAT_COMPARE = "啟用裝備屬性統計";

	MOD_INFO_COMPARISON_TIPFRAME = "開啟裝備統計面板";
	MOD_INFO_COMPARISON_TIPFRAME_TOOLTIP = "在裝備欄右邊顯示統計當前裝備屬性總和";

	MDO_INFO_ENABLE_DURABILITY = "顯示裝備耐久度";
	MDO_INFO_ENABLE_DURABILITY_TOOLTIP= "在人物裝備圖標右下角顯示裝備剩餘耐久度";

	MDO_INFO_ENABLE_HIGHLIGHT = "高亮裝備欄邊框";
	MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP= "根據裝備品質高亮顯示裝備欄邊框";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("MerInspect",{BFNew_AddonTypeTable[7]},nil,nil,true)
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

BFNew_RegisterAddonConfig("MerInspect","CheckBox","EnableMerInspect",MOD_INFO_COMPARISON_STAT_COMPARE,nil,
true,-----默认值
	function (arg)
		if ( arg) then
			if (not BigFoot_IsAddOnLoaded("MerInspect")) then
				BigFoot_LoadAddOn("MerInspect");
			end

			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_Toggle(false);
			end
		end
	end
)
BFNew_RegisterAddonConfig("MerInspect","CheckBox","DisplayStatistics",MOD_INFO_COMPARISON_TIPFRAME,MOD_INFO_COMPARISON_TIPFRAME_TOOLTIP,
true,-----默认值
	function (arg)
		if ( arg) then
			if (not BigFoot_IsAddOnLoaded("MerInspect")) then
				BigFoot_LoadAddOn("MerInspect");
			end

			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_Toggle(false);
			end
		end
	end,1
)
BFNew_RegisterAddonConfig("MerInspect","CheckBox","DisplayDurability",MDO_INFO_ENABLE_DURABILITY,MDO_INFO_ENABLE_DURABILITY_TOOLTIP,
true,-----默认值
	function (arg)
		if ( arg ) then
			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_ToogleD(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_ToogleD(false);
			end
		end
	end,1
)
BFNew_RegisterAddonConfig("MerInspect","CheckBox","DisplayItemQulity",MDO_INFO_ENABLE_HIGHLIGHT,MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP,
true,-----默认值
	function (arg)
		if ( arg  ) then
			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_ToogleH(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("MerInspect")) then
				MerInspect_ToogleH(false);
			end
		end
	end,1
)