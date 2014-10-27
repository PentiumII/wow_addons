local class = select(2, UnitClass("player")) 
local Frame = CreateFrame("Frame") 
local TH=GetTime()
local TB=GetTime()
local TO=GetTime()


Frame:SetScript("OnEvent", function(_,_,_,e,_,_,_,_,_,_,t) 
   if class == "PRIEST" and GetSpecializationRole(GetSpecialization())=="HEALER" then 
         if ( ( e=="SPELL_DAMAGE" or e=="SWING" ) and strfind(GetUnitName("player"),t)~=nil and not UnitIsDeadOrGhost("player") and ( UnitHealth("player")/UnitHealthMax("player") < 0.9 ) ) then 
         	local t=GetTime()
	 	if t-TH>8 then
			s={"panic","fear","cringe","shudder","flop","scared"}
			DoEmote(s[random(1,6)],"none")
			TH=t
		end
         end 
	 if ( ( e=="SPELL_DAMAGE" or e=="SWING" ) and strfind(GetUnitName("player"),t)~=nil and not UnitIsDeadOrGhost("player") and ( UnitHealth("player")/UnitHealthMax("player") < 0.4 ) ) then 
         	local t=GetTime()
	 	if t-TB>30 then
			DoEmote("helpme","none")
			TB=t
		end
         end 
	 if ( not UnitIsDeadOrGhost("player") and ( UnitMana("player")/UnitManaMax("player") < 0.3 ) ) then 
         	local t=GetTime()
	 	if t-TO>30 then
			DoEmote("oom")
			TO=t
		end
         end 
    end 
end) 

Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") 