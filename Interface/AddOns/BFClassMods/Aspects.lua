
---------------------------
-- AspectBar - 守护动作条
-- Terry@BF
---------------------------

local Addon = LibStub("AceAddon-3.0"):GetAddon("BFClassMod")
if not Addon then return end

local A = Addon:NewModule("AspectBar","AceEvent-3.0","AceHook-3.0","AceTimer-3.0")
if not A then return end
local _

local f =CreateFrame("GameTooltip","newTooltip",UIParent,"GameTooltipTemplate")
f:SetOwner(UIParent,"ANCHOR_NONE");

-----------------
--localization
-----------------
local L = {}
setmetatable(L,Addon.localMt)

if GetLocale()=='zhTW' then
	L["%d+.-次"] = "%d+.-次"
	L["法力宝石"] = "法力寶石"
	L["制造法力宝石"] = "製造法力寶石"
	L["使用法力宝石"] ="使用法力寶石"
	L["邪甲术"] ="魔化護甲"
	L["魔甲术"] ="惡魔護甲"
	L["使用治疗石"] ="使用治療石"
	L["治疗石"] ="魔化治療石"
	L["灵魂石"] ="惡魔靈魂石"
	L["使用灵魂石"] ="使用惡魔靈魂石"

	L["Alt+左键：移动守护动作条"] = "Alt+左鍵：移動守護動作條"
	L["Shift/Alt+左键移动;右键还原设置"] = "Shift/Alt+左鍵移動;右鍵還原設置"

	L["法师护甲"] = "魔甲術"
	L["霜甲术"] = "霜甲術"
	L["熔岩护甲"] = "炎甲術"
	L["奥术光辉"] = "秘法光輝"

	L["召唤餐桌"] = "餐點儀式"
	L["造餐术"] = "召喚餐點"

	L["左键 - "] = "左鍵 - "
	L["中键 - "] = "中键 - "
	L["右键 - "] = "右鍵 - "
	L["传送：埃索达"] = "傳送:艾克索達"
	L["传送：塞拉摩"] = "傳送:塞拉摩"
	L["传送：奥格瑞玛"] = "傳送:奧格瑪"
	L["传送：幽暗城"] = "傳送:幽暗城"
	L["传送：斯通纳德"] = "傳送:斯通納德"
	L["传送：暴风城"] = "傳送:暴風城"
	L["传送：沙塔斯"] = "傳送:撒塔斯"
	L["传送：达拉然"] = "傳送:達拉然"
	L["传送：达纳苏斯"] = "傳送:達納蘇斯"
	L["传送：雷霆崖"] = "傳送:雷霆崖"
	L["传送：铁炉堡"] = "傳送:鐵爐堡"
	L["传送：银月城"] = "傳送:銀月城"
	L["传送：托尔巴拉德"] = "傳送:托巴拉德"
	L["传送：锦绣谷"] = "傳送:锦绣谷"

	L["传送门：埃索达"] = "傳送門:艾克索達"
	L["传送门：塞拉摩"] = "傳送門:塞拉摩"
	L["传送门：奥格瑞玛"] = "傳送門:奧格瑪"
	L["传送门：幽暗城"] = "傳送門:幽暗城"
	L["传送门：斯通纳德"] = "傳送門:斯通納德"
	L["传送门：暴风城"] = "傳送門:暴風城"
	L["传送门：沙塔斯"] = "傳送門:撒塔斯"
	L["传送门：达拉然"] = "傳送門:達拉然"
	L["传送门：达纳苏斯"] = "傳送門:達納蘇斯"
	L["传送门：雷霆崖"] = "傳送門:雷霆崖"
	L["传送门：铁炉堡"] = "傳送門:鐵爐堡"
	L["传送门：银月城"] = "傳送門:銀月城"
	L["传送门：托尔巴拉德"] = "傳送門:托巴拉德"
	L["传送门：锦绣谷"] = "傳送門:锦绣谷"

	L["恶魔变形"] = "惡魔化身"
	L["召唤恶魔卫士"] = "召喚惡魔守衛"
	L["召唤地狱猎犬"] = "召喚惡魔獵犬"
	L["召唤魅魔"] = "召喚魅魔"
	L["召唤虚空行者"] = "召喚虛無行者"
	L["召唤小鬼"] = "召喚小鬼"

	L["制造治疗石"] = "製造治療石"
	L["制造灵魂石"]	= "製造靈魂石"
	L["制造法术石"]	= "製造法術石"
	L["制造火焰石"]	= "製造火焰石"
	L["召唤仪式"] = "召喚儀式"
	L["灵魂仪式"] = "靈魂儀式"

	L["普通召唤宠物"] ="普通召喚寵物"
	L["快速召唤宠物"] ="快速召喚寵物"

	L["潜行"] = "潛行"
	L["暗影之舞"] = "暗影之舞"
	L["上毒主手"] = "上毒主手"
	L["上毒副手"] = "上毒副手"
	L["上毒投掷"] ="上毒投掷"
	L["召唤"] = "召喚"
	L["毒药"] = "毒藥"
	L["药膏"] = "藥膏"
	L["施放技能"] = "施放技能"
	L["展开菜单"] = "展開菜單"
