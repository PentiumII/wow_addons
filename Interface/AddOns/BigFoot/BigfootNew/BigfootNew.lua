local _
BF_Gloable={}
-- BF_Gloable.SavedSuitList[server][name]
-- BF_Gloable.SeleteSuilt[server][name]
-- BF_Gloable.BNewFrame[server][name]

local _
                                   
local SavedSuitList = {}
local NotShowAddon={"BigFoot","ACP"};
CurrentEnvironment = BF_AddonSuit.new("Current");

function BFNew_GetEnabledAddons(m_Environment,m_Filter)
	local enabledAddonList = m_Environment:Search(m_Filter)
	local nameList = {}
	for k,v in pairs(enabledAddonList) do
		if v:GetEnable() then
			table.insert(nameList,{v:GetName(),v:GetStrMemory()})
		end
	end
	return nameList
end
function BFNew_SetNewFrameState(bnew)
	BF_Gloable.BNewFrame = BF_Gloable.BNewFrame or {}
	local server =BFU_GetServerName()
	local name = BFU_GetName()
	if server and  name then
		if not BF_Gloable.BNewFrame[server] then
			BF_Gloable.BNewFrame[server] ={}
		end
		BF_Gloable.BNewFrame[server][name] =bnew
		if not bnew then
			BFNew_SetNewFrameChangeState(1);
		end
	end
end
function BFNew_GetNewFrameState()
	-- BF_Gloable.BNewFrame = BF_Gloable.BNewFrame or {}
	-- local server =BFU_GetServerName()
	-- local name = BFU_GetName()
	-- if BF_Gloable.BNewFrame[server] then
		-- return BF_Gloable.BNewFrame[server][name]
	-- else
		return false;
	-- end
end

function BFNew_SetNewFrameChangeState(bnew)
	BF_Gloable.NewFrameChangeState = BF_Gloable.NewFrameChangeState or {}
	local server =BFU_GetServerName()
	local name = BFU_GetName()
	if server and  name then
		if not BF_Gloable.NewFrameChangeState[server] then
			BF_Gloable.NewFrameChangeState[server] ={}
		end
		BF_Gloable.NewFrameChangeState[server][name] =bnew
	end
end

function BFNew_GetNewFrameChangeState()
	BF_Gloable.NewFrameChangeState = BF_Gloable.NewFrameChangeState or {}
	local server =BFU_GetServerName()
	local name = BFU_GetName()
	if BF_Gloable.NewFrameChangeState[server] then
		return BF_Gloable.NewFrameChangeState[server][name]
	else
		return false;
	end
end

--[[@func
	BFNew_SetEnvironmentAddonInfo(BF_AddonSuit)        将当前所有插件信息初始化保存在方案对象中
]]--
local function BFNew_GetNotShowAddon(addonName)
	for k,v in pairs(NotShowAddon) do
		if addonName and  v ==addonName then
			return true;
		end
	end
end
function BFNew_SetEnvironmentAddonInfo(m_Environment)
	local name, title, notes, enabled, loadable, reason, security;
	local revision;
	local deps,bBigfoot;
	local m_Addon;
	local BBigfootNet =nil;
	local BigfootTitle =nil;
	local BigfootType =nil;
	for index=1,GetNumAddOns()do
		name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(index)
		revision = GetAddOnMetadata(index,"X-Revision");
		-- BBigfootNet = GetAddOnMetadata(index,"X-BBigfootNet");
		BigfootTitle =GetAddOnMetadata(index,"X-BigfootDesc");
		BigfootType = GetAddOnMetadata(index,"X-BigfootType");
		deps = {
			-- GetAddOnDependencies(index);
			GetAddOnOptionalDependencies(index);
		}
		bBigfoot =nil;
		if revision=="BigFoot" then
			bBigfoot =true
		end
		if BigfootTitle and BigfootType then
			notes = BigfootTitle;
			bBigfoot =false;
		end
		if (bBigfoot or (BigfootTitle and BigfootType)) then
			if BFNew_GetNotShowAddon(name) then
				bBigfoot =nil;
			end
			m_Addon = m_Environment:GetAddon(name)
			if not m_Addon then
				m_Addon =BF_Addon.new(name, title, notes, enabled, loadable, reason, security,bBigfoot,deps,nil,BigfootType);
				m_Environment:insert(m_Addon);
			else
				-- m_Addon:Settitle(title);
				-- m_Addon:Setnotes(notes)
				-- m_Addon:SetEnable(enabled)
				-- m_Addon:Setloadable(loadable)
				-- m_Addon:Setreason(reason)
				-- m_Addon:Setsecurity(security)
				-- m_Addon:SetbBigfoot(bBigfoot)
				-- m_Addon:Setdeps(deps)
				-- m_Addon:SetBigfootType(BigfootType)
				m_Addon:SetData({name =name, title= title, notes=notes, enabled =enabled, loadable=loadable, reason=reason, security=security,bBigfoot=bBigfoot,deps=deps,BigfootType=BigfootType},true)
				m_Addon:SetEnable(enabled)
			end
		end
	end
