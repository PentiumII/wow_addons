
if GetLocale()=='zhCN' then
	MASQUEENABLE = "开启界面美化"
	BUTTONFACADEENABLE = "开启界面美化额外素材包"
	MASQUEENABLEOPTION = "配置界面美化"
	BUFFDISABLE = "禁用默认BUFF按钮组美化"
elseif GetLocale()=='zhTW' then
	MASQUEENABLE = "開啟界面美化"
	BUTTONFACADEENABLE = "開啟界面美化額外素材包"
	MASQUEENABLEOPTION = "配置界面美化"
	BUFFDISABLE = "禁用默认BUFF按钮组美化"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Masque",{BFNew_AddonTypeTable[6]},nil,nil,true)
BFNew_RegisterAddon("ButtonFacade",{BFNew_AddonTypeTable[6]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
--------------------注册插件配置信息----------------------------------

BFNew_RegisterAddonConfig("ButtonFacade","CheckBox","EnableButtonFacade",BUTTONFACADEENABLE,nil,
true,-----默认值
function(arg,init)
	if (arg) then
		if not BigFoot_IsAddOnLoadedFromBigFoot("ButtonFacade") then
			BigFoot_LoadAddOn("ButtonFacade")
		end
	else
		if (BigFoot_IsAddOnLoadedFromBigFoot("ButtonFacade")) then

			--BigFoot_RequestReloadUI(function() BigFoot_Print(RECOUNT_DISABLE_DELAY_TEXT); end);
		end
	end
end
)

BFNew_RegisterAddonConfig("Masque","CheckBox","EnableMasque",MASQUEENABLE,nil,
true,-----默认值
function(arg,init)
	if (arg) then
		if not BigFoot_IsAddOnLoadedFromBigFoot("Masque") then
			BigFoot_LoadAddOn("Masque")
		end
	else
		if (BigFoot_IsAddOnLoadedFromBigFoot("Masque")) then

			--BigFoot_RequestReloadUI(function() BigFoot_Print(RECOUNT_DISABLE_DELAY_TEXT); end);
		end
	end
end
)

BFNew_RegisterAddonConfig("Masque","CheckBox","Masque_BuffDisable",BUFFDISABLE,nil,
true,-----默认值
function(arg,init)
	if (arg) then
		if BigFoot_IsAddOnLoadedFromBigFoot("ButtonFacade") then
			BF_EnableBuffGroup(false)
		end
	else
		if (BigFoot_IsAddOnLoadedFromBigFoot("ButtonFacade")) then
			BF_EnableBuffGroup(true)
		end
	end
end,1
)

BFNew_RegisterAddonConfig("Masque","Button","MasqueOption",MASQUEENABLEOPTION, nil,
true,-----默认值
function (arg)
	if BigFoot_IsAddOnLoaded("Masque")  then
		InterfaceOptionsFrame_OpenToCategory("Masque")
		PlaySound("igMainMenuOption");
	end
end,1
)