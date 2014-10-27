---------------------------------------------------------------------------------
if GetLocale() == "zhCN" then
	ENABLE_MAIL_MOD = "启用邮件助手";
	ENABLE_MAIL_MOD_TOOLTIP= "强化邮件功能：可记忆收信人及支持批量收取邮件";
elseif GetLocale() == "zhTW" then
	ENABLE_MAIL_MOD = "啟用郵件助手";
	ENABLE_MAIL_MOD_TOOLTIP= "槍換郵件功能：可記憶收信人及支持批量收取郵件";

else
	ENABLE_MAIL_MOD = "Enable CT-Mail Mod";
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE = "Enable Fast Focus";
end


-------------------注册插件类型-----------------------------------
--------------参数1 插件的名字-----------------------------------
--------------参数2 插件的类型。-----------------------------------
--------------参数3 启动插件是否需要重载界面。默认nil 可设置为true-----------------------------------
BFNew_RegisterAddon("MailMod",{BFNew_AddonTypeTable[8]},nil,nil,true)
--------------------------------------------------------------
--------------------------------------------------------------
-------------------注册插件互斥信息-------------------------------------------
-------------------参数1 互斥的插件名字列表的Tab-------------------------------------------
-- BFNew_RegisterAddonexclusiveTab({"Skada","Recount"})
--------------------注册插件配置信息----------------------------------

	BFNew_RegisterAddonConfig("MailMod","CheckBox","EnableMailMod",ENABLE_MAIL_MOD,ENABLE_MAIL_MOD_TOOLTIP,
	true,-----默认值
	function(arg,init)
		if (arg) then
			if (not BigFoot_IsAddOnLoaded("MailMod")) then
				BigFoot_LoadAddOn("MailMod");
			end

			if (BigFoot_IsAddOnLoaded("MailMod")) then
				MailMod_Toggle(true);
			end
		else
			if (BigFoot_IsAddOnLoaded("MailMod")) then
				MailMod_Toggle(false);
			end
		end
	end
	)
	
 
