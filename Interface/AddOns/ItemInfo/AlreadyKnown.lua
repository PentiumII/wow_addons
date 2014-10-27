
-- here is your custom color. note: it acts as a filter applied to the texture image.
local COLOR = { r = 0.6, g = 0, b = 0 ,a = 0.8}

local tooltip = CreateFrame('GameTooltip')
tooltip:SetOwner(WorldFrame, 'ANCHOR_NONE')
local _

local IsAlreadyKnown,tog_swith
do
	local knowns = {}

	-- things we have to care. please let me know if any lack or surplus here.
	local weapon, armor, container, consumable, glyph, trade_goods, recipe, gem, miscallaneous, quest = GetAuctionItemClasses()
	local knowables = { [glyph] = true, [recipe] = true, [miscallaneous] = true, }

	local lines = {}
	for i = 1, 40 do
		lines[i] = tooltip:CreateFontString()
		tooltip:AddFontStrings(lines[i], tooltip:CreateFontString())
	end

	function IsAlreadyKnown (itemLink)
		if ( not itemLink ) then
			return
		end

		local itemID = itemLink:match('item:(%d+):')
		if ( knowns[itemID] ) then
			return true
		end

		local _, _, _, _, _, itemType = GetItemInfo(itemLink)
		if ( not knowables[itemType] ) then
			return
		end

		tooltip:ClearLines()
		tooltip:SetHyperlink(itemLink)

		for i = 1, tooltip:NumLines() do
			if ( lines[i]:GetText() == ITEM_SPELL_KNOWN ) then
				knowns[itemID] = true
				return true
			end
		end
	end
end

-- merchant frame

local function MerchantFrame_UpdateMerchantInfo ()
	if not tog_swith then return end
	local numItems = GetMerchantNumItems()

	for i = 1, MERCHANT_ITEMS_PER_PAGE do
		local index = (MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE + i
		if ( index > numItems ) then
			return
		end

		local button = _G['MerchantItem' .. i .. 'ItemButton']
		button.bfTexture = button.bfTexture or button:CreateTexture(nil,"OVERLAY");

		if ( button and button:IsShown() ) then
			local _, _, _, _, numAvailable, isUsable = GetMerchantItemInfo(index)

			if ( isUsable and IsAlreadyKnown(GetMerchantItemLink(index)) ) then
				local r, g, b = COLOR.r, COLOR.g, COLOR.b
				if ( numAvailable == 0 ) then
					r, g, b = r * 0.5, g * 0.5, b * 0.5
				end

				-- SetItemButtonTextureVertexColor(button, r, g, b)
				button.bfTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER);
				button.bfTexture:SetAllPoints(button)
				button.bfTexture:SetVertexColor(r, g, b,COLOR.a)
				button.bfTexture:Show();
			else
				button.bfTexture:Hide();
			end
		end
	end
end

hooksecurefunc('MerchantFrame_UpdateMerchantInfo', MerchantFrame_UpdateMerchantInfo)

local function MerchantFrame_UpdateBuybackInfo ()
	if not tog_swith then return end
	local numItems = GetNumBuybackItems()

	for index = 1, BUYBACK_ITEMS_PER_PAGE do
		if ( index > numItems ) then
			return
		end

		local button = _G['MerchantItem' .. index .. 'ItemButton']
		button.bfTexture = button.bfTexture or button:CreateTexture(nil,"OVERLAY");

		if ( button and button:IsShown() ) then
			local _, _, _, _, _, isUsable = GetBuybackItemInfo(index)

			if ( isUsable and IsAlreadyKnown(GetBuybackItemLink(index)) ) then
				-- SetItemButtonTextureVertexColor(button, COLOR.r, COLOR.g, COLOR.b)
				button.bfTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER);
				button.bfTexture:SetAllPoints(button)
				button.bfTexture:SetVertexColor(COLOR.r, COLOR.g, COLOR.b,COLOR.a)
				button.bfTexture:Show();
			else
				button.bfTexture:Hide();
			end
		end
	end
end

hooksecurefunc('MerchantFrame_UpdateBuybackInfo', MerchantFrame_UpdateBuybackInfo)

-- guild bank frame

