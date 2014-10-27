
local TARGETCHARMS_VERSION = GetAddOnMetadata("TargetCharms", "Version");
local TARGETCHARMS_DB_VERSION = "1.5.5 (29/08/2014)";

local Defaults = {
	["Version"] = TARGETCHARMS_VERSION,
	["TargetCharms"] = {
		["show"] = 1,
		["barscale"] = 0.8,
		["Xspacing"] = -3,
		["Yspacing"] = 0,
		["draggable"] = 1,
		["toggleicon"] = false,
		["alphaVal"] = 0.8,
		["showontarget"] = true,
		["buttonSetup"] = ">1>2>3>4>5>6>7>8>0",
		["buttonSetupID"] = 3,
		},
	["ReadyCharm"] = {
		["show"] = 3,
		["barscale"] = 1.0,
		["draggable"] = 1,
		["alphaVal"] = 0.8,
		["width"] = 70,
		["text"] = TARGETCHARMS_READYCHECK_TEXT,
		},
	["FlareCharms"] = {
		["show"] = 1,
		["barscale"] = 0.8,
		["draggable"] = 1,
		["alphaVal"] = 0.8,
		["Xspacing"] = -4,
		["Yspacing"] = 0,
		["showicons"] = false,
		["buttonSetup"] = ">B>G>P>R>Y>X",
		["buttonSetupID"] = 3,
		},
};

local frameNames = {
	"TargetCharms",
	"TopCharm",
	"ReadyCharm",
	"TopReady",
	"FlareCharms",
	"TopFlare",
	"TargetCharmsSetup"
};

local buttonCharm = {
	["TargetCharms"]={},
	["FlareCharms"]={}
};

local texturePaths = {
	"interface\\targetingframe\\UI-RaidTargetingIcons.blp",
	"interface\\buttons\\UI-Quickslot.blp","interface\\buttons\\UI-GroupLoot-Pass-Up.blp",
	"interface\\icons\\ability_hunter_snipershot.blp"
};

function TargetCharms_msg(text)
	DEFAULT_CHAT_FRAME:AddMessage(TARGETCHARMS_MSG_TAG..text);
end

function TargetCharms_Command(msg)
	orig_msg = msg
	msg = string.lower(msg)
	a,b,cmd,arg = string.find(msg,"(%S+)%s*(%S*)")
	if cmd==TargetCharms_CMDS[1] then
		TargetCharms_Options = Defaults;
		local tmpFrame = _G[frameNames[1]];
		tmpFrame:SetScale(TargetCharms_Options[frameNames[1]]["barscale"]);
		tmpFrame:SetPoint("TOPLEFT", -30, 0);
		tmpFrame = _G[frameNames[2]];
		tmpFrame:ClearAllPoints()
		tmpFrame:SetPoint("TOPLEFT", _G["UIParent"],"TOP", -30, -25);
		tmpFrame:SetAlpha(TargetCharms_Options[frameNames[1]]["alphaVal"]);
		TargetCharms_SaveFrame(tmpFrame)
		tmpFrame = _G[frameNames[4]];
		tmpFrame:SetAlpha(TargetCharms_Options[frameNames[3]]["alphaVal"]);
		tmpFrame:SetScale(TargetCharms_Options[frameNames[3]]["barscale"]);
		tmpFrame:ClearAllPoints();
		tmpFrame:SetPoint("TOPLEFT",_G["UIParent"],"TOP", -30, 0);
		TargetCharms_SaveFrame(tmpFrame)
		tmpFrame = _G[frameNames[3]];
		tmpFrame:SetAlpha(TargetCharms_Options[frameNames[3]]["alphaVal"]);
		tmpFrame:SetScale(1);
		tmpFrame:ClearAllPoints();
		tmpFrame:SetPoint("TOPLEFT", -30, 0);
		tmpFrame:SetWidth(TargetCharms_Options[frameNames[3]]["width"]);
		tmpFrame = _G[frameNames[4]];
		tmpFrame:SetWidth(TargetCharms_Options[frameNames[3]]["width"]);
		tmpFrame = _G[frameNames[5]];
		tmpFrame:SetScale(TargetCharms_Options[frameNames[5]]["barscale"]);
		tmpFrame:SetPoint("TOPLEFT", -30, 0);
		tmpFrame = _G[frameNames[6]];
		tmpFrame:ClearAllPoints()
		tmpFrame:SetPoint("TOPLEFT", _G["UIParent"],"TOP", 45,0);
		TargetCharms_SaveFrame(tmpFrame)
		tmpFrame:SetAlpha(TargetCharms_Options[frameNames[5]]["alphaVal"]);
		tmpFrame = _G[frameNames[7]];
		if (tmpFrame~=nil) then
			tmpFrame:ClearAllPoints();
			tmpFrame:SetPoint("CENTER", 0, 0);
		end
		TargetCharms_msg("配置已重置");
	elseif cmd==TargetCharms_CMDS[2] then
		ShowSetup();
	else
		TargetCharms_msg(TARGETCHARMS_CMD_HELP);
	end
    CheckReadyButtonViewState();
    CheckFrameViewState();
    CheckFlareFrameViewState();
