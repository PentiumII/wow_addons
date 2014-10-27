---------------------------------------------------------------------------------
local SkadaString ={}
SkadaString.colorText = "(|cff808080Skada|r)"
if GetLocale()=='zhCN' then
	ENABLE_BFTalent = "开启天赋助手"
elseif GetLocale()=='zhTW' then
	ENABLE_BFTalent = "開啟天賦助手"
else
	OPEN = "開啟"
	GDKP_ADDON_TITLE = "Use GDKP"
end

Skada_ENABLE_TEXT = OPEN..(SkadaString.Name or "")..SkadaString.colorText;

-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("BFTalent",{BFNew_AddonTypeTable[10]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("BFTalent","CheckBox","EnableBFTalent",ENABLE_BFTalent,nil,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("BFTalent")) then
				BigFoot_LoadAddOn("BFTalent");
			end
			if (BigFoot_IsAddOnLoaded("BFTalent")) then
				BFTalent_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("BFTalent")) then
				BFTalent_Toggle(false);
			end
		end
end
)
