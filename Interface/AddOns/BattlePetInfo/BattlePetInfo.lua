
-----------------------------------------
-----------------------------------------
--对战界面对宠物品质增强
-----------------------------------------
-----------------------------------------






-----------------------------------------
--Pet Battle Events
-----------------------------------------
-- PET_BATTLE_PET_CHANGED
-- PET_BATTLE_OPENING_START
-- PET_BATTLE_ACTION_SELECTED
-----------------------------------------

local IsHooked = false
local f = CreateFrame("Frame")
local t_AllyPetQuality = {}
local t_EnemyPetQuality = {}

-----------------------------------------
--获得对战双方品质颜色
--返回值为 table
-- t_color = {
-- hex = hex,
-- r = r,
-- g = g,
-- b = b
-- }
-----------------------------------------
local function BattlePetInfo_GetPetQualityColor(owner,index)
	local qualityId = C_PetBattles.GetBreedQuality(owner,index)
	if ITEM_QUALITY_COLORS and qualityId then
		return ITEM_QUALITY_COLORS[qualityId-1]
	end
end

-----------------------------------------
--为名字上色
-- PetBattleFrame.ActiveAlly.Name
-- PetBattleFrame.Ally2
-- PetBattleFrame.Ally3
-- PetBattleFrame.ActiveEnemy.Name
-- PetBattleFrame.Enemy2
-- PetBattleFrame.Enemy3
-----------------------------------------
local function  BattlePetInfo_ColorName()


	--active ally 
	local t_activeAllycolor =  BattlePetInfo_GetPetQualityColor(1,PetBattleFrame.ActiveAlly.petIndex)
	PetBattleFrame.ActiveAlly.Name:SetTextColor(t_activeAllycolor.r,t_activeAllycolor.g,t_activeAllycolor.b)


	--active enemy
	local t_activeEnemycolor =  BattlePetInfo_GetPetQualityColor(2,PetBattleFrame.ActiveEnemy.petIndex)
	PetBattleFrame.ActiveEnemy.Name:SetTextColor(t_activeEnemycolor.r,t_activeEnemycolor.g,t_activeEnemycolor.b)
	
	
end


-----------------------------------------
--战斗开始时初始化宠物信息
---------------------------------------
local function BattlePetInfo_InitQuality()
	local qId
	t_AllyPetQuality = {}
	t_EnemyPetQuality = {}
	for i=1,3 do
		qId = C_PetBattles.GetBreedQuality(1,i) or "Unknown"
		table.insert(t_AllyPetQuality,qId)
		qId = C_PetBattles.GetBreedQuality(2,i) or "Unknown"
		table.insert(t_EnemyPetQuality,qId)
	end
	BattlePetInfo_ColorName()
end

-----------------------------------------
--刷新
-----------------------------------------
local function BattlePetInfo_UpdateQualityColor()
	BattlePetInfo_ColorName()
end


-----------------------------------------
--OnEvent
-----------------------------------------
do	
	-- f:RegisterAllEvents()
	f:RegisterEvent("PET_BATTLE_OPENING_START")
	f:RegisterEvent("PET_BATTLE_PET_CHANGED")
	if PetBattleFrame then
		
	end
	f:SetScript("OnEvent",function(self,event,...)
		if event == "PET_BATTLE_OPENING_START" then
			BattlePetInfo_InitQuality()
		elseif event == "PET_BATTLE_PET_CHANGED" then
			BattlePetInfo_UpdateQualityColor()
		end
	end)
end

-----------------------------------------
--Hook  修改Tooltip中的名字颜色
-----------------------------------------
do
	PetBattlePrimaryUnitTooltip:HookScript("OnShow",function(self)
		if self.petIndex and self.petOwner then
			local t_qcolor = BattlePetInfo_GetPetQualityColor(self.petOwner,self.petIndex)
			self.Name:SetTextColor(t_qcolor.r,t_qcolor.g,t_qcolor.b)
		end
	end)
end
-----------------------------------------
--品质部分测试内容
-----------------------------------------
-- for i=1,3 do
	-- local P=C_PetBattles.GetBreedQuality(2,i)
	-- print("第"..i.."只:"..ITEM_QUALITY_COLORS[P-1].hex.._G["BATTLE_PET_BREED_QUALITY"..P])
-- end