local function GuildBankFrame_Update ()
	if not tog_swith then return end
	if ( GuildBankFrame.mode ~= 'bank' ) then
		return
	end

	local tab = GetCurrentGuildBankTab()
	local tem_num;

	for i = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
		tem_num = math.fmod(i, NUM_SLOTS_PER_GUILDBANK_GROUP) == 0 and 14 or math.fmod(i, NUM_SLOTS_PER_GUILDBANK_GROUP)
		local button = _G['GuildBankColumn' .. math.ceil((i - 0.5) / NUM_SLOTS_PER_GUILDBANK_GROUP) .. 'Button' .. tem_num]
		button.bfTexture = button.bfTexture or button:CreateTexture(nil,"OVERLAY");
		if ( button and button:IsShown() ) then
			local texture, _, locked = GetGuildBankItemInfo(tab, i)
			if ( texture and not locked ) then
				if ( IsAlreadyKnown(GetGuildBankItemLink(tab, i)) ) then
					-- SetItemButtonTextureVertexColor(button, COLOR.r, COLOR.g, COLOR.b)
					button.bfTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER);
					button.bfTexture:SetAllPoints(button)
					button.bfTexture:SetVertexColor(COLOR.r, COLOR.g, COLOR.b,COLOR.a)
					button.bfTexture:Show();
				else
					button.bfTexture:Hide();
				end
			end
		end
	end
end

local isBlizzard_GuildBankUILoaded
if ( IsAddOnLoaded('Blizzard_GuildBankUI') ) then
	isBlizzard_GuildBankUILoaded = true

	hooksecurefunc('GuildBankFrame_Update', GuildBankFrame_Update)
end

-- auction frame

local function AuctionFrameBrowse_Update ()
	if not tog_swith then return end
	local numItems = GetNumAuctionItems('list')
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)

	for i = 1, NUM_BROWSE_TO_DISPLAY do
		local index = offset + i
		if ( index > numItems ) then
			return
		end

		local button = _G['BrowseButton' .. i .. 'Item']
		button.bfTexture = button.bfTexture or button:CreateTexture(nil,"OVERLAY");

		if ( button and button:IsShown() ) then
			local _, _, _, _, canUse =  GetAuctionItemInfo('list', index)

			if ( canUse and IsAlreadyKnown(GetAuctionItemLink('list', index)) ) then
				-- texture:SetVertexColor(COLOR.r, COLOR.g, COLOR.b)
				button.bfTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER);
				button.bfTexture:SetAllPoints(button)
				button.bfTexture:SetVertexColor(COLOR.r, COLOR.g, COLOR.b,COLOR.a)
				button.bfTexture:Show();
			else
				button.bfTexture:Hide();
			end
		end
	end
end

local function AuctionFrameBid_Update ()
	if not tog_swith then return end
	local numItems = GetNumAuctionItems('bidder')
	local offset = FauxScrollFrame_GetOffset(BidScrollFrame)

	for i = 1, NUM_BIDS_TO_DISPLAY do
		local index = offset + i
		if ( index > numItems ) then
			return
		end

		local button = _G['BidButton' .. i .. 'Item']
		button.bfTexture = button.bfTexture or button:CreateTexture(nil,"OVERLAY");

		if ( button and button:IsShown() ) then
			local _, _, _, _, canUse =  GetAuctionItemInfo('bidder', index)

			if ( canUse and IsAlreadyKnown(GetAuctionItemLink('bidder', index)) ) then
				-- texture:SetVertexColor(COLOR.r, COLOR.g, COLOR.b)
				button.bfTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER);
				button.bfTexture:SetAllPoints(button)
				button.bfTexture:SetVertexColor(COLOR.r, COLOR.g, COLOR.b,COLOR.a)
				button.bfTexture:Show();
			else
				button.bfTexture:Hide();
			end
		end
	end
end

