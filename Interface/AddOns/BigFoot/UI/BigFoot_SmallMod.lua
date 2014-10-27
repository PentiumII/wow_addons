
--------------------------一些基本的小模块。---------------------------------
if (GetLocale() == "zhCN") then
	BF_MOVEFRAME_TIP="按住Shift或Alt点击移动";
	BF_OPEN_NEWADDON_OPTION="打开设置";
elseif (GetLocale() == "zhTW") then
	BF_MOVEFRAME_TIP ="按住Shift或Alt點擊移動"
	BF_OPEN_NEWADDON_OPTION="打開設置";
else
	BF_MOVEFRAME_TIP ="Shift/Alt+Left mouse to move";
	BF_OPEN_NEWADDON_OPTION="open option";
end

--------------------------------------移动窗体基本库---------------------------------------
-------------------目前模块，请在 PLAYER_LOGIN 这个事件之前调用 BigFoot_RegistMoveFrame---------------------------------------------------------
BF_Frames_Config = {};
BigFoot_NewAddonChecked={};
BigFoot_NewAddonChecked.CheckedTime =nil;

local F=CreateFrame("Frame","Bigfoot_PosFram",UIParent);
F.BCanMove =true;
F.FrameTab={};
F.FrameDataTab={};
F.BloadPos =false
F:RegisterEvent("PLAYER_ENTERING_WORLD");

local lastCheckTime =0

F:SetScript("OnUpdate",function(F,elapsed)
	local newTime = GetTime();
	if newTime -lastCheckTime>1 then
		lastCheckTime = newTime;
		BigFoot_CheckMoveFrame();
	end
end);
F:SetScript("OnEvent", function(_, event, ...)
	if event =="PLAYER_ENTERING_WORLD" then
		-- F.FrameDataTab[name].BsetPos
		for k,v in pairs (F.FrameDataTab) do
			if v.BsetPos then
				v.BsetPos =false;
			end
		end
	end
end
)
local function __GetPoint(frame)
	local point,ref,refPoint,x,y = frame:GetPoint()
	ref = ref and ref:GetName() or "UIParent"
	return point,ref,refPoint,x,y
end

local function OnDragStart(self)
	if self:IsMovable() then
		self:StartMoving()
	end
end

local function OnDragStop(self)
	self:StopMovingOrSizing()
	if not BF_Frames_Config[self:GetName()] then
		BF_Frames_Config[self:GetName()] ={};
	end
	local point,ref,refPoint,x,y = __GetPoint(self)
	BF_Frames_Config[self:GetName()]["Pos"]={point,ref,refPoint,x,y};
end

function BigFoot_SetFrameCanMove(m_Frame)
	if m_Frame and m_Frame.EnableMouse then
		local name = m_Frame:GetName();
		if (not F.BCanMove) and (F.FrameDataTab[name] and F.FrameDataTab[name].bChanged) then
			F.FrameDataTab[name].bChanged =false;
			if F.FrameDataTab[name].IsOldMouseEnabled then
				m_Frame:EnableMouse(true);
			else
				m_Frame:EnableMouse(false);
			end

			if F.FrameDataTab[name].IsOldMovable then
				m_Frame:SetMovable(true);
			else
				m_Frame:SetMovable(false);
			end
			m_Frame:StopMovingOrSizing()
		elseif (F.BCanMove and not (F.FrameDataTab[name] and F.FrameDataTab[name].bChanged)) then
			if not F.FrameDataTab[name] then
				F.FrameDataTab[name] ={};
			end
			F.FrameDataTab[name].bChanged =true;
			if m_Frame:IsMouseEnabled() then
				F.FrameDataTab[name].IsOldMouseEnabled =true;
			else
				F.FrameDataTab[name].IsOldMouseEnabled =false;
				m_Frame:EnableMouse(true);
			end
			if m_Frame:IsMovable() then
				F.FrameDataTab[name].IsOldMovable =true;
			else
				F.FrameDataTab[name].IsOldMovable =false;
				m_Frame:SetMovable(true);
			end
			m_Frame:RegisterForDrag("LeftButton");
			m_Frame:SetScript("OnDragStart", OnDragStart)
			m_Frame:SetScript("OnDragStop", OnDragStop)
			m_Frame:SetClampedToScreen(true)
		end
	end
