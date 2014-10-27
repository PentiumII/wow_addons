-------------------这里是所有注册的函数。 包括注册函数。注册配置。---------------------------------------------
-----------------这是注册插件的类型--------------------------------
local AddonTypeTab={};
local AddonTypeList={"All"}
local exclusiveTab={};
-----------------插件注册函数--------------------------------
-----------------参数1： 表示要注册的插件的名字    type string--------------------------------
-----------------参数2：插件类型的列表  type table--------------------------------
-----------------参数3：标识插件在开启的时候 是否需要重载。 type bool--------------------------------
-----------------参数4： 表示插件是否为当期新推出插件效果。 type bool--------------------------------
-----------------参数5：表示插件默认是否载入。  type bool  返回插件默认开启属性 1 开启 0 关闭--------------------------------
function BFNew_RegisterAddon(addonName,m_TypeTab,bReload,bnew,bnotloaddefault)
	assert(addonName,"can not Register a Nil Addon")
	if not AddonTypeTab[addonName] then
		AddonTypeTab[addonName]={};
	end
	AddonTypeTab[addonName].m_TypeTab =m_TypeTab;
	AddonTypeTab[addonName].bReload =bReload;
	AddonTypeTab[addonName].bnew =bnew;
	AddonTypeTab[addonName].bnotloaddefault = bnotloaddefault
	BFNew_RegisterModAddType(m_TypeTab);
end
function BFNew_RegisterModCheckMod(m_Str)
	for k,v in pairs (AddonTypeList) do
		if v ==m_Str then
			return false;
		end
	end
	return true;
end
function BFNew_RegisterModAddType(m_TypeTab)
	if m_TypeTab and type(m_TypeTab) =="table" then
		for k,v in pairs (m_TypeTab) do
			if BFNew_RegisterModCheckMod(v) then
				table.insert(AddonTypeList,v);
			end			
		end
	end
end
------------返回插件默认开启属性 1 开启 0 关闭   false  没有记录---------------------
function BFNew_GetAddonDefaulteEnable(addonName)
	assert(addonName,"can not Get a Nil Addon DefaulteEnable")
	if AddonTypeTab[addonName] then
		if AddonTypeTab[addonName].bnotloaddefault~=nil then
			if AddonTypeTab[addonName].bnotloaddefault then
				return 1;
			else
				return 0;
			end
		else
			return false;
		end
	end
end
function BFNew_GetAddonType(addonName)
	assert(addonName,"can not Get a Nil Addon TypeTab")
	if AddonTypeTab[addonName] then
		return AddonTypeTab[addonName].m_TypeTab;
	end
end
function BFNew_GetAddonReloadInfo(addonName)
	assert(addonName,"can not Get a Nil Addon ReloadInfo")
	if AddonTypeTab[addonName] then
		return AddonTypeTab[addonName].bReload;
	end
end
function BFNew_GetAddonbnewInfo(addonName)
	assert(addonName,"can not Get a Nil Addon ReloadInfo")
	if AddonTypeTab[addonName] then
		return AddonTypeTab[addonName].bnew;
	end
end
function BFNew_RegisterAddonexclusiveTab(m_tab)
	table.insert(exclusiveTab,m_tab);
end
function BFNew_GetAddonexclusiveTab(addonName)
	local bHave =false;
	local m_tab={}
	for k,v in pairs (exclusiveTab)do
		bHave =false;
		if type(v) =="table" then
			for i,j in pairs(v) do
				if addonName == j then
					bHave =true;
					break;
				end
			end
			if bHave then
				m_tab =v;
				break;
			end
		end
	end
	return m_tab;
end
function BFNew_GetAddonTypeList()
	return AddonTypeList;
end

--------------这下面是插件Config的注册------------------------
local configTable ={}
function BFNew_GetAddonConfig(addonName)
	if configTable[addonName] then
		return configTable[addonName]
	end
end
function BFNew_RegisterISHave(addonName,__caption)
	local bHave =false;
	local tableKey =nil;
	if configTable[addonName] then
		for k,v in pairs(configTable[addonName]) do
			if __caption == v.caption then
				bHave =true;
				tableKey =k;
				break;
			end
		end
	end
	return bHave,tableKey
end

-- self.type = t_data.type;
-- self.caption = t_data.caption;
-- self.variable = t_data.variable;
-- self.tooltip = t_data.tooltip;
-- self.default = t_data.default;
-- self.callback = t_data.callback;
-- self.indent = t_data.indent or 0;


function BFNew_RegisterAddonConfig(addonName,m_type,caption,variable,tooltip,default,callback,indent,bnewConfig)
	local configelem = {}
	if not configTable[addonName] then
		configTable[addonName]  ={}
	end
	local bHave,tableKey = BFNew_RegisterISHave(addonName,__caption);
	if bHave then
		table.remove(configTable[addonName],tableKey)
	end
	configelem.type = m_type;
	configelem.caption = caption;
	configelem.variable = variable;
	configelem.tooltip = tooltip;
	configelem.default = default;
	configelem.callback = callback;
	configelem.indent = indent or 0;
	configelem.bnewConfig = bnewConfig;
	table.insert(configTable[addonName],configelem)
end