end

function BFNew_SetListAddonEnableInfo(m_AddonList)
	local m_addonName="";
	local name, title, notes, enabled, loadable, reason, security;
	for k,v in pairs (m_AddonList)do
		m_addonName =v:GetName();
		if m_addonName  and m_addonName ~="" then
			name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(m_addonName);
			v:SetEnable(enabled)
		end
	end
end
--[[@func
	BFNew_InitCurrentEnvironment()        初始化当前方案对象 备注：初始化时会将初始化标识 [BF_AddonSuit.Inited (true or nil)]置为true
]]--
function BFNew_UpdataCurrentEnvironment(m_CurrentEnvironment)
	if not m_CurrentEnvironment then m_CurrentEnvironment = CurrentEnvironment end
	if m_CurrentEnvironment then
		m_CurrentEnvironment:SetTime();
		m_CurrentEnvironment:SetCharacterName(UnitName("player"));
		BFNew_SetEnvironmentAddonInfo(m_CurrentEnvironment);
	end
end

--[[@func
	BF_IsSuitExist(BF_AddonSuit)        是否有同名方案存在
]]--
function BF_IsSuitExist(m_Environment)
	if SavedSuitList[m_Environment:GetName()] then
		return true;
	end
end
--[[@func
	BF_SaveSuit(BF_AddonSuit)        将方案保存  备注：当 m_Environment:GetInitMark() 为 true 时才会将方案保存否则什么都不做
								     m_Environment:GetInitMark() 为标识 标识该方案下是否已经有插件列表
]]--
function BF_SaveSuit(m_Environment)
	BF_Gloable.SavedSuitList = BF_Gloable.SavedSuitList or {}
	if m_Environment:GetInitMark() then
		local server =BFU_GetServerName()
		local name = BFU_GetName()
		if server and  name then
		-- SavedSuitList[m_Environment:GetName()] = m_Environment:GetSaveData();
			if not BF_Gloable.SavedSuitList[server] then
				BF_Gloable.SavedSuitList[server] ={}
			end
			if not BF_Gloable.SavedSuitList[server][name] then
				BF_Gloable.SavedSuitList[server][name] ={}
			end
			m_Environment:SetCharacterName(server .. "-" .. name)
			m_Environment:SetTime()
			BF_Gloable.SavedSuitList[server][name][m_Environment:GetName()] = m_Environment:GetSaveData();
		end
	end
end
function BFNew_SavedCurrentSuit()
	BF_SaveSuit(CurrentEnvironment)