end

function BigFoot_CheckMoveFrame(xPos, yPos)
	-- local xPos, yPos = GetCursorPosition();
	-- print(__GetPoint(GetMouseFocus()))
	local Check_Frame;
	-- local drag_Frame;
	-- local present = UIParent:GetEffectiveScale();
	for k, v in pairs(F.FrameTab) do
		if type(k) =="string" then
			Check_Frame = _G[k];
			if Check_Frame then--and drag_Frame then --and PM_x and PM_y then
				if Check_Frame:IsShown() then
					if F.BloadPos then
						BigFoot_SetMoveFramePos(Check_Frame);
					end
					BigFoot_SetFrameCanMove(Check_Frame);
				end
			end
		end
	end
end

-- BF_Frames_Config
function BigFoot_SetMoveFramePos(Check_Frame)
	local point,ref,refPoint,Pos_x,Pos_y
	local name = Check_Frame:GetName();
	if not F.FrameDataTab[name] then
		F.FrameDataTab[name] ={};
	end
	if F.FrameDataTab[name].BsetPos then return end
	F.FrameDataTab[name].BsetPos =true
	-- BigFoot_SetPosDcall(name,Check_Frame)
	BigFoot_DelayCall(BigFoot_SetPosDcall,4,name,Check_Frame)

end

function BigFoot_SetPosDcall(name,Check_Frame) ---延迟一下 等待官方界面自己设置位置之后 再载入自己的位置
	if BF_Frames_Config.BCanMove~=nil then
		if BF_Frames_Config.BCanMove then
			F.BCanMove =true;
		else
			F.BCanMove =false;
		end
	end
	if BF_Frames_Config[Check_Frame:GetName()] and BF_Frames_Config[Check_Frame:GetName()]["Pos"]  then
		point,ref,refPoint,Pos_x,Pos_y = unpack(BF_Frames_Config[Check_Frame:GetName()]["Pos"])
		Check_Frame:ClearAllPoints();
		Check_Frame:SetPoint(point,ref,refPoint,Pos_x,Pos_y);
	else
		local TopX = Check_Frame:GetLeft();
		local TopY = Check_Frame:GetTop();
		if not TopX or not TopY then
			Check_Frame:ClearAllPoints();
			Check_Frame:SetPoint("CENTER","UIParent","CENTER",0,0);
		else
			-- dragFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT",TopX,-TopY);
			Check_Frame:ClearAllPoints();
			-- Check_Frame:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",TopX,TopY);
		end
		BF_Frames_Config[Check_Frame:GetName()]={}
	end
end

function BigFoot_CreatFrame()
	local Check_Frame;
	local dragFrame;
	local dragSizeFrame;
	for k, v in pairs(F.FrameTab) do
		if type(k) =="string" then
			Check_Frame = _G[k];
			if Check_Frame and Check_Frame:IsShown() then
				BigFoot_SetMoveFramePos(Check_Frame,k,v)
			end
		end
	end
	F.BloadPos =true
end

-----------窗体名字的string---------
-- BTop 移动锚点位置 true 为左上窗体外-----------
-- BigFoot_RegistMoveFrame("CoolLine")
function BigFoot_RegistMoveFrame(Frame,BTop)
	if BTop then
		F.FrameTab[Frame] =1;
	else
		F.FrameTab[Frame] =2;
	end
	--如果注册的时候已经存在这个窗体了就及时生效
	-- if _G[Frame] then
		-- BigFoot_CreatFrame()
	-- end
end

--------------设置所有注册的窗体是否处于解锁可移动状态---------------------------------
function BigFoot_CanMoveFrame(BTop) --- true or false
	F.BCanMove = BTop
	BF_Frames_Config.BCanMove = F.BCanMove;
end

function BigFoot_BCanMoveFrame()
	return F.BCanMove;
end

------------------------鼠标提示关于显示物品延迟调用实现-------------------------------------------
------------------------------调用方法。RatingBuster_CheckShow 输入为当前鼠标提示的模块 和 itemLINK ------------------
-----------------------------返回true 添加要现实的内容-----------------------------------
local CheckMod ={}

