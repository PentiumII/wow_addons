local BIGFOOT_LOADADDONFALSE="|cff00e0e0LoadAddon %s false reason:%s |r";
BF_Addon =classv2(SearchEnfy);
-- BF_Addon.new(name, title, notes, enabled, loadable, reason, security,bBigfoot,deps);
function BF_Addon:ctor(name, title, notes, enabled, loadable, reason, security,bBigfoot,deps,estMemory,BigfootType)
	assert(name,"Can not creat addon without name")
	self.name =name;                          --插件名
	self.title =title;						  --Title
	self.notes = notes;						  --Notes
	self.enabled =enabled;					  --是否已启用
	self.configEnable = self.enabled          --配置状态
	self.loadable =loadable;                  --是否可以加载
	self.reason =reason;                      --加载失败时原因
	self.security =security;                  --for Blizzard built-in addons 来源:GetAddOnInfo()
	self.bBigfoot =bBigfoot;                  --是否是大脚插件
	self.deps =deps;                          --运行依赖
	self.Type ={"All",};						  --插件属于的类型。如果大型，热门 这些
	self.bReload = BFNew_GetAddonReloadInfo(name); ---- 这是插件载入属性。这个值为true 则插件启动需要重载界面。
	self.bnew = BFNew_GetAddonbnewInfo(name); ------------这是插件新属性。这个值为true 则插件为新推出插件。
	self.estMemory = estMemory;           		--预估内存
	self.BigfootType = BigfootType;
	self:IniAddonType();
	self:IniAddonConfig();
	self:CheckAddon();
end
function BF_Addon:GetbBigfoot()
	return self.bBigfoot
end
function BF_Addon:CheckAddon()
	local name = self:GetName();
	if name and name~="" then
		if string.find(name,"DBM") and name~="DBM-Core" then
			self:SetName("");
		elseif string.find(name,"dct") and name~="dct" then
			self:SetName("");
		elseif string.find(name,"Combuctor") and name~="Combuctor" then
			self:SetName("");
		elseif string.find(name,"Grid") and name~="Grid" then
			self:SetName("");
		end
	end
end
function BF_Addon:IniAddonType()
	if self:GetName() then
		local m_AddonTypeTab = BFNew_GetAddonType(self:GetName());
		if m_AddonTypeTab then
			self:SetType(m_AddonTypeTab)
		end	
		local exclusiveTab = BFNew_GetAddonexclusiveTab(self:GetName());
		if exclusiveTab then
			self:SetexclusiveTab(exclusiveTab)
		end
	end
end

function BF_Addon:IniAddonConfig()
	if self:GetName() then
		local m_configTab = BFNew_GetAddonConfig(self:GetName());
		if m_configTab  and  type(m_configTab)=="table" then
			for k,v in pairs (m_configTab)do
				local m_AddonConfig = BF_AddonConfig.new(v.caption);
				-----------------------------
				m_AddonConfig:RegisterItem(v)
				----------------------------
				self:insert(m_AddonConfig);
			end
		end
	end
end
--[[@func
		BF_Addon:GetState()  返回当前的状态值
	@return
		1 -将要启用 ,2 - 将要关闭,3 - 已启用,4 - 已经关闭
]]--
function BF_Addon:GetState()
	if not self:GetCanCheck() then
		return 4;
	end
	if self.enabled then
		if self:GetConfigEnable() == self.enabled then
			return 3
		else
			return 2
		end
	else
		if self:GetConfigEnable() == self.enabled then
			return 4
		else
			return 1
		end
	end
end
function BF_Addon:GetConfigEnable()
	if not self:GetCanCheck() then
		return nil;
	end
	return self.configEnable
end
function BF_Addon:GetInfo(bAll)
	local strNots =nil;
	local outDate = nil;
	local bUsable = nil;
	if self.Info then
		strNots= self.Info;
	else
		if self.notes then
			strNots=self.notes;
			if string.find(strNots,"          ") then
				string.gsub(self.notes,".-%s+(.+)",function(str) strNots = str end);
			end
		end
	end
	if string.find(strNots,"|c") then
		local start,_end = string.find(strNots,"|c")
		strNots = string.sub(strNots,0,start+1) .."ffffffff"..string.sub(strNots,_end+9,-1)
	end
	if not self:GetCanCheck() and strNots then
		if bAll then
			bUsable = true
		else
			bUsable = nil
		end
	end
	if self:IsAddonOutDate() == 1 then
		if bAll then
			outDate = true
		else
			outDate = nil
			-- strNots = BF_ADDON_OUTDATE--..strNots
		end
	end
	return strNots,bUsable,outDate;