end
------------修改 删除的是 全部角色下的方案----------------------------
function BF_DelSaveSuitByName(m_name)
	BF_Gloable.SavedSuitList = BF_Gloable.SavedSuitList or {}
	local server =BFU_GetServerName()
	local name = BFU_GetName()
	if server and  name then
		-- if not BF_Gloable.SavedSuitList[server] then
			-- BF_Gloable.SavedSuitList[server] ={}
		-- end
		-- if not BF_Gloable.SavedSuitList[server][name] then
			-- BF_Gloable.SavedSuitList[server][name] ={}
		-- end
		-- BF_Gloable.SavedSuitList[server][name][m_name] = nil;
		for i,k in pairs(BF_Gloable.SavedSuitList) do
			for key,value in pairs(k) do
				for name,data in pairs(value) do
					if name== m_name then
						BF_Gloable.SavedSuitList[i][key][m_name] =nil;
					end
				end
			end
		end
	end

end
function BF_GetSaveSuitName()
	local m_ShowSuiltName ="Current";
	if BF_Gloable.SeleteSuilt then
		-- m_ShowSuiltName = BF_Gloable.SeleteSuilt;
		local server =BFU_GetServerName()
		local name = BFU_GetName()
		if server and  name then
			if BF_Gloable.SeleteSuilt[server]  and  BF_Gloable.SeleteSuilt[server][name] then
				m_ShowSuiltName =BF_Gloable.SeleteSuilt[server][name];
			end
		end
	end
	return m_ShowSuiltName
end
function BF_SetSeleteSuitName(m_name)
	BF_Gloable.SeleteSuilt = BF_Gloable.SeleteSuilt or {}
	local server =BFU_GetServerName();
	local name = BFU_GetName();
	BF_Gloable.SeleteSuilt[server] = BF_Gloable.SeleteSuilt[server]or {};
	BF_Gloable.SeleteSuilt[server][name] =m_name;

end
-- local setDefaultSuits = false
--[[@func
	BF_AddonSuit:SetData(dataTab)        将table赋值给对象  备注:当类成员变量修改时注意将该方法内的变量赋值同步
]]--
function BF_GetAllSuits() ------------修改 获得 全部角色 方案
	local suitList = {}
	BFNew_SetDefaultSuits()
	local SavedSuitList = BF_Gloable.SavedSuitList or {}
	local server =BFU_GetServerName();
	local Save_name = BFU_GetName();
	local tempObj;
	for i,k in pairs(SavedSuitList) do
		for key,value in pairs(k) do
			for name,data in pairs(value) do
				tempObj = BF_AddonSuit.new(name)
				tempObj:SetData(data)
				if tempObj:GetName() then
					if tempObj:GetName() =="Current" then
						if i == server and key == Save_name then
							CurrentEnvironment = tempObj;
						end
					else
						suitList[tempObj:GetName()] =tempObj;
					end
				end
			end
		end
	end
	
	return suitList
end
--[[@func  	
	BFNew_SetDefaultSuits       初始化默认方案
]]
function BFNew_SetDefaultSuits()
	-- print("BFNew_SetDefaultSuits")
	-- if not setDefaultSuits then
		if not BF_Gloable.SavedSuitList then
			BF_Gloable.SavedSuitList ={}
		end
		local _savedSuitList = BF_Gloable.SavedSuitList;
		local server =BFU_GetServerName();
		local name = BFU_GetName();
		if not _savedSuitList[server] then
			_savedSuitList[server] ={};
		end
		_savedSuitList =_savedSuitList[server];
		if not _savedSuitList[name] then
			_savedSuitList[name] ={};
		end
		_savedSuitList =_savedSuitList[name];
		_savedSuitList[BF_DEFAULTSUITNAME_SIMPLE .. BF_BIGFOOT_DEFAULT] = G_DefaultSuitList[BF_DEFAULTSUITNAME_SIMPLE .. BF_BIGFOOT_DEFAULT]
		_savedSuitList["pve" .. BF_BIGFOOT_DEFAULT] = G_DefaultSuitList["pve" .. BF_BIGFOOT_DEFAULT];
		_savedSuitList["pvp" .. BF_BIGFOOT_DEFAULT] = G_DefaultSuitList["pvp" .. BF_BIGFOOT_DEFAULT];
		-- setDefaultSuits = true
	-- end
