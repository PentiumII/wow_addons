local t_Tutorials={}

-- function RegisterTutorial(name)
-- end
-- function RegisterTutorialStep(name,text,arrow,index,frame,offsetX,offsetY)
	-- t_Tutorials[name][index] = {}
	-- t_Tutorials[name][index] = {text,arrow}
-- end
t_Tutorials ["FirstLogin"] = {
	[3] = {text=Tutorial_First_Login_step1,arrow="UP",index=3,frame="BigfootSuitDropDownMenuButton",offsetX=10,offsetY=0},
	[2] = {text=Tutorial_First_Login_step2,arrow="UP",index=2,frame="BigfootNewMainFrameMainSettingButton",offsetX=10,offsetY=0},
	[1] = {text=Tutorial_First_Login_step3,arrow="UP",index=1,frame="guidertestButton3",offsetX=10,offsetY=0},
	[4] = {text=Tutorial_First_Login_step4,arrow="UP",index=4,frame="BF_AddonListContainerButton1Option",offsetX=10,offsetY=10},
	[5] = {text=Tutorial_First_Login_step5,arrow="UP",index=5,frame="AddOnStatusHeader",offsetX=10,offsetY=0},
	[6] = {text=Tutorial_First_Login_step6,arrow="UP",index=6,frame="BF_SearchBox",offsetX=10,offsetY=0},
}
function TutorialsFrameNextOnClick(self)
	if self:GetText() == DONE then
		self:GetParent():Hide()
	end
	if #self:GetParent().tuorials>self:GetParent().curStep then
		self:GetParent().curStep = self:GetParent().curStep+1
	end
	if self:GetParent().curStep>1 then
		self:GetParent().lastStep:Show()
	end
	TutorialsFrameUpdate(self:GetParent())
	if self:GetParent().curStep == #self:GetParent().tuorials then
		self:SetText(DONE)
		
	end
end
function TutorialsFrameLastOnClick(self)
	if self:GetParent().curStep>1 then
		self:GetParent().curStep = self:GetParent().curStep-1
	end
	if self:GetParent().curStep<#self:GetParent().tuorials then
		self:GetParent().nextStep:SetText(BUTTONTEXT_NEXT)
	end
	TutorialsFrameUpdate(self:GetParent())
	if self:GetParent().curStep == 1 then
		self:Hide()
	end
end
function TutorialsFrameOnShow(self)
	self.curStep = 1
	TutorialsFrameUpdate(self)
	if self.tuorials then
		self.lastStep:Hide()
	else
		-- self:Hide()
	end
end
function TutorialsFrameUpdate(self)
	local t_currentData = {}
	if self.tuorials[self.curStep] then
		t_currentData = self.tuorials[self.curStep]
		self.text:SetText(t_currentData.text)
		-- print(self.text:GetHeight())
		self:SetHeight(self.text:GetHeight()+62)
		if t_currentData.arrow == "UP" then
			self.arrowup:Show()
			self.arrowdown:Hide()
			self:ClearAllPoints()
			self:SetPoint("TOP",_G[t_currentData.frame],"BOTTOM",t_currentData.offsetX,t_currentData.offsetY-20)
		elseif t_currentData == "DOWN" then
			self.arrowdown:Show()
			self.arrowup:Hide()
		end
	end
	if self.curStep == 1 then
		self.lastStep:Hide()
		self.nextStep:SetText(BUTTONTEXT_NEXT)
		self.nextStep:Show()
	end
end
function TutorialsFrameStart(name)
	if t_Tutorials[name] and BF_Gloable.EndTutorials~=true then
		BigfootTutorialFrame.tuorials = t_Tutorials[name]
		BigfootTutorialFrame:Show()
	end
	
	BF_Gloable.EndTutorials = true
end