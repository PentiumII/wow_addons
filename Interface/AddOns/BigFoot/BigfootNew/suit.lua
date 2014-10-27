BF_AddonSuit =classv2(SearchEnfy);
--[[@param
	BF_AddonSuit.name (string)				     	 方案名	
	BF_AddonSuit.Inited (true or nil) 		         初始化标识:当方案中Insert第一个插件对象时置为true
	BF_AddonSuit.time (table)        				 方案保存时间
	BF_AddonSuit.Character (string)  				 保存方案时角色名
]]--
function BF_AddonSuit:ctor(name)
	self.name =name;					
	self.Inited =nil;  
	self.Class = UnitClass("player")
end



function BF_AddonSuit:SetName(StrName)
	self.name = StrName;
end
function BF_AddonSuit:GetName()
	return self.name;
end
function BF_AddonSuit:SetTime()
	-- local m_time =date("*t");
	local m_time =date();
	self.time =m_time;
	self.CheckTime = time();
end
function BF_AddonSuit:GetCheckTime()
	if self.CheckTime then
		return self.CheckTime
	else
		return -1;
	end
end
function BF_AddonSuit:GetTime()
	return self.time;
end
function BF_AddonSuit:SetCharacterName(m_Name)
	self.Character =m_Name;
end
function BF_AddonSuit:GetClass()
	if self.Class then
		return self.Class
	end
end
function  BF_AddonSuit:GetCharacterName()
	return self.Character;
end
--[[@func
	BF_AddonSuit:insert(BF_Addon)        向方案中添加插件
]]--
function BF_AddonSuit:insert(m_Addon)
	if not self.AddonList then
		self.AddonList ={};
	end
	if m_Addon:GetName() and m_Addon:GetName()~="" then
		table.insert(self.AddonList,m_Addon)
		if not self.Inited then
			self.Inited=true;
		end
	end
end 
function BF_AddonSuit:GetInitMark() 
	return self.Inited
end
--[[@func
	BF_AddonSuit:SetData(dataTab)        将table赋值给对象  
]]--
function BF_AddonSuit:SetData(dataTab)
	if dataTab then
		for k,v in pairs(dataTab) do
			if type(k)=="string" and type(v)~="table" then
				self[k]=v;
			end
		end
		-- self.name = dataTab.name;						
		-- self.Inited = dataTab.Inited;
		-- self.time = dataTab.time;
		-- self.Character = dataTab.Character;
		if dataTab.AddonList then
			for k,v in pairs (dataTab.AddonList) do
				local Addon = BF_Addon.new(v.name);
				Addon:SetData(v);
				self:insert(Addon);
			end
		end
	end
end
function BF_AddonSuit:GetSaveData()
	local m_SaveTab={}
	for k,v in pairs(self) do
		if type(k)=="string" and type(v)~="table" then
			m_SaveTab[k]=v;
		end
	end
	if self.AddonList then
		m_SaveTab.AddonList={};
		for k,v in pairs (self.AddonList) do
			local AddonSaveData = v:GetSaveData()
			table.insert(m_SaveTab.AddonList,AddonSaveData)
		end
	end
	return m_SaveTab;
end

function BF_AddonSuit:IsDefaultSuit()
	if self:GetTime() == BF_DEFAULTSUITNAME_DEFAULT then
		return true
	end
end
function BF_AddonSuit:Search(m_Filter)
	local Addonlist ={}
	if self.AddonList then
		for k,v in pairs(self.AddonList) do
			if v:Search(m_Filter) then
				table.insert(Addonlist,v);
			end
		end
	end
	return Addonlist;
end
function BF_AddonSuit:GetAddonList()
	return self.AddonList or {};
end
function BF_AddonSuit:GetAddon(AddonName)
	if self.AddonList and AddonName then
		for k,v in pairs(self.AddonList) do
			if v:GetName()== AddonName then
				return v;
			end
		end
	end
	return nil;
end
function BF_AddonSuit:GetEnableAddonNum()
	local Addonlist =self:GetAddonList()
	local EnableNum =0;
	for k,v in pairs (Addonlist) do
		if v:GetConfigEnable() then
			EnableNum = EnableNum+1;
		end
	end
	return EnableNum;
end
function BF_AddonSuit:submitSet()
	local AddonList = self:GetAddonList()
	local State;
	local name;
	for k,v in pairs (AddonList) do
		v:submitSet();
	end
end