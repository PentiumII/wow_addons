
if (GetLocale() == "zhCN") then
	BIGFOOT_TOOLTIP = {"鼠标提示", "shubiaotishi"};
	
	ENABLE_BIGFOOT_TOOLTIP = "启用大脚鼠标提示";
	ENABLE_BIGFOOT_TOOLTIP_TOOLTIP= "扩展增强了普通鼠标提示信息";
	
	BIGFOOT_TOOLTIP_OPTION = {
		[1] = { "BigFootTooltipPosition", "提示位置:", {NONE, "鼠标", "左上", "顶部", "右上", "左侧", "中心", "右侧", "左下", "底部", "右下"}, nil, 1 },
		[2] = { "BigFootTooltipPositionX", "X轴偏移:", nil, {-300, 300, 5}, "-20" },
		[3] = { "BigFootTooltipPositionY", "Y轴偏移:", nil, {-300, 300, 5}, "-25" },
		[4] = { "BigFootTooltipFade", "渐隐提示:", {"否", "是"}, nil,  2},
		[5] = { "BigFootTooltipTalent", "天赋信息:", {"隐藏", "显示"}, nil, 2 },
		[6] = { "BigFootTooltipCorpse", "当前装等:", {"隐藏", "显示"}, nil, 2 },
		[7] = { "BigFootTooltipToT", "目标的目标:", {"隐藏", "显示"}, nil, 2 },
		[8] = { "BigFootTooltipPvP", "PvP:", {"显示", "隐藏"}, nil, 2},
		[9] = { "BigFootTooltipGuildRank", "公会阶级:", {"显示", "隐藏"}, nil, 2},
	};
	
elseif (GetLocale() == "zhTW") then
	BIGFOOT_TOOLTIP = {"鼠標提示", "shubiaotishi"};
	
	ENABLE_BIGFOOT_TOOLTIP = "啟用大腳鼠標提示";
	ENABLE_BIGFOOT_TOOLTIP_TOOLTIP= "擴展增強了普通鼠標提示信息";
	
	BIGFOOT_TOOLTIP_OPTION = {
		[1] = { "BigFootTooltipPosition", "提示位置:", {NONE, "鼠標", "左上", "頂部", "右上", "左側", "中心", "右側", "左下", "底部", "右下"}, nil, 1 },
		[2] = { "BigFootTooltipPositionX", "X軸偏移:", nil, {-300, 300, 5}, "-20" },
		[3] = { "BigFootTooltipPositionY", "Y軸偏移:", nil, {-300, 300, 5}, "-25" },
		[4] = { "BigFootTooltipFade", "漸隱提示:", {"否", "是"}, nil, 2 },
		[5] = { "BigFootTooltipTalent", "天賦信息:", {"隱藏", "顯示"}, nil, 2 },
		[6] = { "BigFootTooltipCorpse", "當前裝等:", {"隱藏", "顯示"}, nil, 2 },
		[7] = { "BigFootTooltipToT", "目標的目標:", {"隱藏", "顯示"}, nil, 2 },
		[8] = { "BigFootTooltipPvP", "PvP:", {"顯示", "隱藏"}, nil, 2 },
		[9] = { "BigFootTooltipGuildRank", "公會階級:", {"顯示", "隱藏"}, nil, 2 },
	};
	
else
	BIGFOOT_TOOLTIP = "BigFoot Tooltip";
	
	ENABLE_BIGFOOT_TOOLTIP = "Enable BigFoot Tooltip";
	BIGFOOT_TOOLTIP_OPTION = {
		[1] = { "BigFootTooltipPosition", "Position:", {NONE, "Following Mouse", "Top Left", "Top", "Top Right", "Left", "Center", "Right", "Bottom Left", "Bottom", "Bottom Right"}, nil, 1 },
		[2] = { "BigFootTooltipPositionX", "PositionX:", nil, {-300, 300, 5}, "-20" },
		[3] = { "BigFootTooltipPositionY", "PositionY:", nil, {-300, 300, 5}, "-25" },
		[4] = { "BigFootTooltipFade", "Fade:", {"No", "Yes"}, nil, 2 },
		[5] = { "BigFootTooltipTalent", "Talent:", {"Hide", "Show"}, nil, 2},
		[6] = { "BigFootTooltipCorpse", "ItemLevel:", {"Hide", "Show"}, nil, 2},
		[7] = { "BigFootTooltipToT", "ToT:", { "Hide", "Show"}, nil, 2 },
		[8] = { "BigFootTooltipPvP", "PvP:", {"Show", "Hide"}, nil, 2 },
		[9] = { "BigFootTooltipGuildRank", "Guild Rank", {"Show", "Hide"}, nil, 2 },
	};
end

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
--------------参数4 是否为新推出插件。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BFTooltip",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2]},nil,nil,true)
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
--------------参数9 是否为新推出功能 nil 可设置true-----------------------------------

BFNew_RegisterAddonConfig("BFTooltip","CheckBox","EnableBFTooltip",ENABLE_BIGFOOT_TOOLTIP,ENABLE_BIGFOOT_TOOLTIP_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFTooltip")) then
				BigFoot_LoadAddOn("BFTooltip");
			end
			
			if (BigFoot_IsAddOnLoaded("BFTooltip")) then
				BFTT_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("BFTooltip")) then
				BFTT_Toggle(false);
			end
		end
	end
)
	for i, info in ipairs(BIGFOOT_TOOLTIP_OPTION) do	
		if (info[4]) then
			BFNew_RegisterAddonConfig("BFTooltip","SpinBox",info[1],info[2],nil,
			{info[4],info[5],1},-----默认值
			function(arg,init)
				if not BigFoot_IsAddOnLoaded("BFTooltip") then
					BigFoot_LoadAddOn("BFTooltip");
				end
				if (BigFoot_IsAddOnLoaded("BFTooltip")) then
					BFTT_OPTION_FUNC[i](arg);
				end
			end,1
			)
		else
			BFNew_RegisterAddonConfig("BFTooltip","SpinBox",info[1],info[2],nil,
			{info[3],info[5]},-----默认值
			function(arg,init)
				if not BigFoot_IsAddOnLoaded("BFTooltip") then
					BigFoot_LoadAddOn("BFTooltip");
				end
				if (BigFoot_IsAddOnLoaded("BFTooltip")) then
					BFTT_OPTION_FUNC[i](arg);
				end
			end,1
			)
		end
	end

	-- BFNew_RegisterAddonConfig("BFCooldown","SpinBox","ShineType",BFCD_SHINE_TYPE_TITLE,BFCD_SHINE_TYPE_TITLE_TOOLTIP,
	-- {BFCD_SHINE_TYPE,1},-----默认值
	-- function(arg,init)
		-- if arg and BigFoot_IsAddOnLoaded("BFCooldown") then
			-- for _i,_val in pairs(BFCD_SHINE_TYPE) do
				-- if _val == arg then
					-- BFCooldown:SwitchActionStyle(arg-2);
					-- return
				-- end
			-- end
		-- end
	-- end,1
	-- )