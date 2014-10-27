
if GetLocale() =="zhCN" then
	BFCD_COOLDOWN_COUNT = "显示冷却时间";
	BFCD_COOLDOWN_COUNT_TOOLTIP="在自己技能图标上显示详细的冷却时间";

	BFCD_SHINE_TYPE_TITLE = "闪光类型：";
	BFCD_SHINE_TYPE = {"标准","图标", "大闪光", "雷达","收缩"};
	BFCD_SHINE_TYPE_TITLE_TOOLTIP="在自己的技能冷却结束时，选择显示的类型：标准(系统默认效果)，图标(技能图标扩大)，大闪光(技能图标高亮闪)，雷达(技能图标高亮微缩)，收缩(技能图标闪烁微缩)";

	BFCD_COOLDOWN_SHAMAN_CD = "显示图腾时间";
	BFCD_COOLDOWN_SHAMAN_CD_TOOLTIP="在玩家头像下的图腾图标上显示剩余时间";

	BFCD_COOLDOWN_DK_CD = "显示符文冷却时间";
	BFCD_COOLDOWN_DK_CD_TOOLTIP="在玩家头像下的符文图标上显示剩余时间";

	BFCD_COOLDOWN_SHOW_MIDDLE = "显示冷却提示";
	BFCD_COOLDOWN_SHOW_MIDDLE_TOOLTIP="在技能冷却结束时屏幕中央闪出技能图标效果";

	BFCD_COOLDOWN_SHOW_BAR = "显示冷却计时条";
	BFCD_COOLDOWN_SHOW_BAR_TOOLTIP="提供一个显示技能名称及冷却时间的面板";

	BFCD_COOLDOWN_SHOW_TARGET = "显示目标时间";
	BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP="显示目标头像下各种(DE)BUFF的持续(剩余)时间";
elseif GetLocale() == "zhTW" then
	BFCD_COOLDOWN_COUNT = "顯示冷卻時間";
	BFCD_COOLDOWN_COUNT_TOOLTIP= "在自己技能圖標上顯示詳細的冷卻時間";

	BFCD_SHINE_TYPE_TITLE = "閃光類型：";
	BFCD_SHINE_TYPE = {"標準", "圖標","大閃光", "雷達","收縮"};
	BFCD_SHINE_TYPE_TITLE_TOOLTIP= "在自己的技能冷卻結束時，選擇顯示的類型：標準(系統默認效果)，圖標(技能圖標擴大)，大閃光(技能圖標高亮閃)，雷達(技能圖標高亮微縮)，收縮(技能圖標閃爍微縮)";

	BFCD_COOLDOWN_SHAMAN_CD = "顯示圖騰時間";
	BFCD_COOLDOWN_SHAMAN_CD_TOOLTIP= "在玩家頭像下的圖騰圖標上顯示剩餘時間";

	BFCD_COOLDOWN_DK_CD = "顯示符文冷卻時間";
	BFCD_COOLDOWN_DK_CD_TOOLTIP= "在玩家頭像下的符文圖標上顯示剩餘時間";

	BFCD_COOLDOWN_SHOW_MIDDLE = "顯示冷卻提示";
	BFCD_COOLDOWN_SHOW_MIDDLE_TOOLTIP= "在技能冷卻結束時屏幕中央閃出技能圖標效果";

	BFCD_COOLDOWN_SHOW_BAR = "顯示冷卻計時條";
	BFCD_COOLDOWN_SHOW_BAR_TOOLTIP= "提供一個顯示技能名稱及冷卻時間的面板";

	BFCD_COOLDOWN_SHOW_TARGET = "顯示目標時間";
	BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP= "顯示目標頭像下各種(DE)BUFF的持續(剩餘)時間";
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BFCooldown",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2]},nil,nil,true)
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

BFNew_RegisterAddonConfig("BFCooldown","CheckBox","EnableCooldownCount2",BFCD_COOLDOWN_COUNT,BFCD_COOLDOWN_COUNT_TOOLTIP,
true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
				BigFoot_LoadAddOn("BFCooldown");
			end
			if (BigFoot_IsAddOnLoaded("BFCooldown")) then
				BFCooldown:ToggleSec(true,"ACTION");
			end
		else
			if (BigFoot_IsAddOnLoaded("BFCooldown")) then
				BFCooldown:ToggleSec(false,"ACTION");
			end
		end
	end
)

	BFNew_RegisterAddonConfig("BFCooldown","SpinBox","ShineType",BFCD_SHINE_TYPE_TITLE,BFCD_SHINE_TYPE_TITLE_TOOLTIP,
	{BFCD_SHINE_TYPE,1},-----默认值
	function(arg,init)
		if arg and BigFoot_IsAddOnLoaded("BFCooldown") then
			for _i,_val in pairs(BFCD_SHINE_TYPE) do
				if _val == arg then
					BFCooldown:SwitchActionStyle(_i-2);
					return
				end
			end
		end
	end,1
	)

