 if (GetLocale() == "zhCN") then SCREEN_MARK_PHOTO_MODE="按住Shift键来截取纯画面" SCREEN_MARK_CINEMATIC_MODE="按住Alt键来截取电影模式画面" elseif (GetLocale() == "zhTW") then SCREEN_MARK_CINEMATIC_MODE="按住Alt鍵來截取電影模式畫面" SCREEN_MARK_PHOTO_MODE="按住Shift鍵來截取純畫面" else SCREEN_MARK_CINEMATIC_MODE="Hold Alt key to taking cinematic screenshot" SCREEN_MARK_PHOTO_MODE="Hold shift key to taking pure screenshot" end local ScreenMark_5d43233e412ff889bb8d0210a00fc0c3; local ScreenMark_dce1ca0dd51a9ff443157fb9f3293779 = 0; local function ScreenMark_a96ace4e9bde6b7fa40224f85080fde3() if ( BFScreenMark_EnableSign == 1 ) then if ( not ScreenshotSign:IsVisible() ) then ScreenshotSign:Show(); end end if ( (BFScreenMark_EnablePhotoMode and IsShiftKeyDown()) or (BFScreenMark_EnableCinematicMode and IsAltKeyDown())) then if ( UIParent:IsVisible() ) then ScreenMark_dce1ca0dd51a9ff443157fb9f3293779 = 1; else ScreenMark_dce1ca0dd51a9ff443157fb9f3293779 = 0; end CloseAllWindows(); UIParent:Hide(); if (BFScreenMark_EnableCinematicMode and IsAltKeyDown()) then ShowUIPanel(CinematicFrame); CinematicFrameCloseDialog:Hide(); end end ScreenMark_5d43233e412ff889bb8d0210a00fc0c3(); end function ScreenMark_OnLoad(self) ScreenMark_5d43233e412ff889bb8d0210a00fc0c3 = TakeScreenshot; TakeScreenshot = ScreenMark_a96ace4e9bde6b7fa40224f85080fde3; end if ActionStatus then ActionStatus:SetScript("OnEvent",function (self, event, ...) self.startTime = GetTime(); self:SetAlpha(1.0); if ( event == "SCREENSHOT_SUCCEEDED" ) then ActionStatus_DisplayMessage(SCREENSHOT_SUCCESS, true); end if ( event == "SCREENSHOT_FAILED" ) then ActionStatus_DisplayMessage(SCREENSHOT_FAILURE, true); end self:Show(); ScreenshotSign:Hide(); if (BFScreenMark_EnableCinematicMode and IsAltKeyDown()) then HideUIPanel(CinematicFrame); end if ( ScreenMark_dce1ca0dd51a9ff443157fb9f3293779 == 1 ) then UIParent:Show(); ScreenMark_dce1ca0dd51a9ff443157fb9f3293779 = 0; end end) end 
