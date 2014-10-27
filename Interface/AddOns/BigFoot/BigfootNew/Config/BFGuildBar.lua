if GetLocale() =="zhCN" then
	BFGuildBar_Title = "开启公会技能助手"
	BFGuildBar_Title_ToolTip = "在组队状态下，大脚提供群体复活、组团出发等快捷技能栏"
elseif GetLocale() == "zhTW" then
	BFGuildBar_Title = "開啟公會技能助手"
	BFGuildBar_Title_ToolTip = "在組隊狀態下，大腳提供群體復活、組團出發等快捷技能"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BFGuildBar",{BFNew_AddonTypeTable[3],BFNew_AddonTypeTable[10]},nil,nil,true)
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

BFNew_RegisterAddonConfig("BFGuildBar","CheckBox","EnableBFGuildBar",BFGuildBar_Title,BFGuildBar_Title_ToolTip,
true,-----默认值
	function (arg)
		if ( arg) then
			if (not BigFoot_IsAddOnLoaded("BFGuildBar")) then
				BigFoot_LoadAddOn("BFGuildBar");
			end

			if (BigFoot_IsAddOnLoaded("BFGuildBar")) then
				BFGuildBar_Toggle(true)
			end
		else
			if (BigFoot_IsAddOnLoaded("BFGuildBar")) then
				BFGuildBar_Toggle(false)
			end
		end
	end
)