elseif GetLocale()=="enUS" then
	L["%d+.-次"] = "%d+.-Times"
	L["法力宝石"] = "Mana Gem"
	L["Alt+左键：移动守护动作条"] = "Alt+LeftButtton: Moving BFAspect Frame"
	L["法师护甲"] = "Mage Armor"
	L["霜甲术"] = "Frost Armor"
	L["熔岩护甲"] = "Molten Armor"
	L["奥术光辉"] = "Arcane Brilliance"

	L["召唤餐桌"] = "Ritual of Refreshment"
	L["造餐术"] = "Conjure Refreshment"

	L["左键 - "] = "Left Click - "
	L["右键 - "] = "Right Click - "
	L["中键 - "] ="bond Click - ";
	L["传送：埃索达"] = "Teleport: Exodar"
	L["传送：塞拉摩"] = "Teleport: Theramore"
	L["传送：奥格瑞玛"] = "Teleport: Orgrimmar"
	L["传送：幽暗城"] = "Teleport: Undercity"
	L["传送：斯通纳德"] = "Teleport: Stonard"
	L["传送：暴风城"] = "Teleport: Stormwind"
	L["传送：沙塔斯"] = "Teleport: Shattrath"
	L["传送：达拉然"] = "Teleport: Dalaran"
	L["传送：达纳苏斯"] = "Teleport: Darnassus"
	L["传送：雷霆崖"] = "Teleport: Thunder Bluff"
	L["传送：铁炉堡"] = "Teleport: Ironforge"
	L["传送：银月城"] = "Teleport: Silvermoon"

	L["传送门：埃索达"] = "Portal: Exodar"
	L["传送门：塞拉摩"] = "Portal: Theramore"
	L["传送门：奥格瑞玛"] = "Portal: Orgrimmar"
	L["传送门：幽暗城"] = "Portal: Undercity"
	L["传送门：斯通纳德"] = "Portal: Stonard"
	L["传送门：暴风城"] = "Portal: Stormwind"
	L["传送门：沙塔斯"] = "Portal: Shattrath"
	L["传送门：达拉然"] = "Portal: Dalaran"
	L["传送门：达纳苏斯"] = "Portal: Darnassus"
	L["传送门：雷霆崖"] = "Portal: Thunder Bluff"
	L["传送门：铁炉堡"] = "Portal: Ironforge"
	L["传送门：银月城"] = "Portal: Silvermoon"

	L["恶魔变形"] = "Metamorphosis"
	L["召唤恶魔卫士"] = "Summon Felguard"
	L["召唤地狱猎犬"] = "Summon Felhunter"
	L["召唤魅魔"] = "Summon Succubus"
	L["召唤虚空行者"] = "Summon Voidwalker"
	L["召唤小鬼"] = "Summon Imp"

	L["制造治疗石"] = "Create Healthstone"
	L["制造灵魂石"]	= "Create Soulstone"
	L["制造法术石"]	= ""
	L["制造火焰石"]	= ""
	L["召唤仪式"] = "Ritual of Summoning"
	L["灵魂仪式"] = "Ritual of Souls"

	L["普通召唤宠物"] ="Normal Summon"
	L["快速召唤宠物"] ="Fast Summon"

	L["潜行"] = "Stealth"
	L["暗影之舞"] = "Shadow Dance"
	L["上毒主手"] = "Coat Mainhand"
	L["上毒副手"] = "Coat Offhand"
	L["召唤"] ="Summon "
	L["毒药"] = "Poison"
	L["药膏"] = "Poison"
	L["施放技能"] = "Cast Spell"
	L["展开菜单"] = "Expand Menu"

end

-- local references for ShapeShiftBarFrame
local ssbFrame,class,level
local debugFlag= false
local printOrg = print
local function print(...)
	if debugFlag then
		printOrg(...)
	end
end

-- all the spells, items and macros that will be used
--[[
	table rules
	t: type (s = spell,m = macro, e = expand, i = item) required
	s: spell name
	m: macro text
	d: dependency (spell id or name), default to equal n
	i: item id list or item id
	f: tooltip, if not ,default to use spell in s
]]

local aspectSpellList = {
	["MAGE"] = {
		{t = "e",
			{t = "s"	,		s=L["传送门：奥格瑞玛"]},
			{t = "s"	, 		s=L["传送门：幽暗城"]},
			{t = "s"	,		s=L["传送门：雷霆崖"]},
			{t = "s"	, 		s=L["传送门：银月城"]},
			{t = "s"	,		s=L["传送门：斯通纳德"]},
			{t = "s"	, 		s=L["传送门：暴风城"]},
			{t = "s"	, 		s=L["传送门：铁炉堡"]},
			{t = "s"	,	 	s=L["传送门：达纳苏斯"]},
			{t = "s"	, 		s=L["传送门：埃索达"]},
			{t = "s"	,		s=L["传送门：塞拉摩"]},
			{t = "s"	, 		s=L["传送门：沙塔斯"]},
			{t = "s"	,		s=L["传送门：达拉然"]},
			{t = "s"	, 		s=L["传送门：托尔巴拉德"], sId =88345},
			{t = "s"	, 		s=L["传送门：托尔巴拉德"], sId =88346},
			{t = "s"	,		s=L["传送门：锦绣谷"]},

		},

		{t = "e",
			{t = "s"	,		s=L["传送：奥格瑞玛"]},
			{t = "s"	, 		s=L["传送：幽暗城"]},
			{t = "s"	,		s=L["传送：雷霆崖"]},
			{t = "s"	, 		s=L["传送：银月城"]},
			{t = "s"	,		s=L["传送：斯通纳德"]},
			{t = "s"	, 		s=L["传送：暴风城"]},
			{t = "s"	, 		s=L["传送：铁炉堡"]	},
			{t = "s"	,	 	s=L["传送：达纳苏斯"]},
			{t = "s"	, 		s=L["传送：埃索达"]},
			{t = "s"	,		s=L["传送：塞拉摩"]},
			{t = "s"	, 		s=L["传送：沙塔斯"]},
			{t = "s"	,		s=L["传送：达拉然"]},
			{t = "s"	, 		s=L["传送：托尔巴拉德"], sId =88342},
			{t = "s"	, 		s=L["传送：托尔巴拉德"], sId =88344},
			{t = "s"	,		s=L["传送：锦绣谷"]},

		},

		{t = "m",
			m = "/cast [button:1] "..L["造餐术"].." \n/cast [button:2] "..L["召唤餐桌"],
			s = L["造餐术"],
			f = {L["左键 - "]..L["造餐术"],L["右键 - "]..L["召唤餐桌"]}
		},

		{t = "s",
			s = L["奥术光辉"]
		},

		{t = "e",
			{t = "s"	,		s = L["熔岩护甲"]},
			{t = "s"	,		s = L["霜甲术"]},
			{t = "s"	,		s = L["法师护甲"]},

		},

		{t = "m",
			m = "/use [button:1] "..L["法力宝石"].." \n/cast [button:2] "..L["制造法力宝石"],
			s = L["制造法力宝石"],
			i = 36799,
			f = {L["左键 - "]..L["使用法力宝石"],L["右键 - "]..L["制造法力宝石"]},
			cd = 5512
		},

	},

	["WARLOCK"] = {
		{t = "s",
			s = L["召唤仪式"]
		},

		{t = "s",
			s = L["灵魂仪式"]
		},

		{t = "e",
			{t = "s"	, 		s=L["召唤小鬼"]},
			{t = "s"	, 		s=L["召唤虚空行者"]},
			{t = "s"	, 		s=L["召唤魅魔"]},
			{t = "s"	, 		s=L["召唤地狱猎犬"]},
			{t = "s"	, 		s=L["召唤地狱火"]},
			{t = "s"	, 		s=L["召唤末日守卫"]},
			{t = "s"	, 		s=L["召唤恶魔卫士"]},
		},

		{t = "e",
			{t = "s"	, 		s=L["魔甲术"]},
			{t = "s"	, 		s=L["邪甲术"]},
		},

		{t = "m",
			m = "/use [button:1] "..L["灵魂石"].." \n/cast [button:2] "..L["制造灵魂石"],
			s = L["制造灵魂石"],
			i=5232,
			f = {L["左键 - "]..L["使用灵魂石"],L["右键 - "]..L["制造灵魂石"]},
			cd = 5512
		},

		{t = "m",
			m = "/use [button:1] "..L["治疗石"].." \n/cast [button:2] "..L["制造治疗石"],
			s = L["制造治疗石"],
			i=5512,
			f={L["左键 - "]..L["使用治疗石"],L["右键 - "]..L["制造治疗石"]},
			cd = 5512
		},

	},

}