end
function BF_Addon:GetShowState()
	local m_State=-1;
	if self.bnew then
		m_State =2;
	else
		if self.bnewConfig then
			m_State =1;
		end
	end
	return m_State
end

function BF_Addon:SetConfigEnable(enable)
	self.configEnable = enable
	self:SetAddonConfigData()
	pcall(BigfootNewMainFrame_AlertFrameAddOnMessage,self:GetName(),enable,self:GetReloadInfo())
end
function BF_Addon:GetName()
	return self.name
end
function BF_Addon:SetName(str)
	self.name = str;
end
function BF_Addon:GetTitle()
	local alias = nil
	local strNots="";
	alias =GetAddOnMetadata(self:GetName(),"X-Alias")
	if self.title then
		string.gsub(self.title,"%[.+%](.+)",function(str) strNots = str end)
	end
	if strNots =="" then
		strNots = self.title;
	end
	if alias  then
		return alias
	else
		return strNots;
	end
end
function BF_Addon:SetEnable(enabled)
	self.enabled=enabled;
end

function BF_Addon:Settitle(title)
	self.title =title
end
function BF_Addon:Setnotes(notes)
	self.notes =notes
end

function BF_Addon:Setloadable(loadable)
	self.loadable =loadable
end
function BF_Addon:Setreason(reason)
	self.reason =reason
end
function BF_Addon:Setsecurity(security)
	self.security =security
end
function BF_Addon:SetbBigfoot(bBigfoot)
	self.bBigfoot =bBigfoot
end
function BF_Addon:Setdeps(deps)
	self.deps =deps
end
function BF_Addon:SetBigfootType(BigfootType)
	self.BigfootType =BigfootType
end
function BF_Addon:SetexclusiveTab(exclusiveTab)
	self.exclusiveTab = exclusiveTab;
end
function BF_Addon:GetexclusiveTab()
	local bHave =false;
	local m_exclusiveTab ={};
	if self.exclusiveTab and type(self.exclusiveTab) =="table" then --self:GetConfigEnable()
		for k,v in pairs (self.exclusiveTab)do
			if v ==self:GetName() then
				bHave =true
			else
				table.insert(m_exclusiveTab,v);
			end
		end
	end
	if not bHave then
		m_exclusiveTab= {};
	end
	return m_exclusiveTab;
end
function BF_Addon:GetdepsTab()
	local m_depsTab={};
	-- if self:GetConfigEnable() then
		if self.deps and type(self.deps)=="table" then
			m_depsTab = self.deps;
		end
	-- end
	return m_depsTab
end
function BF_Addon:GetReloadInfo()
	return self.bReload;
end
function BF_Addon:GetCanCheck()
	if #self:GetAddonConfigList()>0 then
		return true;
	elseif self.bBigfoot==false then
		return true;
	end
end
function BF_Addon:GetEnable()
	if not self:GetCanCheck() then
		return nil;
	end
	
	return self.enabled
end
function BF_Addon:GetEstMemory()
	return self.estMemory or-1;
end
function BF_Addon:SetEstMemory(eslMemory)
	self.estMemory = eslMemory
end
local UpdateAddOnMemoryTime;
function BF_Addon:GetMemory(bUpdata)
	if self:GetEnable() then
		if (not self.Memory) or bUpdata then
			local m_Time =GetTime();
			if UpdateAddOnMemoryTime and m_Time -UpdateAddOnMemoryTime <1 then
			else
				-- collectgarbage("collect");    --回收在5.05 会报ran script too long  错误 未知原因暂时注掉
				UpdateAddOnMemoryUsage();
			end
			UpdateAddOnMemoryTime = m_Time;
			if self:GetName() then
				 self.Memory =  math.floor(GetAddOnMemoryUsage(self:GetName()));
				return self.Memory
			else
				self.Memory  =0
				return self.Memory;
			end
		else
			return self.Memory;
		end
	else
		return self:GetEstMemory()
	end
