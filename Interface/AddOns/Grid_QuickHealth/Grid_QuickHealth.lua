local QuickHealth = LibStub("LibQuickHealth-2.0")

-- env changement code taken from interruptus
local proxyEnv = setmetatable(
	{
		UnitHealth = QuickHealth.UnitHealth,
	},
	{
		__index    = _G,
		__newindex = function (t, k, v) _G[k] = v end,
	}
)

local IsInRaid = IsInRaid
local GridStatusHealth = Grid:GetModule("GridStatus"):GetModule("GridStatusHealth")
local GridStatusHeals = Grid:GetModule("GridStatus"):GetModule("GridStatusHeals")
local function UnitHealthUpdated(event, unitid, newHealth, healthMax)
	if IsInRaid() and unitid:sub(1,4) ~= "raid" then return end
	if GridStatusHealth then GridStatusHealth:UpdateUnit(event, unitid, ignoreRange) end
	if GridStatusHeals then GridStatusHeals:UpdateUnit(event, unitid) end
end

local eventFrame = CreateFrame("Frame")
local PLAYER_LOGIN
function PLAYER_LOGIN()
	QuickHealth.RegisterCallback("Grid_QuickHealth", "UnitHealthUpdated", UnitHealthUpdated)

	if(GridStatusHealth) then
	setfenv(GridStatusHealth.UpdateUnit, proxyEnv)
	GridStatusHealth:UnregisterEvent("UNIT_HEALTH")
	GridStatusHealth:UnregisterEvent("UNIT_MAXHEALTH")
	end

	if(GridStatusHeals) then
	setfenv(GridStatusHeals.UpdateUnit, proxyEnv)
	GridStatusHeals:UnregisterEvent("UNIT_HEALTH")
		GridStatusHeals:UnregisterEvent("UNIT_MAXHEALTH")
	end

	eventFrame:SetScript("OnEvent", nil)
	eventFrame:UnregisterAllEvents()
	PLAYER_LOGIN = nil
end

eventFrame:SetScript("OnEvent", PLAYER_LOGIN)
eventFrame:RegisterEvent("PLAYER_LOGIN")
