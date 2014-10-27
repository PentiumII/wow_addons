local SPELL_TIMER;
local SPELL_TIMER_ENABLE;
if (GetLocale() == "zhCN") then
	SPELL_TIMER = {"技能计时器", "fashujishiqi"};
	SPELL_TIMER_ENABLE = "启用技能计时器";
	SPELL_TIMER_OPTION ="设置";
elseif (GetLocale() == "zhTW") then
	SPELL_TIMER = {"技能計時器", "fashujishiqi"};
	SPELL_TIMER_ENABLE = "啟用技能計時器";
	SPELL_TIMER_OPTION ="設置";
else
	SPELL_TIMER = "Spell Timer";
	SPELL_TIMER_ENABLE = "Enable Spell Timer";
end

local function SpellTimer_DelayShow()
	if (SPELL_TIMER_LOADED) then
		SpellTimer_Toggle(1);
		ModManagement_Refresh();
	else
		BigFoot_DelayCall(SpellTimer_DelayShow, 0.1);
	end
end

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("SpellTimer",{BFNew_AddonTypeTable[1],BFNew_AddonTypeTable[2]})
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
BFNew_RegisterAddonConfig("SpellTimer","CheckBox","EnableSpellTimer",SPELL_TIMER_ENABLE,nil,
	true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("SpellTimer")) then
				BigFoot_LoadAddOn("SpellTimer");
			end
			if (BigFoot_IsAddOnLoaded("SpellTimer")) then
				SpellTimer_DelayShow();
				SpellTimerOptionFrame.name="SpellTimer";
				if not BFN_IsCategoryHave(SpellTimerOptionFrame) then
					InterfaceOptions_AddCategory(SpellTimerOptionFrame)
				end
			end
		else
			if (BigFoot_IsAddOnLoaded("SpellTimer")) then
				SpellTimer_Toggle(false);					
			end
		end
	end
)
BFNew_RegisterAddonConfig("SpellTimer","Button","SpellTimer_option",SPELL_TIMER_OPTION,nil,
nil,-----默认值
	function ()
		InterfaceOptionsFrame_OpenToCategory("SpellTimer") 
	end,1
)