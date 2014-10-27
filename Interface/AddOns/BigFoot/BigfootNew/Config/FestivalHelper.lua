if GetLocale() =="zhCN" then
	FestivalTab ={"春节","情人节"};
	DAYEVENT_ENABLE_TEXT = "开启节日助手"
	DAYEVENT_ENABLE_TEXT_TOOTIP="根据当前节日提供不同的增强内容，方便玩家更好的寻找NPC、完成任务及成就。"
elseif GetLocale() == "zhTW" then
	FestivalTab ={"春節","情人節"};
	DAYEVENT_ENABLE_TEXT = "開啟節日助手"
	DAYEVENT_ENABLE_TEXT_TOOTIP= "根據當前節日提供不同的增強內容，方便玩家更好的尋找NPC、完成任務及成就"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("FestivalHelper",{BFNew_AddonTypeTable[10]})
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 配置的类型。-----------------------------------
--------------参数3 配置名字-----------------------------------
--------------参数4 配置显示的名字-----------------------------------
--------------参数5 配置的鼠标提示-----------------------------------
--------------参数6 （Checkbox）配置的默认值  ----  true false 不要为nil-----------------------------------
--------------参数7 （Checkbox）配置的CallBack函数  2个参数 第一个为 toggle_value  为 true or false  后一个为是否初始化的标识-----------------------------------
--------------参数8 配置的层级 默认0-----------------------------------

function BF_CheckFestival(m_FestivalTab)
	local m_Newtime = date("*t");
	local year = m_Newtime.year;
	local month = m_Newtime.month;
	local day = m_Newtime.day;
	local Bhave =false;
	CalendarSetAbsMonth(month, year);
	local numEvents = CalendarGetNumDayEvents(0, day)		-- arg1:0表示当前月；-1：前一个月；1：下一个月
	if ( numEvents <= 0 ) then
		return;
	end
	for i = 1, numEvents do
		local title, hour, minute, calendarType, sequenceType, eventType, texture,modStatus, inviteStatus, invitedBy, difficulty, inviteType,sequenceIndex, numSequenceDays, difficultyName = CalendarGetDayEvent(0, day, i);
		for k,v in pairs (m_FestivalTab)do
			if title == v then
				Bhave =true;
				break;
			end
		end
	end
	return Bhave;
end
if BF_CheckFestival(FestivalTab) then
	BFNew_RegisterAddonConfig("FestivalHelper","CheckBox","EnableFestivalHelper",DAYEVENT_ENABLE_TEXT,DAYEVENT_ENABLE_TEXT_TOOTIP,
	true,-----默认值
		function (__arg,init)
			if (__arg) then
				if (not BigFoot_IsAddOnLoaded("FestivalHelper")) then
					BigFoot_LoadAddOn("FestivalHelper");
				end
			elseif (BigFoot_IsAddOnLoaded("FestivalHelper")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(DAYEVENT_ENABLE_DELAY_TEXT); end);
			end
			if init then
				BF_NewAddOnsPromotion("zhCN",317,NewInfoStrName,NewInfoStr1,"FestivalHelper","EnableFestivalHelper")
			end
		end
	)
end