-- table for character learned spells list
local aspectSpells = {}
local subSpellTable = {}

-- table for aspect buttons
local aspectButtons = {}
local __ItemTooltip

----------------------
-- spell functions
----------------------

local function _GetItemInfo(__bagId, __slotId)
	local __link = GetContainerItemLink(__bagId, __slotId);					--得到包裹中的物品链接
	if (__link) then
		return GetItemInfo(GetContainerItemLink(__bagId, __slotId));		--得到物品的详细信息(名称，链接，品质，物品等级，需要等级，类型，类型子类，可堆叠数量，装备位置，物品图标，[出售单件])
	end
end

local function __GetManaGemCount(Itemname)
	local __itemName, __texture, __price, __quality, __count,__link;
	local bagid,number;
	local itemUseNumber =0;
	for __bagId = 0, NUM_BAG_FRAMES, 1 do
		local __numSlots = GetContainerNumSlots(__bagId);		--得到当前循环包的容量
		if (__numSlots and __numSlots > 0) then
			for __slotId =__numSlots, 1, -1 do
				__itemName = _GetItemInfo(__bagId, __slotId);		--得到每格物品的详细信息
				if (__itemName and __itemName == Itemname) then
					bagid = __bagId;
					number = __slotId;
					break
				end
			end
		end
		if bagid and number then break end
	end
	if bagid and number then
		f:ClearLines();
		f:SetBagItem(bagid,number);
		local lineText;
		for i=1, f:NumLines() do
			lineText = _G[f:GetName().."TextLeft" .. i]:GetText();
			if string.find(lineText,L["%d+.-次"]) then
				string.gsub(lineText,"(%d+).-",function(number) itemUseNumber = number end)
			end
		end
	end
	return tonumber(itemUseNumber);
end

local function __GetItemCount(item)
	local count;
	---对法力宝石的特别处理
	if item == 36799 then
		count = __GetManaGemCount(L["法力宝石"]);
	else
		count = GetItemCount(item)
	end
	return count
end

local F=CreateFrame("Frame");
F.updataTab ={}

F:SetScript("OnUpdate", function()
	for k, v in pairs(F.updataTab) do
		if v and v.m_time then
			if v.m_time>0 then
				if GetTime()-v.m_time > 1 then
					k:SetText(__GetItemCount(v.item));
					v.m_time =-1;
				end
			end
		end
	end
end)

--check whether the player knows spell, passed by name or ID
local function __IsSpellLearned(spell)
	if not spell then return end
	-- print("Checking if "..spell .." is learned ...")
	if type(spell) =='number' then
		return IsSpellKnown(spell)
	end
	if not GetSpellInfo(spell) then return end
	local currentSpell,numTabs,offset,numSpells;
	numTabs = GetNumSpellTabs()
	_,_,offset,numSpells = GetSpellTabInfo(numTabs)
	for i = 1, offset+numSpells do
		currentSpell = GetSpellInfo(i, BOOKTYPE_SPELL)
		if (spell == currentSpell) then
			return i
		end
		i = i + 1
	end
	return;
end

--check if the dependency is meet
local function __IsRequireMeet(dependent)
	assert(dependent,"Dependent can not be nil")
	-- print(dependent)
	return __IsSpellLearned(dependent)
end

--return a list of items that the player can use.
local function __GetAvailableItems(item)
	local t = {}
	local lvlReq;
	if type(item)=='table' then
		for _,_item in ipairs(item) do
			lvlReq = select(5,GetItemInfo(_item))
			if lvlReq and level and lvlReq  <= level then
				tinsert(t,_item)
			end
		end
	else
		lvlReq = select(5,GetItemInfo(item))
		if lvlReq and level and lvlReq  <= level then
			tinsert(t,item)
		end
	end
	return t
end