function RatingBuster_CheckShow(m_mod,link)
	if not m_mod then return true end
	if not GetMouseFocus() then return end
	local FrameName = GetMouseFocus():GetName()
	if FrameName and string.find(FrameName,"QuestInfo") then return true end
	if not CheckMod[m_mod] then
		CheckMod[m_mod] ={};
		CheckMod[m_mod].ShowTan={};
		CheckMod[m_mod].BStratCheck =false;
		CheckMod[m_mod].CheckNumber=0;
		CheckMod[m_mod].BOKLink1 =nil
		CheckMod[m_mod].BOKLink2 =nil
		CheckMod[m_mod].BOKLink3 =nil
		CheckMod[m_mod].LastTiem =0;
	end
	if link == CheckMod[m_mod].BOKLink1 or link == CheckMod[m_mod].BOKLink2 or link == CheckMod[m_mod].BOKLink3 then
		return true
	end

	CheckMod[m_mod].BOk =false;
	if not CheckMod[m_mod].BStratCheck then
		CheckMod[m_mod].BStratCheck =true;
		CheckMod[m_mod].BOKLink1=nil;
		CheckMod[m_mod].BOKLink2=nil;
		CheckMod[m_mod].BOKLink3=nil;
		CheckMod[m_mod].CheckNumber =0;
		CheckMod[m_mod].LastTiem =GetTime();
		CheckMod[m_mod].ShowTan ={};
	end
	CheckMod[m_mod].CheckNumber = CheckMod[m_mod].CheckNumber+1;
	CheckMod[m_mod].ShowTan[CheckMod[m_mod].CheckNumber]=link;
	if GetTime() - CheckMod[m_mod].LastTiem >0.4 then
		CheckMod[m_mod].BOk =true
		for k , v in pairs(CheckMod[m_mod].ShowTan) do
			if not CheckMod[m_mod].BOKLink1 then
				CheckMod[m_mod].BOKLink1  = v;
			end
			if CheckMod[m_mod].BOKLink1 and CheckMod[m_mod].BOKLink1~= v and (not CheckMod[m_mod].BOKLink2) then
				CheckMod[m_mod].BOKLink2 =v;
			end
			if CheckMod[m_mod].BOKLink1 and CheckMod[m_mod].BOKLink1~= v and CheckMod[m_mod].BOKLink2 and CheckMod[m_mod].BOKLink2~= v and (not CheckMod[m_mod].BOKLink3) then
				CheckMod[m_mod].BOKLink3 =v;
			end
			if CheckMod[m_mod].BOKLink1 and CheckMod[m_mod].BOKLink1~= v and CheckMod[m_mod].BOKLink2 and CheckMod[m_mod].BOKLink2~= v and CheckMod[m_mod].BOKLink3 and CheckMod[m_mod].BOKLink3~= v  then
				CheckMod[m_mod].BOk =false;
				CheckMod[m_mod].BOKLink1=nil;
				CheckMod[m_mod].BOKLink2=nil;
				CheckMod[m_mod].BOKLink3=nil;
				break;
			end
		end
		CheckMod[m_mod].BStratCheck =false;
	end
	return CheckMod[m_mod].BOk;
end

-----------------------------新插件推出效果模块------------------------------------------------------------------
-----------------------调用方法。-BF_NewAddOnsPromotion --------------------------------------------------------
------------输入为 推出插件的版本和版本号 推出插件的 AddOnsName；显示的说明文字 ShowStr；插件所在大脚模板BigFootMod;插件所在大脚的设置选项BigFootOption-------------------
----------------函数调用时间：保证在 BF_NewAddOnsShowTip 函数执行直接 调用BF_NewAddOnsPromotion-----
--------------------目前模块，请在 PLAYER_LOGIN 这个事件之前调用 BF_NewAddOnsPromotion --------------------------

