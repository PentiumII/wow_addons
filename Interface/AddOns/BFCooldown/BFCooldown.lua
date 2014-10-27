 local GetTime = GetTime; local GetItemSpell = GetItemSpell; local GetItemInfo = GetItemInfo; local GetItemCooldown = GetItemCooldown; local GetInventoryItemID = GetInventoryItemID; local GetSpellTexture = GetSpellTexture; local GetSpellCooldown = GetSpellCooldown; local GetSpellInfo = GetSpellInfo local CreateFrame = CreateFrame; local PlaySoundFile = PlaySoundFile; local IsActionInRange = IsActionInRange; local find = string.find; local font = GameTooltipTextLeft1:GetFont(); local _ local ignoredList = {} local coolingList = {} local succeedList = {} local centerList = {} local barTimer = {} local timers = {} local shines = {} local actives = {} local L = {} if GetLocale() == "zhCN" then L.CDOver = "%s 冷却完成了！" L.CoolDownBar = "冷却计时" L.LockToolTip = "点击小锁解开/锁定窗口"; elseif GetLocale() == "zhTW" then L.CDOver = "%s冷卻完成了！" L.CoolDownBar = "冷卻計時" L.LockToolTip = "點擊小鎖解開/鎖定窗口"; else L.CDOver = "%s cooldown complete!" L.CoolDownBar = "Cooldown Bar" end BFCooldown = CreateFrame("Frame") local CD = BFCooldown CD.style = { "Interface\\Cooldown\\star4", "Interface\\Cooldown\\ping4", "Interface\\Cooldown\\starburst", } CD.Util = {} local isload; function CD.Util:GetSpellID(spell) if not spell then return end if not BFCooldownDB.spellCache or not isload then BFCooldownDB.spellCache={} isload = true; end if BFCooldownDB.spellCache[spell] then if BFCooldownDB.spellCache[spell][2] == "spell" then if type(BFCooldownDB.spellCache[spell][1]) == "number" and (GetSpellInfo(BFCooldownDB.spellCache[spell][1], "spell")) == spell then return unpack(BFCooldownDB.spellCache[spell]); end elseif BFCooldownDB.spellCache[spell][2] == "pet" then if type(BFCooldownDB.spellCache[spell][1]) == "number" and (GetSpellInfo(BFCooldownDB.spellCache[spell][1], "pet")) == spell then return unpack(BFCooldownDB.spellCache[spell]); end else return unpack(BFCooldownDB.spellCache[spell]) end end local s, r local numTabs = GetNumSpellTabs() local _,_,offset,numSpells = GetSpellTabInfo(numTabs) for i = 1, offset+numSpells do s = GetSpellInfo(i, "spell") if s == spell then BFCooldownDB.spellCache[spell]={i,"spell"} return i, "spell" end end local slots, id for i = 1, 19 do id = GetInventoryItemID("player", i) if id then s, r = GetItemSpell(id) if s and s == spell then BFCooldownDB.spellCache[spell]={id,"item"} return id, "item" end end end for i = 0, 4 do slots = GetContainerNumSlots(i) if slots > 0 then for j = 1, slots do id = GetContainerItemID(i, j) if id then s, r = GetItemSpell(id) if s and s == spell then BFCooldownDB.spellCache[spell]={id,"item"} return id, "item" end end end end end end function CD.Util:GetInfo(id, type) if not id or not type then return; end local icon, name; if type == "spell" or type == "pet" then name,_,icon = GetSpellInfo(id, type); elseif type == "item" then name,_,_,_,_,_,_,_,_,icon = GetItemInfo(id); end return name, icon; end function CD.Util:GetCD(id,type) local start, duration, enable; if type == "spell" or type == "pet" then start, duration, enable = GetSpellCooldown(id, type); elseif type == "item" then start, duration, enable = GetItemCooldown(id); end return start, duration, enable end function CD.Util:Debug(...) local a = ... BigFoot_DebugPrint(a,"<BFCD>") end function CD.Util:GetFormattedTime(t, long) local style, str, nextUpdate; if t < 9 then style = BFCooldownDB.short; str = ceil(t); nextUpdate = t-floor(t); elseif t < 60 then style = BFCooldownDB.secs; str = ceil(t); nextUpdate = t-floor(t); elseif t < 3600 then style = BFCooldownDB.mins; if t < 600 and long then str = format("%d:%02d",floor(t/60),t%60); nextUpdate = t-floor(t); else str = format("%dm", ceil(t/60)); nextUpdate = t%60; end elseif (t < 86400) then style = BFCooldownDB.hrs; str = format("%dh", ceil(t/3600)); nextUpdate = t%3600; else style = BFCooldownDB.days; str = format("%dd", ceil(t)); nextUpdate = t%86400; end return str, style.s, style.r, style.g, style.b, nextUpdate; end function CD.Util:FormatCenterText(text) if not text then return "" end return format(L.CDOver, format("|cff%2x%2x%2x%s|r", BFCooldownDB.center.r * 255, BFCooldownDB.center.g * 255, BFCooldownDB.center.b * 255, text)); end function CD.Util:GetButtonType(button) if button.unit then return "BUFF" else local name = button:GetName() or ""; if find(name, "[Bb][Uu][Ff][Ff]") or find(name, "[Aa][Uu][Rr][Aa]") then return "BUFF" end end return "ACTION" end function CD.Util:GetTimeString(BFCooldown_ac970a92b1bae84f591d2098084a233d) BFCooldown_ac970a92b1bae84f591d2098084a233d = math.floor(BFCooldown_ac970a92b1bae84f591d2098084a233d); local BFCooldown_377682ab4d11f1b730b680e0c65e174c = math.floor(BFCooldown_ac970a92b1bae84f591d2098084a233d/60); local BFCooldown_c7b591b2c752c8cb9c847770ee2d8f9d = BFCooldown_ac970a92b1bae84f591d2098084a233d - BFCooldown_377682ab4d11f1b730b680e0c65e174c*60; return string.format("%02d:%02d", BFCooldown_377682ab4d11f1b730b680e0c65e174c, BFCooldown_c7b591b2c752c8cb9c847770ee2d8f9d); end local OO ={} local function spellEqual(s1,s2) if (s1.name and s2.name and s1.name == s2.name ) or (s1.spell and s2.spell and s1.spell == s2.spell )then return true end return false end OO.Spell = {} function OO.Spell:New(spell) local t = {} setmetatable(t,{__index = OO.Spell,__eq = spellEqual}) t.spell = spell return t end function OO.Spell:GetSpellInfo() if not self.id or not self.type then self.id,self.type = CD.Util:GetSpellID(self.spell) end if not self.id then return end if not self.icon then self.name,self.icon = CD.Util:GetInfo(self.id, self.type) end end function OO.Spell:CheckSpell() self.start,self.duration,self.enable= CD.Util:GetCD(self.id,self.type) end function OO.Spell:IsValid() if self.id and self.duration and self.duration >2 then return true end return false end function OO.Spell:IsExpired() if not self.left or self.left <=0 then return true end end function OO.Spell:Update(t) self.left = self.duration -(t-self.start) if self.left<=0.1 and not self.shined then self:OnExpiring() self.shined = 1 end end function OO.Spell:BindUI(ui) self.ui = ui end function OO.Spell:UnbindUI() end function OO.Spell:OnExpiring() centerList:AddSpell(self) end function OO.Spell:SetCenter(center) center.icon:SetTexture(self.icon); center.text:SetText(CD.Util:FormatCenterText(self.name or self.spell)); center.spell = self end function OO.Spell:Acc() self.count = self.count or 0 self.count = self.count + 1 end function OO.Spell:GetAcc() return self.count end function OO.Spell:GetName() if self.name then return self.name else return self.spell end end OO.SpellList = {} function OO.SpellList:New(t) local newT = {} if not t then newT.data = {} else newT.data = t end setmetatable(newT,{__index = OO.SpellList}) return newT end function OO.SpellList:HasSpell(spell) for _i,_spell in pairs(self.data) do if _spell == spell then return _spell end end return false end function OO.SpellList:AccSpell(spell) spell.count= spell.count + 1 end function OO.SpellList:AddSpell(spell) if self:HasSpell(spell) then return end tinsert(self.data,spell) end function OO.SpellList:RemoveSpell(spell) for _i,_spell in pairs(self.data)do if _spell == spell then tremove(self.data,_i) end end end function OO.SpellList:BindUI(ui) end function OO.SpellList:Count() return #self.data end function OO.SpellList:Get(_i) return self.data[_i] end local function Center_Update(self, elapsed) self.finish = self.finish + elapsed; local alpha = BFCooldownDB.center.alpha; if self.finish > BFCooldownDB.center.time / 2 then alpha = (1 - self.finish / BFCooldownDB.center.time) * 2 * alpha; end self:SetAlpha(alpha) if self.finish >= BFCooldownDB.center.time then centerList:RemoveSpell(self.spell) self.finish = 0 self:Hide() end end function CD:CreateCenter() local center = CreateFrame("frame", nil, UIParent); center:Hide(); center:SetFrameStrata("HIGH"); center:SetScript("OnUpdate", Center_Update); center.icon = center:CreateTexture(nil, "OVERLAY"); center.icon:Show(); center.text = center:CreateFontString(nil, "ARTWORK"); center.text:SetPoint("TOP", center, "BOTTOM"); self:UpdateCenterStyle(center) self.center = center; end function CD:UpdateCenterStyle(frame) if frame then frame:SetWidth(BFCooldownDB.center.width); frame:SetHeight(BFCooldownDB.center.width); frame:SetAlpha(BFCooldownDB.center.alpha); frame:ClearAllPoints(); frame:SetPoint(BFCooldownDB.center.position.p, UIParent, BFCooldownDB.center.position.r, BFCooldownDB.center.position.x, BFCooldownDB.center.position.y); frame:SetBackdrop{ bgFile = "Interface/ChatFrame/ChatFrameBackground", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 14, tileSize = 20, tile = true, insets = {left = 2, right = 2, top = 2, bottom = 2} }; frame:SetBackdropColor(0, 0, 0, 0.7); frame:SetBackdropBorderColor(0.7, 0.7, 0.7); frame.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93); frame.icon:ClearAllPoints(); frame.icon:SetPoint("TOPLEFT", 5, -5); frame.icon:SetPoint("TOPRIGHT", -5, -5); frame.icon:SetPoint("BOTTOMLEFT", 5, 5); frame.icon:SetPoint("BOTTOMRIGHT", -5, 5); frame.text:SetFont(BFCooldownDB.center.font, BFCooldownDB.center.size, "OUTLINE"); if BFCooldownDB.center.text then frame.text:Show(); else frame.text:Hide(); end frame.icon:SetBlendMode(BFCooldownDB.center.mode and "ADD" or "BLEND"); end end function CD:UpdateCenter() if BFCooldownDB.center.config and centerList:Count() > 0 and (not self.center:IsVisible()) then centerList:Get(1):SetCenter(self.center) self.center.finish = 0 self.center:Show() end end local function Timer_Update(self, elapsed) if not self.cooldown:IsVisible() then self:Hide(); else if self.nextUpdate <= 0 then CD:UpdateTimer(self); else self.nextUpdate = self.nextUpdate - elapsed; end end end local function Timer_Hide(self) self.nextUpdate = 0; self.cooldown:SetAlpha(1); end function CD:CreateShine(button) local frame = CreateFrame("Frame", nil, button); frame:SetAllPoints(button); frame:SetToplevel(true); local icon = frame:CreateTexture(nil, 'OVERLAY'); icon:SetPoint('CENTER'); icon:SetBlendMode('ADD'); icon:SetHeight(frame:GetHeight()); icon:SetWidth(frame:GetWidth()); frame.icon = icon; shines[button] = frame; return frame; end function CD:StartShine(timer) local icon = timer.icon; local button = timer.cooldown.button; if button and button:IsVisible() then local shine = shines[button] or self:CreateShine(button); if shine and not actives[shine] then shine.type = timer.cooldown.type; local style = self.style[BFCooldownDB[shine.type].style]; if BFCooldownDB[shine.type].style == -1 then return elseif not style and icon and icon.GetTexture then shine.icon:SetTexture(icon:GetTexture()); else shine.icon:SetTexture(style); end shine.completed = 0; shine:Show(); actives[shine] = true; self:Show(); end end end function CD:UpdateShine(shine,elapsed) shine.completed = (shine.completed or 0) + elapsed; local scale = (BFCooldownDB[shine.type].scale - 1) * (1 - shine.completed) + 1; if scale <= 1 then actives[shine] = nil; shine:Hide(); else shine.icon:SetHeight(shine:GetHeight() * scale); shine.icon:SetWidth(shine:GetWidth() * scale); end end function CD:UpdateAllShines(elapsed) if next(actives) then for shine in pairs(actives) do self:UpdateShine(shine, elapsed); end else self:Hide(); end end local function IsSpecialButton(button) if BFCooldownDB.ACTION.special then return false end if not button:GetName() then return false end return string.find(button:GetName(),"Totem") or string.find(button:GetName(),"Rune") end function CD:SetCooldown(cooldown, start, duration) cooldown.button = cooldown.button or cooldown:GetParent(); if cooldown.button then if not IsSpecialButton(cooldown.button) then cooldown.type = cooldown.type or self.Util:GetButtonType(cooldown.button); if cooldown.type then if start > 0 and duration > 2 and BFCooldownDB[cooldown.type].config then self:StartTimer(cooldown, start, duration); elseif timers[cooldown] then timers[cooldown]:Hide(); end end elseif timers[cooldown] then timers[cooldown]:Hide(); end end end function CD:UpdateTimer(timer) timer.cooldown:SetAlpha(BFCooldownDB[timer.cooldown.type].hidecooldown and 0 or 1); local _time = timer.duration - (GetTime() - timer.start); local max = BFCooldownDB[timer.cooldown.type].max; if max and max > 0 and _time > max then timer.text:Hide(); elseif _time > 0 then local str, scale, r, g, b, nextUpdate = self.Util:GetFormattedTime(_time, BFCooldownDB[timer.cooldown.type].long); local size = timer:GetWidth() or timer.cooldown.button:GetWidth(); size = floor(size / 36 * BFCooldownDB[timer.cooldown.type].size * scale); if size <= 0 then timer.nextUpdate = 0.2; else timer.text:SetFont(BFCooldownDB[timer.cooldown.type].font, size, "OUTLINE"); timer.text:SetText(str); timer.text:SetTextColor(r, g, b); timer.text:SetAlpha(BFCooldownDB[timer.cooldown.type].alpha); timer.text:SetPoint("CENTER", timer, BFCooldownDB[timer.cooldown.type].point or "CENTER", 0, 0); timer.text:Show(); timer.nextUpdate = nextUpdate; end else timer:Hide(); if _time > -1 and BFCooldownDB[timer.cooldown.type].shine then self:StartShine(timer); end end end function CD:CreateTimer(cooldown) local timer = CreateFrame("Frame", nil, cooldown.button); timer.cooldown = cooldown; timer:SetFrameLevel(cooldown:GetFrameLevel() + 5); timer:SetAllPoints(cooldown); timer:SetToplevel(true); timer:Hide(); timer:SetScript("OnUpdate", Timer_Update); timer:SetScript("OnHide", Timer_Hide); local text = timer:CreateFontString(nil, "OVERLAY"); text:SetPoint("CENTER", timer, BFCooldownDB[cooldown.type].point or "CENTER", 0, 0); timer.text = text; if cooldown.button.icon then timer.icon = cooldown.button.icon; else local name = cooldown.button:GetName(); if name then timer.icon = _G[name .. "Icon"] or _G[name .. "IconTexture"]; end end timers[cooldown] = timer; return timer; end function CD:StartTimer(cooldown, start, duration) local timer = timers[cooldown] or self:CreateTimer(cooldown); if timer then timer.start = start; timer.duration = duration; timer.nextUpdate = 0; timer:Show(); end end CD.Timer = {} CD.Timer.TF = {} function CD.Timer.TF:Create(guid,list) local t ={} local ui = _G.SpellTimerFrameBFCD setmetatable(t,{__index = CD.Timer.TF}) t.guid = guid t.timers = list or {} t.ui = ui ui:SetWidth(190) ui:SetScale(0.8) ui:SetHeight(10); _G[t.ui:GetName().."Header"]:SetText("|cff00ffbb"..L.CoolDownBar.."|r") t.ui.lock = BLibrary("BFLock",ui,ui,BFCooldownDB,L.CoolDownBar,L.LockToolTip) t.ui.lock:Show() return t end function CD.Timer.TF:Add(timer) tinsert(self.timers,timer) timer.ui:SetParent(self.ui) timer.parent = self end function CD.Timer.TF:Remove(timer) for _i,_timer in pairs(self.timers) do if _timer == timer then _timer.ui:Hide() tremove(self.timers,_i) end end end function CD.Timer.TF:Arrange() self.ui:SetHeight(20+#self.timers * 40) for _i,_timer in pairs(self.timers) do if(_timer and _timer.ui) then _timer.ui:Show() _timer.ui:ClearAllPoints() _timer.ui:SetPoint("TOP", self.ui, "TOP", 7, -(20 + (_i-1) * 40)); end end end function CD.Timer.TF:Update() if BFCooldownDB.bar and #(self.timers)>0 then self.ui:Show() for _i,_timer in pairs(self.timers) do if _timer and _timer.Update then _timer:Update() end end self:Arrange() else self.ui:Hide() end end CD.Timer.ST = {} local function timer_eq(t1,t2) if (t1.spell == t2.spell) then return true end return false end function CD.Timer.ST:Create(spell) local t ={} setmetatable(t,{__index = CD.Timer.ST,__eq = timer_eq}) local ui = _G["SpellTimerSpellFrame"..spell:GetName()] or CreateFrame("Frame", "SpellTimerSpellFrame"..spell:GetName(), UIParent, "BFCDSpellFrameTemplate") t.ui = ui t:Bind(spell) return t end function CD.Timer.ST:Bind(spell) self.spell = spell self.bar = _G[self.ui:GetName().."Bar"] self.icon = _G[self.ui:GetName().."IconTexture"] self.text = _G[self.ui:GetName().."Text"] _G[self.bar:GetName().."Flash"]:Hide(); _G[self.bar:GetName().."Spark"]:Hide(); self.icon:SetTexture(spell.icon); end function CD.Timer.ST:Update() if not self.spell:IsExpired() then self.text:SetText("|cff00ffbb"..CD.Util:GetTimeString(self.spell.left).."-"..self.spell:GetName().."|r") self.bar:SetStatusBarColor(1.0, 0.7, 0.0) self.bar:SetMinMaxValues(self.spell.start , self.spell.start + self.spell.duration) self.bar:SetValue(self.spell.start + self.spell.duration - self.spell.left) else self.parent:Remove(self) end end function CD:GetDefault() return { ACTION = { config = false, hidecooldown = false, long = nil, shine = true, alpha = 0.8, size = 35, scale = 4, style = 0, font = font, min = 2.99,special = false }, BUFF = { config = false, hidecooldown = false, max = 0, long = nil, alpha = 0.8, size = 30, point = "CENTER", font = font, }, bar = false, center = { config = false, text = true, mode = true, alpha = 0.65, width = 67, time = 1.2, size = 30, font = font, r = 0, g = 1, b = 1, style = 1, position = {p = "CENTER", r = "CENTER", x = -52, y = 78,}, }, days = {r = 0.4, g = 0.4, b = 0.4, s = 0.6}, hrs = {r = 0.6, g = 0.4, b = 0.0, s = 0.6}, mins = {r = 0.8, g = 0.6, b = 0.0, s = 0.7}, secs = {r = 1.0, g = 0.8, b = 0.0, s = 0.9}, short = {r = 1.0, g = 0.1, b = 0.1, s = 1.2}, isLocked = nil, isChangeFont = true, } end function CD:LoadConfig() self.Util:Debug("load config") BFCooldownDB = (BFCooldownDB and BFCooldownDB.isChangeFont and BFCooldownDB) or self:GetDefault(); ignoredList = OO.SpellList:New(BFCooldownDB.ignored) coolingList = OO.SpellList:New(BFCooldownDB.cooling) succeedList = OO.SpellList:New(BFCooldownDB.succeed) centerList = OO.SpellList:New() end function CD:RegisterEvents() self.Util:Debug("Register Events") self:RegisterEvent("SPELL_UPDATE_COOLDOWN") self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") self:RegisterEvent("PLAYER_ENTERING_WORLD") end function CD:ADDON_LOADED(...) local addon = ... if addon ~= "BFCooldown" then return end self.nextUpdate = 0 self:LoadConfig() self.barFrame = CD.Timer.TF:Create(UnitGUID("player"),coolingList) self:RegisterEvents() self:CreateCenter() self:HookCooldown() end function CD:HookCooldown() local methods = getmetatable(CreateFrame("Cooldown", nil, nil, "CooldownFrameTemplate")).__index; hooksecurefunc(methods, "SetCooldown", function(cooldown, start, duration) CD:SetCooldown(cooldown, start, duration); end) local ActionBarButtonEventsFrame = _G['ActionBarButtonEventsFrame'] if not ActionBarButtonEventsFrame then return end local active = {} local function cooldown_OnShow(self) active[self] = true end local function cooldown_OnHide(self) active[self] = nil end local function cooldown_ShouldUpdateTimer(self, start, duration) local timer = self.timer if not timer then return true end return timer.start ~= start end local function cooldown_Update(self) local button = self:GetParent() local start, duration, enable = GetActionCooldown(button.action) if cooldown_ShouldUpdateTimer(self, start, duration) then CD:SetCooldown(self, start, duration); end end local abEventWatcher = CreateFrame('Frame'); abEventWatcher:Hide() abEventWatcher:SetScript('OnEvent', function(self, event) for cooldown in pairs(active) do cooldown_Update(cooldown) end end) abEventWatcher:RegisterEvent('ACTIONBAR_UPDATE_COOLDOWN') local hooked = {} local function actionButton_Register(frame) local cooldown = frame.cooldown if not hooked[cooldown] then cooldown:HookScript('OnShow', cooldown_OnShow) cooldown:HookScript('OnHide', cooldown_OnHide) hooked[cooldown] = true end end if ActionBarButtonEventsFrame.frames then for _, frame in pairs(ActionBarButtonEventsFrame.frames) do actionButton_Register(frame) end end hooksecurefunc('ActionBarButtonEventsFrame_RegisterFrame', actionButton_Register) end function CD:SPELL_UPDATE_COOLDOWN() for _i = 1,succeedList:Count() do local spell = succeedList:Get(_i) if spell then spell:CheckSpell() if spell:IsValid() then succeedList:RemoveSpell(spell) self.barFrame:Add(CD.Timer.ST:Create(spell)) coolingList:AddSpell(spell) end end end for _i = 1,coolingList:Count() do local spell = coolingList:Get(_i) if spell then spell:CheckSpell() if not spell:IsValid() then coolingList:RemoveSpell(spell) self.barFrame:Remove(CD.Timer.ST:Create(spell)) end end end end function CD:UNIT_SPELLCAST_SUCCEEDED(unitID, spell,_,spellID) if unitID ~= 'player' then return end local newSpell = OO.Spell:New(spell) newSpell:GetSpellInfo() if not newSpell.id then return end if ignoredList:HasSpell(newSpell) then return end local spell = succeedList:HasSpell(newSpell) if spell then spell:Acc() if spell:GetAcc()>2 then succeedList:RemoveSpell(spell) ignoredList:AddSpell(spell) end else succeedList:AddSpell(newSpell) newSpell:Acc() end end function CD:PLAYER_ENTERING_WORLD() for _i = 1, coolingList:Count() do local _spell = coolingList:Get(_i) if _spell and not _spell:IsValid() or _spell:IsExpired() then coolingList:RemoveSpell(_spell) self.barFrame:Remove(CD.Timer.ST:Create(_spell)) end end end function CD:Update(elapsed) self:UpdateAllShines(elapsed) if self.nextUpdate <= 0 then local _time = GetTime() for _i = 1, coolingList:Count() do local _spell = coolingList:Get(_i) _spell:Update(_time) if _spell:IsExpired() then coolingList:RemoveSpell(_spell) self.barFrame:Remove(CD.Timer.ST:Create(_spell)) break end end self.barFrame:Update() self:UpdateCenter() self.nextUpdate =0.2 else self.nextUpdate = self.nextUpdate - elapsed end end function CD:ToggleMiddle(tog) BFCooldownDB.center.config = tog end function CD:ToggleBar(tog) BFCooldownDB.bar = tog end function CD:SwitchActionStyle(tog) BFCooldownDB.ACTION.style = tog end function CD:ToggleSec(tog,type) BFCooldownDB[type].config = tog end function CD:ToggleSpecial(tog) BFCooldownDB.ACTION.special = tog end local function CD_Update(self,elapsed) CD:Update(elapsed) end local f = CreateFrame("Frame") f:SetScript("OnUpdate",CD_Update) CD:SetScript("OnEvent", function(self, event, ...) if self[event] then self.Util:Debug(event) self[event](self, ...) end end) CD:RegisterEvent("ADDON_LOADED");
