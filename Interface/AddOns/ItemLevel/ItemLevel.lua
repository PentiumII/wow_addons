
local SyItemLevel;

if (GetLocale() == "zhCN") then
	SyItemLevel = "装备等级：";
elseif (GetLocale() == "zhTW") then
	SyItemLevel = "裝備等級：";
else
	SyItemLevel = "ItemLevel:";
end

local isInInstance;
local m_Tallnum,m_CurNum;
local targetItemLevelInfo = {[UNKNOWNOBJECT.."-"..GetRealmName()] = {}};

local f = CreateFrame'Frame';

local events = {
	'CHAT_MSG_ADDON',
	'UPDATE_MOUSEOVER_UNIT',
	'PLAYER_ENTERING_WORLD',
}

for _, event in pairs(events) do
	f:RegisterEvent(event);
end

f:SetScript('OnEvent', function(self, event, ...)
	if floor(GetAverageItemLevel()) then
		if event == "UPDATE_MOUSEOVER_UNIT" then
			if UnitExists("mouseover") and UnitIsPlayer("mouseover") and UnitIsFriend("player","mouseover") and UnitName("mouseover") ~= UnitName("player") then
				local target,serverName = UnitName("mouseover")
				target = target.."-"..(serverName or GetRealmName());
				if not targetItemLevelInfo[target] or
				(targetItemLevelInfo[target] and targetItemLevelInfo[target].refresh and targetItemLevelInfo[target].refresh <= GetTime()) then
					targetItemLevelInfo[target] = {};
					m_Tallnum,m_CurNum=GetAverageItemLevel()
					isInInstance = nil;
					if UnitInBattleground("mouseover") then
						isInInstance = true;
					elseif UnitInRaid("mouseover") then
						if IsInLFGDungeon() then
							isInInstance = true;
						else
							SendAddonMessage("MyItemLevel","MyItemLevel@"..floor(m_Tallnum).."@"..floor(m_CurNum),'RAID')
						end
					elseif UnitInParty("mouseover") then
						if IsInLFGDungeon() then
							isInInstance = true;
						else
							SendAddonMessage("MyItemLevel","MyItemLevel@"..floor(m_Tallnum).."@"..floor(m_CurNum),'RAID')
						end
					else
						-- if not serverName then
							SendAddonMessage("MyItemLevel","ShowMeLevel@"..floor(m_Tallnum).."@"..floor(m_CurNum),'WHISPER',target)
						-- end
					end
					if isInInstance then
						SendAddonMessage("MyItemLevel","MyItemLevel@"..floor(m_Tallnum).."@"..floor(m_CurNum),'INSTANCE_CHAT')
					end
				end
			end
		elseif event == "CHAT_MSG_ADDON" then
			local _Prefix,message,channel,sender = ...;
			if _Prefix ~= "MyItemLevel" then return end
			local prefix, Syslevel,Curlevel = strsplit("@", message);
			if message and sender and prefix then
				if prefix == "MyItemLevel" or prefix == "ShowMeLevel" then
					targetItemLevelInfo[sender] = targetItemLevelInfo[sender] or {};
					targetItemLevelInfo[sender].itemLevel = Syslevel;
					targetItemLevelInfo[sender].itemCurlevel =Curlevel
					targetItemLevelInfo[sender].refresh = GetTime() + 600;
					if prefix == "ShowMeLevel" then
						m_Tallnum,m_CurNum=GetAverageItemLevel()
						SendAddonMessage("MyItemLevel","MyItemLevel@"..floor(m_Tallnum).."@"..floor(m_CurNum),'WHISPER',sender)
					end
				end
			end
		elseif (event == "PLAYER_ENTERING_WORLD") then
			RegisterAddonMessagePrefix("MyItemLevel");
			self:UnregisterEvent("PLAYER_ENTERING_WORLD");
		end
	end
end)