local function AuctionFrameAuctions_Update ()
	if not tog_swith then return end
	local numItems = GetNumAuctionItems('owner')
	local offset = FauxScrollFrame_GetOffset(AuctionsScrollFrame)

	for i = 1, NUM_AUCTIONS_TO_DISPLAY do
		local index = offset + i
		if ( index > numItems ) then
			return
		end

		local button = _G['AuctionsButton' .. i .. 'Item']
		button.bfTexture = button.bfTexture or button:CreateTexture(nil,"OVERLAY");

		if ( button and button:IsShown() ) then
			local _, _, _, _, canUse, _, _, _, _, _, _, _, saleStatus = GetAuctionItemInfo('owner', index)

			if ( canUse and IsAlreadyKnown(GetAuctionItemLink('owner', index)) ) then
				local r, g, b = COLOR.r, COLOR.g, COLOR.b
				if ( saleStatus == 1 ) then
					r, g, b = r * 0.5, g * 0.5, b * 0.5
				end

				-- texture:SetVertexColor(r, g, b)
				button.bfTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER);
				button.bfTexture:SetAllPoints(button)
				button.bfTexture:SetVertexColor(r, g, b,COLOR.a)
				button.bfTexture:Show();
			else
				button.bfTexture:Hide();
			end
		end
	end
end

local isBlizzard_AuctionUILoaded
if ( IsAddOnLoaded('Blizzard_AuctionUI') ) then
	isBlizzard_AuctionUILoaded = true

	hooksecurefunc('AuctionFrameBrowse_Update', AuctionFrameBrowse_Update)
	hooksecurefunc('AuctionFrameBid_Update', AuctionFrameBid_Update)
	hooksecurefunc('AuctionFrameAuctions_Update', AuctionFrameAuctions_Update)
end

-- ContainerFrame
local function ContainerFrame_UpdateBuybackInfo (frame)
	if not tog_swith then return end
	local id = frame:GetID();
	local name = frame:GetName();
	local __itemButton,__quality,__link;
	if frame.size and type(frame.size) == "number" and frame.size > 1 then
		for i=1, frame.size, 1 do
			__itemButton = _G[name.."Item"..i];
			__itemButton.bfTexture = __itemButton.bfTexture or __itemButton:CreateTexture(nil,"OVERLAY");
			_, _, _, __quality, _, _, __link = GetContainerItemInfo(id, __itemButton:GetID());
			if IsAlreadyKnown (__link) then
				-- SetItemButtonTextureVertexColor(__itemButton, COLOR.r, COLOR.g, COLOR.b)
				__itemButton.bfTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER);
				__itemButton.bfTexture:SetAllPoints(__itemButton)
				__itemButton.bfTexture:SetVertexColor(COLOR.r, COLOR.g, COLOR.b,COLOR.a)
				__itemButton.bfTexture:Show();
			else
				__itemButton.bfTexture:Hide();
			end
		end
	end
end

hooksecurefunc("ContainerFrame_OnShow",function(frame)
	ContainerFrame_UpdateBuybackInfo(frame)
end)

hooksecurefunc("ContainerFrame_OnEvent", function(frame,event,...)
	local arg1 = ...;
	if ( event == "BAG_OPEN" or event == "BAG_UPDATE" ) then
		if ( frame:GetID() == arg1 ) then
			ContainerFrame_UpdateBuybackInfo(frame)
		end
	end
end)

-- for LoD addons

if ( not (isBlizzard_GuildBankUILoaded and isBlizzard_AuctionUILoaded) ) then
	local function OnEvent (self, event, addonName)
		if ( addonName == 'Blizzard_GuildBankUI' ) then
			isBlizzard_GuildBankUILoaded = true

			hooksecurefunc('GuildBankFrame_Update', GuildBankFrame_Update)
		elseif ( addonName == 'Blizzard_AuctionUI' ) then
			isBlizzard_AuctionUILoaded = true

			hooksecurefunc('AuctionFrameBrowse_Update', AuctionFrameBrowse_Update)
			hooksecurefunc('AuctionFrameBid_Update', AuctionFrameBid_Update)
			hooksecurefunc('AuctionFrameAuctions_Update', AuctionFrameAuctions_Update)
		end

		if ( isBlizzard_GuildBankUILoaded and isBlizzard_AuctionUILoaded ) then
			self:UnregisterEvent(event)
			self:SetScript('OnEvent', nil)
			OnEvent = nil
		end
	end

	tooltip:SetScript('OnEvent', OnEvent)
	tooltip:RegisterEvent('ADDON_LOADED')
end

function AlreadyKnown_Toggle(swith)
	tog_swith = swith;
end
