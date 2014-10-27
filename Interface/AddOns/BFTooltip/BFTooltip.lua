--------------------------------------------------------------------------------
-- BigFootTooltip - ver 4.02
-- 作者: 独孤傲雪,Mod by Terry@bf
-- 日期: (2011.08.08)
-- 描述: 增强鼠标信息提示信息显示, 并能跟随鼠标.
-- 版权所有: 艾泽拉斯国家地理
---------------------------------------------------------------------------------
local __hooker = BLibrary:CreateInstance("BHook");
local __secure = BLibrary("BSecureHook");
local __BFTT = BLibrary("BEvent");
local BFTT_GEARSCORE={};
local BFTT_GEARSCORECURRY ={};
local inspectList = {};

if (GetLocale() == "zhCN") then
	__BFTT_YOU = "|CFFFF0000>>你<<|r";
	__BFTT_TALENT = "专精：%s |r"
	__BFTT_TALENT_1 = "专精：%s |r"
	__BFTT_TALENT_2 = "副天赋：%s |r"
	__BFTT_TARGET = "目标："	
	__BFTT_PADDING_WIDTH = 4;
elseif (GetLocale() == "zhTW") then
	__BFTT_YOU = "|CFFFF0000>>你<<|r";
	__BFTT_TALENT = "專精：%s |r"
	__BFTT_TALENT_1 = "專精：%s |r"
	__BFTT_TALENT_2 = "副天賦：%s |r"
	__BFTT_TARGET = "目標："	
	__BFTT_PADDING_WIDTH = 4;
else
	__BFTT_YOU = "|CFFFF0000>>YOU<<|r";
	__BFTT_TALENT = "Talent: %s (%d/%d/%d)|r"
	__BFTT_TALENT_1 = "Primary Talent: %s (%d/%d/%d)|r"
	__BFTT_TALENT_2 = "SecondaryTalent: %s (%d/%d/%d)|r"
	__BFTT_TARGET = "Target: "	
	__BFTT_PADDING_WIDTH = 4;
end

__BFTT_CURRENT_TALENT_COLOR="|CFFFFD000"
__BFTT_INACTIVE_TALENT_COLOR="|CFF777777"



local __BFTT_UNKNOW = UNKNOWNOBJECT;
local __BFTT_ONLINE = GREEN_FONT_COLOR_CODE..GUILD_ONLINE_LABEL;
local __BFTT_PLAYER = PLAYER;
local __BFTT_CORPSE = CORPSE;
local __BFTT_CORPSE_INFO = string.gsub(CORPSE_TOOLTIP,"%%s", "%(%.%+%)");
local __BFTT_NOTSPECIFIED;
local __BFTT_ELITE_TEXT;
local __BFTT_LOOK_GS;
local __BFTT_LOOK_ZD;
local __BFTT_LOOK_ZD_TTTLE;

if (GetLocale() == "zhCN") then
	__BFTT_LOOK_GS = "正在查询目标GS"
	__BFTT_LOOK_ZD = "正在查询目标当前装等"
	__BFTT_NOTSPECIFIED = "无详细信息";
	__BFTT_LOOK_ZD_TTTLE ="当前装等：";
	__BFTT_ELITE_TEXT = {
		["elite"]		= "精英",
		["worldboss"]	= "首领",
		["rare"]		= "稀有",
		["rareelite"]	= "稀有精英",	
	};
	__BFTT_FACTION_TEXT ={
	"仇恨",
	"敌对",
	"冷淡",
	"中立",
	"友善",
	"尊敬",
	"崇敬",
	"崇拜",
	}
	BFTT_FONT = "Fonts\\ARKai_T.TTF";
elseif (GetLocale() == "zhTW") then
	__BFTT_LOOK_ZD_TTTLE ="當前裝等"
	__BFTT_LOOK_GS ="正在查詢目標GS";
	__BFTT_LOOK_ZD="正在查詢目標當前裝等";
	__BFTT_NOTSPECIFIED = "无详细信息";
	__BFTT_ELITE_TEXT = {
		["elite"]		= "精英",
		["worldboss"]	= "首領",
		["rare"]		= "稀有",
		["rareelite"]	= "稀有精英",	
	};
	__BFTT_FACTION_TEXT ={
		"仇恨",
		"敵對",
		"冷淡",
		"中立",
		"友善",
		"尊敬",
		"崇敬",
		"崇拜",
	}
	BFTT_FONT = "Fonts\\bLEI00D.TTF";
