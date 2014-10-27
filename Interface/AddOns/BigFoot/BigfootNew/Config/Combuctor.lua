if GetLocale() =="zhCN" then
	MYBANK_ENABLE = "整合银行背包";
	MYBANK_ENABLE_TOOLTIP= "用一个物品框体整合银行中的所有栏位";
	
	MYINVENTORY_ENABLE_BACKPACK = "整合角色背包"
	MYINVENTORY_ENABLE_BACKPACK_TOOLTIP= "用一个物品框体整合角色背包中的所有栏位";
	
	MYBANK_CONFIG = "设置参数";
	
	
	ENABLE_Bagnon_Forever_Text ="开启背包物品信息"
elseif GetLocale() == "zhTW" then
	MYBANK_ENABLE = "整合銀行背包";
	MYBANK_ENABLE_TOOLTIP= "用一個物品框體整合銀行中的所有欄位";
	
	MYINVENTORY_ENABLE_BACKPACK = "整合角色背包"
	MYINVENTORY_ENABLE_BACKPACK_TOOLTIP= "用一個物品框體整合角色背包中的所有欄位"
	
	MYBANK_CONFIG = "設置參數";
	
	ENABLE_Bagnon_Forever_Text ="開啟背包物品信息"
end
-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("Combuctor",{BFNew_AddonTypeTable[7],BFNew_AddonTypeTable[8]},nil,nil,true)

BFNew_RegisterAddon("Bagnon_Forever",{BFNew_AddonTypeTable[7],BFNew_AddonTypeTable[8]},nil,nil,true)
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

BFNew_RegisterAddonConfig("Combuctor","CheckBox","Enable_Bank_Integration",MYBANK_ENABLE,MYBANK_ENABLE_TOOLTIP,
true,-----默认值
	function (arg)	          
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Combuctor")) then
				BigFoot_LoadAddOn("Combuctor");
			end
			if BFNew_GetCurrentAddonConfig("Combuctor","Enable_BackPack_Integration") == true then
				Combuctor:HookBagEvents(1,1)
			else
				Combuctor:HookBagEvents(1,0)
			end
		else
			
			if BigFoot_IsAddOnLoaded("Combuctor") then
				if BFNew_GetCurrentAddonConfig("Combuctor","Enable_BackPack_Integration") == true then
					Combuctor:HookBagEvents(0,1)
				else
					Combuctor:HookBagEvents(0,0)
				end
			end
		end
	end
)
BFNew_RegisterAddonConfig("Combuctor","CheckBox","Enable_BackPack_Integration",MYINVENTORY_ENABLE_BACKPACK,MYINVENTORY_ENABLE_BACKPACK_TOOLTIP,
true,-----默认值
	function (arg)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("Combuctor")) then
				BigFoot_LoadAddOn("Combuctor");
			end
			if BFNew_GetCurrentAddonConfig("Combuctor","Enable_Bank_Integration") == true then
				Combuctor:HookBagEvents(1,1)	
			else
				Combuctor:HookBagEvents(0,1)
			end
		else
			if BigFoot_IsAddOnLoaded("Combuctor") then
				if BFNew_GetCurrentAddonConfig("Combuctor","Enable_Bank_Integration") == true then
					Combuctor:HookBagEvents(1,0)	
				else
					Combuctor:HookBagEvents(0,0)
				end
			end
		end
	end
)
BFNew_RegisterAddonConfig("Combuctor","Button","BackPack_Integration_option",MYBANK_CONFIG,nil,
nil,-----默认值
	function()
		if BigFoot_IsAddOnLoaded("Combuctor")  then
			Combuctor:ShowOptions()
			PlaySound("igMainMenuOption");
		end
	end,1
)
-- InterfaceOptionsFrame_OpenToCategory(self.Options)

BFNew_RegisterAddonConfig("Bagnon_Forever","CheckBox","Enable_Bagnon_Forever",ENABLE_Bagnon_Forever_Text,nil,
true,-----默认值
	function (arg)
		
	end
)