--
-- !BetterFont
-- written by Tobias Schulz (grdn) 2011, EU-Onyxia (Germany)
--
-- Hides this annoying panel on the left side of the screen.
--

local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_ENTERING_WORLD");

f.EventHandler = function(self, ...)
	CompactRaidFrameManager:Hide();
	CompactRaidFrameManager:UnregisterAllEvents();
	CompactRaidFrameContainer:Hide();
	CompactRaidFrameContainer:UnregisterAllEvents();
	CompactRaidFrameManager.Show = CompactRaidFrameManager.Hide;
	CompactRaidFrameContainer.Show = CompactRaidFrameContainer.Hide;
	
	self:UnregisterAllEvents();
	self:SetScript("OnEvent", nil);
	self = nil;
end

f:SetScript("OnEvent", f.EventHandler);

-- Hide Party   written by mmarionn@nga

for i = 1, MAX_PARTY_MEMBERS do
local pmf = _G["PartyMemberFrame"..i]
pmf:Hide()
pmf.Show = function() end
end

