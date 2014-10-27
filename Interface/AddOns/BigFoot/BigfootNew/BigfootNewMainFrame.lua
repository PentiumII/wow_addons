DROPDOWNMENU_SHOWTIME =2;
SUITDROPDOWNMENNU_MAX =8;
local statusText =BF_NEW_statusText;
StaticPopupDialogs["BF_NEW_SUIT"] = {
	text = BF_NEWSUIT_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 16,
	OnAccept = function(self)
		-- print(self:GetName())
		local editBox = _G[self:GetName().."EditBox"];
		BigfootNewMainFrame_BigfootSuitOptionFrame_NewSuit(editBox:GetText());
	end,
	OnHide = function(self)
		_G[self:GetName().."EditBox"]:SetText("");
	end,
	EditBoxOnEnterPressed = function(self)
		BigfootNewMainFrame_BigfootSuitOptionFrame_NewSuit(self:GetText());
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	OnShow = function (self)
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["BF_COVER_SUIT"] = {
	text = BF_COVERSUIT_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BigfootNewMainFrame_BigfootSuitOptionFrame_SaveSuitByName(self.SuitName);
 
	end,
	OnCancel = function(self)
 
	end,
	OnShow = function (self)
		self.SuitName = StaticPopupDialogs["BF_COVER_SUIT"].SuitName
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["BF_REFUSENAME_SUIT"] = {
	text = BF_COVERSUIT_REFUSE_TEXT,
	button1 = CANCEL,
	OnCancel = function(self)
 
	end,
	OnShow = function (self)
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["BF_DEL_SUIT"] = {
	text = BF_DELSUIT_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BigfootNewMainFrame_DelSuitByName(self.SuitName);
		BF_SuitListContainer.SeleteSuiltName ="";
		BigfootNewMainFrame_BigfootSuitOptionFrame_OnShow()
		-- ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		-- ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		self.SuitName = StaticPopupDialogs["BF_DEL_SUIT"].SuitName
		-- ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["BF_CHOSEOLDFRAME"] = {
	text = BF_CHOSEOLDFRAME_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BFNew_SetNewFrameState(false)
		ReloadUI();
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["BF_LEAVESUITSTATE"] = {
	text = BF_LEAVESUITSTATE_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)

		BigfootNewMainFrame_SetSuiltState(false)
		if not m_TallFilter then
			m_TallFilter = Filter.new(true,"All","")
		end
		m_TallFilter:SetType(self.Text)
		BigfootSuitDropDownMenu.selectbuttonID = nil
		BigfootNewMainFrame_OnShow();                  ------------刷新界面
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		BF_NewCategoryButtonSetState(0)
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		self.Text = StaticPopupDialogs["BF_LEAVESUITSTATE"].Text
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};


StaticPopupDialogs["BF_SELETE_ALL_SUILT"] = {
	text = BF_SELETE_ALL_SUILT_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BFNew_OnAllAddonLoadFun(self.Text);
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		if BF_MainFrame_SelectAllButton then
			BF_MainFrame_SelectAllButton:SetChecked(not BF_MainFrame_SelectAllButton:GetChecked())
		end
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		 self.Text = StaticPopupDialogs["BF_SELETE_ALL_SUILT"].Text
		 ShieldedFrame:Show()
		 self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["BF_SELETE_ALL_SUILT1"] = {
	text = BF_SELETE_ALL_SUILT_TEXT1,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BFNew_OnAllAddonLoadFun(self.Text);
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		if BF_MainFrame_SelectAllButton then
			BF_MainFrame_SelectAllButton:SetChecked(not BF_MainFrame_SelectAllButton:GetChecked())
		end
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		 self.Text = StaticPopupDialogs["BF_SELETE_ALL_SUILT1"].Text
		 ShieldedFrame:Show()
		 self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["BF_DISABLE_ALL_SUILT"] = {
	text = BF_DISABLEALLALERT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BFNew_OnAllAddonLoadFun(self.Text);
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		if BF_MainFrame_SelectAllButton then
			BF_MainFrame_SelectAllButton:SetChecked(not BF_MainFrame_SelectAllButton:GetChecked())
		end
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		 self.Text = StaticPopupDialogs["BF_DISABLE_ALL_SUILT"].Text
		 ShieldedFrame:Show()
		 self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};


StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"] = {
	text = BF_SELETE_ADDON_TEXT_DLG,
	button1 = YES,
	button2 = NO,
	OnAccept = function(self)
		BFNew_OnAddonEnableCheckedFun(self.Addon,self.Checked);
		
		self.Addon =nil;
		self.Checked =nil;
		self.AddonexclusiveTab =nil;
		self.Item =nil
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		self.Item:SetChecked(not self.Checked);
		self.Addon =nil;
		self.Checked =nil;
		self.AddonexclusiveTab =nil;
		self.Item =nil
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		self.Addon =StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].Addon
		self.Checked =	StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].Checked
		self.Item =	StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].Item
		self.AddonexclusiveTab = StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].AddonexclusiveTab
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["BF_LEVEL_SUILT_TEXT_DLG"] = {
	text = BF_LEAVESUITSTATE_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BigfootNewMainFrame_BigfootSuitSeleteFun(self.Text)
		self.Text =nil;
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		BigfootSuitDropDownMenu.selectbuttonID =self.oldText;
		BigfootNewMainFrame_BigfootSuitDropDownMenuUpdateShow()
		self.Text =nil;
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		self.Text = StaticPopupDialogs["BF_LEVEL_SUILT_TEXT_DLG"].Text
		self.oldText = StaticPopupDialogs["BF_LEVEL_SUILT_TEXT_DLG"].oldText
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG"] = {
	text = BF_DEPSTAB_TEXT,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BFNew_OnAddonEnableCheckedFun(self.Addon,self.Checked);
		self.Addon =nil;
		self.Checked =nil;
		self.AddonexclusiveTab =nil;
		self.Item =nil
		
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		self.Item:SetChecked(not self.Checked);
		self.Addon =nil;
		self.Checked =nil;
		self.AddonexclusiveTab =nil;
		self.Item =nil
		
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		self.Addon =StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG"].Addon
		self.Checked =	StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG"].Checked
		self.Item =	StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG"].Item
		
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG1"] = {
	text = BF_DEPSTAB_TEXTA,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BFNew_OnAddonEnableCheckedFun(self.Addon,self.Checked);
		self.Addon =nil;
		self.Checked =nil;
		self.AddonexclusiveTab =nil;
		self.Item =nil
		
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		self.Item:SetChecked(not self.Checked);
		self.Addon =nil;
		self.Checked =nil;
		self.AddonexclusiveTab =nil;
		self.Item =nil
		
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		self.Addon =StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG1"].Addon
		self.Checked =	StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG1"].Checked
		self.Item =	StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG1"].Item
		
		ShieldedFrame:Show()
		self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
StaticPopupDialogs["BF_RESETCONFIG"] = {
	text = BF_RESET_DIALOG,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		BigfootResetCurrent()
		ReloadUI();
		ShieldedFrame:Hide()
	end,
	OnCancel = function(self)
		ShieldedFrame:Hide()
	end,
	OnShow = function (self)
		 ShieldedFrame:Show()
		 self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+11)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};




-- |cffffffff"..m_CheckStr.."|r

local m_TallFilter;
-- m_TallFilter:SetBHaveConfig(1)
-- local G_ShowEnvironment;
-- local G_ShowAddonList;
--local G_SaveSuiltList;
G_SaveSuiltList=nil
local BSuiltState =false
local BSuiltChangeState =nil;
local BShowTextDlg = true;
function BFNew_SetShowTextDlgData(bShow)
	BShowTextDlg = bShow
end
function BigfootNewMainFrame_OnHide_SetSuiltState(bsure)
	if not BSuiltChangeState then
		BSuiltState =bsure;
		BigfootSuitDropDownMenu.selectbuttonID = -1;
	end
end
function BigfootNewMainFrame_SetSuiltChangeState(bsure)
	BSuiltChangeState = bsure;
end
function BigfootNewMainFrame_ShowInfoGameTooltip(self)
	if self:GetParent().Addon then
		local str,bUsable,bOutDate =self:GetParent().Addon:GetInfo(true)
		BigFootNew_Tooltip:SetOwner(self)
		if bUsable then
			BigFootNew_Tooltip:AddLine(BF_NEW_NOT_USED, 1, 1, 1, 1)
		end
		if bOutDate then
			BigFootNew_Tooltip:AddLine(BF_ADDON_OUTDATE, 1, 1, 1, 1)
		end
		BigFootNew_Tooltip:AddLine(str, 1, 1, 1, 1)
		local x,y = BigFootNew_Tooltip:GetSize();
		BigFootNew_Tooltip:SetAnchorType("ANCHOR_LEFT",x,0)
		BigFootNew_Tooltip:SetScale(0.7)
		BigFootNew_Tooltip:Show()
	end
end
function BigfootNewMainFrame_ShowStatusGameTooltip(self)
	if self:GetParent().statustext:GetText() then
		BigFootNew_Tooltip:SetOwner(self)
		BigFootNew_Tooltip:AddLine(self:GetParent().statustext:GetText(), 1, 1, 1, 1)
		local x,y = BigFootNew_Tooltip:GetSize();
		BigFootNew_Tooltip:SetAnchorType("ANCHOR_LEFT",x,0)
		BigFootNew_Tooltip:SetScale(0.7)
		BigFootNew_Tooltip:Show()
	end
end
function BigfootNewMainFrame_ShowOptionGameTooltip(self)
	if self:GetParent().statustext:GetText() then
		BigFootNew_Tooltip:SetOwner(self)
		BigFootNew_Tooltip:AddLine(self:GetParent().statustext:GetText(), 1, 1, 1, 1)
		local x,y = BigFootNew_Tooltip:GetSize();

		BigFootNew_Tooltip:SetAnchorType("ANCHOR_LEFT",x,0)
		BigFootNew_Tooltip:Show()
	end
end

function BigfootNewMainFrame_ConfigSetting_OnEnter(self)
	if self.config and self.config:GetCaption() then
		local textTip = self.config:GetTooltip()
		if textTip then
			BigFootNew_Tooltip:SetOwner(self)
			BigFootNew_Tooltip:SetText(textTip)
			local x,y = BigFootNew_Tooltip:GetSize();
			-- print(x,y)
			BigFootNew_Tooltip:SetAnchorType("ANCHOR_LEFT",x,-2*y)
			BigFootNew_Tooltip:SetScale(0.7)
			BigFootNew_Tooltip:Show()
		end
	end
end
function BigfootNewMainFrame_GetShowAddonList(m_ShowEnvironment,BNotFilter)
	------------------------------------
	local AddonList;
	if BNotFilter then
		local Filter = Filter.new(true,"All","");
		AddonList =m_ShowEnvironment:Search(Filter);
	else
		if not m_TallFilter then
			m_TallFilter = Filter.new(true,"All","");
		end
		AddonList =m_ShowEnvironment:Search(m_TallFilter);
	end
	if AddonList then
		BF_AddonSort(AddonList,5,true)
	end
	return AddonList;
end
function BigfootNewMainFrame_OnSearchBox_OnLoad(self)
	SearchBoxTemplate_OnLoad(self)
	self:SetText(BigfootNewMainFrame_SearchBigFoot);
end
function BigfootNewMainFrame_OnEditFocusGained(self)
	SerachBoxTemplate_OnEditFocusGained(self);
	if string.find(key,BigfootNewMainFrame_NotSearchKey) then
		self:SetText("");
	end
end
function BigfootNewMainFrame_OnEditFocusLost(self)
	self:HighlightText(0, 0);
	self:SetFontObject("GameFontDisable");
	self.searchIcon:SetVertexColor(0.6, 0.6, 0.6);
	if ( self:GetText() == "" or string.find(self:GetText(),BigfootNewMainFrame_NotSearchKey) ) then

		if self.SearchStr then
			self:SetText(self.SearchStr);
		end
		self.clearButton:Hide();
	end
end
function BigfootNewMainFrame_OnSearchBoxChange(self,userInput)
	-- -- print(self:GetText())
	key = self:GetText()
	if string.find(key,BigfootNewMainFrame_NotSearchKey) then
		return;
	end
	if not m_TallFilter then
		m_TallFilter = Filter.new(true,"All","")
	end
	m_TallFilter:SetStr(key)
	-- print("m_TallFilter:GetStr() ",m_TallFilter:GetStr() )
	
	_G["guidertestButton1"]:Click()
	BigfootNewMainFrame_UpdateShow()
end

function MbbSearchNewFrame(key)
	if string.find(key,BigfootNewMainFrame_NotSearchKey) then
		return;
	end
	if not m_TallFilter then
		m_TallFilter = Filter.new(true,"All","")
	end
	m_TallFilter:SetStr(key)
	_G["guidertestButton1"]:Click()
	BigfootNewMainFrame_UpdateShow()
end

function BigfootNewMainFrame_GuiderBarSearchResultMod(b_toggle)
	if b_toggle then
		for i=1,# BFNew_GetAddonTypeList() do
			if i == 1 then
				_G["guidertestButton" .. i].text:SetText(ALL_RESULTS)
			elseif i == 2 then
				_G["guidertestButton" .. i].text:SetText(RETURN)
			else
				_G["guidertestButton" .. i]:Hide()
			end
		end
	else
		for i=1,# BFNew_GetAddonTypeList() do
			if i == 1 then
				_G["guidertestButton" .. i].text:SetText(BF_TEXT_ALL)
			elseif i == 2 and BFNew_GetAddonTypeList()[2] then
				_G["guidertestButton" .. i].text:SetText(BFNew_GetAddonTypeList()[2])
			elseif i >2 then
				_G["guidertestButton" .. i]:Show()
			end
		end

	end
end


--------------search Editbox funcs------------------

local BigfootNewMainFrame_SeleteAddon="";
function BigfootNewMainFrame_OnElemButtOnClick(self)
	local parent =self:GetParent();
	if parent.nametext then
		local Str = parent.AddonName;
		local Addon =parent.Addon;
		if BigfootNewMainFrame_SeleteAddon ~=Str then
			BigfootNewMainFrame_SeleteAddon =Str;
			if (#Addon:GetAddonConfigList()>0) and Addon:GetEnable() then
				if not (Addon:IsAddonOutDate() == 1) then
					BigfootNewMainFrame.settinginfo:Show();
				end
				BigfootNewMainFrame_UpdateSettingFrame(Addon);
			else
				BigfootNewMainFrame.settinginfo:Hide();
			end
		else
			if BigfootNewMainFrame.settinginfo:IsShown() then
				BigfootNewMainFrame.settinginfo:Hide();
			else
				if (#Addon:GetAddonConfigList()>0) and Addon:GetEnable() then
					if not (Addon:IsAddonOutDate() == 1) then
						BigfootNewMainFrame.settinginfo:Show();
					end
					BigfootNewMainFrame_UpdateSettingFrame(Addon);
				end
			end
		end
		BigfootNewMainFrame_UpdateAddonListEleButton()
	end
end
local function BigfootNewMainFrame_CheckStr(m_Str)
	local m_CheckStr =nil;
	if  m_TallFilter then
		m_CheckStr =m_TallFilter:GetStr()
	end
	if m_CheckStr and m_CheckStr~="" then
		local Pos = string.find(string.lower(m_Str),string.lower(m_CheckStr))
		if Pos then
			local pos1 = string.find(m_Str,"|c")
			if pos1 then
				local color = string.sub(m_Str,pos1,10);
				m_Str =string.gsub(m_Str,string.sub(m_Str,Pos,Pos+string.len(m_CheckStr)-1),"|r|cffffffff"..string.sub(m_Str,Pos,Pos+string.len(m_CheckStr)-1).."|r"..color);
			else
				m_Str =string.gsub(m_Str,string.sub(m_Str,Pos,Pos+string.len(m_CheckStr)-1),"|cffffffff"..string.sub(m_Str,Pos,Pos+string.len(m_CheckStr)-1).."|r");
			end
		end
		-- m_Str =string.gsub(m_Str,m_CheckStr,"|cffffffff"..m_CheckStr.."|r");
	end
	return m_Str;
end
function BigfootNewMainFrame_UpdateAddonListEleButton()
	local scrollFrame = BF_AddonListContainer;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local results = scrollFrame.buttons;
	local result, index;
	----------------------------------------
	if not G_ShowEnvironment then
		G_ShowEnvironment = BigfootNewMainFrame_GetShowEnvironment();
	end
	if BSuiltState then
		BigfootNewMainFrame_SuitOptionMod(true,G_ShowEnvironment:GetName())
	elseif not (m_TallFilter:GetStr() == "") then
		BigfootNewMainFrame_GuiderBarSearchResultMod(true)
	else
		BigfootNewMainFrame_GuiderBarSearchResultMod(false)
	end
	
	
	-- local m_ShowEnvironment = G_ShowEnvironment;
	------------------------------------------
	-- G_ShowAddonList = BigfootNewMainFrame_GetShowAddonList(G_ShowAddonList)
	local AddonList = G_ShowAddonList
	if not AddonList then return end
	local numResults = #AddonList;   ------结果数量
	local title,name,info,consume,status,ShowAddon,ConfigEnable,bUsable,bOutDate;
	local ShowState;
	local BAll =1;
	for i = 1,#results do
		result = results[i];
		index = offset + i;
		if index <= numResults then
			ShowAddon = AddonList[index];
			if ShowAddon then
				-- status 1 -将要启用 ,2 - 将要关闭,3 - 已启用,4 - 已经关闭
				title,name,consume,status = ShowAddon:GetTitle(),ShowAddon:GetName(),ShowAddon:GetStrMemory(),ShowAddon:GetState()
				info,bUsable,bOutDate = ShowAddon:GetInfo(true)
				if bUsable then
					info = BF_NEW_NOT_USED
				end
				if bOutDate then
					info = BF_ADDON_OUTDATE
				end
				ShowState= ShowAddon:GetShowState()
				result.AddonName = name;
				result.Addon = ShowAddon;
				result.titletext:SetText(BigfootNewMainFrame_CheckStr(title));
				result.nametext:SetText(BigfootNewMainFrame_CheckStr(name))
				result.infotext:SetText(BigfootNewMainFrame_CheckStr(info));
				result.consumetext:SetText(BigfootNewMainFrame_CheckStr(consume));
				ConfigEnable = ShowAddon:GetConfigEnable()
				result.enabled:SetChecked(ConfigEnable)
				if ShowAddon:GetCanCheck() then
					result.enabled:Enable();
				else
					result.enabled:Disable();
				end
				if ShowState then
					if ShowState ==2 then
						result.new:Show();
						BigfootNewMainFrame_SetTitleSignPoint(result)
						result.up:Hide();
					elseif ShowState ==1 then
						result.new:Hide();
						result.up:Show();
						BigfootNewMainFrame_SetTitleSignPoint(result)
					else
						result.new:Hide();
						result.up:Hide();
					end
				else
					result.new:Hide();
					result.up:Hide();
				end
				-- if not ConfigEnable then
					-- BAll=nil;
				-- end
				if BigfootNewMainFrame_SeleteAddon == name then
					result.Checked =true
					result.TChecked:Show()
				else
					result.Checked =false
					result.TChecked:Hide()
				end
				if statusText[status] then
					result.statustext:SetText(BigfootNewMainFrame_CheckStr(statusText[status]));
				end

				result:SetID(index);
				result:Show();
			end
		else
			result:Hide();
		end
	end
	for k,v in pairs(AddonList) do
		if not v:GetConfigEnable() and v:GetCanCheck() then
			BAll = nil
			break;
		end
	end
	if BF_MainFrame_SelectAllButton then
		BF_MainFrame_SelectAllButton:SetChecked(BAll)
	end
	local totalHeight = (numResults * 35);
	HybridScrollFrame_Update(scrollFrame, totalHeight, 370);
end
function BigfootNewMainFrame_SetTitleSignPoint(self)
	local offset = 2
	if self.titletext:GetText() then
		self.up:ClearAllPoints()
		self.new:ClearAllPoints()
		if self.titletext:GetStringWidth()< self.titletext:GetWidth() then
			self.up:SetPoint("LEFT",self.titletext,"LEFT",offset+self.titletext:GetStringWidth(),-1)
			self.new:SetPoint("LEFT",self.titletext,"LEFT",offset+self.titletext:GetStringWidth(),-1)
		else
			self.up:SetPoint("LEFT",self.titletext,"LEFT",self.titletext:GetWidth(),-1)
			self.new:SetPoint("LEFT",self.titletext,"LEFT",self.titletext:GetWidth(),-1)
		end
	end
end
function BigfootNewMainFrame_OnElemButtonEnter(self)
	local parentFrame = self:GetParent()
	local HighlightTexture = _G[parentFrame:GetName().."HighlightTexture"];
	abdf = HighlightTexture
	if HighlightTexture then
		HighlightTexture:Show()
	end
end
function BigfootNewMainFrame_OnElemButtonLeave(self)
	local parentFrame = self:GetParent()
	local HighlightTexture = _G[parentFrame:GetName().."HighlightTexture"];
	if HighlightTexture then
		HighlightTexture:Hide()
	end
end

local function BigfootNewMainFrame_UpdateAddonMemory(m_ShowAddonList)
	if m_ShowAddonList  then
		BFNew_SetListAddonEnableInfo(m_ShowAddonList)
		for k,v in pairs(m_ShowAddonList) do
			v:GetMemory(1);
		end
	end
end
local function BigfootNewMainFrame_GetDepsTabAddon(m_Addon,BChecked)
	local DepsTab={}
	m_table={};
	local name, title, notes, enabled, loadable, reason, security
	if BChecked then
		DepsTab =m_Addon:GetdepsTab();
		for k,v in pairs (DepsTab) do
			name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v);
			if (not enabled) and reason~="MISSING" then
				table.insert(m_table,v);
			end
		end
	else
		local m_name =m_Addon:GetName();
		if G_ShowEnvironment then
			for k,v in pairs (G_ShowEnvironment:GetAddonList()) do
				if v  then
					DepsTab =v:GetdepsTab();
					for i,j in pairs(DepsTab) do
						if m_name ==j then
							name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v:GetName());
							if enabled and loadable then
								table.insert(m_table,v:GetName());
							end
						end
					end
				end
			end
		end
	end
	return m_table;
end

local function BigfootNewMainFrame_GetdepsAddon(m_Addon,BChecked)
	local depsTab={};
	depsTab = BigfootNewMainFrame_GetDepsTabAddon(m_Addon,BChecked)--m_Addon:GetdepsTab();
	if not G_ShowEnvironment then return end
	local addon;
	local AddonTab ={};
	for k,v in pairs (depsTab) do
		addon = G_ShowEnvironment:GetAddon(v);
		if addon then--and not addon:GetConfigEnable() then
			if not addon:GetConfigEnable() then
				addon:SetConfigEnable(1);
				table.insert(AddonTab,addon);
			else
				addon:SetConfigEnable(nil);
				table.insert(AddonTab,addon);
			end
		end

	end
	return AddonTab
end
local function BigfootNewMainFrame_GetexclusiveTabAddon(m_Addon,BChecked)
	local exclusiveTab ={};
	exclusiveTab = m_Addon:GetexclusiveTab();
	local m_table={};
	local name, title, notes, enabled, loadable, reason, security
	if BChecked then
		for k,v in pairs (exclusiveTab) do
			name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v);
			if enabled then
				table.insert(m_table,v);
			end
		end
	end
	return m_table;
end

function BFNew_OnAddonEnableCheckedFun(m_Addon,BChecked)
	m_Addon:SetConfigEnable(BChecked);

	local AddonTab= BigfootNewMainFrame_GetdepsAddon(m_Addon,BChecked)
	for k,v in pairs(AddonTab) do
		v:submitSet(1);
	end
	
	m_Addon:submitSet(1);
	BFNew_SavedCurrentSuit()
	-----------------------------

	BFNew_SetListAddonEnableInfo(G_ShowAddonList)
	BigfootNewMainFrame.settinginfo:Hide()
	BigfootNewMainFrame_UpdateAddonMemory(G_ShowAddonList);
	BigfootNewMainFrame_UpdateAddonListEleButton()
end
 
function BFNew_OnAddonEnableChecked(self)
	if BSuiltState then
		local Item = self:GetParent();
		Item.Addon:SetConfigEnable(self:GetChecked());
		BigfootNewMainFrame_SetSuiltChangeState(true)
		BigfootNewMainFrame.settinginfo:Hide()
		BigfootNewMainFrame_UpdateAddonListEleButton();
		-- BigfootNewMainFrame_OnShow();
	else
		local Item = self:GetParent();
		local AddonexclusiveTab = BigfootNewMainFrame_GetexclusiveTabAddon(Item.Addon,self:GetChecked());
		local AddonDepsTab = BigfootNewMainFrame_GetDepsTabAddon(Item.Addon,self:GetChecked());
		if #AddonexclusiveTab>0 and BShowTextDlg then

			StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].Addon = Item.Addon;
			StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].Checked = self:GetChecked();
			StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].Item = self;
			StaticPopupDialogs["BF_SELETE_ADDON_TEXT_DLG"].AddonexclusiveTab =AddonexclusiveTab;
			local str=""
			for k,v in pairs (AddonexclusiveTab) do
				if k ==#AddonDepsTab then
					str = str.."|cffffff00"..v.."|r";
				else
					str = str.."|cffffff00"..v.."|r".."\n";
				end
			end
			StaticPopup_Show("BF_SELETE_ADDON_TEXT_DLG","|cffffff00"..Item.Addon:GetName().."|r",str);
		elseif #AddonDepsTab>0 and BShowTextDlg then
			if self:GetChecked() then
				StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG"].Addon = Item.Addon;
				StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG"].Checked = self:GetChecked();
				StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG"].Item = self;
				local str=""
				for k,v in pairs (AddonDepsTab) do
					if k ==#AddonDepsTab then
						str = str.."|cffffff00"..v.."|r";
					else
						str = str.."|cffffff00"..v.."|r".."\n";
					end
				end
				StaticPopup_Show("BF_DEPSTAB_TEXT_DLG","|cffffff00"..Item.Addon:GetName().."|r",str);
			else
				StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG1"].Addon = Item.Addon;
				StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG1"].Checked = self:GetChecked();
				StaticPopupDialogs["BF_DEPSTAB_TEXT_DLG1"].Item = self;
				local str=""
				for k,v in pairs (AddonDepsTab) do
					if k ==#AddonDepsTab then
						str = str.."|cffffff00"..v.."|r";
					else
						str = str.."|cffffff00"..v.."|r".."\n";
					end
				end
				StaticPopup_Show("BF_DEPSTAB_TEXT_DLG1","|cffffff00"..Item.Addon:GetName().."|r",str);
			end
		else
			BFNew_OnAddonEnableCheckedFun(Item.Addon,self:GetChecked())
		end
	end
