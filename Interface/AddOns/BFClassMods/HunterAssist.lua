
--===================================================
-- HunterAssist - ver 1.0
-- 作者: 独孤傲雪
-- 日期: 2007 - 2008
-- 描述: 提供一系列猎人的辅助功能
-- 版权所有: 艾泽拉斯国家地理
--===================================================

HunterAssist = BLibrary("BEvent");
HunterAssist.H = BLibrary("BHook");

local _
local __H = HunterAssist;
local info = GetInterfaceInfo() or 40100;

local HunterAssist_Enabled = false;

local printOrg = print
local function print(...)
	if debugFlag then
		printOrg(...)
	end
end

---------------------
-- 自动射击进度条
---------------------
local __HunterAssist_CastBar_AutoShot = nil;

function HunterAssistCasteBar_OnLoad(self)
	RegisterForSaveFrame(self);

	self:SetMinMaxValues(0, 1);
	self:SetValue(1);
end

local function __HunterAssistCasteBar_FlashBar()
	if not HunterAssistCasteBar:IsVisible() then
		HunterAssistCasteBar:Hide();
	end
	if HunterAssistCasteBar:IsShown() then
		local __min, __max = HunterAssistCasteBar:GetMinMaxValues();
		HunterAssistCasteBar:SetValue(__max);
		HunterAssistCasteBar:SetStatusBarColor(0.0, 1.0, 0.0);
		HunterAssistCasteBarSpark:Hide();
		HunterAssistCasteBarFlash:SetAlpha(0.0);
		HunterAssistCasteBarFlash:Show();
		HunterAssistCasteBar.__casting = nil;
		HunterAssistCasteBar.__flash = 1;
		HunterAssistCasteBar.__fadeOut = 1;
	end
end

local function __HunterAssistCasteBar_Cast(__spell)
	local __min, __max = GetTime();

	if (__spell and __spell == HUNTERASSIST_AUTO or __spell == HUNTERASSIST_AIMED) then
		__max = __min + UnitRangedDamage("player");
		HunterAssistCasteBar:SetStatusBarColor(1.0, 0.7, 0.0);
		HunterAssistCasteBar:SetMinMaxValues(__min, __max);
		HunterAssistCasteBar:SetValue(__min);
		HunterAssistCasteBar:SetAlpha(1.0);
		HunterAssistCasteBar.__casting = 1;
		HunterAssistCasteBar.__fadeOut = nil;
		HunterAssistCasteBarTextLeft:SetText(HUNTERASSIST_AUTO);
		HunterAssistCasteBarSpark:Show();
		HunterAssistCasteBar:Show();
	end
end

function __H:STOP_AUTOREPEAT_SPELL()
	__HunterAssistCasteBar_FlashBar();
end

function __H:PLAYER_LOGIN()
	self:STOP_AUTOREPEAT_SPELL();
end

function __H:PLAYER_ENTERING_WORLD()
	self:STOP_AUTOREPEAT_SPELL();
end

function __H:UNIT_SPELLCAST_SUCCEEDED(unit, spell)
	if (unit == "player") then
		__HunterAssistCasteBar_Cast(spell);
	end
end

function HunterAssistCasteBar_OnUpdate(self)
	if (not HunterAssist_Enabled) then
		return;
	end

	local __min, __max = HunterAssistCasteBar:GetMinMaxValues();
	if self.__casting then
		local __status = GetTime();
		if __status > __max then
			__status = __max;
		end
		HunterAssistCasteBarTextRight:SetText(format("%0.1f",__max-__status));
		HunterAssistCasteBar:SetValue(__status);
		HunterAssistCasteBarFlash:Hide();
		local __sparkPosition = ((__status - __min) / (__max - __min)) * 195;
		if __sparkPosition < 0 then
			__sparkPosition = 0;
		end
		HunterAssistCasteBarSpark:SetPoint("CENTER", HunterAssistCasteBar, "LEFT", __sparkPosition, 0);
	elseif self.__flash then
		local alpha = HunterAssistCasteBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP;
		if alpha < 1 then
			HunterAssistCasteBarFlash:SetAlpha(alpha);
		else
			HunterAssistCasteBarFlash:SetAlpha(1.0);
			self.__flash = nil;
		end
	elseif self.__fadeOut then
		local alpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP;
		if alpha > 0 then
			self:SetAlpha(alpha);
		else
			self.__fadeOut = nil;
			self:Hide();
		end
	end
