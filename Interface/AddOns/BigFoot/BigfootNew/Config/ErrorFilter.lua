
if (GetLocale() == "zhCN") then
	ErrorFilter_Text="开启红色信息过滤"
	ErrorFilter_TOOLTIP ="过滤显示界面中上方部分的系统红字提示，可以自行设置想要屏蔽的信息"
elseif (GetLocale() == "zhTW") then
	ErrorFilter_Text="開啟红色信息过滤"
	ErrorFilter_TOOLTIP ="過濾顯示介面中上方部份的系統紅字提示，可以自行設置想要屏蔽的信息"
else
	ErrorFilter_Text="Enable ErrorFilter"
	ErrorFilter_TOOLTIP ="Filters the errors dislayed in the UIErrorsFrame"
end

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("ErrorFilter",{BFNew_AddonTypeTable[10]},nil,nil,true)
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
BFNew_RegisterAddonConfig("ErrorFilter","CheckBox","EnableErrorFilter",ErrorFilter_Text,ErrorFilter_TOOLTIP,
	true,-----默认值
	function (arg)
		if (arg ) then
			if (not BigFoot_IsAddOnLoaded("ErrorFilter")) then
				BigFoot_LoadAddOn("ErrorFilter");
			end
			if (BigFoot_IsAddOnLoaded("ErrorFilter")) then
				ErrorFilter_Toggle(1)
			end
		else
			if (BigFoot_IsAddOnLoadedFromBigFoot("ErrorFilter")) then
				ErrorFilter_Toggle()
			end
		end
	end
)