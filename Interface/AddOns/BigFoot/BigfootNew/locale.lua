BF_L={};
if (GetLocale() == "zhCN") then
	__MOD_MANAGEMENT_FONT = "Fonts\\ARKai_T.TTF";
	ALL_RESULTS = "搜索结果"
	RETURN="返回列表"
	BF_BUTTONTEXT_SAVERETURN = "保存并返回"
	TabList={
	"Integrate",
	"Single"
	}
	
	defaultSelectedTab = TabList[1]
	BF_L["Integrate"] = "大脚整合";
	BF_L["Single"] = "单体插件";
	BF_MAINSETTING ="大脚主设置"
	BF_UPDATEINFO = "更新日志"
	BF_CLASSICPANEL = "切换至经典界面"
	BF_SAVESUIT="保存方案"
	BF_DELETESUIT="删除方案"
	BF_SWITCHSUIT ="切换至"
	BF_MANAGEMENT_SUIT="方案管理";
	BF_RELOAD="重载界面/RL"
	NF_APPLY ="应用"
	BF_LOADEXPIREDADDONS ="加载过期插件"
	BF_SELECTADDONSUIT ="插件配置方案"
	BF_ADDONTITLE="功能简称"
	BF_ADDONNAME="插件名称"
	BF_ADDONINFO="简要介绍"
	BF_ADDONCONSUME="占用大小"
	BF_ADDONSTATUS="使用状态"
	BF_SAVESUIT = "保存方案"
	BF_RETURNMAIN="返回主界面"
	BF_NEWSUIT="新建方案"
	BF_NEWSUIT_TEXT="请输入一个新的方案名"
	BF_COVERSUIT_TEXT="方案  %s   已经存在,是否覆盖?"
	BF_COVERSUIT_REFUSE_TEXT = "系统方案无法被覆盖"
	BF_DELSUIT_TEXT ="确定删除方案%s"
	BF_TEXT_ALL="全部插件";
	BF_CHOSEOLDFRAME_TEXT ="确定切换至经典界面？"
	BF_LEAVESUITSTATE_TEXT="将离开插件方案编辑，未应用或保存的内容将丢失，是否离开？"
	BF_MAINFRAME_TITLE="大脚插件"
	BF_SUITOPTION_TITLE="方案管理"
	BF_MAINSETTING_TITLE ="大脚主设置"
	BF_SELETE_ALL_SUILT_TEXT ="以下插件功能相似,建议您选择其一:\n %s  接受将同时开启全部插件\n"
	BF_SELETE_ALL_SUILT_TEXT1 ="是否确定开启全部插件。"
	BF_CATEGORY_TOOTIP_ENABLE = "已启用"
	BF_CATEGORY_TOOTIP_MEMORY = "占用"
	BF_SUITBUTTON_CUSTOM = "自定义"
	
	BF_NEW_statusText ={"将要启用","将要关闭","|cff00ff00已启用|r","|cffff0000已关闭|r"};
	
	BF_NEW_NOT_USED="|cffff0000当前状态不可用|r"
	
	BigfootSuitOptionFrame_Title ="序列";
	BigfootSuitOptionFrame_Name="名称";
	BigfootSuitOptionFrame_SaveTime="保存时间";
	BigfootSuitOptionFrame_SavePlayer="保存角色";
	BigfootSuitOptionFrame_OpenNum="已开启";
	
	
	BigfootNewMainFrame_Button_Text1= "应用后设置生效";
	BigfootNewMainFrame_Button_Text2= "需要重载插件";
	
	BigfootNewMainFrame_SearchBigFoot ="搜索大脚整合"
	BigfootNewMainFrame_SearchNotBigFoot ="搜索单体插件"
	BigfootNewMainFrame_NotSearchKey ="搜索"
	BF_ADDON_OUTDATE = "|cffff0000该插件已过期|r"

	BFNEW_TEXT_MEMORY_NOTENABLE ="未开启"

	
	AFTERRELOAD = "重载效果预览:\n"
	T_ENABLE = {"将被开启,\n","将被关闭,\n"}

	
	BF_SELETE_ADDON_TEXT_DLG=" %s与已启用的%s功能类似，是否同时启用？";
	BF_DEPSTAB_TEXT =" %s功能依赖于未启用的%s ，是否同时启用？";
	BF_DEPSTAB_TEXTA="%s功能关闭，依赖于他的%s是否同时关闭？"
	
	BF_Text_AND ="与"	
	BF_LEVEL_SUILT_TEXT_DLG="确定离开当前方案，未保存的设置将丢失"
		
	BF_DEFAULTSUITNAME_SIMPLE="简约"
	BF_DEFAULTSUITNAME_DEFAULT="默认"
	BF_BIGFOOT_DEFAULT="(大脚推荐)"
	BF_BIGFOOT_backup="临时备份"

	BF_ENABLEALL = "启用全部"
	BF_DISABLEALL = "禁用全部"
	
	BF_DISABLEALLALERT = "是否确定关闭全部插件"
	
	BF_EnableAllOptionTooltip = "点击选择禁用或启用全部插件"
	
	
	
	Tutorial_First_Login_step1="大脚提供了三套推荐方案方便玩家快捷切换,玩家也可以编辑方案以供使用。"
	Tutorial_First_Login_step2="这里包含了一些基本设置。"
	Tutorial_First_Login_step3="这里是分类导航栏,点击进入该分类插件列表,鼠标悬停可获取插件占用信息。"
	Tutorial_First_Login_step4="勾选开启插件,点击进入插件配置。"
	Tutorial_First_Login_step5="点击列表标题栏可以按需排序。"
	Tutorial_First_Login_step6="输入关键字可以对插件进行搜索,例如:DBM或界面调整。"
	DONE = "完成"
	BUTTONTEXT_NEXT= "下一步"
	BUTTONTEXT_LAST= "上一步"

	BF_Text_SeleteAll ="显示全部"
	BF_Text_SeleteNotCanUsed ="仅显示当前不可用插件"
	BF_Text_SeleteCanUsed ="仅显示当前可用插件"
	BF_Text_SeleteDisable="仅显示未启用插件"
	BF_Text_SeleteEnable ="仅显示已启用插件";

	BF_COLLECT = "回收内存"
	BF_COLLECT_PRINT="|cff00efe0大脚已经帮您清理了插件内存，祝您游戏愉快！|r"
	BF_RESET = "还原默认配置"
	BF_RESET_DIALOG = "还原默认配置需要重载插件，点击确定继续。"