function BF_ShowNewAddonsInBigfoot(BigFootMod)
	if not ModManagementFrame:IsShown() then
		ShowUIPanel(ModManagementFrame);
	end
	local AllTab
	if BigFoot_ModIndexList then
		AllTab = BigFoot_ModIndexList[1];
	end
	if AllTab then
		local pagenumber =1;
		local Sellnumber =1;
		for k , v in pairs (AllTab) do
			if v.name == BigFootMod then
				if mod(k,MAX_MOD_BUTTON_COUNT) ==0 then
					pagenumber = k/MAX_MOD_BUTTON_COUNT;
					Sellnumber =MAX_MOD_BUTTON_COUNT;
				else
					pagenumber = floor(k/MAX_MOD_BUTTON_COUNT)+1;
					Sellnumber = mod(k,MAX_MOD_BUTTON_COUNT)
				end
			end
		end
		ModManagementFrame_ShowPage(pagenumber,1)
		local __button = getglobal("ModButton"..Sellnumber);
		__button:SetChecked(1)
		ModButton_OnClick(__button)
	end
end

local anchorData = {align = "RIGHT", xOff = -50, yOff = 0}
local textBox = {font =GameFontNormalLarge,topLeft_xOff = 33, topLeft_yOff = -80, bottomRight_xOff = -29, bottomRight_yOff = 35}
local tileHeight = 21
local TUTORIALFRAME_WIDTH = 364;
local TUTORIALFRAME_MIDDLE_HEIGHT = 10;
local TUTORIALFRAME_BOTTOM_HEIGHT = 30;
local TUTORIALFRAME_TOP_HEIGHT = 80;
local BNewAddonShow =false;
local ShowPageNumber =1;
BF_NewAddOnsTab={};
BF_BshowNewAddOnsTab={}

----------------------这个做个判断，只保留最近5个版本的推出效果，太早之前的推出效果可以忽略了。------------------------------
function BF_NewAddonCheckGetversion()
	local versionNumTab={};
	for k,v in pairs(BF_NewAddOnsTab)do
		if type(k)=="number" then
			table.insert(versionNumTab,k);
		end
	end
	table.sort(versionNumTab,function(left,right) return left>right end)
	if #versionNumTab >5 then
		for i=6,#versionNumTab do
			if versionNumTab[i] then
				BF_NewAddOnsTab[versionNumTab[i]] =nil
			end
		end
	end
end

function BF_NewAddonCheckCersionNum(Version,VersionNum)
	local m_Version = BIGFOOT_VERSION;
	if not m_Version then
		m_Version ="CN3.1.0.000"
	end
	if m_Version then
		if string.find(m_Version,Version) then
			return true;
		end
	end
end

function BF_NewAddOnsPromotion(Version,VersionNum,AddOnsName,ShowStr,BigFootMod,BigFootOption)
	-- 暂时干掉提示
	-- if BF_NewAddonCheckCersionNum(Version,VersionNum) then
		-- if not BF_NewAddOnsTab[VersionNum] then
			-- BF_NewAddOnsTab[VersionNum]={}
		-- end
		-- table.insert(BF_NewAddOnsTab[VersionNum],{Version=Version,VersionNum=VersionNum,AddOnsName=AddOnsName,ShowStr=ShowStr,BigFootMod=BigFootMod,BigFootOption=BigFootOption})
		-- BF_NewAddonCheckGetversion()
	-- end
end

function BF_NewTutorialFrame_AlertButton_OnClick(self)
	if not BNewAddonShow then
		table.sort(BF_BshowNewAddOnsTab,function(left,right) return left.VersionNum>right.VersionNum end)
		BF_ShowNewAddon(1)
		BNewAddonShow =true;
	end
end

