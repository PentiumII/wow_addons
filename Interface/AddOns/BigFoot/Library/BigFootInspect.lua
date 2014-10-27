
--������ʾװ����Ϣ������
--Terry@bf Copyrights reserved.
--[[
	0.������ע�� "INSPECT_FINISH"
	0.������ע�� "START_INSPECT"

	1.���������� BigFoot_FireEvent("START_INSPECT")
	2.��������Ӧ "START_INSPECT"
	3.����������Inspect��У��װ�����߼�
	4.��������� BigFoot_FireEvent("INSPECT_FINISH")
	5.��������Ӧ "INSPECT_FINISH"
]]

--[[ʹ�ò���: 
	1.ʹ��BigFoot_RegisterEvent��ע�� INSPECT_FINISH�¼������¼�����������unit��Ϣ�Լ����ƣ���ʱ���Զ�unit��װ��������
	2.ʹ��BigFoot_FireEvent ����һ��START_INSPECT�¼���ָ������
]]
local _
function GetFullName(unit)
	local name,server = UnitName(unit);
	if server then
		name = name.."-"..server
	end
	return name
end

-- ��� ��ɫĳ�츳������Ϣ
--Modify@2012 0924 ��ʱ����Ҫ����
__getTalent=function(index)
	-- local specName = GetSpecializationInfoByID()
	-- print(index,"--------index")
	-- local talentname, point, point1, point2, point3,icon;
	-- point1 = select(5, GetTalentTabInfo(1, true,false,index)); ---- �츳API �仯
	-- point2 = select(5, GetTalentTabInfo(2, true,false,index));
	-- point3 = select(5, GetTalentTabInfo(3, true,false,index));
	-- if not (point1 and  point2 and  point3) then return end
	-- point = max(point1, point2, point3);
	-- if point ==0 then return end
	-- if point == point1 then
		-- _,talentname,_,icon = GetTalentTabInfo(1, true,nil,index);
	-- elseif point == point2 then
		-- _,talentname,_,icon = GetTalentTabInfo(2, true,nil,index);
	-- elseif point == point3 then
		-- _,talentname,_,icon = GetTalentTabInfo(3, true,nil,index);
	-- end
	-- return talentname,icon,point1, point2, point3;
end


-- --���һ����ɫ�Ƿ��ܱ���ȫ�鿴��װ��ȫ׼���ã�
local function CheckInspect(unit)
	if CanInspect(unit) then
		local bhave  =nil
		for i = 1, 19 do
			if  GetInventoryItemID(unit,i) then
				bhave =true
				if not GetInventoryItemLink(unit,i) then				
					return false
				end
			end
		end
		if not bhave then return false end
		return true
	else
		return false;
	end
end

do
	local UPDATE_INTERVAL = 0.1
	local NOTIFY_INTERVAL = 0.5
	local STOP_TIME =0.5;
	local INSPECT_WAIT_TIME = 4
	local F=CreateFrame("Frame")
	F:RegisterEvent("INSPECT_READY");
	F.inTbl = {}
	F.outTbl = {}
	
	local talentTable = {}
	
	--�����еĽ�ɫ�Ƿ��ظ�
	local function InspectAlreadyHave(unit,unitName)
		if F.outTbl[unit] and F.outTbl[unit] == unitName then
			return true;
		else
			return false;
		end
	end