end

function resetTop(frame,offset)

end

function TargetCharms_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
	-- self:RegisterEvent("PARTY_LEADER_CHANGED");
	-- self:RegisterEvent("PARTY_MEMBERS_CHANGED");
	-- self:RegisterEvent("PLAYER_TARGET_CHANGED");
	SetTargetHideShow();
	SLASH_TargetCharms1 = TARGETCHARMS_SLASH1;
	SLASH_TargetCharms2 = TARGETCHARMS_SLASH2;
	SlashCmdList["TargetCharms"] = TargetCharms_Command;
end

--Code by Grayhoof (SCT)
function CloneTable(t)				-- return a copy of the table t
	local new = {};					-- create a new table
	local i, v = next(t, nil);		-- i is an index of t, v = t[i]
	while i do
		if type(v)=="table" then
			v=CloneTable(v);
		end
		new[i] = v;
		i, v = next(t, i);			-- get next index
	end
	return new;
end

function CopyOldValues(t,f)
	if(f~=nil) then
		for i=1,5,2 do
			if ( f[frameNames[i]]~=nil) then
				for key,value in pairs(f[frameNames[i]]) do
					t[frameNames[i]][key]=value ;
				end
			end
		end
	end
	return t;
end

function CheckFrameViewState()
	local charmBar = _G[frameNames[2]];

	if IsInSetup() then
		if(charmBar:IsShown()~=1) then
			charmBar:Show();
		end
	else
		if TargetCharms_Options["TargetCharms"]["show"] == 2 then
			SetHideShow(frameNames[2]);
		elseif TargetCharms_Options["TargetCharms"]["show"] == 3 then
	    		if(charmBar:IsShown()==1) then
				charmBar:Hide();
			end
		else
			if ((GetNumGroupMembers()>0) and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player"))) then
				SetHideShow(frameNames[2]);
				-- SetHideShow(frameNames[5]);
			else
				if(charmBar:IsShown()==1) then
					charmBar:Hide();
				end
			end
		end
	end
end

function CheckFlareFrameViewState()
    if InCombatLockdown()~=1 then
		local charmBar = _G[frameNames[6]];

		if IsInSetup() then
			if(charmBar:IsShown()~=1) then
				charmBar:Show();
			end
		else
			if TargetCharms_Options[frameNames[5]]["show"] == 2 then
				if (charmBar:IsShown()~=1) then
					charmBar:Show();
				end
			elseif TargetCharms_Options[frameNames[5]]["show"] == 3 then
					if(charmBar:IsShown()==1) then
					charmBar:Hide();
				end
			else
				if ((GetNumGroupMembers()>0) and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")))  then
					if (charmBar:IsShown()~=1) then
						charmBar:Show();
					end
				else
					if(charmBar:IsShown()==1) then
						charmBar:Hide();
					end
				end
			end
		end
    else
		_G[frameNames[1]]:RegisterEvent("PLAYER_REGEN_ENABLED");
    end
end

function CheckReadyButtonViewState()
	charmBar = _G[frameNames[4]];
	charmBar:Show();
	charmBar = _G[frameNames[3]];
	charmBar:Show();

	if IsInSetup() then
		if(charmBar:IsShown()~=1) then
			charmBar:Show();
		end
	else
		if TargetCharms_Options[frameNames[3]]["show"] == 2 then
			if (charmBar:IsShown()~=1) then
				charmBar:Show();
			end
		elseif TargetCharms_Options[frameNames[3]]["show"] == 3 then
	    		if(charmBar:IsShown()==1) then
				charmBar:Hide();
			end
		else
			if ((GetNumGroupMembers()>0) and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")))  then
				if (charmBar:IsShown()~=1) then
					charmBar:Show();
				end
			else
				if(charmBar:IsShown()==1) then
					charmBar:Hide();
				end
			end
		end
	end
end

function IsInSetup()
 local TargetCharmsSetup = _G[frameNames[7]];
 if TargetCharmsSetup~=nil then
	if TargetCharmsSetup:IsShown()==1 then
		return true;
	end
 end
 return false;
end

function SetHideShow(frame)
 local charmBar = _G[frame];
 if TargetCharms_Options[frameNames[1]]["showontarget"] then

	if UnitExists("target") then
		if (charmBar:IsShown()~=1) then
			charmBar:Show();
		end
	else
		if (charmBar:IsShown()==1) then
			charmBar:Hide();
		end
	end
 else
	if (charmBar:IsShown()~=1) then
		charmBar:Show();
	end
 end
end

function SetTargetHideShow()
	RegisterUnitWatch(_G[frameNames[2]], true)
end

function TargetCharms_OnEvent(self, event,...)
	local addon = ...;
	if event=="ADDON_LOADED" and addon == "TargetCharms" then
		if TargetCharms_Options == nil or TARGETCHARMS_DB_VERSION ~= TargetCharms_Options["Version"] then
			TargetCharms_Options = CopyOldValues(CloneTable(Defaults),TargetCharms_Options);
			TargetCharms_Options["Version"] = TARGETCHARMS_DB_VERSION;
			TargetCharms_Options[frameNames[5]]["buttonSetup"] = string.gsub(TargetCharms_Options[frameNames[5]]["buttonSetup"],"W","Y");
		end
		local tmpFrame = _G[frameNames[1]];
		tmpFrame:SetScale(TargetCharms_Options[frameNames[1]]["barscale"]);
		tmpFrame = _G[frameNames[2]];
		TargetCharms_LoadFrame(tmpFrame)
		tmpFrame:SetAlpha(TargetCharms_Options[frameNames[1]]["alphaVal"]);
		tmpFrame = _G[frameNames[5]];
		tmpFrame:SetScale(TargetCharms_Options[frameNames[5]]["barscale"]);
		tmpFrame = _G[frameNames[6]];
		tmpFrame:SetAlpha(TargetCharms_Options[frameNames[5]]["alphaVal"]);
		TargetCharms_LoadFrame(tmpFrame)
		TargetCharms_LoadFrame(_G[frameNames[4]])
		SetupButtons(frameNames[1],frameNames[1]);
		SetupButtons(frameNames[5],frameNames[5]);
		SetUpReadyButton();
	end
	if event~= "PLAYER_TARGET_CHANGED" then
		CheckReadyButtonViewState();
		CheckFlareFrameViewState();
		if event=="PLAYER_REGEN_ENABLED" then
			_G[frameNames[1]]:UnregisterEvent("PLAYER_REGEN_ENABLED");
			LockFlares();
		end
	end
	CheckFrameViewState();
end

function SetUpReadyButton()
	local tmpFrame = _G[frameNames[4]];
	tmpFrame:SetAlpha(TargetCharms_Options[frameNames[3]]["alphaVal"]);
	tmpFrame:SetScale(TargetCharms_Options[frameNames[3]]["barscale"]);
	tmpFrame:SetWidth(TargetCharms_Options[frameNames[3]]["width"]);
	tmpFrame = _G[frameNames[3]];
	tmpFrame:SetWidth(TargetCharms_Options[frameNames[3]]["width"]);
	tmpFrame:SetText(TargetCharms_Options[frameNames[3]]["text"]);
end

function MakeButton(frame, buttonNum, isMacro)
	local button = _G[frame.."Charm"..buttonNum];
	local template = "CharmTemplate";
	if isMacro then
		template = "SecureCharmTemplate";
	end
	if button == nil then
		button = CreateFrame("Button", frame.."Charm"..buttonNum, _G[frame], template)
		button:SetScript("OnEnter",function ()
			GameTooltip:SetOwner(button, "ANCHOR_BOTTOMLEFT")
			GameTooltip:ClearLines()
			GameTooltip:AddLine(TARGETCHARMS_LEFTCLICK)
			GameTooltip:AddLine(TARGETCHARMS_RIGHTDRAG)
			GameTooltip:AddLine(TARGETCHARMS_RIGHTSET)
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave",function ()
			GameTooltip:Hide()
		end)
		button:SetID(buttonNum);
		button:SetHeight(32);
		button:SetWidth(32);
		local texture = button:CreateTexture(button:GetName().."CharmTex");
		if isMacro then
			button:SetAttribute("type", "macro")
			button:SetHeight(32);
			button:SetWidth(32);
			local textureColor = button:CreateTexture(button:GetName().."TextureColor");
			textureColor:SetPoint("TOPLEFT", button,"TOPLEFT", 4, -4);
			textureColor:SetPoint("BOTTOMRIGHT", button,"BOTTOMRIGHT", -4.5, 4.5);
			local textureIcon = button:CreateTexture(button:GetName().."TextureIcon");
			textureColor:SetPoint("TOPLEFT", button,"TOPLEFT", 4, -4)
			textureColor:SetPoint("BOTTOMRIGHT", button,"BOTTOMRIGHT", -4.5, 4.5)
		end
	end
	return button;
end

function SetupButtons(frameInfo,frameTarget)
	local buttonString = TargetCharms_Options[frameInfo]["buttonSetup"];
	local maxlen = strlen(buttonString);
	if mod(maxlen,2) == 1 then
		maxlen=maxlen-1
	end
	local buttonNum=1;
	if maxlen > 40 then
		maxlen = 40;
	end

	local t
	for t=1,maxlen,2 do
		MakeButton(frameTarget, buttonNum, (frameInfo==frameNames[5]));
		FormatButton(frameTarget, buttonNum, strsub(buttonString,t,t), strsub(buttonString,t+1,t+1),TargetCharms_Options[frameInfo]["Xspacing"],TargetCharms_Options[frameInfo]["Yspacing"]);
		buttonNum=buttonNum+1;
	end

	for t=buttonNum,20 do
		local button = _G[frameTarget.."Charm"..buttonNum];
		if button ~= nil then
			button:Hide();
		end
	end
end

function FormatButton(frame, buttonNum ,posChar, typeNum, xSpacing, ySpacing)
	local button = _G[frame.."Charm"..buttonNum];
	button:ClearAllPoints();
	if strlower(posChar) == TARGETCHARMS_POSITION_DOWN then
		button:SetPoint("TOPLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"BOTTOMLEFT",0,0-ySpacing);
	elseif posChar == TARGETCHARMS_POSITION_UP then
		button:SetPoint("BOTTOMLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPLEFT",0,0+ySpacing);
	elseif posChar == TARGETCHARMS_POSITION_RIGHT then
		button:SetPoint("TOPLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPRIGHT",0+xSpacing,0);
	elseif posChar == TARGETCHARMS_POSITION_LEFT then
		button:SetPoint("TOPRIGHT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPLEFT",0-xSpacing,0);
	else
		--ERROR--
		button:SetPoint("TOPLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPRIGHT",0,0-ySpacing);
		buttonCharm[frame][buttonNum] = 0;
        	button:Hide();
		return false;
	end
	if frame == frameNames[1] then
		if typeNum == TARGETCHARMS_CHARM0 then
			MakeCharm(frame,button,buttonNum,0,3,0,1,0,1,3,-2,26,26);
		elseif typeNum == TARGETCHARMS_CHARM1 then
			MakeCharm(frame,button,buttonNum,1,1,0,0.25,0,0.25,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM2 then
			MakeCharm(frame,button,buttonNum,2,1,0.25,0.5,0,0.25,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM3 then
			MakeCharm(frame,button,buttonNum,3,1,0.5,0.75,0,0.25,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM4 then
			MakeCharm(frame,button,buttonNum,4,1,0.75,1,0,0.25,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM5 then
			MakeCharm(frame,button,buttonNum,5,1,0,0.25,0.25,0.5,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM6 then
			MakeCharm(frame,button,buttonNum,6,1,0.25,0.5,0.25,0.5,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM7 then
			MakeCharm(frame,button,buttonNum,7,1,0.5,0.75,0.25,0.5,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM8 then
			MakeCharm(frame,button,buttonNum,8,1,0.75,1,0.25,0.5,2,-2,28,28);
		elseif typeNum == TARGETCHARMS_CHARM9 then
			MakeCharm(frame,button,buttonNum,9,4,0,1,0,1,0,0,32,32);
		else
      	  		button:Hide();
			return false;
		end
	else
		if typeNum == TARGETCHARMS_BLUEFLARE then
			MakeCharm(frame,button,buttonNum,1, 2,0.15,0.85,0.15,0.85,0,0,32,32);
			if TargetCharms_Options[frameNames[5]]["showicons"] then
				SetTexture(button, _G[button:GetName().."TextureIcon"],1,0.25,0.5,0.25,0.5,6,-5,20,20);
			else
				_G[button:GetName().."TextureIcon"]:SetTexture();
			end
			local textureColor = _G[button:GetName().."TextureColor"];
			textureColor:SetTexture(0,.5,1);
			button:SetAttribute("macrotext", [[/wm 1]]);
		elseif typeNum == TARGETCHARMS_GREENFLARE then
			MakeCharm(frame,button,buttonNum,2,2,0.15,0.85,0.15,0.85,0,0,32,32);
			if TargetCharms_Options[frameNames[5]]["showicons"] then
				SetTexture(button, _G[button:GetName().."TextureIcon"],1,0.75,1,0,0.25,6,-5,20,20);
			else
				_G[button:GetName().."TextureIcon"]:SetTexture();
			end
			local textureColor = _G[button:GetName().."TextureColor"];
			textureColor:SetTexture(0,1,.2);
			button:SetAttribute("macrotext", [[/wm 2]]);
		elseif typeNum == TARGETCHARMS_PURPLEFLARE then
			MakeCharm(frame,button,buttonNum,3,2,0.15,0.85,0.15,0.85,0,0,32,32);
			if TargetCharms_Options[frameNames[5]]["showicons"] then
				SetTexture(button, _G[button:GetName().."TextureIcon"],1,0.5,0.75,0,0.25,6,-5,20,20);
			else
				_G[button:GetName().."TextureIcon"]:SetTexture();
			end
			local textureColor = _G[button:GetName().."TextureColor"];
			textureColor:SetTexture(.5,0,1);
			button:SetAttribute("macrotext", [[/wm 3]]);
		elseif typeNum == TARGETCHARMS_REDFLARE then
			MakeCharm(frame,button,buttonNum,4,2,0.15,0.85,0.15,0.85,0,0,32,32);
			if TargetCharms_Options[frameNames[5]]["showicons"] then
				SetTexture(button, _G[button:GetName().."TextureIcon"],1,0.5,0.75,0.25,0.5,6,-5,20,20);
			else
				_G[button:GetName().."TextureIcon"]:SetTexture();
			end
			local textureColor = _G[button:GetName().."TextureColor"];
			textureColor:SetTexture(1,0,0);
			button:SetAttribute("macrotext", [[/wm 4]]);
		elseif typeNum == TARGETCHARMS_YELLOWFLARE then
			MakeCharm(frame,button,buttonNum,5,2,0.15,0.85,0.15,0.85,0,0,32,32);
			if TargetCharms_Options[frameNames[5]]["showicons"] then
				SetTexture(button, _G[button:GetName().."TextureIcon"],1,0,0.25,0,0.25,6,-5,20,20);
			else
				_G[button:GetName().."TextureIcon"]:SetTexture();
			end
			local textureColor = _G[button:GetName().."TextureColor"];
			textureColor:SetTexture(1,1,0);
			button:SetAttribute("macrotext", [[/wm 5]]);
		elseif typeNum == TARGETCHARMS_CLEARFLARE then
			MakeCharm(frame,button,buttonNum,0,2,0.15,0.85,0.15,0.85,0,0,32,32);
			SetTexture(button, _G[button:GetName().."TextureIcon"],3,0,1,0,1,3,-2,26,26);
			_G[button:GetName().."TextureColor"]:SetTexture();
			button:SetAttribute("macrotext", [[/cwm 全部]]);
		else
        		button:Hide();
			return false;
		end
	end
	button:Show();
	return true;
end

function MakeCharm(frame, button, buttonNum, id, textureID, o1,o2,o3,o4,a1,a2,w,h)
	buttonCharm[frame][buttonNum] = id;
	local texture = _G[button:GetName().."CharmTex"];
	SetTexture(button, texture, textureID, o1,o2,o3,o4,a1,a2,w,h);
end

function SetTexture(button, texture, textureID, o1,o2,o3,o4,a1,a2,w,h)
	texture:SetPoint("TOPLEFT", button,"TOPLEFT",a1,a2);
	texture:SetWidth(w);
	texture:SetHeight(h);
	texture:SetTexture(texturePaths[textureID]);
	texture:SetTexCoord(o1,o2,o3,o4)
end

function SelectTarget(frameId, targetId)
	local charmId = buttonCharm[frameNames[frameId]][tonumber(targetId)];
	if (TargetCharms_Options[frameNames[1]]["toggleicon"]~=1) then
		if (GetRaidTargetIndex("target")~=charmId) then
			SetRaidTarget("target", charmId)
		end
	else
		SetRaidTargetIcon("target", charmId)
	end
end

function SetFrameScale(scale,id)
	local tmpFrame = _G[frameNames[id]];
	tmpFrame:SetScale(scale);
end

function FormDropDownType_Initialize()
	local info;
	for i = 1, getn(TargetCharms_ShowTypes), 1 do
		info = {
			text = TargetCharms_ShowTypes[i];
			func = FormDropDownType_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function FormDropDownType2_Initialize()
	local info;
	for i = 1, getn(TargetCharms_ShowTypes), 1 do
		info = {
			text = TargetCharms_ShowTypes[i];
			func = FormDropDownType2_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function FormDropDownTypeFlare_Initialize()
	local info;
	for i = 1, getn(TargetCharms_ShowTypes), 1 do
		info = {
			text = TargetCharms_ShowTypes[i];
			func = FormDropDownTypeFlare_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function FormDropDownType_OnShow()
	UIDropDownMenu_Initialize(FormDropDownType, FormDropDownType_Initialize);
	UIDropDownMenu_SetSelectedID(FormDropDownType, TargetCharms_Options[frameNames[1]]["show"]);
	UIDropDownMenu_SetWidth(FormDropDownType,100);
	CheckFrameViewState();
end

function FormDropDownType2_OnShow()
	UIDropDownMenu_Initialize(FormDropDownType2, FormDropDownType2_Initialize);
	UIDropDownMenu_SetSelectedID(FormDropDownType2, TargetCharms_Options[frameNames[3]]["show"]);
	UIDropDownMenu_SetWidth(FormDropDownType2,100);
	CheckReadyButtonViewState();
end

function FormDropDownTypeFlare_OnShow()
	UIDropDownMenu_Initialize(FormDropDownTypeFlare, FormDropDownTypeFlare_Initialize);
	UIDropDownMenu_SetSelectedID(FormDropDownTypeFlare, TargetCharms_Options[frameNames[5]]["show"]);
	UIDropDownMenu_SetWidth(FormDropDownTypeFlare,100);
	CheckFlareFrameViewState();
end

function FormDropDownType_OnClick(self)
	local i = self:GetID();
	TargetCharms_Options[frameNames[1]]["show"] = i;
	UIDropDownMenu_SetSelectedID(FormDropDownType, i);
	FormDropDownType_OnShow();
end

function FormDropDownType2_OnClick(self)
	local i = self:GetID();
	TargetCharms_Options[frameNames[3]]["show"] = i;
	UIDropDownMenu_SetSelectedID(FormDropDownType2, i);
	FormDropDownType2_OnShow();
end

function FormDropDownTypeFlare_OnClick(self)
	local i = self:GetID();
	TargetCharms_Options[frameNames[5]]["show"] = i;
	UIDropDownMenu_SetSelectedID(FormDropDownTypeFlare, i);
	FormDropDownTypeFlare_OnShow();
end

function DropDownPresetOptions_Initialize()
	local info;
	for i = 1, getn(TargetCharms_LayoutDefaults), 1 do
		info = {
			text = TargetCharms_LayoutDefaults[i][1];
			func = DropDownPresetOptions_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function DropDownPresetOptions_OnShow(di)
	UIDropDownMenu_Initialize(DropDownPresetOptions , DropDownPresetOptions_Initialize);
	UIDropDownMenu_SetSelectedID(DropDownPresetOptions , TargetCharms_Options["TargetCharms"]["buttonSetupID"]);
	UIDropDownMenu_SetWidth(DropDownPresetOptions,100);
end

function DropDownPresetOptions_OnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(DropDownPresetOptions, i);
	TargetCharms_Options["TargetCharms"]["buttonSetup"] = TargetCharms_LayoutDefaults[i][2];
	TargetCharms_Options["TargetCharms"]["buttonSetupID"] = i;
	SetupButtons("TargetCharms","TargetCharms");
end

function FlareDropDownPresetOptions_Initialize()
	local info;
	for i = 1, getn(Flare_LayoutDefaults), 1 do
		info = {
			text = Flare_LayoutDefaults[i][1];
			func = FlareDropDownPresetOptions_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function FlareDropDownPresetOptions_OnShow(di)
	UIDropDownMenu_Initialize(FlareDropDownPresetOptions , FlareDropDownPresetOptions_Initialize);
	UIDropDownMenu_SetSelectedID(FlareDropDownPresetOptions , TargetCharms_Options["FlareCharms"]["buttonSetupID"]);
	UIDropDownMenu_SetWidth(FlareDropDownPresetOptions,100);
end

function FlareDropDownPresetOptions_OnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(FlareDropDownPresetOptions, i);
	if InCombatLockdown()~=1 then
		TargetCharms_Options["FlareCharms"]["buttonSetup"] = Flare_LayoutDefaults[i][2]
		TargetCharms_Options["FlareCharms"]["buttonSetupID"] = i
		SetupButtons("FlareCharms","FlareCharms");
	end
end

function MoveFlares()
	local frame = _G[frameNames[5]];
	frame:EnableMouse(true);
	_G[frameNames[5].."_Tex"]:SetTexture(0,1,0);
	_G[frameNames[5].."Text"]:SetText(TARGETCHARMS_OPTIONS_FLARE_MOVE_TEXT);

	for buttonNum=1,20 do
		local button = _G[frameNames[5].."Charm"..buttonNum];
		if button ~= nil then
			button:Hide();
		end
	end

	local frame = _G["FlareMoveButton"];
	frame:SetText(TARGETCHARMS_OPTIONS_FLARE_LOCK_BUTTON);
end

function LockFlares()
	if InCombatLockdown()~=1 then
		local frame = _G[frameNames[5]];
		-- frame:EnableMouse(false);
		_G[frameNames[5].."_Tex"]:SetTexture();
		_G[frameNames[5].."Text"]:SetText();

		local button = _G["FlareMoveButton"];
		if button~=nil then
			button:SetText(TARGETCHARMS_OPTIONS_FLARE_MOVE_BUTTON);
		end
		SetupButtons(frameNames[5],frameNames[5]);
	end
end

function ShowSetup()
	local setupFrame = _G[frameNames[7]];
	if setupFrame == nil then
		setupFrame = CreateFrame("Frame",frameNames[7],UIParent,"TargetCharmsSetupTemplate");
	end
	setupFrame:Show();
end

function HideSetup()
	local setupFrame = _G[frameNames[7]];
	if setupFrame ~= nil then
		setupFrame:Hide();
	end
end

function TopCharm_Toggle(swith)
	if swith then
		TargetCharms:RegisterEvent("PARTY_LEADER_CHANGED");
		TargetCharms:RegisterEvent("GROUP_ROSTER_UPDATE");
		TargetCharms:RegisterEvent("PLAYER_TARGET_CHANGED");
		SetHideShow(frameNames[2]);
		CheckFlareFrameViewState();
	else
		TargetCharms:UnregisterEvent("ADDON_LOADED");
		TargetCharms:UnregisterEvent("PARTY_LEADER_CHANGED");
		TargetCharms:UnregisterEvent("GROUP_ROSTER_UPDATE");
		TargetCharms:UnregisterEvent("PLAYER_TARGET_CHANGED");
		if TopCharm then
			TopCharm:Hide()
		end
		if ReadyCharm then
			ReadyCharm:Hide()
		end
		if TopFlare then
			TopFlare:Hide()
		end
	end
end

function TargetCharms_SaveFrame(frame)
	if not frame then return end
	local frameName = frame:GetName()
	local _point,rel,relp,xo,yo=frame:GetPoint()
	if not TargetCharms_Options.AttackFrame then TargetCharms_Options.AttackFrame = {} end
	TargetCharms_Options.AttackFrame[frameName] = {_point,"UIParent",relp,xo,yo}
end

function TargetCharms_LoadFrame(frame)
	if not frame then return end
	if not TargetCharms_Options.AttackFrame then TargetCharms_Options.AttackFrame = {} end
	local frameName = frame:GetName()
	if not TargetCharms_Options.AttackFrame[frameName] then
		local _point,rel,relp,xo,yo=frame:GetPoint()
		TargetCharms_Options.AttackFrame[frameName] = {_point,"UIParent",relp,xo,yo}
	end
	frame:ClearAllPoints();
	frame:SetPoint(unpack(TargetCharms_Options.AttackFrame[frameName]))
end