else
	__BFTT_NOTSPECIFIED = "Not specified";
	__BFTT_ELITE_TEXT = {
		["elite"]		= "Elite",
		["worldboss"]	= "Boss",
		["rare"]		= "Rare",
		["rareelite"]	= "Rare Elite",	
	};
	__BFTT_FACTION_TEXT ={
		"Hated",
		"Hostile",
		"Unfriendly",
		"Neutral",
		"Friendly",
		"Honored",
		"Revered",
		"Exalted"
	}
	BFTT_FONT = "Fonts\\ARIALN.TTF";
end

BFTT_Config = {
	["Anchor"] = 1,		-- 共11种
	["PositionX"] = -20,
	["PositionY"] = -25,
	["Fade"] = 0,
	["Talent"] = 2,
	["ItemLevel"] = 1,
	["TOT"] = 2,
	["Actor"] = 2,
	["GuildRank"] = 1,
};

local __BFTT_Anchor = {
	[1] = {nil, nil},
	[2] = {"TOPLEFT", "BOTTOMLEFT"},
	[3] = {"TOPLEFT", "TOPLEFT"},
	[4] = {"TOP", "TOP"},
	[5] = {"TOPRIGHT", "TOPRIGHT"},
	[6] = {"LEFT", "LEFT"},
	[7] = {"CENTER", "CENTER"},
	[8] = {"RIGHT", "RIGHT"},
	[9] = {"BOTTOMLEFT", "BOTTOMLEFT"},
	[10] = {"BOTTOM", "BOTTOM"},
	[11] = {"BOTTOMRIGHT", "BOTTOMRIGHT"},
};
----------------------------------------------------------------------------------------
-- COLORS
----------------------------------------------------------------------------------------
local __BFTT_CLASS_COLORS = {		
	  ["HUNTER"]	= "|cffaad372",
	  ["WARLOCK"]	= "|cff9382C9",
	  ["PRIEST"]	= "|cffffffff",
	  ["PALADIN"]	= "|cfff48cba",
	  ["MAGE"]		= "|cff68ccef",
	  ["ROGUE"]		= "|cfffff468",
	  ["DRUID"]		= "|cffff7c0a",
	  ["SHAMAN"]	= "|cff2359ff",
	  ["WARRIOR"]	= "|cffc69b6d",
	  ["DEATHKNIGHT"] = "|cffc41f3b",
	  ["MONK"] = "|cff00ff96",
	  ["DEFAULT"]	= "|cffa0a0a0",
	  
};
local __BFTT_CORPSE_COLOR = "|cff888888";
local __BFTT_TARGET_COLOR = "|c0000ff00";

local __BFTT_LEVEL_COLOR = {
	[1] = "|cffff0000", --impossible
	[2] = "|cffff6600", --hard
	[3] = "|cffffff00", --normal
	[4] = "|cff00ff00", --easy
	[5] = "|cff888888", --trivial
	[6] = "|cffffcc00", --samefaction
};
local __BFTT_ELITE_COLOR = {
	["elite"] = "|cffffcc00",
	["worldboss"] = "|cffff0000",
	["rare"] = "|cffff66ff",
	["rareelite"] = "|cffffaaff",
};
local __BFTT_BACKGROUND_COLOR = {
	[1] = {			--蓝
		["r"] = 0.0,
		["g"] = 0.0,
		["b"] = 0.5,
	},	
	[2] = {			--黄
		["r"] = 0.5,
		["g"] = 0.5,
		["b"] = 0.0,
	},
	[3] = {			--紫
		["r"] = 0.5,
		["g"] = 0.0,
		["b"] = 0.5,
	},
	[4] = {			--红
		["r"] = 0.5,
		["g"] = 0.0,
		["b"] = 0.0,
	},
	[5] = {			--黑
		["r"] = 0.0,
		["g"] = 0.0,
		["b"] = 0.0,
	},
};

-------------------
-- 获得文字空隙字符串
-------------------
local function __BFTT_GetPaddingString(__count)
	local __text = "";

	for __i = 1, __count, 1 do
		__text = __text .. " ";
	end

	return __text;
end