--fill in aspectSpells with macros, spells and items that player knows
local function __GetLearnedSpells()
	print("Update aspect spell table for class: "..class)
	aspectSpells = {}
	local aspectTable = aspectSpellList[class]
	if not aspectTable then return end
	local dependent ,itemList,skillList,subdependent
	for _,_spellTable in ipairs(aspectTable) do
		dependent = _spellTable.sId or _spellTable.s
		if dependent then
			if __IsRequireMeet(dependent) then
				tinsert(aspectSpells,_spellTable)
			end
		elseif _spellTable.i then
			itemList = __GetAvailableItems(_spellTable.i)
			if #itemList > 0 then
				_spellTable.items = itemList
				tinsert(aspectSpells,_spellTable)
			end
		-- if the node is a collection of spells
		elseif _spellTable.t =='e' then
			subSpellTable = {}
			subSpellTable.t='e'
			for _,_subSpell in ipairs(_spellTable) do
				subdependent = _subSpell.sId or _subSpell.s
				if subdependent then
					if __IsRequireMeet(subdependent) then
						tinsert(subSpellTable,_subSpell)
					end
				elseif _subSpell.i then
					itemList = __GetAvailableItems(_subSpell.i)
					if #itemList > 0 then
						_subSpell.items = itemList
						tinsert(subSpellTable,_subSpell)
					end
				end
			end
			if #subSpellTable >0 then
				tinsert(aspectSpells,subSpellTable)
			end
		end
	end

	--[[	排除某些物品 比如 盗贼不想显示低等级毒药 但是现在没有必要了 因为统一了
	local exclude,spell
	local i = 1
	while aspectSpells[i] do
		exclude = aspectSpells[i].e
		if exclude then
			for j = 1, #aspectSpells do
				spell = aspectSpells[j]
				if spell.s == exclude then
					tremove(aspectSpells,i)
					i = i - 1
					break;
				end
			end
		end
		i = i + 1
	end
	]]
end

--check which buff is active
local function __IsBuffActive(name)
	if not name then return end
	-- print("check if buff: "..name.."is active.")

	local i = 1
	local buffName = UnitBuff("player", i)
	while (buffName) do
		if (buffName == name) then
			return i
		end
		i = i + 1
		buffName = UnitBuff("player", i)
	end
	return false
end

--check if pet is active
local function __IsPetActive(spellName)
	local creatureName = spellName:gsub(L["召唤"],"")
	local petName = UnitCreatureFamily("pet")
	if petName and petName:match(creatureName) then return true end
end

--get the spell texture
local function __GetSpellTexture(spell,t)
	assert(type(spell)=='number' or type(spell)=='string', "Must use spell ID or name")
	if t and t=='item' then
		return select(10,GetItemInfo(spell))
	end
	return select(3,GetSpellInfo(spell))
end

--get the spell cooldown
local function __GetSpellCooldown(spell,t)
	assert(type(spell)=='number' or type(spell)=='string', "Must use spell ID or name")
	if t and t=='item' then
		return nil
	end
	return GetSpellCooldown(spell)
end

