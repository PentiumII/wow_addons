if GetLocale() =="zhCN" then
	PET_ENHANCE_ENABLE_TEXT = "使用宠物增强"
	PET_ENHANCE_ENABLE_TEXT_TOOLTIP="提供宠物品质、宠物鼠标信息提示等功能"

elseif GetLocale() == "zhTW" then

	PET_ENHANCE_ENABLE_TEXT = "使用寵物增強"
	PET_ENHANCE_ENABLE_TEXT_TOOLTIP="提供寵物品質、寵物鼠標信息提示等功能"
end
BFNew_RegisterAddon("BattlePetInfo",{BFNew_AddonTypeTable[10]},nil,nil,true)
BFNew_RegisterAddonConfig("BattlePetInfo","CheckBox","EnableBattlePetInfo",PET_ENHANCE_ENABLE_TEXT,PET_ENHANCE_ENABLE_TEXT_TOOLTIP,
true,-----默认值
	function (arg)
		if ( arg ) then
			if not BigFoot_IsAddOnLoadedFromBigFoot("BattlePetInfo") then
				BigFoot_LoadAddOn("BattlePetInfo")
			end
		end
	end
)
