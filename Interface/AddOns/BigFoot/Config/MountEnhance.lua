
function MountEnhanceConfigFunc()
	if (GetLocale() == "zhCN") then
		MOUNT_ENHANCE_MOD_TEXT = {"伙伴增强", "zuoqizengqiang"};

		MOUNT_ENHANCE_ENABLE_TEXT = "启用坐骑增强"
		MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP="支持随机召唤坐骑功能"

		PET_ENHANCE_ENABLE_TEXT = "启用宠物助手"
		PET_ENHANCE_ENABLE_TEXT_TOOLTIP="提供宠物品质,目标宠物信息提示等功能"

	elseif (GetLocale() == "zhTW") then
		MOUNT_ENHANCE_MOD_TEXT = {"夥伴增強", "zuoqizengqiang"};

		MOUNT_ENHANCE_ENABLE_TEXT = "啟用坐騎增強"
		MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP= "支持隨機召喚坐騎功能"

		PET_ENHANCE_ENABLE_TEXT = "啟用寵物助手"
		PET_ENHANCE_ENABLE_TEXT_TOOLTIP="提供寵物品質,寵物鼠標信息提示等功能"

	else
		MOUNT_ENHANCE_MOD_TEXT = "Associate Enhance";

		MOUNT_ENHANCE_ENABLE_TEXT = "Enable Mount Enhance"
		MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP="Support random summon mounts function"

		PET_ENHANCE_ENABLE_TEXT = "Enable Pet Enhance"
		PET_ENHANCE_ENABLE_TEXT_TOOLTIP="Support random summon pets function"
	end

	local NewInfoStrName=[[
	宠物助手上线！
	]]

	local NewInfoStr1=[[
	还在为凑齐150个宠物而找不到最后几个而烦恼吗？使用大脚原创宠物助手即可帮你找到，该功能集成筛选未获得宠物以及鼠标提示宠物来源为一体，帮助玩家摆脱149=1的尴尬局面！向着【小小宠物店】冲刺！

	点开小伙伴界面即可使用，方便、快捷！
	]]

	if (IsConfigurableAddOn("BFMount") or IsConfigurableAddOn("BattlePetInfo")) then
		ModManagement_RegisterMod(
			"BFMount",
			"Interface\\Icons\\ability_mount_charger",
			MOUNT_ENHANCE_MOD_TEXT,
			"",
			nil,
			nil,
			{[7]=true}
		);
		
		if IsConfigurableAddOn("BFMount") then
			ModManagement_RegisterCheckBox(
				"BFMount",
				MOUNT_ENHANCE_ENABLE_TEXT,
				MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP,
				"EnableMountEnhance",
				1,
				function (arg)
					if (not BigFoot_IsAddOnLoaded("BFMount")) then
						BigFoot_LoadAddOn("BFMount");
					end
					if ( arg == 1 ) then
						if (BigFoot_IsAddOnLoaded("BFMount")) then
							BFMount:Enable();
						end
					else
						if (BigFoot_IsAddOnLoaded("BFMount")) then
							BFMount:Disable();
						end
					end
				end
			);
		end
		
		if IsConfigurableAddOn("BattlePetInfo") then
			ModManagement_RegisterCheckBox(
				"BFMount",
				PET_ENHANCE_ENABLE_TEXT,
				PET_ENHANCE_ENABLE_TEXT_TOOLTIP,
				"EnableBattlePetInfo",
				1,
				function (arg)
					if ( arg == 1 ) then
						if not BigFoot_IsAddOnLoaded("BattlePetInfo") then
							BigFoot_LoadAddOn("BattlePetInfo");
						end
					else
						if BigFoot_IsAddOnLoaded("BattlePetInfo") then
							BigFoot_RequestReloadUI()
						end
					end
				end
			);
		end
	end
end

BigFoot_AddCollector(MountEnhanceConfigFunc)