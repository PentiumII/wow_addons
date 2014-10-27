
-------------------------------------------------------
-- BigFootPatch.lua
-- AndyXiao@BigFoot
-- 本文件是用来修正一些来自WoW本身Interface的问题
-------------------------------------------------------
do
	-- 和谐难看的字体
	-- SetTextStatusBarTextPrefix(PlayerFrameHealthBar, "");
	-- SetTextStatusBarTextPrefix(PlayerFrameManaBar, "");
	-- SetTextStatusBarTextPrefix(MainMenuExpBar, "");
	-- PlayerFrame.noTextPrefix = true
	-- TextStatusBarText:SetFont(DAMAGE_TEXT_FONT, 13, "OUTLINE");

	-- 屏蔽界面失效的提醒
	UIParent:UnregisterEvent("ADDON_ACTION_BLOCKED");

	_G["ChatFrameEditBox"] = _G["ChatFrame1EditBox"]
end

--
function __OnInspectFinish(unit,unitName)
	if unit ==InspectFrame.unit and GetFullName(unit)==unitName then
		InspectPaperDollFrame_OnShow()
	end
end

function __OnInspectTalentFinish(unit,unitName)
	-- if unit ==InspectFrame.unit and GetFullName(unit)==unitName then
		-- BigFoot_DelayCall(InspectTalentFrame_Update,0.3);
	-- end
end

local F = CreateFrame("Frame")

F:RegisterEvent("ADDON_LOADED")
F:RegisterEvent("PLAYER_TARGET_CHANGED")
F:SetScript("OnEvent", function(_,event,...)
	if event=="ADDON_LOADED" then
		local addOn = ...
		if addOn == "Blizzard_InspectUI" then
			hooksecurefunc("InspectSwitchTabs",function(tab)
				if tab ==1 or tab==3 then
					BigFoot_FireEvent("START_INSPECT",InspectFrame.unit)
				end
			end)
			F:UnregisterEvent("ADDON_LOADED")
			BigFoot_RegisterEvent("INSPECT_FINISH",__OnInspectFinish)
			BigFoot_RegisterEvent("INPSECT_TALENT_FINISH",__OnInspectTalentFinish)
		end
	elseif event=="PLAYER_TARGET_CHANGED" and InspectFrame and InspectFrame:IsShown() then
		BigFoot_FireEvent("START_INSPECT","target")
	end
end)

--支持可以从团队框体直接选择
do
	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event,...)
		if event == "ADDON_LOADED" and select(1,...) == "Blizzard_RaidUI" then
			BigFoot_DelayCall(BFSecureCall,1,function ()
				for i=1,40 do
					local raidbutton = getglobal("RaidGroupButton"..i);
					if(raidbutton and raidbutton.unit) then
						raidbutton:SetAttribute("type", "target");
						raidbutton:SetAttribute("unit", raidbutton.unit);
					end
				end
			end)
			f:UnregisterEvent("ADDON_LOADED")
		end
	end)
end

--QuickLoot中当拾取到空尸体的时候自动隐藏LootFrame 的逻辑移到这里
do
	local f = CreateFrame("Frame")
	f:RegisterEvent("LOOT_READY")
	f:SetScript("OnEvent",function(self,event)
		if ( GetNumLootItems() == 0 ) then
			HideUIPanel(LootFrame);
		end
	end)
end

--切天赋污染的问题暂时处理
do
    local function hook()
        PlayerTalentFrame_Toggle = function() 
            if ( not PlayerTalentFrame:IsShown() ) then 
                ShowUIPanel(PlayerTalentFrame); 
                TalentMicroButtonAlert:Hide(); 
            else 
                PlayerTalentFrame_Close(); 
            end 
        end

        for i=1, 4 do
            local tab = _G["PlayerTalentFrameTab"..i];
            if not tab then break end
            tab:SetScript("PreClick", function()
                for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
                    local frame = _G["StaticPopup"..index];
                    if(not issecurevariable(frame, "which")) then
                        local info = StaticPopupDialogs[frame.which];
                        if frame:IsShown() and info and not issecurevariable(info, "OnCancel") then
                            info.OnCancel()
                        end
                        frame:Hide()
                        frame.which = nil
                    end
                end
            end)
        end
    end

    if(IsAddOnLoaded("Blizzard_TalentUI")) then
        hook()
    else
        local f = CreateFrame("Frame")
        f:RegisterEvent("ADDON_LOADED")
        f:SetScript("OnEvent", function(self, event, addon)
            if(addon=="Blizzard_TalentUI")then
                self:UnregisterEvent("ADDON_LOADED")
                hook()
            end             
        end)
    end
end

-- 5.4  禁用相关
do
	--宠物
	local function Pet_hook()
        setfenv(PetJournalParent_OnShow, setmetatable({UpdateMicroButtons=function() 
			if (PetJournalParent and PetJournalParent:IsShown()) then 
				CompanionsMicroButton:Enable(); 
				CompanionsMicroButton:SetButtonState("PUSHED", 1); 
			end 
		end }, { __index = _G}))
    end

    if(IsAddOnLoaded("Blizzard_PetJournal")) then
        Pet_hook()
    else
        local f = CreateFrame("Frame")
        f:RegisterEvent("ADDON_LOADED")
        f:SetScript("OnEvent", function(self, event, addon)
            if(addon=="Blizzard_PetJournal")then
                self:UnregisterEvent("ADDON_LOADED")
                Pet_hook()
            end             
        end)
    end
	
	--成就
	local function Achievement_hook()
        setfenv(AchievementFrame_OnShow, setmetatable({UpdateMicroButtons=function() 
			if (AchievementFrame and AchievementFrame:IsShown()) then 
				AchievementMicroButton:SetButtonState("PUSHED", 1); 
			end 
		end }, { __index = _G}))
    end

    if(IsAddOnLoaded("Blizzard_AchievementUI")) then
        Achievement_hook()
    else
        local f = CreateFrame("Frame")
        f:RegisterEvent("ADDON_LOADED")
        f:SetScript("OnEvent", function(self, event, addon)
            if(addon=="Blizzard_AchievementUI")then
                self:UnregisterEvent("ADDON_LOADED")
                Achievement_hook()
            end             
        end)
    end
end

