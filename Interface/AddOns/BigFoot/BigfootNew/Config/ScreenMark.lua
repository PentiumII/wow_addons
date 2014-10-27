---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	SCREEN_MARK_PHOTO_MODE="截取纯画面"
	SCREEN_MARK_PHOTO_MODE_TOOLTIP="截图时按住Shift与截图键来截取纯画面图片"
	
	SCREEN_MARK_CINEMATIC_MODE="截取电影模式的画面"
	SCREEN_MARK_CINEMATIC_MODE_TOOLTIP="截图时按住Alt与截图键来截取电影模式的画面图片"
elseif GetLocale() == "zhTW" then
	SCREEN_MARK_PHOTO_MODE="截取純畫面"
	SCREEN_MARK_PHOTO_MODE_TOOLTIP="截圖時按住Shift與截圖鍵來截取純畫面圖片"
	
	SCREEN_MARK_CINEMATIC_MODE="截取電影模式的畫面"
	SCREEN_MARK_CINEMATIC_MODE_TOOLTIP="截圖時按住Alt與截圖鍵來截取電影模式畫面的畫面圖片"
else
	SCREEN_MARK_PHOTO_MODE="Hold shift key to taking pure screenshot"
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("ScreenMark",{BFNew_AddonTypeTable[10]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("ScreenMark","CheckBox","ScreenMark_EnablePhotoMode",SCREEN_MARK_PHOTO_MODE,SCREEN_MARK_PHOTO_MODE_TOOLTIP,
true,-----默认值
function(arg,init)
	if (arg) then
		if (not BigFoot_IsAddOnLoaded("ScreenMark")) then
			BigFoot_LoadAddOn("ScreenMark");
		end
		if (BigFoot_IsAddOnLoaded("ScreenMark")) then
			BFScreenMark_EnablePhotoMode = 1;
		end
	else
		if (BigFoot_IsAddOnLoaded("ScreenMark")) then
			BFScreenMark_EnablePhotoMode = nil;
		end
	end
end
)

BFNew_RegisterAddonConfig("ScreenMark","CheckBox","ScreenMark_EnableCinematicMode",SCREEN_MARK_CINEMATIC_MODE,SCREEN_MARK_CINEMATIC_MODE_TOOLTIP,
true,-----默认值
function(arg)
	if arg then
		if (not BigFoot_IsAddOnLoaded("ScreenMark")) then
			BigFoot_LoadAddOn("ScreenMark");
		end
		if (BigFoot_IsAddOnLoaded("ScreenMark")) then
			BFScreenMark_EnableCinematicMode = 1;
		end
	else	
		if (BigFoot_IsAddOnLoaded("ScreenMark")) then
			BFScreenMark_EnableCinematicMode = nil;
		end
	end
end
)

 
