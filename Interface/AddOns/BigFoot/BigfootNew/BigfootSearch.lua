SearchEnfy = classv2() ----------查找的模板类
function SearchEnfy:Search(m_Filter)
	print("SearchEnfy:Search")
end

Filter =classv2();------------查找对象类。
--[[	@param
		Bbigfoot (bool)				     	 标识是否属于大脚	
		type ( string) 		         		 类型，如大型 热门 这些
		Str (string)        				 查找的关键字（包含addon 和addonconfig）
		bHaveConfig                          表示插件是否已经有config 主要是测试时候用 实际中没有使用是否拥有config搜索这个功能。
]]--
--[[
		@func
		
]]--
local refuseList = {
"搜索",
}
function Filter:ctor(Bbigfoot,type,Str)
	self.Bbigfoot = Bbigfoot;
	self.type =type or "All";
	self.Str =Str;
	
end
function Filter:SetBbigfoot(Bbigfoot)
	self.Bbigfoot =Bbigfoot;
end
function Filter:SetBHaveConfig(Bhave)
	self.BhaveConfig = Bhave;
end
function Filter:GetBHaveConfig()
	return self.BhaveConfig;
end
function Filter:GetBbigfoot()
	return self.Bbigfoot;
end

function Filter:SetType(type)
	self.type =type;
end
function Filter:SetNewSearType(type)
	self.Newtype =type;
end
function Filter:GetNewSearType()
	return self.Newtype or 1;
end
function Filter:GetType()
	return self.type;
end
function Filter:IsRefused(str)
	if str ~="" and string.len(str)<3 then
		return true
	end
	for k,v in pairs(refuseList) do
		if type(v) == "string" and v == str then
			return true
		end
	end
end
function Filter:SetStr(Str)
	if not self:IsRefused(Str) then
		self.Str =Str;
	end
end
function Filter:GetStr()
	return self.Str;
end