end

function HunterAssistBar_Toggle(__switch)
	if (__switch) then
		__H:RegisterEvent("STOP_AUTOREPEAT_SPELL");
		__H:RegisterEvent("PLAYER_REGEN_DISABLED");
		__H:RegisterEvent("PLAYER_REGEN_ENABLED");
		__H:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		__H:RegisterEvent("PLAYER_LOGIN");
		__H:RegisterEvent("PLAYER_ENTERING_WORLD");
		HunterAssist_Enabled = true;
	else
		__H:UnregisterEvent("STOP_AUTOREPEAT_SPELL");
		__H:UnregisterEvent("PLAYER_LOGIN");
		__H:UnregisterEvent("PLAYER_ENTERING_WORLD");
		__HunterAssistCasteBar_FlashBar();

		HunterAssist_Enabled = false;
	end
end

function HunterAssistCasteBar_AjustPosition()
	if HunterAssistCasteBarMove:IsVisible() then
		HunterAssistCasteBarMove:Hide()
		HunterAssistCasteBar:Hide()
	else
		HunterAssistCasteBarMove:Show()
		HunterAssistCasteBar:Show()
		HunterAssistCasteBar:SetAlpha(1)
		HideUIPanel(ModManagementFrame);
	end
end

-------------------
-- 自动取消猎豹守护 thanks to zHunterMod
-------------------
local groupmate = bit.bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE,
	COMBATLOG_OBJECT_AFFILIATION_PARTY,
	COMBATLOG_OBJECT_REACTION_FRIENDLY,
	COMBATLOG_OBJECT_CONTROL_PLAYER,
	COMBATLOG_OBJECT_CONTROL_NPC,
	COMBATLOG_OBJECT_TYPE_PLAYER,
	COMBATLOG_OBJECT_TYPE_PET,
	COMBATLOG_OBJECT_TYPE_GUARDIAN,
	COMBATLOG_OBJECT_TYPE_OBJECT
);

local function UnitIsA(unitFlags, flagType)
	if (bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_AFFILIATION_MASK) > 0 and
	bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_REACTION_MASK) > 0 and
	bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_CONTROL_MASK) > 0 and
	bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_TYPE_MASK) > 0)
	or bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_SPECIAL_MASK) > 0 then
		return true
	end
	return false
end

function __H:AntiDaze(guid)
	--r如果你开了猎豹
	local buffID = self:IsBuffActive(HUNTERASSIST_ASPECT_CHEETAH);
	--如果你没开猎豹，看是否自己身上有豹群
	if not buffID  then
		buffID = self:IsBuffActive(	HUNTERASSIST_ASPECT_ASPECT_PACK);
	end
	if (buffID and type(buffID) == "number" and buffID >= 0) then
		CancelUnitBuff("player", buffID);
	end
end

function HunterAssistDaze_Toggle(__switch)
	if (__switch) then
		__H:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "SPELL_AURA_APPLIED");
		__H:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "SPELL_AURA_APPLIED_DOSE");
	else
		__H:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "SPELL_AURA_APPLIED");
		__H:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "SPELL_AURA_APPLIED_DOSE");
	end
end

function __H:SPELL_AURA_APPLIED(timestamp, event, ...)
	local hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags,spellName,auraType
	if info >= 40200 then
		hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags,_,spellName,_,auraType = ...;
	else
		hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags,_,spellName,_,auraType = ...;
	end
	if (UnitIsA(destFlags, groupmate)) then
		if (auraType == "DEBUFF" and spellName == HUNTERASSIST_ASPECT_DAZED) then
			self:AntiDaze(destGUID);
		end
	end
end

function __H:SPELL_AURA_APPLIED_DOSE(timestamp, event, ...)
	self:SPELL_AURA_APPLIED(timestamp, event, ...);
end

