--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2012 Kyle Smith (a.k.a. Pastamancer), A. Kinley (a.k.a. Phanx) <addons@phanx.net>
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
------------------------------------------------------------------------
	GridStatusResurrect.lua
	GridStatus module for showing incoming resurrections.
----------------------------------------------------------------------]]

if select(4, GetBuildInfo()) < 50000 then
	return -- LibResInfo is not compatible with WoW 4.x
end

local _, Grid = ...
local L = Grid.L

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusResurrect = Grid:NewStatusModule("GridStatusResurrect", "AceTimer-3.0")
GridStatusResurrect.menuName = L["Resurrection"]
GridStatusResurrect.options = false

GridStatusResurrect.defaultDB = {
	alert_resurrect = {
		enable = true,
		text =  L["RES"],
		color = { r = 0.8, g = 1, b = 0, a = 1 },
		color2 = { r = 0.2, g = 1, b = 0, a = 1 },
		priority = 50,
		showUntilUsed = true,
	},
}

local extraOptionsForStatus = {
	showUntilUsed = {
		name = L["Show until used"],
		desc = L["Show the status until the resurrection is accepted or expires, instead of only while it is being cast."],
		type = "toggle",
		width = "double",
		get = function(t)
			return GridStatusResurrect.db.profile.alert_resurrect.showUntilUsed
		end,
		set = function(t, v)
			GridStatusResurrect.db.profile.alert_resurrect.showUntilUsed = v
			GridStatusResurrect:UpdateAllUnits()
		end,
	},
	color2 = {
		order = 21,
		name = L["Pending color"],
		desc = L["Use this color for resurrections that have finished casting and are waiting to be accepted."],
		type = "color",
		hasAlpha = true,
		get = function(t)
			local color = GridStatusResurrect.db.profile.alert_resurrect.color2
			return color.r, color.g, color.b, color.a or 1
		end,
		set = function(t, r, g, b, a)
			local color = GridStatusResurrect.db.profile.alert_resurrect.color2
			color.r, color.g, color.b, color.a = r, g, b, a or 1
		end,
	},
}

------------------------------------------------------------------------

function GridStatusResurrect:PostInitialize()
	self:Debug("PostInitialize")

	self:RegisterStatus("alert_resurrect", L["Resurrection"], extraOptionsForStatus, true)

	self.core.options.args.alert_resurrect.args.color.name = L["Casting color"]
	self.core.options.args.alert_resurrect.args.color.desc = L["Use this color for resurrections that are currently being cast."]

	self.core.options.args.alert_resurrect.args.range = nil
end

function GridStatusResurrect:OnStatusEnable(status)
	self:Debug("OnStatusEnable", status)

	local LibResInfo = LibStub("LibResInfo-1.0")
	LibResInfo.RegisterCallback(self, "LibResInfo_ResCastStarted", "UpdateAllUnits")
	LibResInfo.RegisterCallback(self, "LibResInfo_ResCastCancelled", "UpdateAllUnits")
	LibResInfo.RegisterCallback(self, "LibResInfo_ResCastFinished", "UpdateAllUnits")
	LibResInfo.RegisterCallback(self, "LibResInfo_ResPending", "UpdateAllUnits")
	LibResInfo.RegisterCallback(self, "LibResInfo_ResUsed", "UpdateAllUnits")
	LibResInfo.RegisterCallback(self, "LibResInfo_ResExpired", "UpdateAllUnits")

	self:RegisterMessage("Grid_RosterUpdated", "UpdateAllUnits")
end

function GridStatusResurrect:OnStatusDisable(status)
	self:Debug("OnStatusDisable", status)

	local LibResInfo = LibStub("LibResInfo-1.0")
	LibResInfo.UnregisterAllCallbacks(self)

	self:UnregisterMessage("Grid_RosterUpdated")
	self.core:SendStatusLostAllUnits("alert_resurrect")
end

------------------------------------------------------------------------

function GridStatusResurrect:UpdateAllUnits(event)
	self:Debug("UpdateAllUnits", event)

	local LibResInfo = LibStub("LibResInfo-1.0")
	local db = self.db.profile.alert_resurrect
	local now = GetTime()

	for guid, unit in GridRoster:IterateRoster() do
		local hasRes, endTime, casterUnit, casterGUID = LibResInfo:UnitHasIncomingRes(guid)
		if hasRes and (hasRes == "CASTING" or db.showUntilUsed) then

			local _, _, _, icon, startTime = casterUnit and UnitCastingInfo(casterUnit)
			local duration
			if startTime then
				startTime = startTime / 1000
				duration = endTime - startTime
			else
				startTime = endTime - 60
				duration = 60
			end

			self.core:SendStatusGained(guid, "alert_resurrect",
				db.priority,
				nil,
				hasRes == "PENDING" and db.color2 or db.color,
				db.text,
				nil,
				nil,
				icon,
				startTime,
				duration)
		else
			self.core:SendStatusLost(guid, "alert_resurrect")
		end
	end
end