end

local function BF_MainFrame_Check_AddonExclusive(Bcheck)
	if (not G_ShowAddonList)  or (not Bcheck) then return end
	local exclusiveTab ={};
	local CheckTab={};
	local CheckNum =1;
	local AllNumber = #G_ShowAddonList
	local m_addon;
	local bHave;
	local haveTab={}
	local resuleTable={}
	local t_addon;
	while(CheckNum<=AllNumber) do
		m_addon =G_ShowAddonList[CheckNum];
		exclusiveTab ={};
		exclusiveTab = m_addon:GetexclusiveTab();
		if #exclusiveTab>0 and not CheckTab[m_addon:GetName()] then
			CheckTab[m_addon:GetName()] =true;
			table.insert(exclusiveTab,m_addon:GetName());
		else
			exclusiveTab ={};
		end
		haveTab={}
		for k,v in pairs(exclusiveTab) do
			bHave =false;
			for i,j in pairs(G_ShowAddonList) do
				if v == j:GetName() then
					bHave =true;
					break;
				end
			end
			if G_ShowEnvironment then
				t_addon= G_ShowEnvironment:GetAddon(v);
				if t_addon and t_addon:GetConfigEnable()  then
					bHave =true;
				end
			end
			if bHave then
				CheckTab[v] =true;
				table.insert(haveTab,v);
			end
		end
		if #haveTab >=2 then
			-- for k,v in pairs(haveTab) do
				-- table.insert(resuleTable,v)
			-- end
			table.insert(resuleTable,haveTab);
		end
		CheckNum =CheckNum +1;
	end
	CheckTab=nil;
	exclusiveTab=nil;
	haveTab=nil;
	t_addon =nil;
	return resuleTable;