-------------------
-- 自动切换追踪 - 根据当前目标的类型改变追踪技能
-------------------
local enable_tracking = true;
local tracking = {};
local orig_tracking_id = nil;
local track_talent;
local creature = {
	[HUNTERASSIST_BEAST] = "Beast";
	[HUNTERASSIST_HUMANOID] = "Humanoid";
	[HUNTERASSIST_UNDEAD] = "Undead";
	[HUNTERASSIST_GIANT] = "Giant";
	[HUNTERASSIST_ELEMENTAL] = "Elemental";
	[HUNTERASSIST_DEMON] = "Demon";
	[HUNTERASSIST_DRAGONKIN] = "Dragonkin";
};
local ignor_tracking_buff = {
	["player"] = {5384, 13481},
	["target"] = {13481}
};

function __H:UpdateTrackTalent()
	track_talent=true
	--Terry09-10-14: we want auto-tracking to work regardless talent
--[[	local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq  = GetTalentInfo(3, 1);
	if (rank and rank >= 1) then
		track_talent = true;
	else
		track_talent = false;
	end]]
end

function __H:UpdateTrackingID()
	for id=1, GetNumTrackingTypes() do
		local name, texture, active, category = GetTrackingInfo(id);
		if ( name == GetSpellInfo(1494) ) then
			tracking["Beast"] = id;
		elseif ( name == GetSpellInfo(19883) )then
			tracking["Humanoid"] = id;
		elseif ( name == GetSpellInfo(19884) ) then
			tracking["Undead"] = id;
		elseif ( name == GetSpellInfo(19882) ) then
			tracking["Giant"] = id;
		elseif ( name == GetSpellInfo(19880) ) then
			tracking["Elemental"] = id;
		elseif ( name == GetSpellInfo(19878) ) then
			tracking["Demon"] = id;
		elseif ( name == GetSpellInfo(19879) ) then
			tracking["Dragonkin"] = id;
		end
	end
end

function __H:GetCurTrackingID()
	for id=1, GetNumTrackingTypes() do
		local name, texture, active, category = GetTrackingInfo(id);
		if (active) then
			return id;
		end
	end
	return false;
end

function __H:CanTracking()
	local spellName = GetSpellInfo(19883);
	local start, duration, enabled = GetSpellCooldown(spellName);
	if (duration == 0) then
		return true;
	else
		return false;
	end
end

local function delayTracking(trackingID)
	if (trackingID > 0 and __H:GetCurTrackingID() ~= tracingID and InCombatLockdown() and not __H:UnitHasIgnoreBuff() ) then
		SetTracking(trackingID);
	end
end

function __H:CastTracking()
	if (not track_talent) then return end

	local creatureType = UnitCreatureType("target");
	local trackingID = 0;
	if (creatureType and creature[creatureType]) then
		if (UnitCanAttack("player", "target") and not UnitIsDeadOrGhost("target")) then
			trackingID = tracking[creature[creatureType]] or 0;
		end
	end

	if (trackingID > 0 and self:GetCurTrackingID() ~= trackingID) then
		if (not self:UnitHasIgnoreBuff() and self:CanTracking()) then
			SetTracking(trackingID);
		else
			BigFoot_DelayCall(delayTracking, 1.5, trackingID);	-- GCD
		end
	end
end

function __H:OnSkillChange()
	self:UpdateTrackingID();
end

function __H:OnTalentChange()
	self:UpdateTrackTalent();
end

function __H:PLAYER_REGEN_DISABLED()
	if HunterAssistCasteBarMove:IsVisible() then
		HunterAssistCasteBarMove:Hide();
	end

	orig_tracking_id = self:GetCurTrackingID();
	if (enable_tracking) then
		self:CastTracking();
	end

end

function __H:UnitHasIgnoreBuff()
	local spellName, debuffName;
	local i = 1;
	if (ignor_tracking_buff.player) then
		local buffName = UnitAura("player", i,"HELPFUL");
		while (buffName) do
			for k, v in pairs(ignor_tracking_buff.player) do
				spellName = GetSpellInfo(v);
				if (buffName == spellName) then
					return true;
				end
			end
			i = i +1;
			buffName = UnitAura("player", i,"HELPFUL");
		end
	end
	if (ignor_tracking_buff.target) then
		i = 1;
		debuffName = UnitAura("target", i, "HARMFUL|PLAYER");
		while (debuffName) do
			for k, v in ipairs(ignor_tracking_buff.target) do
				spellName = GetSpellInfo(v);
				if (debuffName == spellName) then
					return true;
				end
			end
			i = i +1;
			debuffName = UnitAura("target", i, "HARMFUL|PLAYER");
		end
	end
	return false;