local Bhook =true
function ItemLevelShow()
	if not Bhook then return end
	local target,serverName = UnitName("mouseover")
	if target then
		target = target.."-"..(serverName or GetRealmName());
		if targetItemLevelInfo[target] and targetItemLevelInfo[target].itemLevel and targetItemLevelInfo[target].refresh and targetItemLevelInfo[target].refresh > GetTime() then
			if UnitExists("mouseover") and UnitIsPlayer("mouseover") and UnitIsFriend("player","mouseover") and (CanInspect("mouseover")) then
				GameTooltip:AddLine(SyItemLevel..targetItemLevelInfo[target].itemLevel)
			end
		end
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", ItemLevelShow)

function ItemLevel_Tag(arg)
	Bhook =arg
end

-------------------------------------------------------------------------------------------------------------------
local DECIMAL_PLACES = 2
local coefficient = 10 ^ DECIMAL_PLACES
local formatString = '%.' .. DECIMAL_PLACES .. 'f'
local invalidSlots = { [INVSLOT_BODY] = true, [INVSLOT_TABARD] = true, [INVSLOT_RANGED] = true, }
local levelAdjust={ -- 11th item:id field and level adjustment
    ["0"]=0,	["1"]=8,	["373"]=4,	["374"]=8,	["375"]=4,	["376"]=4,
	["377"]=4,	["379"]=4,	["380"]=4,	["445"]=0,	["446"]=4,	["447"]=8,
	["451"]=0,	["452"]=8,	["453"]=0,	["454"]=4,	["455"]=8,	["456"]=0,
	["457"]=8,	["458"]=0,	["459"]=4,	["460"]=8,	["461"]=12,	["462"]=16,
	["465"]=0,	["466"]=4,	["467"]=8,	["468"]=0,	["469"]=4,	["470"]=8,
	["471"]=12,	["472"]=16,	["476"]=0,	["477"]=4,	["478"]=8,	["479"] = 0,
	["480"]=8,	["491"]=0,	["492"]=4,	["493"]=8,	["494"]=0,	["495"]=4,
	["496"]=8,	["497"]=12,	["498"]=16,	["504"]=12,	["505"]=16,	["506"]=20,
	["507"]=24 }

local function calculate (unit, slot, total, count, is2Handed, isRetrieving)
	if ( slot > INVSLOT_LAST_EQUIPPED) then
		if ( not isRetrieving ) then
			return formatString:format(math.floor(total / (is2Handed and count - 1 or count) * coefficient) / coefficient)
		end
		return
	end

	if ( invalidSlots[slot] ) then
		return calculate(unit, slot + 1, total, count, is2Handed, isRetrieving)
	end
	-------------id 是幻化物品的--------------
	-- local id = GetInventoryItemID(unit, slot)
	local ItemLink = GetInventoryItemLink(unit, slot)
	local name,_, level, equipLoc
	if ( ItemLink ) then
		name, _, _, level, _, _, _, _, equipLoc = GetItemInfo(ItemLink)
		local upgrade = ItemLink:match(":(%d+):%d:%d\124h%[")
		if level and upgrade then
			level = level + (levelAdjust[upgrade] or 0)
		end
	end

	if ( isRetrieving or ItemLink and not (level and equipLoc) ) then
		return calculate(unit, slot + 1, total, count, is2Handed, true)
	end

	total = type(level) == "number" and (total + level) or total
	count = count + 1

	if ( slot == INVSLOT_MAINHAND ) then
		is2Handed = not ItemLink and 0 or equipLoc == 'INVTYPE_2HWEAPON' and 1 or equipLoc:find("INVTYPE_RANGED") and 1
	elseif ( slot == INVSLOT_OFFHAND ) then
		is2Handed = is2Handed == 0 and equipLoc == 'INVTYPE_2HWEAPON' or is2Handed == 1 and not ItemLink
	end

	return calculate(unit, slot + 1, total, count, is2Handed)
end

-----------当前装等获取函数----------------------
function UnitAverageItemLevel (unit)
	-- local target,serverName = UnitName(unit)
	-- if serverName then
		-- target = target.."-"..serverName;
	-- end
	-- if targetItemLevelInfo[target] and targetItemLevelInfo[target].itemCurlevel and targetItemLevelInfo[target].refresh and targetItemLevelInfo[target].refresh > GetTime() then
		-- return targetItemLevelInfo[target].itemCurlevel
	-- else
		return calculate(unit, INVSLOT_FIRST_EQUIPPED, 0, 0)
	-- end
end