--�滻ԭ�ȵ�NotifyInspect
	local ori_NotifyInspect = NotifyInspect
	local NotifyInpsectTab={};
	-- NotifyInspect = function(unit,flag)
		-- print(unit,falg)
		-- -- if not flag then return end
		-- if CanInspect(unit) then
			-- if #NotifyInpsectTab>0 then
				-- if NotifyInpsectTab[#NotifyInpsectTab] and NotifyInpsectTab[#NotifyInpsectTab].name == GetFullName(unit) then
					-- return 
				-- end
			-- end
			-- table.insert(NotifyInpsectTab,{unit =unit,name =GetFullName(unit),bStart =false,bEnd =false})
		-- end
		-- if InspectFrame then 
			-- InspectFrame.unit = InspectFrame.unit or unit or "target"
		-- end
	-- end

	--���غ����츳��Ϣ��table
	local function OnTalentReady(name)
		if not name then return end
		-- talentTable ={};
		-- local ptalentname,icon1, ppoint1, ppoint2, ppoint3=__getTalent(1)
		-- local stalentname,icon2, spoint1, spoint2, spoint3=__getTalent(2)
		-- local activeTalent;--=GetActiveTalentGroup(true)
		-- talentTable.activeTalent = activeTalent
		-- if (ptalentname and ppoint1 and ppoint2 and ppoint3) then
			-- talentTable.talent1 = {};
			-- talentTable.talent1.name = ptalentname;
			-- talentTable.talent1.icon = icon1;
			-- talentTable.talent1.p1 = ppoint1;
			-- talentTable.talent1.p2 = ppoint2;
			-- talentTable.talent1.p3 = ppoint3;
		-- end
		-- if (stalentname and spoint1 and spoint2 and spoint3) then
			-- talentTable.talent2 = {};
			-- talentTable.talent2.name = stalentname;
			-- talentTable.talent2.icon = icon2;
			-- talentTable.talent2.p1 = spoint1;
			-- talentTable.talent2.p2 = spoint2;
			-- talentTable.talent2.p3 = spoint3;
		-- end
		return talentTable;
	end

	--���һ�����鿴�Ľ�ɫ������
	local function OnInspectStart(unit)
		local time = GetTime();
		F.inTbl[unit] = {GetFullName(unit),time}
	end
	
	--��ն�����Ľ�ɫ�������۲���ɵ��¼�
	local function OnInspectFinish(unit,unitName)	 
		if unit then
			BigFoot_FireEvent("INSPECT_FINISH",unit,unitName)
			F.outTbl[unit]=""
		end
	end	

	--�ط���Ϣ
	local function OnInpsectTalentEnd(unit,name,tTable)
		-- print("OnInpsectTalentEnd")
		if unit and unit~="" and name then
			BigFoot_FireEvent("INPSECT_TALENT_FINISH",unit,name,tTable);
		end
	end
	
	F:SetScript("OnUpdate",function(F,elapsed)
		F.time = (F.time or 0) + elapsed
		if F.time < UPDATE_INTERVAL then
			return
		else
		  F.time = 0 
		end
		for key,val in pairs(F.inTbl) do
			if(val[2]>-1 and GetTime() - val[2]>STOP_TIME) then
				if not InspectAlreadyHave(key,val[1]) then
					F.outTbl[key] = val[1];
					val[2] = -1
				end
			end
		end
		
		for key,val in pairs(F.outTbl) do
			if GetFullName(key) ==val then
				if CheckInspect(key) then	
					OnInspectFinish(key,val);			
				else
					if not F.LastNotifyTime or GetTime()- F.LastNotifyTime>NOTIFY_INTERVAL then
						NotifyInspect(key,true)
						F.LastNotifyTime = GetTime();
					end
				end
			end
		end
		
		for key,value in pairs(NotifyInpsectTab)do
			if not value.bStart and not value.bEnd then
				value.bStart =true;
				value.startTime =GetTime();
				if(GetFullName(value.unit) ==value.name ) then
					ori_NotifyInspect(value.unit);
				else
					value.bEnd =true;
					OnInpsectTalentEnd(value.unit,value.name,nil);
				end
				break;
			elseif value.bStart and not value.bEnd then
				if value.startTime and GetTime()- value.startTime>INSPECT_WAIT_TIME then
					value.bEnd =true
				end
				break
			elseif value.bStart and value.bEnd then
				table.remove(NotifyInpsectTab,key);
				break;
			end
		end
	end)

	F:SetScript("OnEvent",function(self,event)
		if event =="INSPECT_READY" then
			-- print("INSPECT_READY")
			local m_unit,m_name,m_Talent;
			for key,value in pairs(NotifyInpsectTab)do
				if value.bStart and not value.bEnd then
					m_unit = value.unit;
					m_name = value.name;
					value.bEnd =true;
					break
				end
			end
			if m_unit and m_name then
				m_Talent = OnTalentReady(m_name);
				OnInpsectTalentEnd(m_unit,m_name,m_Talent);
			end
		end
	end)

	BigFoot_RegisterEvent("START_INSPECT",OnInspectStart)
end