BF_AddonConfig =classv2();
local BFAddonConfig_NotLoadCallBackType={"Button"}
function BF_AddonConfig:ctor(__caption)
	self.caption =__caption;
	self.type = nil;
end
function BF_AddonConfig:SetData(t_value)
	if self:GetCaption() == t_value[1] then
		self.value = t_value[2];
	end
end
function BF_AddonConfig:GetSaveData()
	return {self:GetCaption(),self.value};
end
function BF_AddonConfig:GetCaption()
	if self.caption then
		return  self.caption ;
	end
end

function BF_AddonConfig:GetType()
	if self.type then
		return  self.type;
	end
end
function BF_AddonConfig:GetTooltip()
	if self.tooltip then	
		return self.tooltip;
	end
end
function BF_AddonConfig:GetVariable()
	if self.variable then	
		return self.variable;
	end
end
function BF_AddonConfig:GetDefault()
	if self.default~=nil then
		local default = self.default;
		if self:GetValueList() then
			-- print(type(default))
			if type(default)=="number" then
				default = self:GetValueList()[default]
			elseif type(default)=="string" then
				
			end
		end
		-- print(default)
		return default;
	end
end

function BF_AddonConfig:GetValue()
	-- if self:GetCaption() =="EnableLoadDate" and self:GetConfigAddon()and self:GetConfigAddon():GetName() =="BigFoot"  then
		-- if GetCVar("checkAddonVersion") =="0"  then
			-- return false;
		-- else
			-- return true;
		-- end
	-- end
	if self.value~=nil then
		local value = self.value;
		if self:GetValueList() then
			if type(value)=="number" then
				value = self:GetValueList()[value]
			elseif type(value)=="string" then
				
			end
		end
		return value ;
	else
		return self:GetDefault();
	end
end
function BF_AddonConfig:GettrueValue()
	if self.value~=nil then
		return self.value;
	else
		return self.default;
	end
end

function BF_AddonConfig:SetValue(_value)
	self.value = _value;
	if self:GetValueList() then
		if type(self.value) =="string" then
			if tonumber(self.value) < self:GetValueList()[1] then
				self.value =tostring(self:GetValueList()[1])
			elseif tonumber(self.value) > self:GetValueList()[2] then
				self.value =tostring(self:GetValueList()[2])
			end
		elseif  type(self.value) =="number" then
			if self.value<1 then
				self.value =1
			elseif self.value>#self:GetValueList() then
				self.value =#self:GetValueList()
			end
		end
	end
end
function BF_AddonConfig:CheckAddon(b_notCallback)
	if self:GetbAddonconfig() then
		local addon = self:GetConfigAddon()
		if addon then
			if self.value then
				addon:SetConfigEnable(1);
			else
				addon:SetConfigEnable(nil);
			end
			if not b_notCallback then
				addon:submitSet(true)
			else
				addon:submitSet(false)
			end
			return true
		end
	end
	return false;
end

function BF_AddonConfig:CheckType()
	local m_type =self:GetType()
	local BOk =true
	if m_type then
		for k,v in pairs (BFAddonConfig_NotLoadCallBackType) do
			if v == m_type then
				BOk =false
				break
			end
		end
	else
		return false
	end
	return BOk
	
end
--[[@func
	BF_AddonConfig:SetConfigValue(_value,b_notCallback) 将对应控件值设置为 _value  当 b_notCallback 为 true 时只会赋值不会应用
]]--
function BF_AddonConfig:SetConfigValue(_value,b_notCallback)
	self:SetValue(_value);
	local bedone = self:CheckAddon(b_notCallback);
	if (not b_notCallback) and (not bedone) then
		self:CallBackFun()
	elseif BigfootNewMainFrame_SetSuiltChangeState then
		BigfootNewMainFrame_SetSuiltChangeState(true)
	end
end
function BF_AddonConfig:CallBackFun(bLoad)
	if type(self.callback) == "function" then
		local bOK,reason=true,nil;
		if bLoad then
			if self:CheckType() then
				bOK,reason= pcall(self.callback,self:GetValue(),bLoad);
			end
		else
			bOK,reason = pcall(self.callback,self:GetValue(),bLoad);
		end
		if not bOK and BigFoot_Error and BigFoot_Error.debug_Mod and G__BIGFOOT_ERRORMESSAGE then
			G__BIGFOOT_ERRORMESSAGE(reason)
		end
	end
end
function BF_AddonConfig:SetbAddonconfig(bAddonconfig)
	self.bAddonconfig = bAddonconfig;
end
function BF_AddonConfig:GetbAddonconfig()
	return self.bAddonconfig;
end
function BF_AddonConfig:SetConfigAddon(m_addon)
	self.Addon =m_addon;
end
function BF_AddonConfig:GetConfigAddon()
	return self.Addon
end
function BF_AddonConfig:RegisterItem(t_data)
	self.type = t_data.type;
	self.caption = t_data.caption;
	self.variable = t_data.variable;
	self.tooltip = t_data.tooltip;
	if self.type=="SpinBox" then
		if t_data.default[1] and t_data.default[2] then
			self.default =t_data.default[2];
			self.ValueList = t_data.default[1];
			self.ListType =t_data.default[3];
		end
	else
		self.default = t_data.default;
		self.ValueList =nil;
		self.ListType =nil;
	end
	self.callback = t_data.callback;
	self.indent = t_data.indent or 0;
	self.bnewConfig = t_data.bnewConfig;
end
function BF_AddonConfig:GetbnewConfig()
	return self.bnewConfig;
end
function BF_AddonConfig:GetListType()
	return self.ListType;
end
function BF_AddonConfig:GetValueList()
	return self.ValueList;
end
function BF_AddonConfig:GetIndent()
	if self.indent then
		return self.indent
	end
end
------------test-------------
-- function textfuncregister()    ----注册控件测试
	-- addonConfig = BF_AddonConfig.new("abc","str")
	-- addonConfig:RegisterCheckbox("CheckboxCaption","CheckboxTooltip","CheckboxVariable","CheckboxDefault",function() print("CheckboxCallback"); end,1)
	-- addonConfig:RegisterSpinBox("SpinboxCaption","SpinboxTooltip","SpinboxVariable","SpinboxType","SpinboxData","SpinboxDefault","SpinboxCallback",1)
	-- addonConfig:RegisterButton("ButtonCaption","ButtonCallback","ButtonTooltip",1)
-- end