end
function BF_Addon:GetStrMemory()
	local strMemory =self:GetMemory();
	if tonumber(strMemory) then
		strMemory =tonumber(strMemory);
		if strMemory==-1 then
			strMemory =BFNEW_TEXT_MEMORY_NOTENABLE;
		else
			if strMemory>1024 then
				strMemory =string.format("%.1fMB",strMemory/1024);
			else
				strMemory =tostring(strMemory).."KB";
			end
		end
	end
	return strMemory;
end
function BF_Addon:insert(m_AddonConfig)
	if not self.AddonConfigList then
		self.AddonConfigList ={};
	end
	table.insert(self.AddonConfigList,m_AddonConfig);
	m_AddonConfig:SetConfigAddon(self);
	if m_AddonConfig:GetbnewConfig() then
		self.bnewConfig =true;
	end
	self:CheckAddonConfig()
end
function BF_Addon:CheckAddonConfig()
	local AddonConfigList = self:GetAddonConfigList();
	local numberAddon =0;
	local addon=nil;
	for k,v in pairs (AddonConfigList) do
		v:SetbAddonconfig(nil)
		if v:GetIndent()==0 then
			numberAddon = numberAddon +1;
			addon =v;
		end
	end
	if numberAddon==1 and addon~=nil and addon:GetType()=="CheckBox" then
		addon:SetbAddonconfig(true)
	end
end
function BF_Addon:GetAddonConfigList()
	return self.AddonConfigList or {};
end
function BF_Addon:GetAddonConfigByName(AddonConfigName)
	if self.AddonConfigList then
		for k,v in pairs(self.AddonConfigList) do
			if v:GetCaption() ==AddonConfigName then
				return v;
			end
		end
	end
	return nil;
end
function BF_Addon:SetData(dataTab,bnotload)
	if dataTab then
		local bhave =false
		for k,v in pairs(dataTab) do
			-- if type(k)=="string" and (k =="deps" or k =="exclusiveTab" or type(v)~="table") and k~="name" then
			if type(k)=="string" and (not (k =="AddonConfigList" and  type(v)=="table")) and k~="name" then
				self[k]=v;
				if k =="configEnable" then
					bhave =true;
				end
			end
		end
		if not bnotload and not bhave then
			self.configEnable = self.enabled;
		end
		if dataTab.AddonConfigList then
			for k,v in pairs (dataTab.AddonConfigList) do
				if type(v) == "table" then
					if v[1] then
						local m_addon = self:GetAddonConfigByName(v[1]);   --[[ v[1] - caption(config name)   v[2] - value ]]--
						if m_addon then
							m_addon:SetData(v);
						end
					end
				end
				-- local AddonConfig = BF_AddonConfig.new();
				-- AddonConfig:SetData(v);
				-- self:insert(AddonConfig);
			end
		end
	end
end
function BF_Addon:GetBigfootType()
	return self.BigfootType;
end
function BF_Addon:GetType()
	if self.BigfootType and not self.BigfootTypeDo then
		local m_str = self.BigfootType..","
		if BFNew_AddonTypeTable then
			for s in string.gmatch(m_str, ".-,") do
				local str1 = string.sub(s, 0, -2);
				str1 = tonumber(str1);
				if str1 and BFNew_AddonTypeTable[str1]  then
					self:SetType(BFNew_AddonTypeTable[str1])
				end
			end
			self.BigfootTypeDo =true;
		end
	end
	return self.Type;
end
function BF_Addon:GetSaveData()
	local m_SaveTab={}
	-----------插件需要保存的参数 1.名字。 2 是否开启。 其他参数不需要保存-----------------------
	m_SaveTab.name =self:GetName();
	m_SaveTab.configEnable = self:GetConfigEnable();
	if self.AddonConfigList then
		m_SaveTab.AddonConfigList={}
		for k,v in pairs (self.AddonConfigList) do
			local m_ConfigSaveData = v:GetSaveData()
			table.insert(m_SaveTab.AddonConfigList,m_ConfigSaveData)
		end
	end
	if self:GetbBigfoot() ==false then
		m_SaveTab = nil;
	end
	if not self:GetCanCheck() then
		m_SaveTab = nil;
	end
	return m_SaveTab;