end
function BF_MainFrame_Check_Enabled_OnClick(b_toggle)
	local m_table =BF_MainFrame_Check_AddonExclusive(b_toggle)
	if m_table and #m_table>1 then
		StaticPopupDialogs["BF_SELETE_ALL_SUILT"].Text = b_toggle
		 
		local Str=""
		for k,v in pairs (m_table)do
			for i,j in pairs(v) do
				if i~=#v then
					Str = Str.."|cffffff00"..j.."|r"..BF_Text_AND;
				else
					Str = Str.."|cffffff00"..j.."|r"..";";
				end
			end
			Str = Str.."\n";
		end
		m_table =nil;
		StaticPopup_Show("BF_SELETE_ALL_SUILT",Str);
	elseif b_toggle == 1 then
		StaticPopupDialogs["BF_SELETE_ALL_SUILT1"].Text = b_toggle
		StaticPopup_Show("BF_SELETE_ALL_SUILT1");
	elseif b_toggle == nil then
		StaticPopupDialogs["BF_DISABLE_ALL_SUILT"].Text = b_toggle
		StaticPopup_Show("BF_DISABLE_ALL_SUILT");
	end
end
function BigfootNewMainFrame_SuitOptionMod(bToggle,suitName)
	if bToggle and suitName then
		for i=1,# BFNew_GetAddonTypeList() do
			if i == 1 then
				_G["guidertestButton" .. i].text:SetText(suitName)
				_G["guidertestButton" .. i]:SetChecked(1)
			elseif i == 2 then
				_G["guidertestButton" .. i].text:SetText(RETURN)
			else
				_G["guidertestButton" .. i]:Hide()
			end
		end
	else
		for i=1,# BFNew_GetAddonTypeList() do
			if i == 1 then
				_G["guidertestButton" .. i].text:SetText(BF_TEXT_ALL)
			elseif i == 2 and BFNew_GetAddonTypeList()[2] then
				_G["guidertestButton" .. i].text:SetText(BFNew_GetAddonTypeList()[2])
			elseif i >2 then
				_G["guidertestButton" .. i]:Show()
			end
		end

	end
end
local LaterTab={};
local CallTab ={};
function BFNew_OnAllAddonLoadFun(btrue)
	-- print("BFNew_OnAllAddonLoadFun",btrue)
	if G_ShowAddonList then
		CallTab =nil
		CallTab ={};
		for k,v in pairs(G_ShowAddonList) do
			if v  then
				if v:GetCanCheck() then
					v:SetConfigEnable(btrue);
					table.insert(CallTab,v);
				end
			end
		end
		if not BSuiltState then
			BFNew_SavedCurrentSuit()
		end
		BigFoot_DelayCall(BFNew_OnAllAddonLoadCallback,0.2);
	end