-------------------
-- 设置名字及背景颜色
-------------------
local function __BFTT_GameTooltip_UnitColor(origfunc, __unit)
	local r, g, b;
	if ( UnitPlayerControlled(__unit) ) then			
		if ( UnitCanAttack(__unit, "player") ) then			
			if ( not UnitCanAttack("player", __unit) ) then									
				r = 1.0;
				g = 1.0;
				b = 1.0;
				GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[3].r, __BFTT_BACKGROUND_COLOR[3].g, __BFTT_BACKGROUND_COLOR[3].b);
			else				
				r = FACTION_BAR_COLORS[2].r;
				g = FACTION_BAR_COLORS[2].g;
				b = FACTION_BAR_COLORS[2].b;
				GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[4].r, __BFTT_BACKGROUND_COLOR[4].g, __BFTT_BACKGROUND_COLOR[4].b);
			end
		elseif ( UnitCanAttack("player", __unit) ) then						
			r = FACTION_BAR_COLORS[4].r;
			g = FACTION_BAR_COLORS[4].g;
			b = FACTION_BAR_COLORS[4].b;
			GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[2].r, __BFTT_BACKGROUND_COLOR[2].g, __BFTT_BACKGROUND_COLOR[2].b);
		elseif ( UnitIsPVP(__unit) ) then					
			r = 0;
			g = 1;
			b = 0;
			GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[1].r, __BFTT_BACKGROUND_COLOR[1].g, __BFTT_BACKGROUND_COLOR[1].b);
		else					
			r = 0.0;
			g = 0.8;
			b = 1.0;	
			GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[1].r, __BFTT_BACKGROUND_COLOR[1].g, __BFTT_BACKGROUND_COLOR[1].b);
		end
	else
		local __reaction = UnitReaction(__unit, "player");
		if ( __reaction ) then
			r = FACTION_BAR_COLORS[__reaction].r;
			g = FACTION_BAR_COLORS[__reaction].g;
			b = FACTION_BAR_COLORS[__reaction].b;
			if (__reaction<=3) then
				GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[4].r, __BFTT_BACKGROUND_COLOR[4].g, __BFTT_BACKGROUND_COLOR[4].b);
			elseif (__reaction == 4) then
				GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[5].r, __BFTT_BACKGROUND_COLOR[5].g, __BFTT_BACKGROUND_COLOR[5].b);
			else
				GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[1].r, __BFTT_BACKGROUND_COLOR[1].g, __BFTT_BACKGROUND_COLOR[1].b);
			end
		else			
			r = 0.0;
			g = 0.8;
			b = 1.0;	
			GameTooltip:SetBackdropColor(__BFTT_BACKGROUND_COLOR[1].r, __BFTT_BACKGROUND_COLOR[1].g, __BFTT_BACKGROUND_COLOR[1].b);
		end
	end
	return r, g, b;
end

--------------------
-- 调整宽度
--------------------
local function __BFTT_AjustWidth()
	local __widthmax = 0;
	for __i=1, GameTooltip:NumLines() do
		local __width = getglobal("GameTooltipTextLeft"..__i):GetWidth();
		if (__width > __widthmax) then
			__widthmax = __width;
		end
	end
	GameTooltip:SetWidth(__widthmax + 18);
end

--==================
-- Hook 部分
--==================
local function __NEW_BFTT_GameTooltip_SetDefaultAnchor(__original, __tooltip, __parent)
	if (not __parent) then
		return;
	end

	__tooltip.default = 1;
	if (__tooltip == getglobal("GameTooltip") or __tooltip == getglobal("MobileGameTooltip")) then
		local __focusFrame = GetMouseFocus();
		if (__focusFrame) then
			if (__focusFrame:GetName() ~= "WorldFrame" and BFTT_Config["Anchor"] == 2) then
				__original(__tooltip, __parent);
			else
				__tooltip:ClearAllPoints();
				__tooltip:SetOwner(__parent, "ANCHOR_NONE");
				local __x, __y = GetCursorPosition();
				local __scale = UIParent:GetScale();
				__x,__y = __x/__scale,__y/__scale;		
				local __XP, __YP = BFTT_Config["PositionX"],BFTT_Config["PositionY"];
				if (BFTT_Config["Anchor"] == 1 ) then
					__original(__tooltip, __parent);
					return;
				elseif (BFTT_Config["Anchor"] == 2) then
					__XP = __XP + __x;
					__YP = __YP + __y;		
				end
				__tooltip:SetPoint(__BFTT_Anchor[BFTT_Config["Anchor"]][1], UIParent, __BFTT_Anchor[BFTT_Config["Anchor"]][2], __XP, __YP);
			end
		else
			__original(__tooltip, __parent);
		end
	else		
		__original(__tooltip, __parent);
	end	
end
--------------------
-- 最主要的hook部分, 增加显示的信息
--------------------