--get the highest lvl item
local function __GetHighestItem(itemList)
	assert(#itemList>0,"ItemList need to have at least one item")
	local count
	for _,_item in ipairs(itemList) do
		count = __GetItemCount(_item)
		if  count > 0 then return _item,count end
	end
	return itemList[1],0
end

--get poison base info
local function __GetPoisonBase(ench)
	local enchName = ench:match("^([^ ]+) ?[IVX]*$")
	local poisonName =enchName:gsub(L["药膏"],L["毒药"])
	return poisonName,enchName
end

--check if certain weapon has enchant
local function __WeaponHasEnch(slot,ench)
	__ItemTooltip:SetInventoryItem("player", slot)
	for i = 1,__ItemTooltip:NumLines() do
		local text = _G[__ItemTooltip:GetName().."TextLeft"..i]:GetText()
		local enchBase,poisonBase = __GetPoisonBase(ench)
		if text:match(enchBase) then return true end
		if text:match(poisonBase) then return true end
	end
end

------------------
--Button functions
------------------
-- while item attribute changes, get the item count and display new count
local function __OnItemAttrChange(button,name,val)
	assert(button,"Button does not exist!")
	assert(name,"Attribute name does not exist!")

	if name == "item" then
		local m_time = GetTime()
		local item = val
		if item and button.count then
			-- button.count:SetText(__GetItemCount(item))
			-- print(button.count)
			if not F.updataTab[button.count] then
				F.updataTab[button.count]={}
			end
			if F.updataTab[button.count].m_time then
				if m_time - F.updataTab[button.count].m_time >1 then
					F.updataTab[button.count].m_time = m_time;
				end
			else
				F.updataTab[button.count].m_time = m_time;
			end
			F.updataTab[button.count].item = item;
		end
	end

end

--set gametooltip here
local function __OnButtonEnter(self)
	if not self.spellTable then return end
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	end
	if not self.spellTable.ignoreSpell then
		if self:GetAttribute("spell") then
			GameTooltip:AddLine(self:GetAttribute("tooltip"));
		elseif self:GetAttribute("item") then
			GameTooltip:AddLine(self:GetAttribute("item"))
		end
	end
	if self.subList then
		GameTooltip:AddLine(L["左键 - "]..L["施放技能"])
		GameTooltip:AddLine(L["右键 - "]..L["展开菜单"])
	end
	if self.spellTable.f then
		for _,_line in ipairs(self.spellTable.f) do
			GameTooltip:AddLine(_line)
		end
	end
	GameTooltip:Show()
end

local function __SaveChoseMod(Frame)
	local parent = Frame:GetParent()
	local m_parentnumber;
	local m_ChildNumber;
	local parentName = parent:GetName();
	local ChildName = Frame:GetName()
	_,_,m_ChildNumber =string.find(ChildName,".+(%d+)")
	_,_,m_parentnumber =string.find(parentName,".-(%d+)")
	m_parentnumber = tonumber(m_parentnumber)
	m_ChildNumber = tonumber(m_ChildNumber)
	if not BFClassMod_Config then
		BFClassMod_Config ={}
	end
	if not BFClassMod_Config["AspectButtonSet"] then
		BFClassMod_Config["AspectButtonSet"] ={}
	end
	BFClassMod_Config["AspectButtonSet"][m_parentnumber] = m_ChildNumber
end

-- create sub buttons
local function __CreateSubButton(parentButton,i)
	-- if _G[parentButton:GetName() .."Sub".. i] then return _G[parentButton:GetName() .."Sub".. i] end
	local __button = CreateFrame("CheckButton", parentButton:GetName() .."Sub".. i, parentButton, "SecureActionButtonTemplate, ActionButtonTemplate,SecureHandlerAttributeTemplate,SecureHandlerEnterLeaveTemplate")
	__button:SetHeight(30)
	__button:SetWidth(30)
	__button:RegisterForClicks("AnyUp")
	__button:SetNormalTexture(nil)
	__button:SetPushedTexture(nil)
	__button:SetScript("OnAttributeChanged",__OnItemAttrChange)

	__button:SetFrameLevel(parentButton:GetFrameLevel())
	__button.cooldown = _G[__button:GetName().."Cooldown"]
	__button.icon = _G[__button:GetName().."Icon"]
	__button.count = _G[__button:GetName().."Count"]
	__button:Hide()
	__button:HookScript("PostClick",function(self) __SaveChoseMod(self) self:SetChecked(0) end)
	__button.OnEnterFrame = __OnButtonEnter
	__button.OnLeaveFrame = function()GameTooltip:Hide() end
	__button:SetScript("PreClick",function(self)
		self:GetParent().icon:SetTexture(self.icon:GetTexture())
	end)
	__button:SetAttribute("_onenter",[[
		control:CallMethod("OnEnterFrame",self)
	]])
	__button:SetAttribute("_onleave",
	[[
		control:CallMethod("OnLeaveFrame",self)
		local parent =  self:GetParent()
		if not self:GetParent():IsUnderMouse(true) then
--			print("hide")
			local t = table.new()
			parent:GetChildList(t)
			for _i,_child in ipairs(t) do
				if _child:IsProtected() then
					_child:Hide()
				end
			end
			self:GetParent():SetAttribute("childrenshown","0")
		end

	]])
	__button:SetAttribute("_childupdate",[[
		if message =="show" then
			self:Show()
		else
			self:Hide()
		end

	]])
	parentButton:WrapScript(__button,"PostClick",
	[[
		local parent = self:GetParent()
		control:ChildUpdate(nil,"hide")
		parent:SetAttribute("childrenshown","0")
		parent:SetAttribute("type",self:GetAttribute("type"))
		parent:SetAttribute("type1",self:GetAttribute("type1"))
		parent:SetAttribute("item",self:GetAttribute("item"))
		parent:SetAttribute("spell",self:GetAttribute("spell"))
		parent:SetAttribute("tooltip",self:GetAttribute("tooltip"))
		parent:SetAttribute("macrotext",self:GetAttribute("macrotext"))
	]])
	return __button
end

-- setup sub button, including attribute and positions
local function __SetSubButton(subButton,button, index)
	subButton:SetPoint("BOTTOM",button,"TOP",0,30* (index -1))
end

-- set up button attribute using spell table
local function __SetButton(__frame,spell,BChild,m_Set)
	assert(type(spell)=='table',"Spell need to be a table")
	assert(spell.t,"Need to specify a type for spell")
	-- save the spell table here for bakup use
	__frame.spellTable = spell
	local texture
	__frame:SetAttribute("iscollect","0")
	if spell.t == 'm' then
		__frame.spell = spell.sId or spell.s
		texture = __GetSpellTexture(__frame.spell)

		__frame:SetAttribute("type","macro")
		__frame:SetAttribute("macrotext",spell.m)
		if spell.sId or spell.s then
			__frame:SetAttribute("spell",spell.sId or spell.s)
		end
		if spell.i then
			__frame:SetAttribute("item",spell.i)
		end
	elseif spell.t == 'i' then
		local item = __GetHighestItem(spell.items)
		local itemName = GetItemInfo(item)
		texture = __GetSpellTexture(item,"item")

		__frame:SetAttribute("type","item")
		__frame:SetAttribute("item", itemName);
		__frame:SetAttribute("target-slot1", 16);
		__frame:SetAttribute("target-slot2", 17);
		__frame:SetAttribute("ctrl-target-slot1", 18);

	elseif spell.t == 's' then
		if BChild then
			__frame:SetAttribute("type1","spell")
		else
			__frame:SetAttribute("type","spell")
		end

		__frame:SetAttribute("spell",spell.sId or spell.s)
		__frame:SetAttribute("tooltip",spell.s)
		texture = __GetSpellTexture(spell.sId or spell.s)
		if spell.i then
			__frame:SetAttribute("item",spell.i)
		end
	elseif spell.t == 'e' then
		assert(#spell >0,"Spell List can not be of size 0")
		-- if the button never set, set to init value
		if not(__frame:GetAttribute("spell") or __frame:GetAttribute("item") )then
			if not m_Set then m_Set =1 end
			__SetButton(__frame,spell[m_Set],true)
		end
		__frame:SetAttribute("iscollect","1")
		__frame.subList = __frame.subList or {}
		for _i,_spell in ipairs(spell) do
			if not __frame.subList[_i] then
				__frame.subList[_i] = __CreateSubButton(__frame,_i)
				__SetSubButton(__frame.subList[_i],__frame,_i)
				__SetButton(__frame.subList[_i],_spell,true)
			end
		end

		-- show and hide logics
	else
		error("Undefined spell type:" .. spell.t)
	end
	if texture then
		__frame.icon:SetTexture(texture)
	end
end

-- get button cooldown
local function __GetButtonCooldown(id)
	assert(type(id)=='number',"Button id need to be number")
	local button =aspectButtons[id]
	local buttonType = button and button:GetAttribute("type1") or button:GetAttribute("type")
	local spell,sType
	if buttonType =="spell" then
		spell = button:GetAttribute("spell")
	elseif buttonType == "item" then
		spell = button:GetAttribute("item")
		sType = "item"
	elseif buttonType == "macro" then
		spell = button.spell
	end
	if button.spellTable and button.spellTable.cd then
		spell = button.spellTable.cd
	end
	return __GetSpellCooldown(spell,sType)
end

--get button active
local function __GetButtonActive(id)
	assert(type(id)=='number',"Button id need to be number")
	local button =aspectButtons[id]
	local buttonType = button:GetAttribute("type1") or button:GetAttribute("type")
	if buttonType =='item' then
		local hasMainEnch,_,_,hasOffEnch,_,_,throwingEnch = GetWeaponEnchantInfo()
		if not hasMainEnch and not hasOffEnch  and not throwingEnch then return false end
		return __WeaponHasEnch(16,button:GetAttribute("item")) or __WeaponHasEnch(17,button:GetAttribute("item")) or __WeaponHasEnch(18,button:GetAttribute("item"))
	elseif buttonType =='spell' then
		return __IsBuffActive(button:GetAttribute("spell"))
	elseif buttonType == 'macro' then
		return __IsBuffActive(button:GetAttribute("spell")) or __IsPetActive(button:GetAttribute("spell"))
	end
end

local function __GetButtonCount(button)
	local item,count = button:GetAttribute("item")
	if item then
		count = __GetItemCount(item)
		return count
	end
end

--set button count
local function __SetButtonCount(button)
	local count = __GetButtonCount(button)
	if not count then return end
	if count > 0 then
		button.count:SetText(count)
	else
		__SetButton(button,button.spellTable)
	end
end

local function __SetAspectButtonCount(id)
	assert(type(id)=='number',"Button id need to be number")
	local button =aspectButtons[id]
	if not button then return end
	__SetButtonCount(button)
	if button.subList and #button.subList > 0 then
		for i = 1, #button.subList do
			__SetButtonCount(button.subList[i])
		end
	end
end

----------------------
-- AspectBar functions
----------------------
local function __GetPoint(frame)
	local point,ref,refPoint,x,y = frame:GetPoint()
	ref = ref and ref:GetName() or "UIParent"
	return point,ref,refPoint,x,y
end

local function __SetPoint(frame,loc)
	BFSecureCall(ssbFrame.ClearAllPoints,ssbFrame)
	local point, ref, refPoint ,x ,y = unpack(loc)
	ref = _G[ref] or UIParent
	BFSecureCall(ssbFrame.SetPoint,ssbFrame,point, ref, refPoint ,x ,y)

end

-- return the aspect button by id
local function __GetAspectButton(i)
	return aspectButtons[i]
end

-- update aspect buttons active status
local function __UpdateAspectButtonsActive()
	print("Update Current Active Button.")
	local isActive
	local numForms = A:GetNumShapeshiftForms()
	for i=1, numForms do
		isActive = __GetButtonActive(i)
		if isActive then
			aspectButtons[i].active = true
			aspectButtons[i]:SetChecked(1)
		else
			aspectButtons[i].active = false
			aspectButtons[i]:SetChecked(0)
		end

	end
end

-- update aspect buttons cooldown
local function __UpdateAspectButtonsCooldown()
	print("Aspect cooldown update")
	local numForms = A:GetNumShapeshiftForms()
	local start, duration, enable, cooldown
	for i=1, numForms do
		cooldown = aspectButtons[i] and aspectButtons[i].cooldown
		start, duration, enable = __GetButtonCooldown(i)
		if (cooldown and start and duration) then
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
		end
	end
end

-- update button spells
local function __UpdateAspectButtonsSpell()
	print("Update Aspect Buttons")
	local numForms = A:GetNumShapeshiftForms()
	local button, icon,m_Set
	UIParent_ManageFramePositions();
	for i=1, numForms do
		button = __GetAspectButton(i)
		icon = button.icon;
		if BFClassMod_Config and BFClassMod_Config["AspectButtonSet"] then
			m_Set = BFClassMod_Config["AspectButtonSet"][i]
		end
		__SetButton(button,aspectSpells[i],nil,m_Set)
		if button:GetAttribute("item") then
			button.count:Show()
		else
			button.count:Hide()
		end
		button:SetNormalTexture(nil)
		button:Show()
	end
end

--update button count
local function __UpdateAspectButtonsCount()
	local numForms = A:GetNumShapeshiftForms()
	local button
	for i=1, numForms do
		button = __GetAspectButton(i)
		__SetAspectButtonCount(i)

	end
end

--create the aspect frame
local function __CreateAspectFrame()
	BFClassMod_Config = BFClassMod_Config or {}
	local frame = CreateFrame("Frame","BFAspectFrame",UIParent)
	local dragFrame = CreateFrame("Button","BFAspectFrameDragButton",frame)
	frame:SetMovable(true)
	frame:SetClampedToScreen(true)
	dragFrame:SetClampedToScreen(true)
	dragFrame:SetWidth(11)
	dragFrame:SetHeight(32)
	dragFrame:SetPoint("RIGHT",frame,"LEFT")
	dragFrame:CreateTexture("BFAspectFrameDragButtonTexture","BACKGROUND")
	BFAspectFrameDragButtonTexture:SetAllPoints(dragFrame);
	BFAspectFrameDragButtonTexture:SetTexture([[Interface\Addons\BFClassMods\Media\Tab]])
	BFAspectFrameDragButtonTexture:SetTexCoord(0.2,0.9,0.8,0.9,0.2,0.1,0.8,0.1);
	BFAspectFrameDragButtonTexture:SetAlpha(0.4)
	dragFrame:SetHighlightTexture([[Interface\Addons\BFClassMods\Media\TabHighlight]],"ADD")
	local _,dragFrameHighlight = dragFrame:GetRegions()
	dragFrameHighlight:SetTexCoord(0.2,0.9,0.8,0.9,0.2,0.1,0.8,0.1);
	dragFrameHighlight:SetAlpha(0.4)
	dragFrame:SetScript("OnMouseDown",function(frame, button)
		frame.isMoving = true;
		frame:GetParent():StartMoving();
	end)
	dragFrame:SetScript("OnMouseUp",function(frame, button)
		if ( frame.isMoving ) then
            frame:GetParent():StopMovingOrSizing();
            frame.isMoving = false;
			BFClassMod_Config.framePos = {__GetPoint(frame:GetParent())}
        end
	end)
	frame:SetWidth(1)
	frame:SetHeight(32)
	frame:Hide()
	return frame
end

-- create the aspect bar
local function __CreateAspectButtons()
	if not ssbFrame then return end
	ssbFrame:Hide()
	local num = A:GetNumShapeshiftForms()
	ssbFrame:SetWidth(32*num)
	local __frame,refFrame
	for i=1,num do
		__frame = CreateFrame("CheckButton", "BFAspectButton" .. i, ssbFrame, "SecureActionButtonTemplate, ActionButtonTemplate,SecureHandlerAttributeTemplate,SecureHandlerEnterLeaveTemplate")
		__frame:SetHeight(30)
		__frame:SetWidth(30)
		__frame:RegisterForClicks("AnyUp")
		if not refFrame then
			__frame:SetPoint("RIGHT",ssbFrame,"RIGHT",-2,0)
		else
			__frame:SetPoint("RIGHT",refFrame,"LEFT",-2,0)
		end
		refFrame = __frame
		__frame:SetNormalTexture(nil)
		__frame:SetScript("OnAttributeChanged",__OnItemAttrChange);
		__frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		__frame:SetScript("OnEvent",function(self,event,...) if (self:GetAttribute("item")) then __OnItemAttrChange(self,"item",self:GetAttribute("item")) end end)
		__frame:SetFrameLevel(5)
		__frame.cooldown = _G[__frame:GetName().."Cooldown"]
		__frame.icon = _G[__frame:GetName().."Icon"]
		__frame.count = _G[__frame:GetName().."Count"]
		tinsert(aspectButtons,__frame)
		__frame:Show()
		__frame.SetButtonCheck = function(self) self:SetChecked(self.active) end
		__frame.OnEnterFrame = __OnButtonEnter
		__frame.OnLeaveFrame =function()
			GameTooltip:Hide()
		end
		__frame:SetAttribute("childrenshown","0")


		__frame:WrapScript(__frame,"PreClick",[[
			if self:GetAttribute("iscollect")=="0" then
			else
				if button=="RightButton" then
					if self:GetAttribute("childrenshown")=="0" then
						control:ChildUpdate(nil,"show")
						self:SetAttribute("childrenshown","1")
					elseif self:GetAttribute("childrenshown")=="1" then
						control:ChildUpdate(nil,"hide")
						self:SetAttribute("childrenshown","0")
					end
				end
			end

			control:CallMethod("SetButtonCheck",self)
		]])
		__frame:SetAttribute("_onenter",[[
			control:CallMethod("OnEnterFrame",self)
		]])
		__frame:SetAttribute("_onleave",[[
			control:CallMethod("OnLeaveFrame")
			if not self:IsUnderMouse(true) then
				control:ChildUpdate(nil,"hide")
				self:SetAttribute("childrenshown","0")
			end
		]])
	end

	ssbFrame:SetScript("OnShow",function()
		BFSecureCall("UIParent_ManageFramePositions")
	end)
	ssbFrame:SetScript("OnHide",function()
		BFSecureCall("UIParent_ManageFramePositions")
	end)

	__UpdateAspectButtonsCount()
	ssbFrame:Show()
	print("Create Aspect Bar")
end

--destory bar
local function __DestoryBar()
	ssbFrame:Hide()
	local num = A:GetNumShapeshiftForms()
	for i=1, num do
		_G["BFAspectButton"..i]:Hide()
	end
end

------------------
-- hook functions
------------------
--find out how many aspect buttons to use
function A:GetNumShapeshiftForms()
	return #aspectSpells or 0
end

-- move pet action bar position
function A:UIParent_ManageFramePositions()
	print("UIParent_ManageFramePositions")
	BFSecureCall(ssbFrame.ClearAllPoints,ssbFrame)
	if BFClassMod_Config and BFClassMod_Config.framePos then
		__SetPoint(ssbFrame,BFClassMod_Config.framePos)
		BFSecureCall(ssbFrame.Show,ssbFrame)
		return
	end
	if SHOW_MULTI_ACTIONBAR_2 then
		if MultiBarBottomRightButton11:GetLeft()<1150 then
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton10,"TOPRIGHT",0,7)
		else
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton11,"TOPRIGHT",0,7)
		end
	else
		if MultiBarBottomRightButton11:GetLeft()<1150 then
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton10,"BOTTOMRIGHT",0,0)
		else
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton11,"BOTTOMRIGHT",0,0)
		end
	end
	BFSecureCall(ssbFrame.Show,ssbFrame)