function BF_ShowNewAddon(PageNumber)
	if not BF_BshowNewAddOnsTab[PageNumber] then return end
	local BF_NewBigFootMod = BF_BshowNewAddOnsTab[PageNumber].BigFootMod;
	local BF_NewShowStr = BF_BshowNewAddOnsTab[PageNumber].ShowStr;
	local BF_NewAddOnsName = BF_BshowNewAddOnsTab[PageNumber].AddOnsName;
	local Allnumber = #BF_BshowNewAddOnsTab
	if not BF_NewBigFootMod or not BF_NewShowStr or not BF_NewAddOnsName then return end
	TutorialFrame.id =1
	TutorialFrame_ClearTextures();
	TutorialFrame:SetPoint( anchorData.align, UIParent, anchorData.align, anchorData.xOff, anchorData.yOff );
	-- <TexCoords left="0.0019531" right="0.7109375" top="0.0019531" bottom="0.1562500"/>
	TutorialFrameTop:SetTexture([[Interface\AddOns\BigFoot\Media\footico.tga]])
	TutorialFrameTop:SetTexCoord(0.0019531, 0.7109375, 0.0019531, 0.1562500*2)

	TutorialFrameTop:Show();
	TutorialFrameLeft1:Show();
	TutorialFrameRight1:Show();
	TutorialFrameBottom:Show();
	TutorialFrameBackground:Show();
	TutorialFrameCloseButton:Show();
	TutorialFrameCloseButton:SetScript("OnClick", function(self) TutorialFrame_Hide() end)
	TutorialFrameOkayButton:Hide();
	TutorialFramePrevButton:Hide();
	TutorialFrameNextButton:Hide();
	local anchorParentLeft = TutorialFrameLeft1;
	local anchorParentRight = TutorialFrameRight1;
	for i = 2, tileHeight do
		local leftTexture = _G["TutorialFrameLeft"..i];
		local rightTexture = _G["TutorialFrameRight"..i];
		leftTexture:SetPoint("TOPLEFT", anchorParentLeft, "BOTTOMLEFT", 0, 0);
		rightTexture:SetPoint("TOPRIGHT", anchorParentRight, "BOTTOMRIGHT", 0, 0);
		leftTexture:Show();
		rightTexture:Show();
		anchorParentLeft = leftTexture;
		anchorParentRight = rightTexture;
	end
	TutorialFrameBottom:SetPoint("TOPLEFT", anchorParentLeft, "BOTTOMLEFT", 0, 0);
	TutorialFrameBottom:SetPoint("TOPRIGHT", anchorParentRight, "TOPRIGHT", 0, 0);

	local height = TUTORIALFRAME_TOP_HEIGHT + (tileHeight * TUTORIALFRAME_MIDDLE_HEIGHT) + TUTORIALFRAME_BOTTOM_HEIGHT;
	TutorialFrame:SetSize(TUTORIALFRAME_WIDTH, height);
	local ShowTab=_G["BFShowNewAdonBtn"];
	if not ShowTab then
		ShowTab = CreateFrame("Button","BFShowNewAdonBtn",TutorialFrame,"UIPanelButtonTemplate")
	end
	ShowTab:Show();
	ShowTab.BF_NewBigFootMod = BF_NewBigFootMod;
	ShowTab:SetScript("OnClick", function(self) BF_ShowNewAddonsInBigfoot(self.BF_NewBigFootMod) end)
	ShowTab:SetPoint("BOTTOMRIGHT", -127, 7)
	ShowTab:SetHeight(22)
	ShowTab:SetWidth(100)
	ShowTab:SetText(BF_OPEN_NEWADDON_OPTION)

	local NextBtn=_G["BFShowNewNextBtn"];
	if not NextBtn then
		NextBtn = CreateFrame("Button","BFShowNewNextBtn",TutorialFrame,"UIPanelButtonTemplate")
	end
	NextBtn:Show();
	NextBtn:SetPoint("BOTTOMRIGHT", -7, 7)
	NextBtn:SetHeight(22)
	NextBtn:SetWidth(108)
	NextBtn:SetText(NEXT)
	if PageNumber < Allnumber then
		NextBtn:Enable()
		NextBtn.PageNumber =PageNumber
		NextBtn:SetScript("OnClick", function(self)  BF_ShowNewAddon(self.PageNumber+1) end)
	else
		NextBtn:Disable()
	end

	local FirstBtn=_G["BFShowPREVBtn"];
	if not FirstBtn then
		FirstBtn = CreateFrame("Button","BFShowPREVBtn",TutorialFrame,"UIPanelButtonTemplate")
	end
	FirstBtn:Show();
	if PageNumber>1 then
		FirstBtn:Enable();
	else
		FirstBtn:Disable();
	end
	FirstBtn.PageNumber = PageNumber;
	FirstBtn:SetScript("OnClick", function(self)  BF_ShowNewAddon(self.PageNumber-1) end)
	FirstBtn:SetPoint("BOTTOMRIGHT", -237, 7)
	FirstBtn:SetHeight(22)
	FirstBtn:SetWidth(100)
	FirstBtn:SetText(PREV)
	-- RaidNotice_AddMessage(RaidWarningFrame, text, HIGHLIGHT_FONT_COLOR);

	TutorialFrameText:SetText(BF_NewShowStr);
	if(textBox.font) then
		TutorialFrameText:SetFontObject(textBox.font);

	end
	TutorialFrameTextScrollFrame:SetPoint("TOPLEFT", TutorialFrame, "TOPLEFT", textBox.topLeft_xOff, textBox.topLeft_yOff);
	TutorialFrameTextScrollFrame:SetPoint("BOTTOMRIGHT", TutorialFrame, "BOTTOMRIGHT", textBox.bottomRight_xOff, textBox.bottomRight_yOff);

	if (BF_NewAddOnsName) then
		TutorialFrameTitle:SetText(BF_NewAddOnsName);
	end
	TutorialFrame:Show();