local function __NEW_BFTT_SetUnit(self, __unit)
	local __linenums = GameTooltip:NumLines();	
	local __name, __realmName = UnitName(__unit);
	local __classtxt, __CLASS = UnitClass(__unit);
	if not __name then return end
	--名字/荣誉等级
	if (UnitIsPlayer(__unit)) then
		local coords =__CLASS and CLASS_BUTTONS[__CLASS];
		if (coords) then
			GameTooltip.classIcon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes");
			GameTooltip.classIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
			GameTooltip.classIcon:Show();
			if BFTT_Config["Actor"] == 1 then
				-- local actorName,_;
				-- local tempActorName = UnitPVPName(__unit)
				-- if tempActorName and tempActorName ~= __name then
					-- local i = strfind(tempActorName, __name)
					-- if i and i > 1 then
						-- actorName = strsub(tempActorName, 1, i - 1 )
					-- elseif i == 1 then
						-- _, actorName = tempActorName:match("(.+)，(.+)")
					-- end
					-- actorName = actorName and (", " .. actorName) or ""
					-- __name = __name..actorName
				-- end
				__name = UnitPVPName(__unit)
			end
			if (__name) then
				GameTooltipTextLeft1:SetText(format(__BFTT_GetPaddingString(__BFTT_PADDING_WIDTH) .."%s", __name));
			else
				GameTooltipTextLeft1:SetText(format(__BFTT_GetPaddingString(__BFTT_PADDING_WIDTH) .."%s", __BFTT_UNKNOW));
			end
		else
			GameTooltipTextLeft1:SetText(__name or __BFTT_UNKNOW);
		end
		if __realmName then
			GameTooltip:AppendText("-"..__realmName);
		end
		local guildName, guildRankName = GetGuildInfo(__unit)
		if guildName then
			if guildRankName and BFTT_Config["GuildRank"]==1 then
				GameTooltipTextLeft2:SetText("<"..guildName.."> - "..guildRankName);
			end
		end
	else		
		GameTooltip.classIcon:Hide();
	end		
	--等级
	local __levelLine;
	for __i=1, __linenums, 1 do
		local __text = getglobal("GameTooltipTextLeft"..__i):GetText();
		if (__text) then
			if (string.find(__text, LEVEL)) then
				__levelLine = __i;
				break;
			end
		else
			break;
		end
	end
	
	local __level = UnitLevel(__unit);
	if (not __levelLine) then
		return;
	else
		--等级--
		local leveltxt, levelcolor;		
		if (__level and __level >= 1) then
			leveltxt = LEVEL .." " ..  __level;
		else
			leveltxt = LEVEL .. "??";
		end		
		local __PlayerLevel = UnitLevel("player");
		if (UnitFactionGroup(__unit) ~= UnitFactionGroup("player")) then
			if ((__level - __PlayerLevel >= 5) or  __level == -1) then
				levelcolor = __BFTT_LEVEL_COLOR[1];
			elseif (__level - __PlayerLevel >= 3) then
				levelcolor = __BFTT_LEVEL_COLOR[2];
			elseif (__level - __PlayerLevel >= -2) then
				levelcolor = __BFTT_LEVEL_COLOR[3];
			elseif (__PlayerLevel - __level  <= GetQuestGreenRange()) then
				levelcolor = __BFTT_LEVEL_COLOR[4];
			else
				levelcolor = __BFTT_LEVEL_COLOR[5];
			end
		else
			levelcolor = __BFTT_LEVEL_COLOR[6];
		end
		--种族--
		local __racetext,__racecolor = "","|cffffffff";	
		local __faction,__factioncolor,__factiontext	
		if (UnitRace(__unit) and UnitIsPlayer(__unit)) then			
			__racetext = UnitRace(__unit);			
		elseif (UnitPlayerControlled(__unit)) then			
			__racetext = UnitCreatureFamily(__unit);			
		else
			__faction=UnitIsFriend(__unit,"player") and UnitReaction(__unit,"player")
			if __faction then
				if __faction<=2 then
					__factioncolor= __BFTT_LEVEL_COLOR[1]
					
				elseif __faction<=3 then
					__factioncolor= __BFTT_LEVEL_COLOR[2];
				elseif __faction<=4 then
					__factioncolor = __BFTT_LEVEL_COLOR[3];
				else
					__factioncolor = __BFTT_LEVEL_COLOR[4];
				end
				__factiontext=__BFTT_FACTION_TEXT[__faction]
			end
			if (UnitCreatureType(__unit) == __BFTT_NOTSPECIFIED) then
				__racetext = ""				
			else
				__racetext = UnitCreatureType(__unit);				
			end
		end
		if (__racetext == nil) then
			__racetext = ("");
		else
			__racetext = (__racetext .. " ");
		end		
		--职业--
		local __classcolor = "|cffffffff";
		if (UnitIsPlayer(__unit)) then
			__classcolor = __CLASS and __BFTT_CLASS_COLORS[__CLASS] or __BFTT_CLASS_COLORS["DEFAULT"];
		else
			__classtxt = " ";
		end
		--精英--
		local __elitetext, __elitecolor = "","|cffffffff";	
		if (UnitClassification(__unit) and UnitClassification(__unit) ~= "normal" and UnitHealth(__unit) > 0) then
			if (UnitClassification(__unit) == "elite" or UnitClassification(__unit) == "worldboss" or UnitClassification(__unit) == "rare" or UnitClassification(__unit) == "rareelite") then			
				__elitetext = ("(" .. __BFTT_ELITE_TEXT[UnitClassification(__unit)] .. ")");
				__elitecolor = __BFTT_ELITE_COLOR[UnitClassification(__unit)];			
			else
				__elitetext = ("(" .. UnitClassification(__unit) .. ")");				
			end	
		end
		--尸体--
		local __corpsetext, __corpsecolor = "","|cffffffff";
		if (UnitHealth(__unit) <= 0) then
			__corpsetext = __BFTT_CORPSE;
			__corpsecolor = __BFTT_CORPSE_COLOR;
			__elitecolor = __BFTT_CORPSE_COLOR;
			__racecolor = __BFTT_CORPSE_COLOR;
			levelcolor = __BFTT_CORPSE_COLOR;
		end
		local __temptext=levelcolor..leveltxt.."|r"..__racecolor.." "..__racetext.."|r"..__classcolor..__classtxt.."|r"..__elitecolor..__elitetext.."|r"..__corpsecolor..__corpsetext.."|r";
		if __factioncolor and __factiontext then
			__temptext= __temptext.."("..__factioncolor..__factiontext.."|r)"
		end
		getglobal("GameTooltipTextLeft"..__levelLine):SetText(__temptext);
	end
	--pvp and tot
	-- add ArmorReduce 5/2/2008
	local __totname, __totcolor = "", "|cffffffff";
	local __lasttext = getglobal("GameTooltipTextLeft"..__linenums):GetText();
	__level = (__level > 0 and __level) or 73;	-- level == -1
	if (UnitIsVisible(__unit.."target") and BFTT_Config["TOT"] == 1) then
		__totname = UnitName(__unit.."target");
		if (UnitIsPlayer(__unit.."target")) then
			local _, __CLASS = UnitClass(__unit.."target");
			__totcolor = __CLASS and __BFTT_CLASS_COLORS[__CLASS];
		end	
	end		
	if (__lasttext == "PvP") then	
		if (BFTT_Config["TOT"] == 1 and UnitIsVisible(__unit.."target")) then
			if (UnitIsUnit(__unit .. "target", "player")) then
				getglobal("GameTooltipTextLeft" .. __linenums):SetText(__BFTT_TARGET_COLOR .. __BFTT_TARGET .. "|r" .. __BFTT_YOU);
			else
				getglobal("GameTooltipTextLeft" .. __linenums):SetText(__BFTT_TARGET_COLOR..__BFTT_TARGET.."|r"..__totcolor..__totname.."|r");
			end
		end		
	else		
		if (BFTT_Config["TOT"] == 1 and UnitIsVisible(__unit.."target")) then
			if (UnitIsUnit(__unit .. "target", "player")) then
				GameTooltip:AddLine(__BFTT_TARGET_COLOR .. __BFTT_TARGET .. "|r" .. __BFTT_YOU);
			else
				GameTooltip:AddLine(__BFTT_TARGET_COLOR..__BFTT_TARGET.."|r"..__totcolor..__totname.."|r");
			end			
			GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
		end
	end
	
	---------GS---------
	
	if GS_Settings then
		if (GS_Settings["Player"]==1 and UnitIsPlayer(__unit) and CanInspect(__unit) ) then	
			local fullname = GetFullName(__unit)
			if BFTT_GEARSCORE[fullname] and BFTT_GEARSCORE[fullname] ~=0 then
			-- if nameOver and GearScore~=0 and __name == nameOver then
				GearScore_HookSetUnit(BFTT_GEARSCORE[fullname])
			else
				GameTooltip:AddLine(__BFTT_LOOK_GS)
			end
			GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
		end
	end
		-----当前装备等级-------------------------------------------------------
	if ItemLevelShow then
		if (BFTT_Config["ItemLevel"]==1 and UnitIsPlayer(__unit) and CanInspect(__unit) ) then
			local fullname = GetFullName(__unit)
			if BFTT_GEARSCORECURRY[fullname] and BFTT_GEARSCORECURRY[fullname] ~=0 then
				-- GearScore_HookSetUnit(BFTT_GEARSCORECURRY[fullname])
				local Red, Blue, Green = 1,1,1;
				GameTooltip:AddLine(__BFTT_LOOK_ZD_TTTLE..BFTT_GEARSCORECURRY[fullname], Red, Green, Blue)
			else
				GameTooltip:AddLine(__BFTT_LOOK_ZD)
			end
			GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
		end
	end

	-- 天赋信息	
	--Modify@20120924byAguan
	--修改为专精信息
	
	local fullname =GetFullName(__unit)
	if (BFTT_Config["Talent"] == 1 and UnitIsPlayer(__unit)) then
		local specID  =  GetInspectSpecialization(__unit)
		local _, name, description, icon  = GetSpecializationInfoByID(specID)
		if name then
			GameTooltip:AddLine(format(__BFTT_CURRENT_TALENT_COLOR..__BFTT_TALENT_1,name));
			GameTooltip:SetHeight(GameTooltip:GetHeight() + 14)
		end
		-- inspectList[fullname] = inspectList[fullname] or {};
		-- if inspectList[fullname].talent1 then
			-- local __color
			-- if  not inspectList[fullname].talent2 or inspectList[fullname].activeTalent==1 then
				-- __color=__BFTT_CURRENT_TALENT_COLOR
			-- else
				-- __color=__BFTT_INACTIVE_TALENT_COLOR
			-- end
			-- if inspectList[fullname].talent2 then
				-- GameTooltip:AddLine(format(__color..__BFTT_TALENT_1, 
					-- inspectList[fullname].talent1.name,
					-- inspectList[fullname].talent1.p1,
					-- inspectList[fullname].talent1.p2,
					-- inspectList[fullname].talent1.p3 
				-- ));
			-- else
				-- GameTooltip:AddLine(format(__color..__BFTT_TALENT, 
					-- inspectList[fullname].talent1.name,
					-- inspectList[fullname].talent1.p1,
					-- inspectList[fullname].talent1.p2,
					-- inspectList[fullname].talent1.p3 ));

			-- end
			
		-- end
		
		-- if inspectList[fullname].talent2 then
			-- if inspectList[fullname].activeTalent==1 then
				-- __color=__BFTT_INACTIVE_TALENT_COLOR
			-- else
				-- __color=__BFTT_CURRENT_TALENT_COLOR
			-- end
			-- GameTooltip:AddLine(format(	__color..__BFTT_TALENT_2, 
				-- inspectList[fullname].talent2.name,
				-- inspectList[fullname].talent2.p1,
				-- inspectList[fullname].talent2.p2,
				-- inspectList[fullname].talent2.p3));
			-- GameTooltip:SetHeight(GameTooltip:GetHeight() + 14)
		-- end
	end	
	
	--调整宽度
	__BFTT_AjustWidth();
