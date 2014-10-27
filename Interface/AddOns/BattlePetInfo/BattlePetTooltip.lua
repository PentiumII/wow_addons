
-----------------------------------------
--刷新每次小宠物的数据
-----------------------------------------

local function BF_BattlePetTooltipUpdate(self)
	local petType = UnitBattlePetType("mouseover")
	local petName = UnitName("mouseover")
	local petLevel = UnitBattlePetLevel("mouseover")
	local auraID = PET_BATTLE_PET_TYPE_PASSIVES[petType];
	local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(auraID);
	self.AbilityPetType:SetTexture("Interface\\PetBattles\\PetIcon-"..PET_TYPE_SUFFIX[petType]);
	self.Name:SetText(name)
	self.PetName:SetText(petName)
	self.PetLevel:SetText(LEVEL .. "  " .. petLevel)
	local bottom = self.AbilityPetType;
	local description = SharedPetAbilityTooltip_ParseText(abilityInfo, unparsedDescription);
	self.Description:SetText(description);
	self.Description:SetPoint("TOPLEFT", bottom, "BOTTOMLEFT", 0, -5);
	self.bottom = self.Description
	if self.Description:GetTop()-self.Description:GetBottom() >220 then
		self:SetHeight(self.Description:GetTop()-self.Description:GetBottom() +10)
	else
		self:SetHeight(230);
	end

end


-----------------------------------------
--在Tooltip 显示时设置锚点
-----------------------------------------
local function BF_PetBattleAbilityTooltip_Show(anchorPoint, anchorTo, relativePoint, xOffset, yOffset)
	local curseX,curseY = GetCursorPosition()
	BF_PetBattlePrimaryAbilityTooltip:ClearAllPoints();
	if IsAddOnLoaded("BFTooltip") and BFTT_Config["Anchor"] == 2 then
	local width  = BF_PetBattlePrimaryAbilityTooltip:GetWidth()
		BF_PetBattlePrimaryAbilityTooltip:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",curseX +width+200,curseY+120)
	else
		BF_PetBattlePrimaryAbilityTooltip:SetPoint(anchorPoint, anchorTo, relativePoint, xOffset, yOffset);
	end

	BF_PetBattlePrimaryAbilityTooltip:SetScale(GameTooltip:GetScale()*0.9)
	BF_PetBattlePrimaryAbilityTooltip:Show();
end

-----------------------------------------
--hook
-----------------------------------------

do
	GameTooltip:HookScript("OnTooltipSetUnit",function(self)
		if UnitIsWildBattlePet("mouseover") then
			GameTooltip:Hide()
			BF_PetBattleAbilityTooltip_Show("TOPLEFT",UIParent,"RIGHT",-400, -300);
			BF_BattlePetTooltipUpdate(BF_PetBattlePrimaryAbilityTooltip)
			BF_PetBattlePrimaryAbilityTooltip.updateTooltip = 0.3
			if BF_PetBattlePrimaryAbilityTooltip.ClearTootipAnim:IsPlaying() then
				BF_PetBattlePrimaryAbilityTooltip.ClearTootipAnim:Stop()
			end
		else
			BF_PetBattlePrimaryAbilityTooltip:Hide()    ---
		end
	end)
end
-----------------------------------------
--Update
-----------------------------------------
function BF_PetBattleAbilityTooltip_Update(self,elapsed)
	self.updateTooltip = self.updateTooltip - elapsed;
	if ( self.updateTooltip > 0 ) then
		return;
	end
	self.updateTooltip = 0.3
	if UnitIsWildBattlePet("mouseover") then
		GameTooltip:Hide()
		BF_PetBattleAbilityTooltip_Show("TOPLEFT",UIParent,"RIGHT",-400, -300);
		BF_BattlePetTooltipUpdate(BF_PetBattlePrimaryAbilityTooltip)
		BF_PetBattlePrimaryAbilityTooltip.updateTooltip = 0.3
	else
		self.ClearTootipAnim:Play()
	end
end