end

function BF_CheckVersion(m_OLd_Time,m_New_Time_Version,m_New_Time_VersionNum)
	if not m_OLd_Time then return true end
	if string.find(m_OLd_Time,"b") and (not string.find(m_New_Time_Version,"b")) then
		return false;
	end
	if string.find(m_OLd_Time,m_New_Time_Version)then
		local m_odl_VersionNum =  tonumber(string.sub(m_OLd_Time,-4,-1));
		if m_odl_VersionNum and m_odl_VersionNum<1 then
			m_odl_VersionNum =  tonumber(string.sub(m_OLd_Time,-3,-1));
		end
		if m_odl_VersionNum then
			if m_New_Time_VersionNum > m_odl_VersionNum then
				return true
			end
		end
	else
		return false
	end
	return false
end

function BF_ISOneNewAddonHave(BigFootMod,BigFootOption)
	local bhave =false;
	if BigFoot_ModOptionConfig and BigFoot_ModOptionConfig[BigFootMod] then
		for k, v in pairs(BigFoot_ModOptionConfig[BigFootMod])do
			if v.variable == BigFootOption then
				bhave =true
				break
			end
		end
	end
	return bhave;
end

function BF_ISNewAddonHave(m_Tab,m_Time)
	local bhave =false;
	if BigFoot_ModOptionConfig then
		for i, j in pairs(m_Tab) do
			if type(j) =="table" then
				for k,v in pairs(j) do
					if BF_ISOneNewAddonHave(v.BigFootMod,v.BigFootOption) then
						if BF_CheckVersion(m_Time,v.Version,v.VersionNum) then
							bhave =true
							table.insert(BF_BshowNewAddOnsTab,{VersionNum =v.VersionNum,AddOnsName=v.AddOnsName,ShowStr=v.ShowStr,BigFootMod=v.BigFootMod,BigFootOption=v.BigFootOption})
						end
					end
				end
			end
		end
	end
	return bhave;
end