end
---------------------
local function OnInspectCallback(__unit,__name)
	local _,server= UnitName(__unit);
	server = server or "";
	if GearScore_GetScore or UnitAverageItemLevel  then
		if GearScore_GetScore then
			local GS = GearScore_GetScore(__name, __unit);
			BFTT_GEARSCORE[__name] = GS;
		end
		if UnitAverageItemLevel then
			local ItemLevelStr = UnitAverageItemLevel(__unit);
			local ItemLevel
			if ItemLevelStr then
				ItemLevel = tonumber(ItemLevelStr);
			else
				ItemLevel =0
			end
			if ItemLevel then
				BFTT_GEARSCORECURRY[__name] = math.floor(ItemLevel)
			else
				BFTT_GEARSCORECURRY[__name] =0;
			end
		end
		GameTooltip:SetUnit('mouseover');
	end
end

local function OnInspectTalentCallback(unit,name,m_inspectList)
	inspectList[name] = m_inspectList
	GameTooltip:SetUnit('mouseover')
end

-- -----修改天赋错误显示Start-------------
local function __GetFoucsTalentTabInfo(name)
	local __talentTabName =""
	if inspectList[name] then
		 if inspectList[name].activeTalent==1  then
		    if inspectList[name].talent1 then
			__talentTabName = inspectList[name].talent1.name;
			end
		 else
		   if inspectList[name].talent2 then
			__talentTabName = inspectList[name].talent2.name;
			end
		 end		 
	end
	return __talentTabName;