if select(2,UnitClass('player') )=='SHAMAN' then
	BFNew_RegisterAddonConfig("BFCooldown","CheckBox","ShowTotem",BFCD_COOLDOWN_SHAMAN_CD,BFCD_COOLDOWN_SHAMAN_CD_TOOLTIP,
	false,-----默认值
		function (arg)
			if (arg) then
				if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
					BigFoot_LoadAddOn("BFCooldown");
				end
				if (BigFoot_IsAddOnLoaded("BFCooldown")) then
					BFCooldown:ToggleSpecial(true)
				end
			else
				if (BigFoot_IsAddOnLoaded("BFCooldown")) then
					BFCooldown:ToggleSpecial(false)
				end
			end
		end
	)
end
if select(2,UnitClass('player') )=='DEATHKNIGHT' then
	BFNew_RegisterAddonConfig("BFCooldown","CheckBox","ShowRune",BFCD_COOLDOWN_DK_CD,BFCD_COOLDOWN_DK_CD_TOOLTIP,
	false,-----默认值
		function (arg)
			if (arg) then
				if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
					BigFoot_LoadAddOn("BFCooldown");
				end
				if (BigFoot_IsAddOnLoaded("BFCooldown")) then
					BFCooldown:ToggleSpecial(true)
				end
			else
				if (BigFoot_IsAddOnLoaded("BFCooldown")) then
					BFCooldown:ToggleSpecial(false)
				end
			end
		end
	)

end
BFNew_RegisterAddonConfig("BFCooldown","CheckBox","ShowCenter",BFCD_COOLDOWN_SHOW_MIDDLE,BFCD_COOLDOWN_SHOW_MIDDLE_TOOLTIP,
	false,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
				BigFoot_LoadAddOn("BFCooldown");
			end
			if (BigFoot_IsAddOnLoaded("BFCooldown")) then
				BFCooldown:ToggleMiddle(true)
			end
			if (BigFoot_IsAddOnLoaded("CoolLine")) then
				if (BigFoot_GetModVariable("ActionButton", "EnableCoolLine") ~= 0) then
					BigFoot_SetModVariable("ActionButton", "EnableCoolLine", 0);
					CoolLine:Hide();
				end
				ModManagement_Refresh();
			end
		else
			if (BigFoot_IsAddOnLoaded("BFCooldown")) then
				BFCooldown:ToggleMiddle(false)
			end
		end
	end
)
BFNew_RegisterAddonConfig("BFCooldown","CheckBox","ToggleBar",BFCD_COOLDOWN_SHOW_BAR,BFCD_COOLDOWN_SHOW_BAR_TOOLTIP,
	false,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFCooldown")) then
				BigFoot_LoadAddOn("BFCooldown");
			end
			if (BigFoot_IsAddOnLoaded("BFCooldown")) then
				BFCooldown:ToggleBar(true)
			end
			if (BigFoot_IsAddOnLoaded("CoolLine")) then
				if (BigFoot_GetModVariable("ActionButton", "EnableCoolLine") ~= 0) then
					BigFoot_SetModVariable("ActionButton", "EnableCoolLine", 0);
					CoolLine:Hide();
				end
				ModManagement_Refresh();
			end
		else
			if (BigFoot_IsAddOnLoaded("BFCooldown")) then
				BFCooldown:ToggleBar(false)
			end
		end
	end
)

BFNew_RegisterAddonConfig("BFCooldown","CheckBox","ShowTargetCooldown2",BFCD_COOLDOWN_SHOW_TARGET,BFCD_COOLDOWN_SHOW_TARGET_TOOLTIP,
	false,-----默认值
	function (arg)
		if (not BigFoot_IsAddOnLoadedFromBigFoot("BFCooldown")) then
			BigFoot_LoadAddOn("BFCooldown");
		end
		if (arg) then
			BFCooldown:ToggleSec(true,"BUFF")
		else
			BFCooldown:ToggleSec(false,"BUFF")
		end
	end
)