end
function BFNew_OnAllAddonLoadCallback()
	local m_CallTab = CallTab;
	local UsedTimw =0
	local bReSet =false
	local Bdone =false;
	while(#m_CallTab>0) do
		local UsedTab = table.remove(m_CallTab,1)
		if not UsedTab then
		end

		if InCombatLockdown() then
			table.insert(LaterTab,UsedTab)
		else
			local m_Time1 =GetTime()
			if not Bdone then Bdone =true end
			if not BSuiltState then 
				UsedTab:submitSet(1);
			end
			UsedTimw = GetTime()-m_Time1+UsedTimw
			if UsedTimw >0.2 then
				BigFoot_DelayCall(BFNew_OnAllAddonLoadCallback,0.4);
				bReSet =true;
				break;
			end
		end
	end
	if #LaterTab>0 and not bReSet then
		CallTab = LaterTab;
		LaterTab=nil;
		LaterTab ={};
		BigFoot_DelayCall(BFNew_OnAllAddonLoadCallback,0.4);
	end
	if #CallTab ==0 and #LaterTab==0  and Bdone then
		-- __BigFoot_CallAllEnd()
		LaterTab=nil;
		CallTab =nil;
		LaterTab={};
		CallTab ={};
		collectgarbage("collect")
		
		-----------------全选完成------------------
		-- BigfootNewMainFrame_OnShow(BSuiltState);
		BigfootNewMainFrame_UpdateShow(BSuiltState)
		if BSuiltState then
			BSuiltChangeState =true;
		else
			
		end
	end
end

function BigfootNewMainFrame_OnLoad(self)
	HybridScrollFrame_CreateButtons(BF_AddonListContainer,"BF_AddonListElemButtonTemplate",0,0,"TOPLEFT","TOPLEFT")
	BF_AddonListContainer.stepSize = 20
	BF_AddonListContainer.scrollBar.doNotHide =true;
	-- -- print("HybridScrollFrame_CreateButtons1",BF_AddonListContainer.scrollBar:GetMinMaxValues())
	BF_AddonListContainer.update =BigfootNewMainFrame_UpdateAddonListEleButton
	BF_AddonListContainer:SetScale(1)
	
	-- BigfootNewMainFrame_UpdateAddonListEleButton()
	-- -- print("HybridScrollFrame_CreateButtons2",BF_AddonListContainer.scrollBar:GetMinMaxValues())
	if BigfootNewMainFrame then
		BigfootNewMainFrame:SetScale(0.85)
		-- BigfootNewMainFrame:Show()
	end
	-- -- print("MainFrame Onload")
	BigfootNewMainFrame_textureRepeat()
	BigfootNewMainFrame_tabButtonsOnLoad()
	BigfootNewMainFrame_CreateHeaderButtons(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_LOGOUT");
end
function BigfootNewMainFrame__OnEvent(self, __event,...)
	if ( __event == "PLAYER_ENTERING_WORLD" ) then
		if not G_SaveSuiltList then
			G_SaveSuiltList = BF_GetAllSuits();
		end
	elseif ( __event == "ADDON_LOADED" ) then
		if self:IsShown() then
			-- BigfootNewMainFrame_OnShow();
		end
	elseif ( __event == "PLAYER_LOGOUT" ) then
		if BigfootNewMainFrame_IsHaveNotSaveDate() then
			 G_ShowEnvironment:SetName(BF_BIGFOOT_backup);
			 BF_SaveSuit(G_ShowEnvironment)
		end
	end
end

function BigfootNewMainFrame_SetDropDownMenu(m_ShowEnvironment)
	-- -- print("BigfootNewMainFrame_SetDropDownMenu",m_ShowEnvironment:GetName())
	-- UIDropDownMenu_RefreshAll
	-- ToggleDropDownMenu(nil, nil, BigfootNewMainFrameSelectSuitButton);
	-- ToggleDropDownMenu(nil, nil, BigfootNewMainFrameSelectSuitButton);
	-- UIDropDownMenu_SetSelectedValue(BigfootNewMainFrameSelectSuitButton, m_ShowEnvironment:GetName())
	-- BigfootSuitDropDownMenu.selectbuttonID = nil
	-- UIDropDownMenu_SetSelectedID(BigfootNewMainFrameSelectSuitButton,1)
	
end
function BigfootNewMainFrame_GetShowEnvironment()
	local m_ShowSuiltName ="Current";
	-- if BF_Gloable.SeleteSuilt then
		-- m_ShowSuiltName = BF_Gloable.SeleteSuilt;
	-- end
	m_ShowSuiltName = BF_GetSaveSuitName();
	-- G_SaveSuiltList
	local G_ShowEnvironment =nil;
	if G_SaveSuiltList then
	-- G_ShowEnvironment = CurrentEnvironment  --------------------------当前显示的插件环境
		G_ShowEnvironment = G_SaveSuiltList[m_ShowSuiltName];
	end
	if not G_ShowEnvironment then
		G_ShowEnvironment = CurrentEnvironment
	end
	BFNew_SetEnvironmentAddonInfo(G_ShowEnvironment);

	-- G_ShowAddonList = BigfootNewMainFrame_GetShowAddonList(G_ShowEnvironment)
	-- BigfootNewMainFrame_UpdateAddonMemory(G_ShowAddonList);
	return G_ShowEnvironment;
end
function BigfootNewMainFrame_UpdateEditBoxState(BNotFilter)
	if BNotFilter==nil then
		BNotFilter = BSuiltState;
	end
	if not BF_SearchBox then return end
	-- BF_SearchBox:ClearFocus();
	if BNotFilter then
		BF_SearchBox:Hide()
		BF_MainFrame_SelectAllButton1:Hide()
		BigfootNewMainFrame_selectTab(_G[defaultSelectedTab.."TabButton"],true)
		m_TallFilter:SetBbigfoot(true);
		_G["SingleTabButton"]:Disable();
		BigfootNewMainFrameSaveSuitButton:Enable();
	else
		BF_SearchBox:Show()
		BF_MainFrame_SelectAllButton1:Show()
		_G["SingleTabButton"]:Enable();
	end
end
function BigfootNewMainFrame_UpdateShow(BNotFilter)
	BigfootNewMainFrame.settinginfo:Hide()
	BigfootMainSettingFrame:Hide();
	if (not m_TallFilter)or (not m_TallFilter:GetType())  then
		BF_NewCategoryButtonSetState(1);
	end
	if G_ShowEnvironment then
		BigfootNewMainFrame_UpdateEditBoxState(BNotFilter)
		BigfootNewMainFrame_SetDropDownMenu(G_ShowEnvironment)
		G_ShowAddonList = BigfootNewMainFrame_GetShowAddonList(G_ShowEnvironment,BNotFilter)
		BigfootNewMainFrame_UpdateAddonMemory(G_ShowAddonList);
	end
	
	-- HybridScrollFrame_SetOffset(BF_AddonListContainer,0);
	BF_AddonListContainer.scrollBar:SetValue(0)
	BigfootNewMainFrame_UpdateAddonListEleButton()
end
local function BigfootNewMainFrame_InitAllState()
	G_SaveSuiltList =nil;
	G_ShowEnvironment =nil;
	G_ShowAddonList =nil;
	BigfootNewMainFrame_ClearOptionPanel();
	collectgarbage("collect")
	G_SaveSuiltList = BF_GetAllSuits();
	-- BigfootNewMainFrame_SeleteAddon="";
end

function BigfootNewMainFrame_IsHaveNotSaveDate()
	if BSuiltState  and BSuiltChangeState then
		return true
	end
end

function BigfootNewMainFrame_OnShow(BCurrent)
	if BigfootNewMainFrame_IsHaveNotSaveDate() then return end
	BigfootNewMainFrame_InitAllState()
--	print("behind the init",#__suitList)
	if BCurrent then
		G_ShowEnvironment = BigfootNewMainFrame_GetShowEnvironment()
		BigfootNewMainFrame_UpdateShow(1)
	else
		G_ShowEnvironment = CurrentEnvironment;
		BFNew_SetEnvironmentAddonInfo(G_ShowEnvironment);
		BigfootNewMainFrame_UpdateShow()
	end
	BigfootNewMainFrame_BigfootSuitDropDownMenuInit()
	BigfootNewMainFrame_SetSuiltState(BSuiltState)
end

function BigfootNewMainFrame_MouseDown(self,button)
	if button == "LeftButton" then
		self:StartMoving()
	end
end

function BigfootNewMainFrame_MouseUp(self,button)
	if button == "LeftButton" then
		self:StopMovingOrSizing()
	end
end
-- function HybridScrollFrame_SetOffset(self, value)
	-- -- print(self:GetName())
-- end

-- hooksecurefunc("HybridScrollFrame_CreateButtons", function()
	-- -- print("HybridScrollFrame_CreateButtons",BF_AddonListContainer.scrollBar:GetMinMaxValues())
-- end)

function BigfootNewMainFrame_textureRepeat()       --------背景循环填充
	local repeatTexture;
	for i=1,14 do
		repeatTexture = BigfootNewMainFrame:CreateTexture("BF_MainFrameTexture" .. i,"BACKGROUND","BF_MainFrame_Repeat")
		repeatTexture:ClearAllPoints()
		if i ==1 then
			repeatTexture:SetPoint("TOPLEFT",BigfootNewMainFrame.leftborder,"TOPRIGHT")
		elseif i ==14 then
			repeatTexture:SetPoint("TOPLEFT","BF_MainFrameTexture" .. i-1,"TOPRIGHT")
			repeatTexture:SetPoint("TOPRIGHT",BigfootNewMainFrame.rightborder,"TOPLEFT")
		else
			repeatTexture:SetPoint("TOPLEFT","BF_MainFrameTexture" .. i-1,"TOPRIGHT")

		end

	end
end

local function BigfootNewMainFrame_CreateTabButtons()    ---------创建Tab按纽
	local tempButton
	for i=1,#TabList do
		tempButton = CreateFrame("BUTTON",TabList[i] .. "TabButton",BigfootNewMainFrame,"BF_Tab_Template")
		tempButton:SetText(BF_L[TabList[i]])
		tempButton.id = i
		-- tempButton:SetSize(100,50)
		if i == 1 then
			tempButton:SetPoint("TOPLEFT",17,-85)
		else
			tempButton:SetPoint("LEFT",TabList[i-1] .. "TabButton","RIGHT",-5,0)
		end
	end
end

function BigfootNewMainFrame_tabButtonsOnLoad()         --------初始化Tab按纽
	BigfootNewMainFrame_CreateTabButtons() -----Tab 页按钮你
	BigfootNewMainFrame_selectTab(_G[defaultSelectedTab.."TabButton"],true)
	BigfootNewMainFrame_CreateGuideButtons() -------类型按钮
	BigfootNewMainFrame_CreateSearchBox() -------搜索
end

-----------------warning frame funcs------------------
function BigfootNewMainFrame_SettingInfoFrameOnLoad(self)
	self:SetFrameLevel(5)
end
----------------setting info frame funcs---------------
local function BigfootNewMainFrame_SearchInit(m_TallFilter,tabId)
	m_TallFilter:SetStr("")
	m_TallFilter:SetType("All");
	BigfootNewMainFrame_GuiderBarSearchResultMod(false);
	BF_NewCategoryButtonSetState(1);
	if tabId ==1 then
		BF_SearchBox.SearchStr =BigfootNewMainFrame_SearchBigFoot
		BF_SearchBox:SetText(BigfootNewMainFrame_SearchBigFoot);
	elseif tabId ==2 then
		BF_SearchBox.SearchStr =BigfootNewMainFrame_SearchNotBigFoot
		BF_SearchBox:SetText(BigfootNewMainFrame_SearchNotBigFoot);
	end
end
function BigfootNewMainFrame_ToggleAddonListPanel(tabId)     ----打开Tab对应的面板
	if tabId ==1 then
		if not m_TallFilter then
			m_TallFilter = Filter.new(true,"All","")
		end
		m_TallFilter:SetBbigfoot(true);
		BigfootNewMainFrameSaveSuitButton:Enable();
	elseif tabId ==2 then
		if not m_TallFilter then
			m_TallFilter = Filter.new(true,"All","")
		end
		m_TallFilter:SetBbigfoot(false);
		BigfootNewMainFrameSaveSuitButton:Disable();
	end
	if m_TallFilter then
		BigfootNewMainFrame_SearchInit(m_TallFilter,tabId)
	end
	BF_SearchBox:ClearFocus();
	BigfootNewMainFrame_UpdateEditBoxState()
	BigfootNewMainFrame_UpdateShow() -- 刷新列表
	-- BigfootNewMainFrame_OnShow();  ---刷新界面
end
function BigfootNewMainFrame_selectTab(tab,bonload)
	local name
	for i=1,#TabList do
		name =TabList[i] .. "TabButton"
		if TabList[i] .. "TabButton" == tab:GetName() then
			if not bonload then
				BigfootNewMainFrame_ToggleAddonListPanel(i)
			end
			_G[name.."Left"]:Hide();
			_G[name.."Middle"]:Hide();
			_G[name.."Right"]:Hide();
			--tab:LockHighlight();
			_G[name]:Disable();
			tab:SetDisabledFontObject(GameFontHighlightSmall);
			_G[name.."Text"]:SetPoint("CENTER", _G[name], "CENTER", (_G[name].selectedTextX or 0), (_G[name].selectedTextY or -3));
			_G[name.."LeftDisabled"]:Show();
			_G[name.."MiddleDisabled"]:Show();
			_G[name.."RightDisabled"]:Show();
		else
			_G[name .."Left"]:Show();
			_G[name .."Middle"]:Show();
			_G[name .."Right"]:Show();
			--tab:UnlockHighlight();
			_G[name]:Enable();
			_G[name .."Text"]:SetPoint("CENTER",_G[name], "CENTER", (_G[name].deselectedTextX or 0), (_G[name].deselectedTextY or -5));
			_G[name .."LeftDisabled"]:Hide();
			_G[name .."MiddleDisabled"]:Hide();
			_G[name .."RightDisabled"]:Hide();
		end
	end
end
function BigfootNewMainFrame_CreateSearchBox()
	SearEditBox=CreateFrame("EditBox","BF_SearchBox",BigfootNewMainFrame,"BigfootNewSearchBoxTemplate")
	SearEditBox.clearFunc = BigfootNewMainFrame_SearEditBoxclearFunc;
end
function BigfootNewMainFrame_SearEditBoxclearFunc(self)
	self:SetText("")
	local key = self:GetText()
	if not m_TallFilter then
		m_TallFilter = Filter.new(true,"All","")
	end
	m_TallFilter:SetStr(key)
	BigfootNewMainFrame_UpdateShow()
end

local function BigfootNewMainFrame_GetAllSuilt(b_InOption)
	local m_Tab ={}
	if G_SaveSuiltList then
		for k,v in pairs (G_SaveSuiltList) do
			if b_InOption then
				if not v:IsDefaultSuit() then
					table.insert(m_Tab,v)
				end
			else
				table.insert(m_Tab,v)
			end
		end
		table.sort(m_Tab,function(left,right) return left:GetCheckTime() > right:GetCheckTime() end);
	end
	return m_Tab;
	-- G_SaveSuiltList
end


local function BigfootNewMainFrame_UnCheckTypeButton()
	BF_NewCategoryButtonSetState(0)
end
function BigfootNewMainFrame_SetSuiltState(btrue)
	BSuiltState =btrue;
	if btrue then
		BigfootNewMainFrameReloadButton:SetText(NF_APPLY)
		-- BigfootNewMainFrame_SetAnimation(true)
		BigfootNewMainFrame_UnCheckTypeButton()
		BigfootButtonAlert_SimpleShow(BigfootNewMainFrame_Button_Text1)
	else
		BigfootNewMainFrameReloadButton:SetText(BF_RELOAD)
		-- BigfootNewMainFrame_AnimationControl(BigfootNewMainFrameReloadButton,"blink",true)
	end
end

----------header button funcs-----------------
function BigfootNewMainFrame_DelSuitButtonOnClick(self)
	-- print("Show delete suit warning frame!")
end

--------------------buttonse funcs -----
--[[self = BigfootNewMainFrame]]--
function BF_HeaderButtOnEnter(self)
	
end
function BF_HeaderButtOnLeave(self)
	
end

function BigfootNewMainFrame_NewSearch(m_Type)
	if m_TallFilter then
		m_TallFilter:SetNewSearType(m_Type)
	end
	BigfootNewMainFrame_UpdateShow()  ----刷新列表
end
function BigfootNewMainFrame_CreateHeaderButtons(self)
	local selectAll = CreateFrame("BUTTON","SelectAllHeader",self,"BF_HeaderButtonTemplate")
	selectAll:SetPoint("TOPLEFT",18,-152)
	selectAll:SetSize(41,25)
	selectAll:Disable()
	local selectAllButton = CreateFrame("CheckButton","BF_MainFrame_SelectAllButton",selectAll,"BF_MainFrame_Check_Enabled")
	selectAllButton:SetPoint("CENTER")
	-- selectAllButton:SetAlpha(0.3)
	selectAllButton:Show()
	enableitems = {
			{
				value = "EnableAll",
				text = BF_ENABLEALL,
				func = function ()
					BF_MainFrame_Check_Enabled_OnClick(1)
				end
				},
			{
				value = "DisableAll",
				text = BF_DISABLEALL,
				func = function ()
					BF_MainFrame_Check_Enabled_OnClick(nil)
				end
				}
		}
	BF_NewPanelDropDown_Register(selectAllButton,enableitems)

	local addontitle = CreateFrame("BUTTON","AddOnTitleHeader",self,"BF_HeaderButtonTemplate")
	addontitle:Disable()
	addontitle:SetPoint("LEFT",selectAll,"RIGHT")
	addontitle:SetSize(102,25)
	addontitle:SetText(BF_ADDONTITLE)
	-- addontitle.id=1
	local addonname = CreateFrame("BUTTON","AddOnNameHeader",self,"BF_HeaderButtonTemplate")
	addonname:SetPoint("LEFT",addontitle,"RIGHT")
	addonname:SetSize(102,25)
	addonname:SetText(BF_ADDONNAME)
	addonname.id=1
	local addoninfo = CreateFrame("BUTTON","AddOnInfoHeader",self,"BF_HeaderButtonTemplate")
	addoninfo:SetPoint("LEFT",addonname,"RIGHT")
	addoninfo:SetSize(320,25)
	addoninfo:SetText(BF_ADDONINFO)
	addoninfo:Disable()
	addoninfo.id=2
	local addonconsume = CreateFrame("BUTTON","AddOnConsumeHeader",self,"BF_HeaderButtonTemplate")
	addonconsume:SetPoint("LEFT",addoninfo,"RIGHT")
	addonconsume:SetSize(88,25)
	addonconsume:SetText(BF_ADDONCONSUME)
	-- addonconsume:SetHighlightTexture("Interface\\AddOns\\BigFoot\\Media\\hover_bg.tga")
	addonconsume.id=3
	local addonstatus = CreateFrame("BUTTON","AddOnStatusHeader",self,"BF_HeaderButtonTemplate")
	addonstatus:SetPoint("LEFT",addonconsume,"RIGHT")
	addonstatus:SetSize(88,25)
	addonstatus:SetText(BF_ADDONSTATUS)
	addonstatus.id=4
	
	
	-------------------添加新的选择按钮---------------------------------------
	local selectAllButton = CreateFrame("CheckButton","BF_MainFrame_SelectAllButton1",BigfootNewMainFrame,"DropDownButtonTemplate_2")
	selectAllButton:SetPoint("BOTTOMLEFT",20,15)
	local selectAllButtontext = selectAllButton:CreateFontString("BF_MainFrame_SelectAllButton1_Text","OVERLAY","DialogButtonNormalText")
	selectAllButtontext:SetPoint("LEFT",selectAllButton,"RIGHT",0,0)
	selectAllButtontext:SetWidth(150);
	selectAllButtontext:SetHeight(27);
	selectAllButtontext:SetJustifyH("LEFT")
	selectAllButtontext:SetText(BF_Text_SeleteAll)
	selectAllButton:Show()
	enableitems = {
			{
				value = "SeleteAll",
				text = BF_Text_SeleteAll,
				func = function ()
					BigfootNewMainFrame_NewSearch(1)
					selectAllButtontext:SetText(BF_Text_SeleteAll)
				end
				},
			{
				value = "SeleteEnable",
				text = BF_Text_SeleteEnable,
				func = function ()
					BigfootNewMainFrame_NewSearch(5)
					selectAllButtontext:SetText(BF_Text_SeleteEnable)
				end
				},
			{
				value = "SeleteDisable",
				text = BF_Text_SeleteDisable,
				func = function ()
					BigfootNewMainFrame_NewSearch(4)
					selectAllButtontext:SetText(BF_Text_SeleteDisable)
				end
				},
			{
				value = "SeleteCanUsed",
				text = BF_Text_SeleteCanUsed,
				func = function ()
					BigfootNewMainFrame_NewSearch(3)
					selectAllButtontext:SetText(BF_Text_SeleteCanUsed)
				end
				},	
			{
				value = "SeleteNotCanUsed",
				text = BF_Text_SeleteNotCanUsed,
				func = function ()
					BigfootNewMainFrame_NewSearch(2)
					selectAllButtontext:SetText(BF_Text_SeleteNotCanUsed)
				end
				},			
		}
	BF_NewPanelDropDown_Register(selectAllButton,enableitems)
end
function BF_NewPanelDropDown_Register(parent, menuList)	
	-- parent:RegisterForClicks("LeftButtonDown", "RightButtonUp");
	local name = parent:GetName() and parent:GetName() .. "MenuFrame" or "BigFootEasyMenu" .. BEASY_MENU_INDEX;
	parent.menuFrame = parent.menuFrame or CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate");
	parent.menuFrame:Hide();
	BEasyMenu(menuList, parent.menuFrame, "cursor", nil, nil, "MENU");
	if (parent:GetScript("OnClick")) then
		parent:HookScript("OnClick", function(self, button)			
			if (button == "LeftButton") then
				BToggleDropDownMenu(nil, nil, self.menuFrame, parent,  nil, nil, menuList);
			end
		end);
	else		
		parent:SetScript("OnClick", function(self, button)	
			if (button == "LeftButton") then	
				BToggleDropDownMenu(nil, nil, self.menuFrame, parent, nil, nil, menuList);
			end
		end);
	end
	BEASY_MENU_INDEX = BEASY_MENU_INDEX + 1;
end
local CheckDate={
[1] =false;
[2] =false;
[3] =false;
[4] =false;
};
local lastChose =nil;
local function BF_HeaderButtSortShowList()
	if not lastChose then return end
	if lastChose ==3 then
		BigfootNewMainFrame_UpdateAddonMemory(G_ShowAddonList)
	end
	if lastChose ==3 then
		G_ShowAddonList = BF_AddonSort(G_ShowAddonList,lastChose,CheckDate[lastChose])
	else
		BF_AddonSort(G_ShowAddonList,lastChose,CheckDate[lastChose])
	end
end
local function BF_HeaderButtUpdataButtonState()
	local m_list ={
	-- "AddOnTitleHeader",
	"AddOnNameHeader",
	"AddOnInfoHeader",
	"AddOnConsumeHeader",
	"AddOnStatusHeader",
	}
	local m_itemArrawDown,m_itemArrawUp;
	for k,v in pairs (m_list) do
		m_itemArrawDown =_G[v.."ArrawDown"];
		m_itemArrawUp = _G[v.."ArrawUp"];
		if m_itemArrawDown and m_itemArrawUp  then
			m_itemArrawDown:Hide();
			m_itemArrawUp:Hide();
			if lastChose and  k ==lastChose then
				if CheckDate[lastChose] then
					m_itemArrawDown:Hide();
					m_itemArrawUp:Show();
				else
					m_itemArrawDown:Show();
					m_itemArrawUp:Hide();
				end
			end
		end
	end

end
function BF_HeaderButtOnClick(self)
	if self.id and G_ShowAddonList then
		CheckDate[self.id] = not CheckDate[self.id];
		lastChose = self.id;
		BF_HeaderButtSortShowList()
	end
	BF_HeaderButtUpdataButtonState()
	BigfootNewMainFrame_UpdateAddonListEleButton()
end

function BigfootNewMainFrame_ConfigCheckButtonOnLoad(self)
end
----------config setting checkbutton
---------------------testfunc------------
local BF_NewCategoryButtoList ={}
function BF_NewCategoryButtonSetState(m_id)
	local m_Frame;
	for k,v in pairs(BF_NewCategoryButtoList) do
		m_Frame =_G[v];
		if m_Frame then
			if m_Frame.id == m_id then
				m_Frame:SetChecked(true)
			else
				m_Frame:SetChecked(false)
			end
		end
	end
end
function BF_NewCategoryButtonOnEnter(self)
	local text = self.text:GetText()
	local categoryDate = Filter.new(m_TallFilter:GetBbigfoot(),text,"")

	local showList = BFNew_GetEnabledAddons(G_ShowEnvironment,categoryDate)
	categoryDate =nil;

	if #showList>0 then
		BigFootNew_Tooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT",130,0)
		BigFootNew_Tooltip:AddDoubleLine(BF_CATEGORY_TOOTIP_ENABLE,BF_CATEGORY_TOOTIP_MEMORY)
		for k,v in pairs(showList) do
			BigFootNew_Tooltip:AddDoubleLine(v[1],v[2])
		end
		BigFootNew_Tooltip:SetScale(0.7)
		BigFootNew_Tooltip:Show()
	end
	showList =nil
	collectgarbage("collect")
end
function BF_NewCategoryButtonOnLeave(self)
	BigFootNew_Tooltip:Hide()
end
function BF_NewCategoryButtonOnClick(self)
	-- print("BF_NewCategoryButtonOnClick",self.id)
	-- BigfootNewMainFrame_SetSuiltState(false)  ----退出方案模式
	BF_NewCategoryButtonSetState(self.id)   ------设置按钮状态
	if BSuiltState then
		if BSuiltChangeState then
			StaticPopupDialogs["BF_LEAVESUITSTATE"].Text = self.m_text
			StaticPopup_Show("BF_LEAVESUITSTATE"); ----退出方案模式 确定？
		else
			BigfootNewMainFrame_SetSuiltState(false)
			if not m_TallFilter then
				m_TallFilter = Filter.new(true,"All","")
			end
			m_TallFilter:SetType("All")
			BigfootSuitDropDownMenu.selectbuttonID = nil
			BF_NewCategoryButtonSetState(1)
			BigfootNewMainFrame_OnShow(); 
		end
	else
		BigfootNewMainFrame_SetSuiltState(false)
		if not m_TallFilter then
			m_TallFilter = Filter.new(true,"All","")
		end
		m_TallFilter:SetType(self.m_text)

		BigfootNewMainFrame_UpdateShow()  ----刷新列表
		-- BigfootNewMainFrame_OnShow();                  ------------刷新界面
	end
	if self.text:GetText() == RETURN then
		BF_SearchBox:SetText("")
	end
end
function BigfootNewMainFrame_CreateGuideButtons()
	local testGuiderButton
	local TypeList = BFNew_GetAddonTypeList()
	for i,v in pairs (TypeList) do
		GuiderButton= CreateFrame("CheckButton","guidertestButton" .. i,BigfootNewMainFrame,"BF_CategoryButtonTemplate")
		if i ==1 then
			GuiderButton:SetPoint("TOPLEFT",20,-127)
		else
			GuiderButton:SetPoint("LEFT","guidertestButton" .. i-1,"RIGHT",-12.5,0)
		end
		GuiderButton.id = i;
		GuiderButton.m_text =v;
		if v =="All" then
			GuiderButton.text:SetText(BF_TEXT_ALL)
		else
			GuiderButton.text:SetText(v)
		end
		table.insert(BF_NewCategoryButtoList,GuiderButton:GetName())
	end
end

---------------标准输入----------------
--[[
{
{}, -----addonConfig
{}, -----addonConfig
{}, -----addonConfig
{}, -----addonConfig
}
]]--


local SettingInfoConfigList = {}
-----------------------------------
local CheckBoxList ={};
local ButtonBoxList ={};
local SpinBoxList={};
local function BigfootNewMainFrame_InitNewConfigItem()
	for k,v in pairs (CheckBoxList) do
		CheckBoxList[k]=false;
		_G[k]:ClearAllPoints()
		_G[k].config =nil
		_G[k]:Hide()
	end
	for k,v in pairs (ButtonBoxList) do
		ButtonBoxList[k]=false;
		_G[k]:ClearAllPoints()
		_G[k].config =nil
		_G[k]:Hide()
	end
	for k,v in pairs (SpinBoxList) do
		SpinBoxList[k]=false;
		_G[k]:ClearAllPoints()
		_G[k].config =nil
		_G[k]:Hide()
	end
end
local function BigfootNewMainFrame__SpinBoxUpdataShow(Item)
	if Item then
		local AddonConfig =Item.config;
		if AddonConfig then
			local ValueList = AddonConfig:GetValueList()
			local value = AddonConfig:GetValue();
			local trueValue = AddonConfig:GettrueValue();
			local ListType = AddonConfig:GetListType();
			if Item.benable then
				Item.__caption:SetTextColor(1.0, 0.82, 0)
				Item.__editbox:Enable()
				Item.__value:SetTextColor(1.0, 0.82, 0)
				Item.__editbox:SetTextColor(1,1,1);


				Item.__prev_button:Enable()
				Item.__next_button:Enable()
				if type(trueValue) =="number" then
					if trueValue ==1 then
						Item.__prev_button:Disable()
					elseif trueValue ==#ValueList then
						Item.__next_button:Disable();
					end
				elseif type(trueValue) =="string" and ValueList then
					if tonumber(trueValue) > ValueList[2] then
						Item.__next_button:Disable();
					elseif tonumber(trueValue) < ValueList[1] then
						Item.__prev_button:Disable();
					end
				end
			else
				Item.__caption:SetTextColor(0.5, 0.5, 0.5);
				Item.__editbox:Disable()
				Item.__editbox:SetTextColor(0.5, 0.5, 0.5);
				Item.__value:SetTextColor(0.5, 0.5, 0.5);

				Item.__prev_button:Disable()
				Item.__next_button:Disable()
			end


			if ListType then
				Item.__editbox:Show();
				Item.__value:Hide();

				Item.__editbox:SetText(value);
			else
				Item.__editbox:Hide();
				Item.__value:Show();

				Item.__value:SetText(value);
			end
		end
	end
end
function BigfootNewMainFrame__SpinBoxPreButton_OnClick(self)
	local Item =self:GetParent();
	if Item then
		local AddonConfig =Item.config;
		if AddonConfig then
			local ValueList = AddonConfig:GetValueList()
			local value = AddonConfig:GettrueValue();
			if type(value) =="number" and value >1 then
				AddonConfig:SetConfigValue(value-1,BSuiltState);
			elseif type(value) =="string" and ValueList[1] then
				if tonumber(value) > ValueList[1] then
					AddonConfig:SetConfigValue(tostring(tonumber(value)-ValueList[3]),BSuiltState)
				end
			end

		end
		BigfootNewMainFrame__SpinBoxUpdataShow(Item)
		if not BSuiltState then
			BFNew_SavedCurrentSuit()
		end
	end
end
function BigfootNewMainFrame__SpinBoxNextButton_OnClick(self)
	local Item =self:GetParent();
	if Item then
		local AddonConfig =Item.config;
		if AddonConfig then
			local ValueList = AddonConfig:GetValueList()
			local value = AddonConfig:GettrueValue();
			if type(value) =="number" and value <#ValueList then
				AddonConfig:SetConfigValue(value+1,BSuiltState)
			elseif type(value) =="string" and ValueList[2] then
				if tonumber(value) < ValueList[2] then
					AddonConfig:SetConfigValue(tostring(tonumber(value)+ValueList[3]),BSuiltState)
				end
			end
		end
		BigfootNewMainFrame__SpinBoxUpdataShow(Item);
		if not BSuiltState then
			BFNew_SavedCurrentSuit()
		end
	end
end
function BigfootNewMainFrame__SpinBoxEditBox_OnTextChange(self)
	local Item =self:GetParent();
	if Item then
		local AddonConfig =Item.config;
		if AddonConfig then
			local ValueList = AddonConfig:GetValueList()
			local value = AddonConfig:GetValue();
			AddonConfig:SetConfigValue(self:GetText(),BSuiltState)
		end
		BigfootNewMainFrame__SpinBoxUpdataShow(Item);
		if not BSuiltState then
			BFNew_SavedCurrentSuit()
		end
	end
end
local function BigfootNewMainFrame_GetSpinBox(m_name,parent)
	local __box = CreateFrame("Frame", m_name, parent);
	__box:SetWidth(200);
	__box:SetHeight(27);

	local __caption = __box:CreateFontString(m_name.."Title","OVERLAY");
	__caption:SetFont(__MOD_MANAGEMENT_FONT, 14);
	__caption:SetTextColor(1.0, 0.82, 0);
	__caption:SetPoint("LEFT", __box, "LEFT", 5, 0);
	__caption:SetWidth(80);
	__caption:SetHeight(24);
	__caption:SetJustifyH("LEFT");
	__caption:SetJustifyV("CENTER");
	__caption:SetNonSpaceWrap(true);
	__caption:SetText("__captionText");
	__box.__caption = __caption;
	local __prev_button = CreateFrame("Button", m_name.."PrevButton", __box);
	__prev_button:SetWidth(20);
	__prev_button:SetHeight(20);
	__prev_button:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	__prev_button:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	__prev_button:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	__prev_button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
	__prev_button:SetPoint("LEFT", __caption, "RIGHT", 0, 0);
	__prev_button:RegisterForClicks("LeftButtonUp" ,"RightButtonUp");
	__prev_button:SetScript("OnClick", BigfootNewMainFrame__SpinBoxPreButton_OnClick);
	__box.__prev_button = __prev_button;

	local __next_button = CreateFrame("Button", m_name.."NextButton", __box);
	__next_button:SetWidth(20);
	__next_button:SetHeight(20);
	__next_button:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	__next_button:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	__next_button:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
	__next_button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
	__next_button:SetPoint("RIGHT", __box, "RIGHT", 0, 0);
	__next_button:RegisterForClicks("LeftButtonUp" ,"RightButtonUp");
	__next_button:SetScript("OnClick", BigfootNewMainFrame__SpinBoxNextButton_OnClick);
	__box.__next_button =__next_button
	local __editbox = CreateFrame("EditBox", m_name .. "EditBox", __box, "InputBoxTemplate");
	__editbox:SetJustifyH("CENTER");
	__editbox:SetWidth(70);
	__editbox:SetHeight(24);
	__editbox:SetPoint("LEFT", __prev_button, "RIGHT", 4, 0);
	__editbox:SetScript("OnTextChanged", BigfootNewMainFrame__SpinBoxEditBox_OnTextChange);
	__editbox:SetScript("OnTabPressed", function(self)
		EditBox_HandleTabbing(__editbox,__TabIndex[__box.mod]);
	end);
	__editbox:SetAutoFocus(false)
	__editbox:Hide();
	__box.__editbox = __editbox
	local __value = __box:CreateFontString(m_name.."Text","OVERLAY");
	__value:SetFont(__MOD_MANAGEMENT_FONT, 14);
	__value:SetTextColor(1.0, 0.82, 0);
	__value:ClearAllPoints();
	__value:SetPoint("LEFT", __prev_button, "RIGHT", 0, 0);
	__value:SetPoint("RIGHT", __next_button, "LEFT", 0, 0);
	__value:SetHeight(24);
	__value:SetJustifyH("CENTER");
	__value:SetJustifyV("CENTER");
	__value:SetNonSpaceWrap(true);
	__value:SetText("__value")
	__box.__value = __value
end
local function BigfootNewMainFrame_GetNewConfigItem(m_ID,m_type)
	local m_Str =nil;
	local i =0;
	if m_type =="CheckBox" then
		for k,v in pairs (CheckBoxList) do
			i =i+1;
			if not v then
				m_Str =k;
				break
			end
		end
		if not m_Str then
			CreateFrame("CheckButton","__addonCongfigCheckBox" .. i+1,BigfootNewMainFrame.settinginfo,"BF_ConfigCheckButtonTemplate");
			-- table.insert(CheckBoxList,"__addonCongfigCheckBox" .. i+1);
			m_Str ="__addonCongfigCheckBox" .. i+1;
		end
		CheckBoxList[m_Str] =true

	elseif m_type =="Button" then
		for k,v in pairs (ButtonBoxList) do
			i =i+1;
			if not v then
				m_Str =k;
				break
			end
		end
		if not m_Str then
			CreateFrame("Button","__addonCongfigButton" .. i+1,BigfootNewMainFrame.settinginfo,"BF_ConfigButtonTemplate")
			m_Str ="__addonCongfigButton" .. i+1;
			-- table.insert(ButtonBoxList,"__addonCongfigButton" .. i+1);
		end
		ButtonBoxList[m_Str] =true
	elseif  m_type =="SpinBox" then
		for k,v in pairs (SpinBoxList) do
			i =i+1;
			if not v then
				m_Str =k;
				break
			end
		end
		if not m_Str then
			m_Str ="__addonCongfigSpinBox" .. i+1;
			BigfootNewMainFrame_GetSpinBox(m_Str,BigfootNewMainFrame.settinginfo)
			-- CreateFrame("Button","__addonCongfigSpinBox" .. i+1,BigfootNewMainFrame.settinginfo,"BF_ConfigButtonTemplate")

			-- table.insert(ButtonBoxList,"__addonCongfigButton" .. i+1);
		end
		SpinBoxList[m_Str] =true
	end
	local Item  =_G[m_Str]
	Item.m_ID= m_ID;
	if m_type~="SpinBox" then
		Item:Enable();
	end
	return Item;
end
local function BigfootNewMainFrame_GetConfigItem(m_ID)
	local m_Str =nil;
	for k,v in pairs (CheckBoxList) do
		if _G[k] and v then
			if  _G[k].m_ID == m_ID then
				m_Str =k;
				break;
			end
		end
	end
	for k,v in pairs (ButtonBoxList) do
		if _G[k] and v then
			if  _G[k].m_ID == m_ID then
				m_Str =k;
				break;
			end
		end
	end
	for k,v in pairs (SpinBoxList) do
		if _G[k] and v then
			if  _G[k].m_ID == m_ID then
				m_Str =k;
				break;
			end
		end
	end
	if m_Str then
		return _G[m_Str]
	end
end
function BigfootNewMainFrame_UpdateSettingFrame(m_Addon)
	-- local __configList = GetConfigListByAddonName(str)   ---------------------------------------测试。
	local __configList =m_Addon:GetAddonConfigList()
	BigfootNewMainFrame_InitNewConfigItem()
	if not __configList then return end
	local __configoption ={}
	local numb = #__configList;
	for k,v in pairs(__configList) do
		__configoption = BigfootNewMainFrame_GetNewConfigItem(k,v:GetType())
		__configoption.t_indentList= {};
		__configoption.type =v:GetType();
		__configoption.config=v;
		if k == 1 then
			if numb>10 then
				__configoption:SetPoint("TOPLEFT",100,-12)
			else
				__configoption:SetPoint("TOPLEFT",100,-20)
			end
		else
			if v:GetIndent() then
				local TopItem = BigfootNewMainFrame_GetConfigItem(k-1);
				if TopItem.config:GetIndent()<v:GetIndent() then
					table.insert(TopItem.t_indentList,__configoption:GetName())
				else
					for i=k-1,1,-1 do
						local Item = BigfootNewMainFrame_GetConfigItem(i);
						if Item.config:GetIndent()<v:GetIndent() then
							table.insert(Item.t_indentList,__configoption:GetName());
							break;
						end
					end
				end
				__configoption:SetPoint("TOPLEFT",TopItem:GetName(),"BOTTOMLEFT",(v:GetIndent()- TopItem.config:GetIndent())*30,0)
			end
		end
		if __configoption.type == "CheckBox" then
			__configoption:Show()
			__configoption:SetChecked(v:GetValue())
			__configoption.text:SetText(v:GetVariable())
		elseif __configoption.type == "Button" then
			__configoption:Show()
			__configoption:SetText(v:GetVariable())
		elseif __configoption.type == "SpinBox" then
			__configoption.__caption:SetText(v:GetVariable())
			__configoption:Show()
			BigfootNewMainFrame__SpinBoxUpdataShow(__configoption)
		end

	end
	local TopItem1
	for k=1,#__configList do
		TopItem1 = BigfootNewMainFrame_GetConfigItem(k);
		if TopItem1 and  TopItem1.config and TopItem1.config:GetIndent()==0 and TopItem1.type=="CheckBox" then
			BigfootNewMainFrame_ConfigSettingCheckButton_OptionIdent(TopItem1,not TopItem1:GetChecked())
		end
	end
end

local function BigfootNewMainFrame_ConfigSettingItemEnabel(Item,benable)
	if Item then
		if Item.type=="SpinBox" then
			if benable then
				BigfootNewMainFrame_ConfigSettingCheckButton_OptionIdent(Item)	;
			else
				BigfootNewMainFrame_ConfigSettingCheckButton_OptionIdent(Item,1);
			end
			Item.benable = benable;
			BigfootNewMainFrame__SpinBoxUpdataShow(Item);
		else
			if benable then
				Item:Enable();
			else
				Item:Disable();
			end
		end
	end
end

function BigfootNewMainFrame_ConfigSettingCheckButton_OptionIdent(self,b_toggle)
	if b_toggle then
		for k,v in pairs(self.t_indentList) do
			if _G[v] then
				-- if not _G[v]:IsEnabled() then
					-- _G[v]:Enable()
				-- end
				-- _G[v]:Disable()
				BigfootNewMainFrame_ConfigSettingItemEnabel(_G[v],1)
				BigfootNewMainFrame_ConfigSettingItemEnabel(_G[v])
			end
		end
	else
		for k,v in pairs(self.t_indentList) do
			if _G[v] then
				-- if _G[v]:IsEnabled() then
					-- _G[v]:Disable()
				-- end
				-- _G[v]:Enable()
				BigfootNewMainFrame_ConfigSettingItemEnabel(_G[v])
				BigfootNewMainFrame_ConfigSettingItemEnabel(_G[v],1)
			end
		end
	end
end
local function BigfootNewMainFrame_GetAddonbyName(str)
	if G_ShowAddonList then
		for k,v in pairs (G_ShowAddonList) do
			if v:GetName() ==str then
				return v;
			end
		end
	end
end
function BigfootNewMainFrame_ConfigSettingCheckButton_OnClick(self)
	if self.config and self.config:GetCaption() then
		if self:GetChecked() then
			self.config:SetConfigValue(true,BSuiltState)
		else
			self.config:SetConfigValue(false,BSuiltState)
		end
	end
	if self:GetChecked() then
		BigfootNewMainFrame_ConfigSettingCheckButton_OptionIdent(self,false)
	else
		BigfootNewMainFrame_ConfigSettingCheckButton_OptionIdent(self,true)
	end
	if not BSuiltState then
		BFNew_SavedCurrentSuit()
	end


	BFNew_SetListAddonEnableInfo(G_ShowAddonList)
	BigfootNewMainFrame_UpdateAddonMemory(G_ShowAddonList);
	BigfootNewMainFrame_UpdateAddonListEleButton()
 
end
function BigfootNewMainFrame_ConfigSettingkButton_OnClick(self)
	-- if not BSuiltState then

	-- end
	if self.config and self.config:GetCaption() then
		self.config:SetConfigValue()
	end
end


function BigfootNewMainFrame_SaveSuitButtonOnClick(self)
	BigfootNewMainFrame.settinginfo:Hide()
	BigfootNewMainFrame_SeleteAddon ="";
	BigfootNewMainFrame_UpdateAddonListEleButton()
	BigfootSuitOptionFrame:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+6)
	BigfootSuitOptionFrame:Show()
end


function BigfootNewMainFrame_ReloadButtonOnClick(self)
	if G_ShowEnvironment then
		G_ShowEnvironment:submitSet();
		CurrentEnvironment = G_ShowEnvironment;
		CurrentEnvironment:SetName("Current");
		BFNew_SavedCurrentSuit()
	end
end

function BigfootNewMainFrame_BigfootSuitOptionFrame_SaveNewSuitButtonOnClick(self)
	StaticPopup_Show("BF_NEW_SUIT")
end
function BigfootNewMainFrame_BigfootSuitOptionFrame_SaveSuitButtonOnClick(self)
	if BF_SuitListContainer.SeleteSuiltName and BF_SuitListContainer.SeleteSuiltName~="" then
		StaticPopupDialogs["BF_COVER_SUIT"].SuitName = BF_SuitListContainer.SeleteSuiltName
		StaticPopup_Show("BF_COVER_SUIT",BF_SuitListContainer.SeleteSuiltName)
	else
		BigfootNewMainFrame_BigfootSuitOptionFrame_SaveNewSuitButtonOnClick()
	end
end
function BigfootNewMainFrame_BigfootSuitOptionFrame_DelSuitButtonOnClick(self)
	if BF_SuitListContainer.SeleteSuiltName and BF_SuitListContainer.SeleteSuiltName~="" then
		StaticPopupDialogs["BF_DEL_SUIT"].SuitName = BF_SuitListContainer.SeleteSuiltName
		StaticPopup_Show("BF_DEL_SUIT",BF_SuitListContainer.SeleteSuiltName);
	end
end
function BigfootNewMainFrame_BigfootSuitOptionFrame_switchSuitButtonOnClick(self)
	if BF_SuitListContainer.SeleteSuiltName and BF_SuitListContainer.SeleteSuiltName~="" then
		BigfootSuitOptionFrame:Hide()
		BigfootNewMainFrame_SetSuiltState(true);
		BF_SetSeleteSuitName(BF_SuitListContainer.SeleteSuiltName)
		BF_SearchBox:ClearFocus();
		BigfootNewMainFrame_BigfootSuitDropDownMenu_SetIdByName(BF_SuitListContainer.SeleteSuiltName)
		BigfootNewMainFrame_OnShow(1)
	end
end
function BigfootNewMainFrame_UpdateSuitListContainerEleButton()
	local scrollFrame = BF_SuitListContainer;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local results = scrollFrame.buttons;
	local result, index;

	local SuiltList = BigfootNewMainFrame_GetAllSuilt(true)
	if not SuiltList then return end
	local numResults = #SuiltList;   ------结果数量
	-- local title,name,info,consume,status,ShowAddon;
	local ShowSuilt;
	for i = 1,#results do
		result = results[i];
		index = offset + i;
		if index <= numResults then
			ShowSuilt =SuiltList[index];
			if ShowSuilt then
				result.SuiltName = ShowSuilt:GetName();
				result.CheckButton.num:SetText(index);
				result.CheckButton.suitname:SetText(ShowSuilt:GetName());
				result.CheckButton.time:SetText(ShowSuilt:GetTime())
				result.CheckButton.charactername:SetText(ShowSuilt:GetCharacterName())
				result.CheckButton.enablenum:SetText(ShowSuilt:GetEnableAddonNum())
				if result.SuiltName == BF_SuitListContainer.SeleteSuiltName then
					result.CheckButton:SetChecked(true)
				else
					result.CheckButton:SetChecked(nil)
				end
				result:Show();
			end
		else
			result:Hide();
		end
	end
	SuiltList =nil;
	local totalHeight = (numResults * 35);
	HybridScrollFrame_Update(scrollFrame, totalHeight, 370);
end

function BigfootNewMainFrame_BigfootSuitOptionFrame_OnLoad(self)

	HybridScrollFrame_CreateButtons(BF_SuitListContainer,"BF_SuitCheckButtonTemplate",35,0,"TOPLEFT","TOPLEFT")
	BF_SuitListContainer.stepSize = 20
	BF_SuitListContainer.scrollBar.doNotHide =true;
	-- -- print("HybridScrollFrame_CreateButtons1",BF_AddonListContainer.scrollBar:GetMinMaxValues())
	BF_SuitListContainer.update =BigfootNewMainFrame_UpdateSuitListContainerEleButton
	BF_SuitListContainer:SetScale(1)
	
	BigfootNewMainFrame_UpdateSuitListContainerEleButton()
	BigfootNewMainFrame_BigfootSuitOptionFrame_RepeatTexture(self)
	BigfootNewMainFrame_BigfootSuitOptionFrame_CreateHeaderButtons(self)
end
function  BigfootNewMainFrame_BigfootSuitOptionFrame_CreateHeaderButtons(self)
	local selectAll = CreateFrame("Frame","BigfootSuitOptionNumTitle",self,"BF_HeaderSuitOptionTitleTemplate")
	selectAll:SetPoint("TOPLEFT",15,-38)
	selectAll:SetSize(51,25)
	selectAll.title:SetText(BigfootSuitOptionFrame_Title)
	local addontitle = CreateFrame("Frame","BigfootSuitOptionNameTitle",self,"BF_HeaderSuitOptionTitleTemplate")
	addontitle:SetPoint("LEFT",selectAll,"RIGHT")
	addontitle:SetSize(60,25)
	addontitle.title:SetText(BigfootSuitOptionFrame_Name)
	local addonname = CreateFrame("Frame","BigfootSuitOptionTimeTitle",self,"BF_HeaderSuitOptionTitleTemplate")
	addonname:SetPoint("LEFT",addontitle,"RIGHT")
	addonname:SetSize(100,25)
	addonname.title:SetText(BigfootSuitOptionFrame_SaveTime)

	local addoninfo = CreateFrame("Frame","BigfootSuitOptionPlayerTitle",self,"BF_HeaderSuitOptionTitleTemplate")
	addoninfo:SetPoint("LEFT",addonname,"RIGHT")
	addoninfo:SetSize(150,25)
	addoninfo.title:SetText(BigfootSuitOptionFrame_SavePlayer);

	local addonconsume = CreateFrame("Frame","BigfootSuitOptionOpenNumTitle",self,"BF_HeaderSuitOptionTitleTemplate")
	addonconsume:SetPoint("LEFT",addoninfo,"RIGHT")
	addonconsume:SetSize(82,25)
	addonconsume.title:SetText(BigfootSuitOptionFrame_OpenNum);
end

function BigfootNewMainFrame_BigfootSuitOptionFrame_OnShow(Self)
	BigfootNewMainFrame_UpdateSuitListContainerEleButton()
end
function BigfootMainSettingButton_OnClick(self)
	BigfootMainSettingFrame:Show();
end
function BigfootMainSettingFrame_OnLOAD(self)
	BigfootNewMainFrame_BigfootSuitOptionFrame_RepeatTexture(self)
end

function BigfootMainSettingFrame_OnShow(self)
	self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+6)
	BigfootMainSettingFrame_UpdataFrame(self)
end
function BigfootMainSettingFrame_UpdataFrame(self)
	if G_ShowEnvironment then
		local bigfoot = G_ShowEnvironment:GetAddon("BigFoot")
		if bigfoot then
			local AddonConfig = bigfoot:GetAddonConfigList()
			for k,v in pairs (AddonConfig)do
				if not _G["__BigFootaddonCongfig"..k] then
					if v:GetType()=="CheckBox" then
						CreateFrame("CheckButton","__BigFootaddonConfig" ..  k,self,"BF_ConfigCheckButtonTemplate");
					elseif v:GetType()=="Button" then
						CreateFrame("Button","__BigFootaddonConfig" .. k,self,"BF_ConfigButtonTemplate")
					end
				end
				local __configoption=_G["__BigFootaddonConfig"..k];
				__configoption.config=v;
				__configoption.type = v:GetType();
				__configoption.t_indentList={};
				__configoption:SetHitRectInsets(0,-200,0,0);
				__configoption.Indent = __configoption.config:GetIndent()
				__configoption:SetPoint("TOPLEFT",20+math.floor((k-1)/7)*230+__configoption.Indent*20,-80-((mod((k-1),7)-1)*30))
				for i=k-1,1,-1 do
					if _G["__BigFootaddonConfig"..i] and _G["__BigFootaddonConfig"..i].Indent and _G["__BigFootaddonConfig"..i].Indent<__configoption.Indent then
						table.insert(_G["__BigFootaddonConfig"..i].t_indentList,__configoption:GetName());
						break;
					end
				end
				if __configoption.type == "CheckBox" then
					__configoption:Show()
					__configoption:SetChecked(v:GetValue())
					__configoption.text:SetText(v:GetVariable())
				elseif __configoption.type == "Button" then
					__configoption:Show()
					__configoption:SetText(v:GetVariable())
				end

			end
			local TopItem1
			for k=1,#AddonConfig do
				TopItem1 = _G["__BigFootaddonConfig"..k];
				if TopItem1 and  TopItem1.config and TopItem1.config:GetIndent()==0 and TopItem1.type=="CheckBox" then
					BigfootNewMainFrame_ConfigSettingCheckButton_OptionIdent(TopItem1,not TopItem1:GetChecked())
				end
			end
		end
	end
end

function BigfootNewMainFrame_BigfootSuitOptionFrame_RepeatTexture(self)
	local _repeatTexture
	for i=1,27 do
		_repeatTexture = self:CreateTexture("RepeatTexture" .. i,"BACKGROUND","BF_SuitOption_RepeatBorder")
		_repeatTexture:ClearAllPoints()
		if i==1 then

			_repeatTexture:SetPoint("TOPLEFT",self.leftborder,"TOPRIGHT")
		elseif i == 27 then
			_repeatTexture:SetPoint("TOPLEFT","RepeatTexture" .. i-1,"TOPRIGHT")
			_repeatTexture:SetPoint("BOTTOMRIGHT",self.rightborder,"BOTTOMLEFT")
		else
			_repeatTexture:SetPoint("TOPLEFT","RepeatTexture" .. i-1,"TOPRIGHT")
		end
	end
end
function BigfootNewMainFrame_BigfootSuitOptionFrame_NewSuit(s_Name)
	if BigfootNewMainFrame_BigfootSuitOptionFrame_IsSuitExist(s_Name) then
		if G_DefaultSuitList[s_Name] then
			StaticPopup_Show("BF_REFUSENAME_SUIT")
		else
			StaticPopupDialogs["BF_COVER_SUIT"].SuitName = s_Name
			StaticPopup_Show("BF_COVER_SUIT",s_Name)
		end
	else
		BigfootNewMainFrame_BigfootSuitOptionFrame_SaveSuitByName(s_Name)
	end
end
function BigfootNewMainFrame_DelSuitByName(SuitName)

	BF_DelSaveSuitByName(SuitName)
	G_SaveSuiltList = BF_GetAllSuits();
	-- BSuiltState =false;
	BigfootNewMainFrame_SetSuiltState(false)
	BigfootSuitDropDownMenu.selectbuttonID = nil
	BigfootNewMainFrame_OnShow();

end
function BigfootNewMainFrame_DelSuitButtonOnClick(self)
	if BSuiltState then
		local SuiltName = G_ShowEnvironment:GetName();
		if SuiltName then
			-- print("DelSuit",SuiltName);
			StaticPopupDialogs["BF_DEL_SUIT"].SuitName = SuiltName
			StaticPopup_Show("BF_DEL_SUIT",SuiltName);
		end
	end
end

function BF_SuitCheckButtOnClick(self)
	local SuiltName;
	local Button = self:GetParent();
	if self:GetChecked() then
		SuiltName =Button.SuiltName;
	else
		SuiltName ="";
	end
	-- print("BF_SuitCheckButtOnClick",SuiltName)
	local SuitList = Button:GetParent():GetParent();
	SuitList.SeleteSuiltName=SuiltName;
	local Buttons = SuitList.buttons;
	if Buttons then
		for k,v in pairs (Buttons)do
			if v.SuiltName and v.SuiltName == SuitList.SeleteSuiltName then
				v.CheckButton:SetChecked(true);
			else
				v.CheckButton:SetChecked(false);
			end
		end
	end
end
function BigfootNewMainFrame_BigfootSuitOptionFrame_IsSuitExist(s_Name)
	for k,v in pairs(G_SaveSuiltList) do
		if k == s_Name then
			return true
		end
	end
end
function BigfootNewMainFrame_BigfootSuitOptionFrame_SaveSuitByName(s_Name)
	-- print("_SaveSuitByName",s_Name)
	if type(s_Name) =="string" and s_Name~="" then
		local Environment_Name = G_ShowEnvironment:GetName();
		G_ShowEnvironment:SetName(s_Name)
		BF_SaveSuit(G_ShowEnvironment)
		-- BFNew_SavedCurrentSuit()
		-- BigfootNewMainFrame_BigfootSuitOptionFrame_Update()
		G_SaveSuiltList=nil
		G_SaveSuiltList = BF_GetAllSuits();
		G_ShowEnvironment:SetName(Environment_Name)
		BigfootNewMainFrame_UpdateSuitListContainerEleButton()
	end
end

function BigfootNewMainFrame_ClassicPanel_OnClick(self)
	StaticPopup_Show("BF_CHOSEOLDFRAME");
end
local __suitList = {}
function BigfootNewMainFrame_BigfootNewMainFrame_BigfootSuitDropDownMenuOnClick(self)
	BigfootSuitDropDownMenu:SetSize(self:GetWidth(),100)
	if BigfootSuitDropDownMenu:IsShown() then
		BigfootSuitDropDownMenu:Hide()
	else
		BigfootSuitDropDownMenu:Show()
	end

end
function BigfootNewMainFrame_BigfootSuitDropDownMenuOnLoad(self)

end
function BigfootNewMainFrame_BigfootSuitDropDownMenuOnShow(self)
	self.timer = 0
	self:SetFrameLevel(BigfootNewMainFrame:GetFrameLevel()+7)
	BigfootNewMainFrame_BigfootSuitDropDownMenuInit()
	BigfootNewMainFrame_BigfootSuitDropDownMenuUpdateButtons(self)
	if #__suitList~=0 then
		self:SetPoint("BOTTOM",_G[self:GetName() .. "SuitButton" .. #__suitList],"BOTTOM",0,-10)
		-- self:SetHeight((#__suitList)*11+((#__suitList)*11))
		self:Show()
	else
		self:Hide(0)
	end
end
function BigfootNewMainFrame_BigfootSuitSeleteFun(value)
	BigfootNewMainFrame_SetSuiltState(true);
	BigfootNewMainFrame_SetSuiltChangeState(false)
	BF_SetSeleteSuitName(value)
	BigfootNewMainFrame_OnShow(1)
	BigfootNewMainFrame_BigfootSuitDropDownMenuUpdateShow();
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuInit()
	BigfootNewMainFrame_BigfootSuitDropDownMenuClearButtons()
	if G_SaveSuiltList then
		local m_tab = BigfootNewMainFrame_GetAllSuilt()
		for k,v in pairs(m_tab) do
			local info = {}
			info.text = v:GetName()
			info.value = v:GetName()
			info.func = function (self)
				-- print("Selected",self.value)
				-- BF_Gloable.SeleteSuilt =  self.value;
				if BSuiltState  and BSuiltChangeState then
					StaticPopupDialogs["BF_LEVEL_SUILT_TEXT_DLG"].oldText =self:GetParent().selectbuttonID
					StaticPopupDialogs["BF_LEVEL_SUILT_TEXT_DLG"].Text = self.value
					StaticPopup_Show("BF_LEVEL_SUILT_TEXT_DLG"); 
				else
					BigfootSuitDropDownMenu.selectbuttonID = self:GetID()
					BigfootNewMainFrame_BigfootSuitSeleteFun(self.value) ;
				end
				-- UIDropDownMenu_SetSelectedID(BigfootNewMainFrame.selectsuit, self:GetID())
				-- -- print(self:GetID())
			end

			BigfootNewMainFrame_BigfootSuitDropDownMenuAddButton(info)
		  -- print("---------------------addButton",info)
		end
		m_tab =nil;
	end
	BigfootNewMainFrame_BigfootSuitDropDownMenuUpdateShow()
	
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuClearButtons()
	__suitList = {}
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuAddButton(info)
	if type(info) == "table" then
		table.insert(__suitList,info)
	end
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuUpdateShow()

	if BigfootSuitDropDownMenu.selectbuttonID and BigfootNewMainFrame_BigfootSuitDropDownMenu_GetNameById(BigfootSuitDropDownMenu.selectbuttonID) then
		BigfootSuitDropDownMenuButton:SetText(BigfootNewMainFrame_BigfootSuitDropDownMenu_GetNameById(BigfootSuitDropDownMenu.selectbuttonID))
	else
		BigfootSuitDropDownMenuButton:SetText(BF_SUITBUTTON_CUSTOM)
	end
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuOnUpdate(self,elapsed)    --DropDownMenu计时
	if self.starCount then
		self.timer = self.timer+elapsed
		if self.timer >= DROPDOWNMENU_SHOWTIME then
			self:Hide()
		end
	end
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuStartCount()     --计时开始并重置计时器
	BigfootSuitDropDownMenu.timer = 0
	BigfootSuitDropDownMenu.starCount =true
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuStopCount()   -- 计时停止并重置计时器
	BigfootSuitDropDownMenu.timer = 0
	BigfootSuitDropDownMenu.starCount =false
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuUpdateButtons(self)
	if #__suitList <= SUITDROPDOWNMENNU_MAX then

	else
		for i =1,#__suitList do
			if i <= SUITDROPDOWNMENNU_MAX then
				_G[self:GetName() .. "SuitButton" .. i]:Show()
			else
				-- print(">SUITDROPDOWNMENNU_MAX",i)
				SUITDROPDOWNMENNU_MAX = SUITDROPDOWNMENNU_MAX+1
				local __suitmenuButton = CreateFrame("CheckButton",self:GetName() .. "SuitButton" .. i,self,"BigfootSuitListButtonTemplate")
				__suitmenuButton:SetPoint("TOP",_G[self:GetName() .. "SuitButton" .. i-1],"BOTTOM")
				__suitmenuButton:SetID(i)
			end
		end
	end
	for i=1,SUITDROPDOWNMENNU_MAX do
		if i == 1 then
			_G[self:GetName() .. "SuitButton" .. i]:SetPoint("TOP",BigfootSuitDropDownMenuButton,"BOTTOM",0,-17)
		else
			_G[self:GetName() .. "SuitButton" .. i]:SetPoint("TOP",_G[self:GetName() .. "SuitButton" .. i-1],"BOTTOM",0,-11)
		end
		-- print("suitlist",i,__suitList,__suitList[i])
		if __suitList[i] then
			-- print("exist")
			_G[self:GetName() .. "SuitButton" .. i .. "Text"]:SetText(__suitList[i].text)
			_G[self:GetName() .. "SuitButton" .. i].value = __suitList[i].value
			_G[self:GetName() .. "SuitButton" .. i].func = __suitList[i].func
			_G[self:GetName() .. "SuitButton" .. i]:Show()
			-- print("Show",i)
		else
			_G[self:GetName() .. "SuitButton" .. i]:Hide()
			-- print("Hide",i)
		end
	end
	BigfootNewMainFrame_BigfootSuitDropDownMenu_SetSelected(self.selectbuttonID,self)
end
function BigfootNewMainFrame_BigfootSuitDropDownMenu_GetNameById(id)
	local text = nil
	for i=1,SUITDROPDOWNMENNU_MAX do
		if i == id and __suitList[i] then
			text = __suitList[i].text
		end
	end
	return text
end
function BigfootNewMainFrame_BigfootSuitDropDownMenu_SetIdByName(name)
	BigfootSuitDropDownMenu.selectbuttonID = -1;
	for i=1,SUITDROPDOWNMENNU_MAX do
		if __suitList[i] and  __suitList[i].text ==name then
			BigfootSuitDropDownMenu.selectbuttonID = i
		end
	end
end

function BigfootNewMainFrame_BigfootSuitDropDownMenu_SetSelected(id,frame)
	for i=1,SUITDROPDOWNMENNU_MAX do
		_G[frame:GetName() .. "SuitButton" .. i]:SetChecked(false)
	end
	if id and id >0 and id < SUITDROPDOWNMENNU_MAX then
		_G[frame:GetName() .. "SuitButton" .. id]:SetChecked(1)
	end
end
function BigfootNewMainFrame_BigfootSuitDropDownMenu_SetButtonName(name)
	for i =1,SUITDROPDOWNMENNU_MAX do
		if _G[frame:GetName() .. "SuitButton" .. i .. "Text"]:GetText() == name then
			BigfootNewMainFrame_BigfootSuitDropDownMenu_SetSelected(i,BigfootSuitDropDownMenu)
			BigfootSuitDropDownMenu.selectbuttonID = i
		end
	end
end
function BigfootNewMainFrame_BigfootSuitDropDownMenuCreateUpdate()

end
function BigfootNewMainFrame_AlertFrameAddOnMessage(name,enable,b_reload)
 
	if enable then
		pcall(BigfootNewMainFrame_SetAnimation,enable,name,1)
		-- BigfootNewMainFrame_SetAnimation(enable,name,1)
	else
		pcall(BigfootNewMainFrame_SetAnimation,enable,name,2)
		-- BigfootNewMainFrame_SetAnimation(enable,name,2);
	end	
end
function BigfootNewMainFrame_SetAnimation(BStar,addOnName,enable)
	if not BStar then
		BigfootNewMainFrame_AnimationControl(BigfootNewMainFrameReloadButton,"blink",true)
		if BSuiltState then
			BigfootNewMainFrame_ButtonAlertControl(BigfootNewMainFrameReloadButton,BigfootNewMainFrame_Button_Text1,true,addOnName,enable);
		else
			BigfootNewMainFrame_ButtonAlertControl(BigfootNewMainFrameReloadButton,BigfootNewMainFrame_Button_Text2,true,addOnName,enable);
		end
	else
		BigfootNewMainFrame_AnimationControl(BigfootNewMainFrameReloadButton,"blink",false)
		if BSuiltState then
			BigfootNewMainFrame_ButtonAlertControl(BigfootNewMainFrameReloadButton,BigfootNewMainFrame_Button_Text1,false,addOnName,enable);
		else
			BigfootNewMainFrame_ButtonAlertControl(BigfootNewMainFrameReloadButton,BigfootNewMainFrame_Button_Text2,false,addOnName,enable);
		end
	end
end
function BigfootNewMainFrame_AnimationControl(frame,_type,toggle)    ----@param  frame：窗体 ,type：动画类型,toggle：true 开始 false 停止
	if frame then
		if toggle then
			if _type == "blink" then
				frame.blinkAnim:Play()
			end
		else
			if _type == "blink" then
				frame.blinkAnim:Stop()
			end
		end
	end
end
--BigfootNewMainFrame_ButtonAlertControl(GetMouseFocus(),"点击重载界面按钮后设置生效",true)
-- AFTERRELOAD = "重載後"
  t_AddonOptionPanel = {}
function BigfootNewMainFrame_AlertFrameIsAddOnMessageExist(name)  --@param name:插件名 @return: index 插件在t_AddonOptionPanel中的索引,b_enable
	for k,v in pairs(t_AddonOptionPanel) do
		if v[1] == name then
			return k,v[2]
		end
	end
end
function BigfootNewMainFrame_ClearOptionPanel()
	t_AddonOptionPanel=nil;
	t_AddonOptionPanel={}
end
function BigfootNewMainFrame_ButtonAlertControl(frame,text,toggle,addOnName,Enable)  ----@param  frame: 窗体 ,text：文字,toggle: true 显示 false 隐藏 addOnName 插件名 Enable:1将被开启, 2将被关闭
	local _index,_enable = BigfootNewMainFrame_AlertFrameIsAddOnMessageExist(addOnName)
	if (addOnName and Enable==2 and not _index) or (addOnName and BSuiltState and not _index) then
		table.insert(t_AddonOptionPanel,{addOnName,Enable})
	end
	if (addOnName and Enable ==1 and _index and _enable ==2) or(addOnName and BSuiltState and _index )  then
		table.remove(t_AddonOptionPanel,_index)
	end
	if Enable ==2 then
		toggle =true
	-- elseif Enable==1 then
		-- toggle = false
	end
	if not text then
		text = ""
	end
	if #t_AddonOptionPanel~=0 then
		text = text .. AFTERRELOAD
	end
	if #t_AddonOptionPanel <=5 then
		for i= #t_AddonOptionPanel,1,-1 do
			text = text .. t_AddonOptionPanel[i][1] ..T_ENABLE[t_AddonOptionPanel[i][2]]
		end
	elseif #t_AddonOptionPanel >5 then
		
		for i= #t_AddonOptionPanel ,#t_AddonOptionPanel-4 ,-1 do
			text = text .. t_AddonOptionPanel[i][1] ..T_ENABLE[t_AddonOptionPanel[i][2]]
		end
		text = text ..".......\n"
	end
	BigfootButtonAlertText:SetText(text)
	if frame then
		BigfootButtonAlert:SetPoint("BOTTOM",frame,"TOP",-60,15)
		if toggle and Enable==2 then
			if not BigfootButtonAlert:IsShown() then
				BigfootButtonAlert:Show()
			else
				BigfootButtonAlert:Hide()
				BigfootButtonAlert:Show()
			end
		else
			if BigfootButtonAlert:IsShown() then
				BigfootButtonAlert:Hide()
				BigfootButtonAlert:Show()
			end
		end
	end
	
end
function BigfootButtonAlert_SimpleShow(text)
	BigfootButtonAlert:SetPoint("BOTTOM",BigfootNewMainFrameReloadButton,"TOP",-60,15)
	BigfootButtonAlertText:SetText(text)
	BigfootButtonAlert:Show()
end
function __CheckbuttonTextfunc()
	__checkbutton=CreateFrame("CheckButton","checkbutton",BigfootSuitDropDownMenu,"BigfootSuitListButtonTemplate")
	__checkbutton:SetPoint("TOP")
	__checkbutton:Show()
end
function BigfootResetCurrent()
	local name = BFU_GetName()
	local server =BFU_GetServerName()
	if BF_Gloable.SavedSuitList then
		if BF_Gloable.SavedSuitList[server] and BF_Gloable.SavedSuitList[server][name] then
			BF_Gloable.SavedSuitList[server][name]["Current"] = nil
		end
	end
end