end


local function __NEW_BFTT_FadeOut()
	if (BFTT_Config["Fade"] ~= 1) then	
		GameTooltip:Hide();
	end	
end
-------------------
-- 使图标消失
-------------------
local function __BFTT_ClearTip()
	GameTooltip.classIcon:SetTexture("");
	GameTooltip.classIcon:Hide();	
end
--------------------
-- 尸体信息查询
--------------------
local __queryTime;
local function __BFTT_OnShow(...)	

	local __linenums = GameTooltip:NumLines();
	local __text = GameTooltipTextLeft1:GetText();
	if (BFTT_Config["ItemLevel"] == 1 and __linenums == 1) then	
		local _, _, __name = string.find(__text, __BFTT_CORPSE_INFO);
		if (__name) then
			--SendWho("n-" .. __name);
			--__queryTime = GetTime();
			return;
		end	
	end	
end

--------------------
-- 不显示查询信息
--------------------
local function __BFTT_ChatFrame_OnEvent(__original, self, event, ...)
	if (event == "CHAT_MSG_SYSTEM" and __queryTime and (GetTime() - __queryTime) < 3 and (string.find(arg1, WHO_NUM_RESULTS) or string.find(arg1, "(.-)%s-: (.- .-) ([^<%-]*) "))) then
	else
		__original(self, event, ...);
	end