elseif (GetLocale() == "zhTW") then
	ALL_RESULTS = "搜索結果"
	RETURN="返回列表"
	BF_NEW_statusText ={"將要啟用","將要關閉","|cff00ff00已啟用|r","|cffff0000已關閉|r"};
	__MOD_MANAGEMENT_FONT = "Fonts\\bLEI00D.TTF";
	TabList={
		"Integrate",
		"Single"
	}
	defaultSelectedTab = TabList[1]
	BF_L["Integrate"] = "大腳整合";
	BF_L["Single"] = "單體插件";
	BF_MAINSETTING ="大腳主設置"
	BF_UPDATEINFO = "更新日誌"
	BF_CLASSICPANEL = "切換至經典界面"
	BF_SAVESUIT="保存方案"
	BF_DELETESUIT="刪除方案"
	BF_SWITCHSUIT ="切換至"
	BF_MANAGEMENT_SUIT="方案管理";
	BF_RELOAD="重載界面/RL"
	NF_APPLY ="應用"
	BF_LOADEXPIREDADDONS ="加載過期插件"
	BF_SELECTADDONSUIT ="插件配置方案"
	BF_ADDONTITLE="功能簡稱"
	BF_ADDONNAME="插件名稱"
	BF_ADDONINFO="簡要介紹"
	BF_ADDONCONSUME="佔用大小"
	BF_ADDONSTATUS="使用狀態"
	BF_SAVESUIT = "保存方案"
	BF_RETURNMAIN="返回主界面"
	BF_NEWSUIT="新建方案"
	BF_NEWSUIT_TEXT="請輸入一個新的方案名"
	BF_COVERSUIT_TEXT="方案  %s   已经存在，是否覆蓋?"
	BF_COVERSUIT_REFUSE_TEXT = "系統方案無法被覆蓋"
	BF_DELSUIT_TEXT ="確定刪除方案%s"
	BF_TEXT_ALL="全部插件";
	BF_CHOSEOLDFRAME_TEXT ="確定切換至經典界面"
	BF_LEAVESUITSTATE_TEXT="將離開插件方案編輯，未應用或保存的內容將丟失，是否離開。"
	BF_MAINFRAME_TITLE="大腳插件"
	BF_SUITOPTION_TITLE="方案管理"
	BF_MAINSETTING_TITLE ="大腳主設置"
	BF_SELETE_ALL_SUILT_TEXT ="以下插件功能相似,建議您選擇其一:\n %s  接受將同時開啟全部插件\n"
	BF_SELETE_ALL_SUILT_TEXT1 ="是否確定開啟全部插件"
	BF_CATEGORY_TOOTIP_ENABLE = "已啟用"
	BF_CATEGORY_TOOTIP_MEMORY = "佔用"
	BF_SUITBUTTON_CUSTOM = "自定義"
	statusText ={"将要启用","将要关闭","|cff00ff00已启用|r","|cffff0000已关闭|r"};
	
	BF_NEW_NOT_USED="|cffff0000當前狀態不可用|r"
	
	BigfootSuitOptionFrame_Title ="序列";
	BigfootSuitOptionFrame_Name="名稱";
	BigfootSuitOptionFrame_SaveTime="保存時間";
	BigfootSuitOptionFrame_SavePlayer="保存角色";
	BigfootSuitOptionFrame_OpenNum="已開啟";
	
	BigfootNewMainFrame_Button_Text1= "應用後設置生效";
	BigfootNewMainFrame_Button_Text2= "需要重載插件";
	
	BigfootNewMainFrame_SearchBigFoot ="搜索大腳整合"
	BigfootNewMainFrame_SearchNotBigFoot ="搜索單體插件"
	BigfootNewMainFrame_NotSearchKey ="搜索"
	BF_ADDON_OUTDATE = "|cffff0000該插件已過期|r"
	BFNEW_TEXT_MEMORY_NOTENABLE ="未開啟"
	BF_BUTTONTEXT_SAVERETURN = "保存並返回"
	
	AFTERRELOAD = "重載效果預覽:"
	T_ENABLE = {"将被開啟,\n","將被關閉,\n"}

	
	BF_SELETE_ADDON_TEXT_DLG=" %s與已經啟用的%s功能類似 是否同時啟用？";
	BF_Text_AND ="與"
	BF_DEPSTAB_TEXT =" %s功能依賴於未啟用的%s，是否同時啟用？";
	BF_DEPSTAB_TEXTA="%s功能关闭，依赖于他的%s是否同時关闭？"
	BF_LEVEL_SUILT_TEXT_DLG=""
	
	BF_DEFAULTSUITNAME_SIMPLE="簡約"
	BF_DEFAULTSUITNAME_DEFAULT="默認"
	BF_BIGFOOT_DEFAULT="(大腳推薦)"
	
	BF_BIGFOOT_backup="臨時備份"
	
	BF_ENABLEALL = "啟用全部"
	BF_DISABLEALL = "禁用全部"
	
	Tutorial_First_Login_step1="大腳提供了三套推薦方案方便玩家快捷切換，玩家也可以編輯方案以供使用。"
	Tutorial_First_Login_step2="這裡包含了一些基本設置。"
	Tutorial_First_Login_step3="這裡是分類導航欄，點擊進入該分類插件列表，鼠標懸停可獲取插件佔用信息。"
	Tutorial_First_Login_step4="勾選開啟插件，點擊進入插件配置。"
	Tutorial_First_Login_step5="點擊列表標題欄可以按需排序。"
	Tutorial_First_Login_step6="輸入關鍵字可以對插件進行搜索，例如：DBM或界面調整。"
	DONE = "完成"
	BF_DISABLEALLALERT = "是否關閉全部插件"
	BF_EnableAllOptionTooltip = "點擊選擇禁用或启用全部插件"
	BUTTONTEXT_NEXT= "下一步"
	BUTTONTEXT_LAST= "上一步"
	
	
	BF_Text_SeleteAll ="顯示全部"
	BF_Text_SeleteNotCanUsed ="僅顯示當前不可用插件"
	BF_Text_SeleteCanUsed ="僅顯示當前可用插件"
	BF_Text_SeleteDisable="僅顯示為開啟插件"
	BF_Text_SeleteEnable ="進現實已啟用插件";

	BF_COLLECT="回收內存"
	BF_COLLECT_PRINT ="|cff00efe0大腳已經幫您清理了插件內存，祝您遊戲愉快！|r"
	BF_RESET = "還原默認配置"
	BF_RESET_DIALOG = "還原默認配置需要重載插件，點擊確定後繼續。"

else
	__MOD_MANAGEMENT_FONT = "Fonts\\ARIALN.TTF";
end