end

-- hook get shapeshift form function
function A:GetShapeshiftFormInfo(i)
	print("Get shapeshift form info: "..i)
	return aspectButtons[i].icon:GetTexture(),
		aspectButtons[i]:GetAttribute("spell") or aspectButtons[i]:GetAttribute("item"),
		aspectButtons[i].active,
		true
end

-----------
--- event functions
-----------
function A:UNIT_AURA(event,unit)
	print("Unit Aura Updated")

	if (unit == "player") then
		self:ScheduleTimer(__UpdateAspectButtonsActive,0.3)
	end
end

function A:PLAYER_LEVEL_UP()
	print("Learned a new spell")

	__GetLearnedSpells()
	__CreateAspectButtons()
	__UpdateAspectButtonsSpell()
	__UpdateAspectButtonsActive()
	__UpdateAspectButtonsCooldown()
end

function A:ACTIONBAR_UPDATE_COOLDOWN()
	-- print("update action cooldown")
	__UpdateAspectButtonsCooldown()
end

function A:BAG_UPDATE()
	__UpdateAspectButtonsCount()
	__UpdateAspectButtonsActive()
end

function A:PET_DISMISS_START()
	__UpdateAspectButtonsActive()
end

--------------
--control
--------------
function A:OnInitialize()
	class = select(2,UnitClass("player"))
	level = UnitLevel("player")
	ssbFrame = __CreateAspectFrame()
	__ItemTooltip = CreateFrame( "GameTooltip", "BFAspectScanTooltip", UIParent,"GameTooltipTemplate");
	__ItemTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
	self:SetEnabledState(false)
	__GetLearnedSpells()
	print("Init BFAspects")