end

--------------------
-- OnEvent
--------------------
function __BFTT:CHAT_MSG_SYSTEM(...)	
	local arg1 = ...;
	if (string.find(arg1, WHO_NUM_RESULTS)) then
		if (GameTooltip:NumLines() == 1 and BFTT_Config["ItemLevel"] == 1) then			 
			for __i = 1, GetNumWhoResults() do
				local whoname, __guild, level, race, class = GetWhoInfo(__i);
				local __name = GameTooltipTextLeft1:GetText();
				BigFoot_Print(GetGuildInfo(whoname))
			
				if (string.find(__name, whoname)) then				
					if (string.len(__guild) > 0) then
			
						GameTooltip:AddLine("<"..__guild..">-"..guildRankName);
						GameTooltip:AddLine(string.format("|cffffbb00"..UNIT_LEVEL_TEMPLATE.."|r"..HIGHLIGHT_FONT_COLOR_CODE .. " %s %s|r", level, race, class));
						GameTooltip:AddLine(__BFTT_ONLINE);
						GameTooltip:SetHeight(GameTooltip:GetHeight()+14*3)
					else
						GameTooltip:AddLine(string.format("|cffffbb00"..UNIT_LEVEL_TEMPLATE.."|r"..HIGHLIGHT_FONT_COLOR_CODE .. " %s %s|r", level, race, class));
						GameTooltip:AddLine(__BFTT_ONLINE);
						GameTooltip:SetHeight(GameTooltip:GetHeight()+14*2)
					end
					__BFTT_AjustWidth();
					return;
				end
			end			
		end		
	end
end

-- Modify by dugu@bigfoot 2008-11-16
-- 针对台服版本的UnitExists("mouseover")Bug添加判断条件.
local function UnitIsMouseOver()
	return UnitExists("mouseover");
end

function __BFTT:UPDATE_MOUSEOVER_UNIT()
	if (UnitIsMouseOver()) then
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
		GameTooltip:SetUnit("mouseover");
		local r, g, b = GameTooltip_UnitColor("mouseover");
		getglobal("GameTooltip".."TextLeft1"):SetTextColor(r, g, b);
		BFTT_Fresh:Show();
		BigFoot_FireEvent("START_INSPECT","mouseover")		
	end
end

local leftlines = setmetatable({[1] = true}, {__index = function(t, i)
	local f = _G["GameTooltipTextLeft"..i]
	t[i] = f
	return f
end})

local rightlines = setmetatable({[1] = true}, {__index = function(t, i)
	local f = _G["GameTooltipTextRight"..i]
	t[i] = f
	return f
end})

local function ChangeQuestText(self,name,title,have,need)
	local quest;
	local numlines = self:NumLines()
	local i = 1 --start at 2 because 1 can never be a quest objective
	while i < numlines do
		i = i + 1
		left = leftlines[i]
		text = left:GetText()
		local quests = GetTooltipQuestTable()
		
		if quests[text] then
			quest = true;			
		end		
	end	

	if (not quest and UnitExists("mouseover")) then
		
		local title,name,have,need =GetTooltipQuestData()
		if name then
			self:AddLine(title, 1, 0.87, 0);
			self:AddLine(format("  - %s: %d/%d", name, have, need), 1, 1, 1);
			self:Show();
		end
	end
end

local function OnTooltipSetUnit(self, ...)
	ChangeQuestText(self);
end

local function __fixGameTooltipHover()
	if GameTooltip:IsShown() then --incase the tooltip is hovering over something on reload
		if GameTooltip:GetItem() then
			-----------------不知道做什么用 报错。注释掉--------------------------
			-- local id = GameTooltip:GetItem()
			-- if id then
				-- MultiItems(GameTooltip, id)
			-- end
		else
			ChangeQuestText(GameTooltip)
		end
		GameTooltip:Show()
	end
end

local SHowTime =nil;
local function __BFTT_OnUpdate(self)
	if (UnitIsMouseOver()) then
	else
		if (BFTT_Config["Fade"] == 1) then
			GameTooltip:FadeOut();
			self:Hide();
		else
			if not SHowTime or (SHowTime and GetTime()- SHowTime >0.5) then
				GameTooltip:Hide();
				self:Hide();
			end
		end
	end
end

local __fresh = CreateFrame("Frame", "BFTT_Fresh",UIParent);
__fresh:SetScript("OnUpdate", __BFTT_OnUpdate);

GameTooltip:HookScript("OnShow",function() SHowTime =GetTime() end)