end
--[[@func
	BF_CheckSuit(dataTab)        比较一个方案与当前插件列表里的差别。
	返回值： m_NeedChangeTab 设置不一样的（开启，关闭）。m_lostTab 丢失的插件  m_redundantTab  多余的插件
]]--
function BF_CheckSuit(m_Suit)
	local name, title, notes, enabled, loadable, reason, security;
	local m_addon;
	local m_redundantTab={}
	local m_NeedChangeTab={}
	local m_lostTab={};
	for index=1,GetNumAddOns()do
		name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(index)
		m_addon = m_Suit:GetAddon(name)
		if m_addon  then
			if  m_addon:GetConfigEnable() == enabled then

			else
				table.insert(m_NeedChangeTab,name);
			end
		else
			table.insert(m_redundantTab,name);
		end
	end
	local m_AddonList =m_Suit:GetAddonList();
	if m_AddonList then
		for k,v in pairs(m_AddonList) do
			name = v:GetName();
			name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(name)
			if reason =="MISSING" then
				table.insert(m_lostTab,name)
			end
		end
	end
	return m_NeedChangeTab,m_lostTab,m_redundantTab
end

--[[@func
	BF_AddonSort(addonList,sortKey,b_Reverse)       插件列表排序函数。sortKey 为排序标识。b_Reverse 为 是否反向
	sortKey 意义 1： 按名字排序  2： 简介  3： 内存     4： 开关闭关系

]]--
function BF_AddonSort(addonList,sortKey,b_Reverse)
	if addonList and type(addonList) == "table" then
		if sortKey == 1 then   --name
			table.sort(addonList,function(left,right)
				if b_Reverse then
					return left:GetName()>right:GetName();
				else
					return left:GetName()<right:GetName();
				end
			end)
			return addonList
		elseif sortKey == 2 then
			table.sort(addonList,function(left,right)
				if b_Reverse then
					return left:GetTitle()>right:GetTitle()
				else
					return left:GetTitle()<right:GetTitle()
				end
			end)
			return addonList
		elseif sortKey == 4 then

			table.sort(addonList,function(left,right)
				if b_Reverse then
					return left:GetState()> right:GetState()
				else
					return left:GetState()< right:GetState()
				end
			end)
			return addonList
		elseif sortKey == 5 then
			table.sort(addonList,function(left,right)
				if b_Reverse then
					return left: GetShowState()> right:GetShowState()
				else
					return left:GetShowState()< right:GetShowState()
				end
			end)
			return addonList
		elseif sortKey == 3 then
			local diabled ={}
			local enabled ={}
			for k,v in pairs(addonList)do
				if v:GetEnable() then
					table.insert(enabled,v)
				else
					table.insert(diabled,v)
				end
			end
			table.sort(enabled,function(left,right)
				if b_Reverse then
					return left:GetMemory()> right:GetMemory()
				else
					return left:GetMemory()< right:GetMemory()
				end
			end)
			table.sort(diabled,function(left,right)
				if b_Reverse then
					return left:GetMemory()> right:GetMemory()
				else
					return left:GetMemory()< right:GetMemory()
				end
			end)
			for k,v in pairs(diabled) do
				table.insert (enabled,v)
			end
			return enabled
		end

	end
end

function BFNew_GetAddonEnableConfig()
	BF_GetAllSuits();
	local m_table ={};
	local m_Addontable ={};
	local name;
	local m_ApplySuilt =CurrentEnvironment;
	local bhave =false;
	for k,v in pairs(m_ApplySuilt:GetAddonList()) do
		if v:GetName() then
			bhave =true;
			if v:GetConfigEnable() then
				m_table[v:GetName()] =1;
				-- print(v:GetName(),"ConfigEnable")
			else
				m_table[v:GetName()] =0;
			end
		end
	end
	for i=1,GetNumAddOns()do
		name,_,_,__ =GetAddOnInfo(i);
		if m_table[name] then
			m_Addontable[name] =m_table[name];
		elseif BFNew_GetAddonDefaulteEnable(name) then
			m_Addontable[name] =BFNew_GetAddonDefaulteEnable(name);
		else
			m_Addontable[name] =-1;
		end
	end

	return m_Addontable;