function BF_NewAddOnsShowTip()
	if   type(BigFoot_NewAddonChecked)~="table" then  BigFoot_NewAddonChecked = {} end
	if BF_ISNewAddonHave(BF_NewAddOnsTab,BigFoot_NewAddonChecked.CheckedTime)  and (not (BFNew_GetNewFrameState and BFNew_GetNewFrameState() )) then
		BF_OldTutorialFrame_AlertButton_OnClick = TutorialFrame_AlertButton_OnClick
		TutorialFrame_AlertButton_OnClick = BF_NewTutorialFrame_AlertButton_OnClick
		----------------------替换图标-----------------------------------
		local TutorialFrameTestTexture = TutorialFrameAlertButton:GetNormalTexture()
		TutorialFrameTestTexture:SetTexture([[Interface\AddOns\BigFoot\Media\footico.tga]])
		TutorialFrameTestTexture:SetTexCoord(0.7167969, 0.9414063, 0.0019531, 0.1386719*2)
		-----------------创建闪烁效果-------------------------------------------------------
		if not BF_NewAddonAnimaTexture then
			TutorialFrameAlertButton:CreateTexture("BF_NewAddonAnimaTexture")
		end
		BF_NewAddonAnimaTexture:SetTexture([[Interface\TutorialFrame\UI-TUTORIAL-FRAME]]);
		BF_NewAddonAnimaTexture:SetTexCoord(0.755859,0.853515625,0.2246094,0.3203125);
		BF_NewAddonAnimaTexture:SetPoint("CENTER",2,4)
		BF_NewAddonAnimaTexture:SetSize(51,50)
		BF_NewAddonAnimaTexture:Show()

		local TutorialFrameAlertButtonAnimationGroup = BF_NewAddonAnimaTexture:CreateAnimationGroup();
		TutorialFrameAlertButtonAnimationGroup:SetLooping("BOUNCE")
		local TutorialFrameAnimation = TutorialFrameAlertButtonAnimationGroup:CreateAnimation("Alpha")
		TutorialFrameAnimation:SetChange(-0.7)
		TutorialFrameAnimation:SetDuration(0.5)
		TutorialFrameAnimation:SetOrder(1)
		TutorialFrameAlertButtonAnimationGroup:Play() --开启闪烁
		TutorialFrameAlertButton:Show()
		TutorialFrameAlertButton.TutorialFrameAlertButtonAnimationGroup = TutorialFrameAlertButtonAnimationGroup
		TutorialFrameAlertButton:SetScript("OnEnter",function(self) if self.TutorialFrameAlertButtonAnimationGroup then self.TutorialFrameAlertButtonAnimationGroup:Stop() BF_NewAddonAnimaTexture:Hide() end  end)
		TutorialFrameAlertButton:SetScript("OnLeave",function(self) if self.TutorialFrameAlertButtonAnimationGroup and not BNewAddonShow then BF_NewAddonAnimaTexture:Show()  self.TutorialFrameAlertButtonAnimationGroup:Play() end  end)
	end
end

-----------还原系统原来效果--------------------
function BF_NewAddonRollBack()
	if BNewAddonShow then
		if BF_OldTutorialFrame_AlertButton_OnClick then
			TutorialFrame_AlertButton_OnClick = BF_OldTutorialFrame_AlertButton_OnClick;
			BF_OldTutorialFrame_AlertButton_OnClick =nil
		end
		local ShowTab=_G["BFShowNewAdonBtn"];
		if ShowTab then
			ShowTab:Hide()
		end
		local ShowTab=_G["BFShowNewNextBtn"];
		if ShowTab then
			ShowTab:Hide()
		end
		local ShowTab=_G["BFShowPREVBtn"];
		if ShowTab then
			ShowTab:Hide()
		end
		local ShowTab=_G["BF_NewAddonAnimaTexture"];
		if ShowTab then
			ShowTab:Hide()
		end
		local TutorialFrameTestTexture = TutorialFrameAlertButton:GetNormalTexture()
		TutorialFrameTestTexture:SetTexture([[Interface\TutorialFrame\UI-TUTORIAL-FRAME]])
		TutorialFrameTestTexture:SetTexCoord(0.7167969, 0.9414063, 0.0019531, 0.1386719)
		TutorialFrameTop:SetTexture([[Interface\TutorialFrame\UI-TUTORIAL-FRAME]])
		TutorialFrameTop:SetTexCoord(0.0019531,0.7109375,0.0019531,0.1562500)
		TutorialFrameAlertButton.TutorialFrameAlertButtonAnimationGroup =nil;
	-- <TexCoords left="0.0019531" right="0.7109375" top="0.0019531" bottom="0.1562500"/>
		TutorialFrameTitle:SetText("");
		TutorialFrameAlertButton:Hide();
		if  type(BigFoot_NewAddonChecked)~="table" then  BigFoot_NewAddonChecked = {} end
		BigFoot_NewAddonChecked.CheckedTime =BIGFOOT_VERSION;
	end
end

hooksecurefunc("TutorialFrame_Hide",BF_NewAddonRollBack);