local function __unhookInspectFrame()
	if InspectFrame then
		InspectGuildFrame:UnregisterEvent("INSPECT_READY")
		InspectFrame:HookScript("OnShow",
		function()
			InspectGuildFrame:RegisterEvent("INSPECT_READY")
			-- print("InspectFrameOnShow")
		end)
		InspectFrame:HookScript("OnHide",
		function()
			InspectGuildFrame:UnregisterEvent("INSPECT_READY")
		end)
		-- hooksecurefunc("InspectTalentFrame_Update",function()
			-- InspectTalentFrame:UnregisterEvent("INSPECT_READY")
		-- end)
			
	end
end

local function __fixPaperDollFrameLevel()
	hooksecurefunc("InspectPaperDollFrame_SetLevel",function()
		if BFTT_Enable then
			specName = __GetFoucsTalentTabInfo(GetFullName(InspectFrame.unit))
			local class,className= UnitClass(InspectFrame.unit)
			local lvl = UnitLevel(InspectFrame.unit)
			local classColor = RAID_CLASS_COLORS[className];
			local classColorString = format("ff%.2x%.2x%.2x", classColor.r * 255, classColor.g * 255, classColor.b * 255);
			if (specName and specName ~= "") then
				InspectLevelText:SetFormattedText(PLAYER_LEVEL, lvl, classColorString, specName, class);
			else
				InspectLevelText:SetFormattedText(PLAYER_LEVEL_NO_SPEC, lvl, classColorString, class);
			end
		end
	end)
end

-- patch up inpsect frame
function __BFTT:ADDON_LOADED(...)
	local addon  = ...
	if addon=="Blizzard_InspectUI" then
		__unhookInspectFrame()
		__fixPaperDollFrameLevel()
		__BFTT:UnregisterEvent("ADDON_LOADED")
	end
end

--------------------
-- 渐变皮肤
--------------------
local function __createSkin()
	local __skin = GameTooltip:CreateTexture(nil, "BORDER");
	__skin:SetTexture("Interface\\ChatFrame\\ChatFrameBackground");
	__skin:SetPoint("TOPLEFT", GameTooltip, "TOPLEFT", 6, -6);
	__skin:SetPoint("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -6, -27);
	__skin:SetBlendMode("ADD");
	__skin:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .2, .2, .2, 1); 
end


__BFTT:Init{
	name = "BFTooltip",
	func = function()
		GameTooltip.classIcon = GameTooltip:CreateTexture(nil, "ARTWORK");		
		GameTooltip.classIcon:SetPoint("LEFT", getglobal("GameTooltipTextLeft1"), "LEFT", 2, -1);
		GameTooltip.classIcon:SetWidth(14);
		GameTooltip.classIcon:SetHeight(14);		
		GameTooltip.classIcon:Hide();
		__createSkin();

		__secure:Hook(GameTooltip, "SetUnit", __NEW_BFTT_SetUnit);
		__secure:Hook(GameTooltip, "FadeOut", __NEW_BFTT_FadeOut);
		__secure:HookScript(GameTooltip, "OnShow", __BFTT_OnShow);
		__secure:HookScript(GameTooltip, "OnTooltipCleared", __BFTT_ClearTip);
		GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
		
		__fixGameTooltipHover()
		__unhookInspectFrame()
		BigFoot_RegisterEvent("INPSECT_TALENT_FINISH",OnInspectTalentCallback);
		BigFoot_RegisterEvent("INSPECT_FINISH",OnInspectCallback);
	end
};
--------------------------------------------------------------------------------------
--Toggle
--------------------------------------------------------------------------------------
function BFTT_Toggle(enable)
	local __key, __method;	
	if (enable) then		
		__hooker:Hook("ChatFrame_MessageEventHandler", __BFTT_ChatFrame_OnEvent);
		__hooker:Hook("GameTooltip_UnitColor", __BFTT_GameTooltip_UnitColor);
		__hooker:Hook("GameTooltip_SetDefaultAnchor", __NEW_BFTT_GameTooltip_SetDefaultAnchor);
		__secure:Enable();
		
		
		__BFTT:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		__BFTT:RegisterEvent("CHAT_MSG_SYSTEM");
		__BFTT:RegisterEvent("ADDON_LOADED")
		GameTooltip:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		BFTT_Fresh:Show();
		BFTT_Enable = 1
	else
		__hooker:Unhook("ChatFrame_MessageEventHandler");
		__hooker:Unhook("GameTooltip_UnitColor");
		__hooker:Unhook("GameTooltip_SetDefaultAnchor");
		GameTooltip:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		__secure:Disable();
		
		__BFTT:UnregisterAllEvent();
		BFTT_Fresh:Hide();
		
		BFTT_Enable = nil;
	end
end