end

local function HunterAssist_ReTracking()
	if (enable_tracking and track_talent and orig_tracking_id and orig_tracking_id ~= __H:GetCurTrackingID() and not InCombatLockdown()) then
		if (__H:UnitHasIgnoreBuff() or not __H:CanTracking()) then
			BigFoot_DelayCall(HunterAssist_ReTracking, 0.5);
		else
			SetTracking(orig_tracking_id);
		end
		orig_tracking_id = nil;
	end
end

function __H:PLAYER_REGEN_ENABLED()
	__HunterAssistCasteBar_FlashBar();
	HunterAssist_ReTracking();
end

function HunterAssistTracking_Toogle(switch)
	__H:UpdateTrackingID();
	__H:UpdateTrackTalent();
	if (switch) then
		enable_tracking = true;
		__H:RegisterEvent("CHAT_MSG_SKILL", "OnSkillChange");
		__H:RegisterEvent("CHARACTER_POINTS_CHANGED",  "OnTalentChange");
		__H:RegisterEvent("PLAYER_REGEN_DISABLED");
		__H:RegisterEvent("PLAYER_REGEN_ENABLED");
	else
		enable_tracking = false;
		__H:UnregisterEvent("CHAT_MSG_SKILL");
		__H:UnregisterEvent("CHARACTER_POINTS_CHANGED");
	end
end

function HunterAssist_Toggle(__switch)
	HunterAssistBar_Toggle(__switch);
	HunterAssistDaze_Toggle(__switch);
	HunterAssistTracking_Toogle(__switch);
end

function __H:IsBuffActive(name)
	print("check if buff is active")

	local i = 1;
	local buffName = UnitBuff("player", i);
	while (buffName) do
		if (buffName == name) then
			return i;
		end
		i = i + 1;
		buffName = UnitBuff("player", i);
	end
	return false;
end

-------------------
-- 误导提示
-------------------
local misDirect = GetSpellInfo(34477);
local misDirectPlayer;
local enablemisDirect = false;

function __H:Yell(msg)
	SendChatMessage(msg, "yell");
end

function __H:UNIT_SPELLCAST_SENT(unit, spell, _, player)
	if (unit == "player" and spell == misDirect ) then
		misDirectPlayer = player;
	end
end

function __H:UNIT_SPELLCAST_SUCCEEDED(unit, spell)
	if (HunterAssist_Enabled and unit == "player") then
		__HunterAssistCasteBar_Cast(spell);
	end
	if (enablemisDirect) then
		if (unit == "player" and spell == misDirect and IsInInstance()) then
			self:Yell(string.gsub(MISDIRECT_PATTERN, "$player", misDirectPlayer));
		end
	end
end

function HunterAssistMisdirect_Toggle(switch)
	if (switch) then
		__H:RegisterEvent("UNIT_SPELLCAST_SENT");
		__H:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		enablemisDirect = true;
	else
		__H:UnregisterEvent("UNIT_SPELLCAST_SENT");
		enablemisDirect = false;
	end
end

-- ERR_FEIGN_DEATH_RESISTED
-------------------
-- 距离提示
-------------------
distanceSpell = {
	[1] = 2974,		-- 摔绊(5码)
	[2] = 19503,	-- 驱散射击(15码)
	[3] = 2764,		-- 投掷(30码)
	[4] = 75,		-- 自动射击(35码 - 41码)
};
local DISTANCE_MAX_RANGE = 0;
spellDistance = {};

function __H:UpdateDistanceSpell()
	for k, v in ipairs(distanceSpell) do
		local name, _, _, _, _, _, _, _, maxRange = GetSpellInfo(v);
		spellDistance[v] = {maxRange, name};
	end
end

function __H:PLAYER_TARGET_CHANGED()
	self:UpdateDistanceSpell();
end