end

function BFNew_GetCurrentConfig(AddOnName)
	local m_ApplySuilt = G_ShowEnvironment;
	if not m_ApplySuilt then
		m_ApplySuilt =CurrentEnvironment;
	end
	local addon =m_ApplySuilt:GetAddon(AddOnName);
	if addon then
		return addon:GetConfigEnable();
	end
end

function BFNew_SetCurrentConfig(AddOnName,bEnable)
	local m_ApplySuilt = G_ShowEnvironment;
	if not m_ApplySuilt then
		m_ApplySuilt =CurrentEnvironment;
	end
	
	local addon =m_ApplySuilt:GetAddon(AddOnName);
	if addon then 
		addon:SetConfigEnable(bEnable);
		addon:submitSet(1);
		BFNew_SavedCurrentSuit()
	end
end
function BFNew_ApplyUserAddonConfig()
	local m_tab={}
	-- BF_GetAllSuits()
	local m_ApplySuilt =CurrentEnvironment --BigfootNewMainFrame_GetShowEnvironment();
	BFNew_SetEnvironmentAddonInfo(m_ApplySuilt);
	if m_ApplySuilt then
		for k,v in pairs (m_ApplySuilt:GetAddonList()) do
			if v:GetName() then
				if v:GetEnable() then
					for key,val in pairs(v:GetAddonConfigList()) do
						-- val:CallBack(true)
						table.insert(m_tab,val)
					end
				end
			end
		end
	end
	return m_tab;
end
function BFNew_OnCallBack(UsedTab)
	if UsedTab and UsedTab.GetCaption  and UsedTab.CallBackFun then
		UsedTab:CallBackFun(true)
	end
end
function BFNew_GetCurrentAddonConfig(addonName,configname)
	local value =nil;
	if CurrentEnvironment then
		local addon = CurrentEnvironment:GetAddon(addonName);
		if addon then
			local addonconfig = addon:GetAddonConfigByName(configname);
			if addonconfig then
				value= addonconfig:GetValue()
			end
		end
	end
	return value;
end

function BFN_IsCategoryHave(m_Frame)
	for i = 1, #INTERFACEOPTIONS_ADDONCATEGORIES do
		if ( INTERFACEOPTIONS_ADDONCATEGORIES[i].name == m_Frame.name) then
			return true
		end
	end
end

--------------------------------test----------------
--[[
function testFunc()
	list = BF_GetAllSuits()
	print(list["Current"].color)
end
function testFunc1()   --搜索测试
	local abc = Filter.new(true,"All")
	list = BF_GetAllSuits()
	eeeeeee=list["Current"]:Search(abc)
end

function testFunc2() --- 综合测试  测试 查找 和排序
	local abc = Filter.new(true,"All","Big")
	BFNew_InitCurrentEnvironment()
	g_AddonList = CurrentEnvironment:Search(abc)
	g_AddonList1 =BF_AddonSort(g_AddonList,1,false)
end
function Text3() ----综合测试保存数据的导入。检查保存配置与当前实际的差别。并更新当前插件不需保存的信息。合成一个综合的实列
	-- BF_SaveSuit(CurrentEnvironment)
	-- registreTest()
	list = BF_GetAllSuits()
	aa,bb,cc =BF_CheckSuit(list["Current"]);
	CurrentEnvironment = list["Current"];
	BFNew_UpdataCurrentEnvironment(CurrentEnvironment)
	CurrentEnvironment:GetAddon("AutoTabard"):GetAddonConfigByName("ceshi3"):SetConfigValue(1)
	CurrentEnvironment:GetAddon("AutoTabard"):GetAddonConfigByName("ceshi3"):SetConfigValue(2,true)
	CurrentEnvironment:GetAddon("BigFoot"):GetAddonConfigByName("ceshi1"):SetConfigValue(1,true)
	CurrentEnvironment:GetAddon("LootListPlus"):GetAddonConfigByName("ceshi2"):SetConfigValue(1,true)
end
]]
