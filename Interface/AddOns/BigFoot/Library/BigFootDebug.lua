 local BLDebug_dbdf11f5b07258936fb1c5a31eaa969c = 1; local BLDebug_1b5523f0adb45c4b8ee51f89ebf6f2b2 = 0; BDebug = {}; BDebug.BLDebug_052d6ebb3394e2e58a7241a35c093f4e = {}; BDebug.BLDebug_627cd7086fdc7c8fc6490353cc56678f = {}; local function BLDebug_fbdc276aab70785831ced75c81d87eff(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) if (type(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) == "table" or type(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) == "function" or type(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) == "userdata") then return nil; else return true; end end local function BLDebug_4f9bfbc72b3131a66003195e78e59a9a(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) if (not BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) then BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae = "(nil)"; elseif (not BLDebug_fbdc276aab70785831ced75c81d87eff(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae)) then BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae = "("..type(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae)..")"; end return BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae; end local function BLDebug_6fc5e6a3f6bb547e6580a85e6b6087de(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) if (type(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) == "table") then local BLDebug_4c5e2a6c497f2639f1590edb13036a7d = "{ "; local BLDebug_385abf181e674ce9c9ab08cef8333911 = ""; local BLDebug_413bf9c15ce77baa8ebf1cda4cbf4887, BLDebug_2361bab8b48b1041ad740bb561b21aee; for BLDebug_413bf9c15ce77baa8ebf1cda4cbf4887, BLDebug_2361bab8b48b1041ad740bb561b21aee in pairs(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae) do if (type(BLDebug_2361bab8b48b1041ad740bb561b21aee) == "table") then BLDebug_4c5e2a6c497f2639f1590edb13036a7d = BLDebug_4c5e2a6c497f2639f1590edb13036a7d .. BLDebug_385abf181e674ce9c9ab08cef8333911 .. BLDebug_413bf9c15ce77baa8ebf1cda4cbf4887 .. " => " .. BLDebug_6fc5e6a3f6bb547e6580a85e6b6087de(BLDebug_2361bab8b48b1041ad740bb561b21aee); else BLDebug_4c5e2a6c497f2639f1590edb13036a7d = BLDebug_4c5e2a6c497f2639f1590edb13036a7d .. BLDebug_385abf181e674ce9c9ab08cef8333911 .. BLDebug_413bf9c15ce77baa8ebf1cda4cbf4887 .. " => " .. BLDebug_6fc5e6a3f6bb547e6580a85e6b6087de(BLDebug_2361bab8b48b1041ad740bb561b21aee); end BLDebug_385abf181e674ce9c9ab08cef8333911 = ", "; end BLDebug_4c5e2a6c497f2639f1590edb13036a7d = BLDebug_4c5e2a6c497f2639f1590edb13036a7d .. " }"; return BLDebug_4c5e2a6c497f2639f1590edb13036a7d; else return tostring(BLDebug_4f9bfbc72b3131a66003195e78e59a9a(BLDebug_7739b813d90aed43ab9d0eb84ec1c1ae)); end end local function BLDebug_1c10d29f38e77d6e8a196a0c3c581087(BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d) local BLDebug_da4b94f92d67ca9ccecb24bec1db6e2b = ""; local BLDebug_5c387ba3afaf9146175764ba9c988bd4 = 0; local BLDebug_f7865900074e23318f1a7d3131a3d027 = 0; local BLDebug_ac970a92b1bae84f591d2098084a233d = 0; BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d = floor(BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d); if (BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d > 86400) then BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d = mod(BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d, 86400); BLDebug_3f50417fb16be9b1078eb68d24fa9c26 = BLDebug_3f50417fb16be9b1078eb68d24fa9c26 + 1; end if (BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d > 3600) then BLDebug_5c387ba3afaf9146175764ba9c988bd4 = floor(BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d / 3600); BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d = mod(BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d, 3600); end if (BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d >= 60) then BLDebug_f7865900074e23318f1a7d3131a3d027 = floor(BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d / 60); BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d = mod(BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d, 60); end if (BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d > 0) then BLDebug_ac970a92b1bae84f591d2098084a233d = BLDebug_c7b591b2c752c8cb9c847770ee2d8f9d; end return string.format("%02d:%02d:%02d", BLDebug_5c387ba3afaf9146175764ba9c988bd4, BLDebug_f7865900074e23318f1a7d3131a3d027, BLDebug_ac970a92b1bae84f591d2098084a233d); end local function BLDebug_1f9318bc2813de1f1c26e6bcfad588fd(BLDebug_c933410cf37b41b19e2f71899bab1b9b, BLDebug_eed0be1c2d5f65980b06b5094460c3c5, ...) if (BDebug.BLDebug_627cd7086fdc7c8fc6490353cc56678f[BLDebug_c933410cf37b41b19e2f71899bab1b9b.BLDebug_f9da61d0483af6cef16512c8cc1a8586]) then local arg = {}; for BLDebug_e914904fab9d05d3f54d52bfc31a0f3f = 1, select("#", ...), 1 do arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f] = BLDebug_6fc5e6a3f6bb547e6580a85e6b6087de(select(BLDebug_e914904fab9d05d3f54d52bfc31a0f3f, ...)); end local BLDebug_efbab3814cee45a006bb3bd137df4a9e = string.format(BLDebug_eed0be1c2d5f65980b06b5094460c3c5, unpack(arg)); if (BDebug.BLDebug_78d27bdc1bb2df7f446abd8916639a33) then DEFAULT_CHAT_FRAME:AddMessage("|cff00c0c0["..BLDebug_1c10d29f38e77d6e8a196a0c3c581087(GetTime()).."]|r " .. "<" .. BLDebug_c933410cf37b41b19e2f71899bab1b9b.BLDebug_f9da61d0483af6cef16512c8cc1a8586 .. "> " .. BLDebug_efbab3814cee45a006bb3bd137df4a9e, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b); else DEFAULT_CHAT_FRAME:AddMessage("<"..BLDebug_c933410cf37b41b19e2f71899bab1b9b.BLDebug_f9da61d0483af6cef16512c8cc1a8586.."> "..BLDebug_efbab3814cee45a006bb3bd137df4a9e, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b); end end end function BDebug:constructor(BLDebug_f9da61d0483af6cef16512c8cc1a8586) assert(BLDebug_f9da61d0483af6cef16512c8cc1a8586 and type(BLDebug_f9da61d0483af6cef16512c8cc1a8586) == "string", "You must specify a module name for using BDebug."); assert(not BDebug.BLDebug_052d6ebb3394e2e58a7241a35c093f4e[BLDebug_f9da61d0483af6cef16512c8cc1a8586], string.format("The specific module \"%s\" already exists.", BLDebug_f9da61d0483af6cef16512c8cc1a8586)); self.BLDebug_f9da61d0483af6cef16512c8cc1a8586 = BLDebug_f9da61d0483af6cef16512c8cc1a8586; BDebug.BLDebug_052d6ebb3394e2e58a7241a35c093f4e[BLDebug_f9da61d0483af6cef16512c8cc1a8586] = true; end function BDebug:Print(BLDebug_eed0be1c2d5f65980b06b5094460c3c5, ...) BLDebug_1f9318bc2813de1f1c26e6bcfad588fd(self, BLDebug_eed0be1c2d5f65980b06b5094460c3c5, ...); end function BDebug:EnableModules(...) local BLDebug_e914904fab9d05d3f54d52bfc31a0f3f; for BLDebug_e914904fab9d05d3f54d52bfc31a0f3f = 1, arg.n, 1 do assert(type(arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f]) == "string", "Invalid Parameter."); assert(BDebug.BLDebug_052d6ebb3394e2e58a7241a35c093f4e[arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f]], string.format("The module \"%s\" is not a valid module.", arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f])); BDebug.BLDebug_627cd7086fdc7c8fc6490353cc56678f[arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f]] = true; end end function BDebug:DisableModules(...) local BLDebug_e914904fab9d05d3f54d52bfc31a0f3f; for BLDebug_e914904fab9d05d3f54d52bfc31a0f3f = 1, arg.n, 1 do assert(type(arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f]) == "string", "Invalid Parameter."); assert(BDebug.BLDebug_052d6ebb3394e2e58a7241a35c093f4e[arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f]], string.format("The module \"%s\" is not a valid module.", arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f])); BDebug.BLDebug_627cd7086fdc7c8fc6490353cc56678f[arg[BLDebug_e914904fab9d05d3f54d52bfc31a0f3f]] = nil; end end function BDebug:EnableTime(BLDebug_98a5dc0296fddcc9b5b804f038f1994c) BDebug.BLDebug_78d27bdc1bb2df7f446abd8916639a33 = BLDebug_98a5dc0296fddcc9b5b804f038f1994c; end function BDebug:IsTimeEnabled() if (BDebug.BLDebug_78d27bdc1bb2df7f446abd8916639a33) then return true; else return false; end end BLibrary:Register(BDebug, "BDebug", BLDebug_dbdf11f5b07258936fb1c5a31eaa969c, BLDebug_1b5523f0adb45c4b8ee51f89ebf6f2b2); 