end
function BF_Addon:SetType(m_type)
	if type(m_type) =="string" then
		table.insert(self.Type,m_type);
	elseif type(m_type) =="table" then
		for k,v in pairs (m_type) do
			if type(v) =="string" then
				table.insert(self.Type,v);
			end
		end
	end
end
function BF_Addon:SetAddonConfigData()
	local ConfigEnable=  self:GetConfigEnable();
	local AddonConfigList = self:GetAddonConfigList();
	for k,v in pairs (AddonConfigList) do
		if v:GetbAddonconfig()then
			if ConfigEnable then
				v:SetValue(true)
			else
				v:SetValue(false)
			end
		end
	end

end
function BF_Addon:submitSet(BNow)
	local State=self:GetState();
	local name =self:GetName()
	-- local Bdisabble =false
	if State and name then
			-- 1 -将要启用 ,2 - 将要关闭
		if State==1 then
			EnableAddOn(name);
			local bLoadOnDemand = IsAddOnLoadOnDemand(name);
			if not bLoadOnDemand then
				BigFoot_LoadAddOn(name);
			end
			if BNow then
				local AddonConfig = self:GetAddonConfigList()
				for k,v in pairs (AddonConfig) do
					v:CallBackFun(1);
				end
			end
		elseif State==2 then
			if BNow then
				local AddonConfig = self:GetAddonConfigList()
				for k,v in pairs (AddonConfig) do
					if v:GetbAddonconfig()then
						v:CallBackFun(1);
					end
				end
			end
			DisableAddOn(name);
		else
			if BNow then
				local AddonConfig = self:GetAddonConfigList()
				for k,v in pairs (AddonConfig) do
					v:CallBackFun(1);
				end
			end
		end
	end

end
function BF_Addon:IsAddonOutDate()
	if self:GetName()~="" then
		local reason = select(6,GetAddOnInfo(self:GetName()))
		if reason == "INTERFACE_VERSION" then
			return 1
		elseif reason == "DISABLED" then
			return -1
		else
			return 0
		end
	else
		return -1
	end

	return      -- 0 不是过期插件  1  过期差价   -1 无法判断
end
------------插件查找函数。输入Filter 类  返回判断结果----------------------------------
function BF_Addon:Search(m_Filter)
	if not m_Filter then return true end
	local bBigfootTrue,BTypetrue,BStrTrue =false,false,false;
	local bBigfoot = m_Filter:GetBbigfoot();
	local Type = m_Filter:GetType()
	local Str = string.lower(m_Filter:GetStr())
	local BhaveConFig =m_Filter:GetBHaveConfig();
	local NewType = m_Filter:GetNewSearType();
	if NewType then
		if NewType==1 then ------------新加的筛选条件。 1.显示全部 2，仅显示当前不可用插件 3， 仅显示当前可用插件  4， 仅显示未启用插件  5， 仅显示已启用插件--------------------------
			
		elseif NewType==2 and self:GetCanCheck() then
			return false;
		elseif NewType==3 and ( not self:GetCanCheck()) then
			return false;
		elseif NewType==4 and (self.enabled and self:GetCanCheck()) then
			return false
		elseif NewType==5 and (not (self.enabled and self:GetCanCheck()) ) then
			return false;
		end
	end

	if self.bBigfoot == bBigfoot then
		bBigfootTrue =true;
	end
	if type(Type)=="string" then
		local m_type = self:GetType()
		for k,v in pairs(m_type) do
			if v == Type then
				BTypetrue =true;
			end
		end
	end
	if not Str or Str=="" then
		BStrTrue =true
	else
		---------这里添加 搜索字符串 搜索 的内容。-------------------------------------------
		if self.name and  string.find(string.lower(self:GetName()),Str) then
			BStrTrue =  true
		elseif self.title and string.find(string.lower(self:GetTitle()),Str) then
			BStrTrue =  true
		elseif self.notes and string.find(string.lower(self.notes),Str) then
			BStrTrue =  true
		end
	end
	if BhaveConFig then
		local number = #self:GetAddonConfigList()
		if number>=1 then
			return false;
		else
			return true
		end
	end
	if bBigfootTrue and BTypetrue and BStrTrue then
		return true;
	else
		return false;
	end
end

-----------------------------------------------------