end

function A:OnEnable()
	self:SecureHook("UIParent_ManageFramePositions")

	__GetLearnedSpells()
	__CreateAspectButtons()
	__UpdateAspectButtonsSpell()
	__UpdateAspectButtonsActive()
	__UpdateAspectButtonsCooldown()

	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("PET_DISMISS_START")

	print("BFAspects Enabled")
end

function A:OnDisable()
	self:UnhookAll()
	__DestoryBar()
	BFSecureCall("UIParent_ManageFramePositions")
	print("BFAspects Disabled")
end

-- --还原配置
-- function BF_ResetFrame(frame)
	-- local frameName = frame:GetName()
	-- if BFClassMod_Config and BFClassMod_Config[frameName.."Default"] then
		-- local point, ref, refPoint ,x ,y = unpack(BFClassMod_Config[frameName.."Default"])
		-- frame:ClearAllPoints();
		-- frame:SetPoint(point,ref,refPoint,x,y)
		-- BFClassMod_Config[frameName] = {__GetPoint(frame)}
	-- end
-- end

-- --移动特殊框体的设置相关
-- function BF_MoveFrame(frame)

	-- local frameName = frame:GetName()
	-- if BFClassMod_Config and not BFClassMod_Config[frameName.."Default"] then
		-- BFClassMod_Config[frameName.."Default"] = {__GetPoint(frame)}
	-- end
	-- local dragFrame = CreateFrame("Button","ClassFrameDragButton",frame)
	-- frame:SetMovable(true)
	-- frame:SetClampedToScreen(true)
	-- dragFrame:SetClampedToScreen(true)
	-- dragFrame:SetWidth(20)
	-- dragFrame:SetHeight(20)
	-- dragFrame:SetPoint("CENTER",frame,"LEFT")
	-- --dragFrame:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]],"ADD")
	-- local texture = dragFrame:CreateTexture();
	-- texture:SetTexture([[Interface\Buttons\UI-Common-MouseHilight]]);
	-- texture:SetBlendMode("ADD");
	-- dragFrame:SetNormalTexture(texture);
	-- texture:SetAllPoints(dragFrame);
	-- dragFrame:SetAlpha(0);
	-- frame:SetScript("OnEnter",function(frame)
		-- dragFrame:SetAlpha(1);
	-- end)
	-- frame:SetScript("OnLeave",function(frame)
		-- dragFrame:SetAlpha(0);
	-- end)
	-- dragFrame:SetScript("OnEnter",function(frame)
		-- dragFrame:SetAlpha(1);
		-- GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT");
		-- GameTooltip:SetText(L["Shift/Alt+左键移动;右键还原设置"])
		-- GameTooltip:Show()
	-- end)
	-- dragFrame:SetScript("OnLeave",function()
		-- dragFrame:SetAlpha(0);
		-- GameTooltip:Hide()
	-- end)
	-- dragFrame:SetScript("OnMouseDown",function(frame, button)
		 -- if ( button == "LeftButton" and (IsShiftKeyDown() or IsAltKeyDown()) ) then
			-- frame.isMoving = true;
            -- frame:GetParent():StartMoving();
		 -- elseif button == "RightButton" then
			-- BF_ResetFrame(frame:GetParent())
		 -- end
	-- end)
	-- dragFrame:SetScript("OnMouseUp",function(frame, button)
		-- if ( frame.isMoving ) then
            -- frame:GetParent():StopMovingOrSizing();
            -- frame.isMoving = false;
			-- BFClassMod_Config = BFClassMod_Config or {}
			-- BFClassMod_Config[frameName] = {__GetPoint(frame:GetParent())}
        -- end
	-- end)
	-- if BFClassMod_Config and BFClassMod_Config[frameName] then
		-- BigFoot_DelayCall(function()
			-- local point, ref, refPoint ,x ,y = unpack(BFClassMod_Config[frameName])
			-- frame:ClearAllPoints();
			-- frame:SetPoint(point,ref,refPoint,x,y)
		-- end,0.1)
	-- end

-- end

-- local function doMoveFrame()
	-- MoveFrame(EclipseBarFrame)		--鸟德能量框体
	-- MoveFrame(ShardBarFrame)		--术士碎片框体
	-- MoveFrame(PaladinPowerBar)		--圣骑圣能框体
	-- PaladinPowerBar:SetFrameStrata("LOW")
	-- MoveFrame(TotemFrame)			--萨满图腾框体
	-- for i=1,4 do MoveFrame(TotemFrame, _G["TotemFrameTotem"..i]) end
	-- if (not IsAddOnLoaded("Xperl")) then			--与Xperl冲突
		-- MoveFrame(RuneFrame)			--死骑符文框体
		-- for i=1,6 do MoveFrame(RuneFrame, _G["RuneButtonIndividual"..i]) end
	-- end
-- end
