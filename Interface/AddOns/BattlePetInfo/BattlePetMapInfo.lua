-----------------------------------------
-----------------------------------------
--地图上增强小宠物显示
--相关事件  WORLD_MAP_UPDATE

-----------------------------------------
-----------------------------------------
WILDPET = "野外可捕捉小宠物"
local mapInfoToggle = true

-----------------------------------------
--刷新函数
-----------------------------------------
local function BattlePetMapInfo_Update(t_mapPets)
	if type(t_mapPets) == "table" then
		BattleMapInfoDropDownMenu:Show()
	else
		BattleMapInfoDropDownMenu:Hide()
	end
end
-----------------------------------------
--DropDownMenu按钮Callback
-----------------------------------------
local function BattlePetMapInfo_DropDownButtonCallback(self)
	-- print(self:GetText())
end
-----------------------------------------
--DropDownMenu初始化
-----------------------------------------
local function BattlePetMapInfo_ButtonsInit(self)
	local mapId = GetCurrentMapZone()
	local t_mapPets = BattlePetDB_GetMapPets(mapId)
	if type(t_mapPets) == "table" then
		for k , v in pairs(t_mapPets) do
			info = UIDropDownMenu_CreateInfo()
			info.text = v
			info.func = BattlePetMapInfo_DropDownButtonCallback
			UIDropDownMenu_AddButton(info)
		end
	end
end
-----------------------------------------
--Event:WORLD_MAP_UPDATE
-----------------------------------------
local function BattlePetMapInfo_WORLD_MAP_UPDATE()
	if not WorldMapFrame:IsShown() then
		return 
	end
	local mapId = GetCurrentMapZone()
	local t_mapPets = BattlePetDB_GetMapPets(mapId)
	BattlePetMapInfo_Update(t_mapPets)
end

local function BattlePetMapInfo_Load()
	UIDropDownMenu_Initialize(BattleMapInfoDropDownMenu,BattlePetMapInfo_ButtonsInit)
	UIDropDownMenu_SetText(BattleMapInfoDropDownMenu,WILDPET)
end

do
	local f = CreateFrame("Frame")
	-- f:RegisterAllEvents()
	f:RegisterEvent("WORLD_MAP_UPDATE")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent",function(self,event,...)
		if event == "WORLD_MAP_UPDATE" then
			BattlePetMapInfo_WORLD_MAP_UPDATE()
		elseif event == "ADDON_LOADED" and select(1,...) == "BattlePetInfo" then
			BattlePetMapInfo_Load()
		end
	end)
end

-----------------------------------------
--地图小宠物增强开关
-----------------------------------------
function BattlePetMapInfo_Toggle(toggle)
	mapInfoToggle = toggle
end

-----------------------------------------
--测试部分
-----------------------------------------
