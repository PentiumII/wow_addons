local BCT = LibStub("LibBabble-CreatureType-3.0"):GetUnstrictLookupTable()
local BCTR = LibStub("LibBabble-CreatureType-3.0"):GetReverseLookupTable()
local icon = LibStub("LibDBIcon-1.0", true)

local LibQTip = LibStub("LibQTip-1.0")

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("LDB")

local dataobject
local db

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("LDB", {
		profile = {
			minimap = {},
		},
	})
	db = self.db

	self:SetupDataObject()

	local config = core:GetModule("Config", true)
	if config then
		config.options.args.outputs.plugins.broker = {
			broker = {
				type = "group",
				name = "Broker",
				args = {
					show_lastseen = {
						type = "toggle",
						name = "Show last seen rare",
						desc = "Toggle showing or hiding the last seen rare as the dataobject's text",
						get = function() return db.profile.show_lastseen end,
						set = function(info, v)
							db.profile.show_lastseen = v
							if v then
								if last_seen then
									dataobject.text = last_seen
								else
									dataobject.text = "None"
								end
							else
								dataobject.text = ""
							end
						end,
						order = 10,
						width = "full",
						descStyle = "inline",
					},
					minimap = {
						type = "toggle",
						name = "Show minimap icon",
						desc = "Toggle showing or hiding the minimap icon.",
						get = function() return not db.profile.minimap.hide end,
						set = function(info, v)
							local hide = not v
							db.profile.minimap.hide = hide
							if hide then
								icon:Hide("SilverDragon")
							else
								icon:Show("SilverDragon")
							end
						end,
						order = 30,
						width = "full",
						descStyle = "inline",
						hidden = function() return not icon or not dataobject or not icon:IsRegistered("SilverDragon") end,
					},
				},
			},
		}
	end
end

function module:SetupDataObject()
	dataobject = LibStub("LibDataBroker-1.1"):NewDataObject("SilverDragon", {
		type = "data source",
		icon = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
		label = "Rares",
		text = "",
	})

	local rares_seen = {}
	local tooltip
	function dataobject:OnEnter()
		local zone = core:GetPlayerZone()

		if not (core.db and core.db.global.mobs_byzoneid[zone]) then
			return
		end

		local mod_tooltip = core:GetModule("Tooltip", true)

		tooltip = LibQTip:Acquire("SilverDragonTooltip", 6, "LEFT", "CENTER", "RIGHT", "CENTER", "RIGHT", "RIGHT")
		tooltip:AddHeader("Name", "Level", "Type", "Count", "Last Seen")
		
		local n = 0
		for id in pairs(core.db.global.mobs_byzoneid[zone]) do
			n = n + 1
			local name, num_locations, level, elite, creature_type, lastseen, count, tameable = core:GetMob(zone, id)
			local index = tooltip:AddLine(core:GetMobLabel(id) or UNKNOWN,
				("%s%s"):format((level and level > 0) and level or (level and level == -1) and 'Boss' or '?', elite and '+' or ''),
				BCT[creature_type],
				count,
				core:FormatLastSeen(lastseen),
				(tameable and 'Tameable' or '')
			)
			if mod_tooltip then
				local achievement, achievement_name, completed = mod_tooltip:AchievementMobStatus(id)
				if achievement then
					if completed then
						tooltip:SetLineColor(index, 0, 1, 0)
					else
						tooltip:SetLineColor(index, 1, 0, 0)
					end
				end
			end
		end
		if n == 0 then
			tooltip:AddLine("None")
		end

		if #rares_seen > 0 then
			tooltip:AddHeader("Seen this session")
			tooltip:AddHeader("Name", "Zone", "Coords", "When", "Source")
			for i,rare in ipairs(rares_seen) do
				tooltip:AddLine(
					core:GetMobLabel(rare.id) or UNKNOWN,
					GetMapNameByID(rare.zone),
					(rare.x and rare.y) and (core.round(rare.x * 100, 1) .. ', ' .. core.round(rare.y * 100, 1)) or UNKNOWN,
					core:FormatLastSeen(rare.when),
					rare.source or UNKNOWN
				)
			end
		else
			tooltip:AddHeader("None seen this session")
		end

		tooltip:SmartAnchorTo(self)
		tooltip:Show()
	end

	function dataobject:OnLeave()
		LibQTip:Release(tooltip)
		tooltip = nil
	end

	function dataobject:OnClick(button)
		if button ~= "RightButton" then
			return
		end
		local config = core:GetModule("Config", true)
		if config then
			config:ShowConfig()
		end
	end

	local last_seen
	core.RegisterCallback("LDB", "Seen", function(callback, id, name, zone, x, y, dead, newloc, source)
		last_seen = name
		if db.profile.show_lastseen then
			dataobject.text = name
		end
		table.insert(rares_seen, {
			id = id,
			name = name,
			zone = zone,
			x = x,
			y = y,
			source = source,
			when = time(),
		})
	end)

	if icon then
		icon:Register("SilverDragon", dataobject, self.db.profile.minimap)
	end
	if db.profile.show_lastseen then
		dataobject.text = "None"
	end
end
