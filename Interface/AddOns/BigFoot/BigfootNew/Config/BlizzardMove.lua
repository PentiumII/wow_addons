---------------------------------------------------------------------------------
if (GetLocale() == "zhCN") then
	BLIZZMOVE_ENABLE_TITLE = "开启窗体移动";
	BLIZZMOVE_ENABLE_TITLE_TOOLTIP = "任意拖动任意窗体，并通过Ctrl+滚轮对当前窗体进行缩放。";
elseif (GetLocale() == "zhTW") then
	BLIZZMOVE_ENABLE_TITLE = "開啟窗體移動";
	BLIZZMOVE_ENABLE_TITLE_TOOLTIP = "任意拖動任意窗體，並通過Ctrl+滾輪對當前窗體進行縮放。";
else
	BLIZZMOVE_ENABLE_TITLE = "Enable BlizzMove";

end

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BlizzMove",{BFNew_AddonTypeTable[6]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------


BFNew_RegisterAddonConfig("BlizzMove","CheckBox","EnableBlizzMove",BLIZZMOVE_ENABLE_TITLE,BLIZZMOVE_ENABLE_TITLE_TOOLTIP,
true,-----默认值
function(arg,init)
	if not init then
		if ( arg ) then
			if (not BigFoot_IsAddOnLoaded("BlizzMove")) then
				BigFoot_LoadAddOn("BlizzMove");
				--BigFoot_RequestReloadUI(function() BigFoot_Print(BLIZZMOVE_DISABLE_DELAY_TEXT); end);
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("BlizzMove")) then
				--BigFoot_RequestReloadUI(function() BigFoot_Print(BLIZZMOVE_DISABLE_DELAY_TEXT); end);
			end
		end
	else
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BlizzMove")) then
				BigFoot_LoadAddOn("BlizzMove");
			end
		end
	end
end
)
