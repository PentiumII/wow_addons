 BLDS_5872dda98e50a9be6a992d46edbad39e = 1; BLDS_d160becf040921f4e2c30daaee5ee22e = 0; BPool = {}; function BPool:constructor(BLDS_2cd86b16eb8adec98c780eb6fcf27efc, BLDS_3ae8eb6ec90242df1e30110fba73067d) assert(type(BLDS_fc2d298aa42d24965e5e3444fe3612b3) ~= "function", "You must assign a creation function to construct pool."); self.generator = BLDS_2cd86b16eb8adec98c780eb6fcf27efc; self.context = BLDS_3ae8eb6ec90242df1e30110fba73067d; self.count = 0; self.innerpool = {}; self.outerpool = {}; end function BPool:Drop(BLDS_7e7860987b220bb966092ef46f8a8f44) local BLDS_88fe8b5ad46d0baa53706cbfe5402203; for BLDS_e914904fab9d05d3f54d52bfc31a0f3f = 1, #self.outerpool, 1 do if (self.outerpool[BLDS_e914904fab9d05d3f54d52bfc31a0f3f] == BLDS_7e7860987b220bb966092ef46f8a8f44) then table.remove(self.outerpool, BLDS_e914904fab9d05d3f54d52bfc31a0f3f); BLDS_88fe8b5ad46d0baa53706cbfe5402203 = true; break; end end assert(BLDS_88fe8b5ad46d0baa53706cbfe5402203 ~= nil, "The specified element does not belong to this pool."); table.insert(self.innerpool, BLDS_7e7860987b220bb966092ef46f8a8f44); if (self.OnDropped) then self.OnDropped(self, BLDS_7e7860987b220bb966092ef46f8a8f44); end end function BPool:DropAll() local BLDS_413bf9c15ce77baa8ebf1cda4cbf4887, BLDS_2361bab8b48b1041ad740bb561b21aee; for BLDS_413bf9c15ce77baa8ebf1cda4cbf4887, BLDS_2361bab8b48b1041ad740bb561b21aee in ipairs(self.outterpool) do self:Drop(BLDS_2361bab8b48b1041ad740bb561b21aee); end end function BPool:Get() local BLDS_7e7860987b220bb966092ef46f8a8f44; if (#self.innerpool == 0) then BLDS_7e7860987b220bb966092ef46f8a8f44 = self.generator(self.context); else BLDS_7e7860987b220bb966092ef46f8a8f44 = self.innerpool[#self.innerpool]; table.remove(self.innerpool); end table.insert(self.outerpool, BLDS_7e7860987b220bb966092ef46f8a8f44); if (self.OnGotten) then self.OnGotten(self, BLDS_7e7860987b220bb966092ef46f8a8f44); end return BLDS_7e7860987b220bb966092ef46f8a8f44; end BLibrary:Register(BPool, "BPool", BLDS_8cf62406635d90ceb577a43efafabe41, BLDS_d160becf040921f4e2c30daaee5ee22e); BLDS_1c3fb0a635a94e3001e1274cff993440 = 1; BLDS_b6a0481a2567ffc77d70559bcc5237d9 = 0; BTree = {}; function BTree:constructor() self.root = nil; self.items = {}; self.hash = {}; self.count = 0; end function BTree:Insert(BLDS_2e00ffac12aadb3a1fd865993ec505b9, BLDS_dc0fe7e5cdedeee808957fa365a170d9, __mode) assert(__mode == nil or __mode == "before" or __mode == "after" or __mode == "child", "Invalid insert mode."); if (not __mode) then __mode = "after"; end local BLDS_a4ae8f1b50c7593a1bada9f62d1883fb; if (BLDS_dc0fe7e5cdedeee808957fa365a170d9) then BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9]; else BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.root; end if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb == nil) then local BLDS_edbee802d3916620e099502d0cfa7f6e = {}; BLDS_edbee802d3916620e099502d0cfa7f6e.item = BLDS_2e00ffac12aadb3a1fd865993ec505b9; BLDS_edbee802d3916620e099502d0cfa7f6e.prev = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.next = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.parent = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.firstchild = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.lastchild = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.level = 1; self.items[BLDS_2e00ffac12aadb3a1fd865993ec505b9] = BLDS_edbee802d3916620e099502d0cfa7f6e; if (type(self.HashKey) == "function") then self.hash[self.HashKey(self, BLDS_2e00ffac12aadb3a1fd865993ec505b9)] = BLDS_edbee802d3916620e099502d0cfa7f6e; end self.root = BLDS_edbee802d3916620e099502d0cfa7f6e; self.count = self.count + 1; elseif (__mode == "before") then local BLDS_8a4f11815f2019d64176fde213fdb6b5 = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev; local BLDS_1346009d8936868590c1d007e3efcfae = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent; local BLDS_edbee802d3916620e099502d0cfa7f6e = {}; BLDS_edbee802d3916620e099502d0cfa7f6e.item = BLDS_2e00ffac12aadb3a1fd865993ec505b9; BLDS_edbee802d3916620e099502d0cfa7f6e.level = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.level; if (BLDS_8a4f11815f2019d64176fde213fdb6b5) then BLDS_8a4f11815f2019d64176fde213fdb6b5.next = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_edbee802d3916620e099502d0cfa7f6e.prev = BLDS_8a4f11815f2019d64176fde213fdb6b5; BLDS_edbee802d3916620e099502d0cfa7f6e.next = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb; BLDS_edbee802d3916620e099502d0cfa7f6e.parrent = BLDS_f8530ae71509105eebe06df6c2c53dfe; else if (BLDS_1346009d8936868590c1d007e3efcfae) then BLDS_1346009d8936868590c1d007e3efcfae.firstchild = BLDS_edbee802d3916620e099502d0cfa7f6e; end BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_edbee802d3916620e099502d0cfa7f6e.prev = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.next = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb; BLDS_edbee802d3916620e099502d0cfa7f6e.parent = BLDS_1346009d8936868590c1d007e3efcfae; end self.items[BLDS_2e00ffac12aadb3a1fd865993ec505b9] = BLDS_edbee802d3916620e099502d0cfa7f6e; if (type(self.HashKey) == "function") then self.hash[self.HashKey(self, BLDS_2e00ffac12aadb3a1fd865993ec505b9)] = BLDS_edbee802d3916620e099502d0cfa7f6e; end self.count = self.count + 1; elseif (__mode == "after") then local BLDS_1c22b99deff300cdd7800f4609cfc93d = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next; local BLDS_1346009d8936868590c1d007e3efcfae = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent; local BLDS_edbee802d3916620e099502d0cfa7f6e = {}; BLDS_edbee802d3916620e099502d0cfa7f6e.item = BLDS_2e00ffac12aadb3a1fd865993ec505b9; BLDS_edbee802d3916620e099502d0cfa7f6e.level = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.level; if (BLDS_1c22b99deff300cdd7800f4609cfc93d) then BLDS_1c22b99deff300cdd7800f4609cfc93d.before = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_edbee802d3916620e099502d0cfa7f6e.prev = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb; BLDS_edbee802d3916620e099502d0cfa7f6e.next = BLDS_1c22b99deff300cdd7800f4609cfc93d; BLDS_edbee802d3916620e099502d0cfa7f6e.parent = BLDS_1346009d8936868590c1d007e3efcfae; else if (BLDS_1346009d8936868590c1d007e3efcfae) then BLDS_1346009d8936868590c1d007e3efcfae.lastchild = BLDS_edbee802d3916620e099502d0cfa7f6e; end BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_edbee802d3916620e099502d0cfa7f6e.prev = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb; BLDS_edbee802d3916620e099502d0cfa7f6e.next = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.parent = BLDS_1346009d8936868590c1d007e3efcfae; end self.items[BLDS_2e00ffac12aadb3a1fd865993ec505b9] = BLDS_edbee802d3916620e099502d0cfa7f6e; if (type(self.HashKey) == "function") then self.hash[self.HashKey(self, BLDS_2e00ffac12aadb3a1fd865993ec505b9)] = BLDS_edbee802d3916620e099502d0cfa7f6e; end self.count = self.count + 1; elseif (__mode == "child") then local BLDS_8a4f11815f2019d64176fde213fdb6b5 = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev; local BLDS_1c22b99deff300cdd7800f4609cfc93d = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next; local BLDS_9c82d7f51ee88c9c3c14cd42deb06413 = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.lastchild; local BLDS_edbee802d3916620e099502d0cfa7f6e = {}; BLDS_edbee802d3916620e099502d0cfa7f6e.item = BLDS_2e00ffac12aadb3a1fd865993ec505b9; BLDS_edbee802d3916620e099502d0cfa7f6e.level = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.level + 1; if (not BLDS_9c82d7f51ee88c9c3c14cd42deb06413) then BLDS_edbee802d3916620e099502d0cfa7f6e.prev = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.next = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.parent = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb; BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.firstchild = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.lastchild = BLDS_edbee802d3916620e099502d0cfa7f6e; else BLDS_9c82d7f51ee88c9c3c14cd42deb06413.next = BLDS_edbee802d3916620e099502d0cfa7f6e; BLDS_edbee802d3916620e099502d0cfa7f6e.prev = BLDS_9c82d7f51ee88c9c3c14cd42deb06413; BLDS_edbee802d3916620e099502d0cfa7f6e.next = nil; BLDS_edbee802d3916620e099502d0cfa7f6e.parent = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb; BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.lastchild = BLDS_edbee802d3916620e099502d0cfa7f6e; end self.items[BLDS_2e00ffac12aadb3a1fd865993ec505b9] = BLDS_edbee802d3916620e099502d0cfa7f6e; if (type(self.HashKey) == "function") then self.hash[self.HashKey(self, BLDS_2e00ffac12aadb3a1fd865993ec505b9)] = BLDS_edbee802d3916620e099502d0cfa7f6e; end self.count = self.count + 1; end end function BTree:Delete(BLDS_dc0fe7e5cdedeee808957fa365a170d9) assert(BLDS_dc0fe7e5cdedeee808957fa365a170d9 ~= nil, "Invalid reference item."); assert(self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9] ~= nil, "The reference item does not exist."); local BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9]; if (not BLDS_a4ae8f1b50c7593a1bada9f62d1883fb) then return; end if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev) then BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev.next = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next; end if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent and BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent.firstchild == BLDS_a4ae8f1b50c7593a1bada9f62d1883fb) then BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent.firstchild = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next; end if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next) then BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next.prev = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev; end if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent and BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent.lastchild == BLDS_a4ae8f1b50c7593a1bada9f62d1883fb) then BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent.lastchild = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev; end if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.firstchild) then local BLDS_9c82d7f51ee88c9c3c14cd42deb06413 = self:Child(BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.item); local BLDS_dd759702c4867e114edab122ed0d11d3; while (BLDS_9c82d7f51ee88c9c3c14cd42deb06413) do BLDS_dd759702c4867e114edab122ed0d11d3 = BLDS_9c82d7f51ee88c9c3c14cd42deb06413; BLDS_9c82d7f51ee88c9c3c14cd42deb06413 = self:Next(BLDS_dd759702c4867e114edab122ed0d11d3); self:Delete(BLDS_dd759702c4867e114edab122ed0d11d3); end end if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb == self.root) then self.root = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next; end BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = {}; self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9] = nil; if (type(self.HashKey) == "function") then self.items[self.HashKey(self, BLDS_dc0fe7e5cdedeee808957fa365a170d9)] = nil; end if (self.OnDeleted) then self.OnDeleted(self, BLDS_dc0fe7e5cdedeee808957fa365a170d9); end self.count = self.count - 1; end function BTree:Next(BLDS_dc0fe7e5cdedeee808957fa365a170d9, __mode) assert(__mode == nil or __mode == "sibling" or __mode == "all", "Invalid mode."); assert(BLDS_dc0fe7e5cdedeee808957fa365a170d9 ~= nil, "Invalid reference item."); assert(self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9] ~= nil, "The reference item does not exist."); local BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9]; if (not __mode) then __mode = "sibling"; end if (__mode == "sibling") then if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next.item; else return; end elseif (__mode == "all") then if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.firstchild) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.firstchild.item; elseif (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.next.item; elseif (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent) then local BLDS_1346009d8936868590c1d007e3efcfae = BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent; while (BLDS_1346009d8936868590c1d007e3efcfae and not BLDS_1346009d8936868590c1d007e3efcfae.next) do BLDS_1346009d8936868590c1d007e3efcfae = BLDS_1346009d8936868590c1d007e3efcfae.parent; end if (BLDS_1346009d8936868590c1d007e3efcfae and BLDS_1346009d8936868590c1d007e3efcfae.next) then return self:Next(BLDS_1346009d8936868590c1d007e3efcfae.item, "sibling"); end else return; end end end function BTree:Last(BLDS_dc0fe7e5cdedeee808957fa365a170d9, __mode) assert(__mode == nil or __mode == "sibling" or __mode == "all", "Invalid mode."); assert(BLDS_dc0fe7e5cdedeee808957fa365a170d9 ~= nil, "Invalid reference item."); assert(self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9] ~= nil, "The reference item does not exist."); local BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9]; if (not __mode) then __mode = "sibling"; end if (not BLDS_dc0fe7e5cdedeee808957fa365a170d9) then return; end if (__mode == "sibling") then if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev.item; end elseif (__mode == "all") then if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev) then if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev.lastchild) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev.lastchild.item; else return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.prev.item; end else if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent.item; end end end end function BTree:Child(BLDS_dc0fe7e5cdedeee808957fa365a170d9) local BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9]; if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.firstchild) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.firstchild.item; end end function BTree:IsChild(BLDS_3ea2d62b9ba79db5c422d98846ce41be, BLDS_4bc3e31513f8ee3d5cdc5304743faf4e) local BLDS_1346009d8936868590c1d007e3efcfae = self:Parent(BLDS_3ea2d62b9ba79db5c422d98846ce41be); while (BLDS_1346009d8936868590c1d007e3efcfae) do if (BLDS_1346009d8936868590c1d007e3efcfae == BLDS_4bc3e31513f8ee3d5cdc5304743faf4e) then return true; else BLDS_1346009d8936868590c1d007e3efcfae = self:Parent(BLDS_1346009d8936868590c1d007e3efcfae); end end end function BTree:Count() return self.count; end function BTree:Parent(BLDS_dc0fe7e5cdedeee808957fa365a170d9) local BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9]; if (BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent) then return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.parent.item; end end function BLDS_969957dcac94cf80e3cc93a45baa32c0(BLDS_338995b5a0b361a7d2de36558ff5e309, BLDS_73b057aa85501275a68c77c2a5ef2f19) local matched = true; for BLDS_413bf9c15ce77baa8ebf1cda4cbf4887, BLDS_2361bab8b48b1041ad740bb561b21aee in pairs(BLDS_338995b5a0b361a7d2de36558ff5e309) do if (BLDS_73b057aa85501275a68c77c2a5ef2f19[BLDS_413bf9c15ce77baa8ebf1cda4cbf4887]) then if (type(BLDS_73b057aa85501275a68c77c2a5ef2f19[BLDS_413bf9c15ce77baa8ebf1cda4cbf4887]) == "table") then matched = BLDS_969957dcac94cf80e3cc93a45baa32c0(BLDS_2361bab8b48b1041ad740bb561b21aee, BLDS_73b057aa85501275a68c77c2a5ef2f19[BLDS_413bf9c15ce77baa8ebf1cda4cbf4887]); else matched = (BLDS_2361bab8b48b1041ad740bb561b21aee == BLDS_73b057aa85501275a68c77c2a5ef2f19[BLDS_413bf9c15ce77baa8ebf1cda4cbf4887]); end end end return matched; end function BTree:Find(BLDS_41d48caa377759cbe469d39f96b9f871, __mode, BLDS_a737304a0a12acb060c26b9da12f857c) assert(__mode == nil or __mode == "normal" or (__mode == "hash" and type(self.HashKey) == "function"), "Invalid mode or Overridables is not defined."); assert(BLDS_41d48caa377759cbe469d39f96b9f871 ~= nil, "Condition is nil."); if (not __mode) then __mode = "normal"; end if (__mode == "hash") then if (self.hash[BLDS_41d48caa377759cbe469d39f96b9f871]) then return self.hash[BLDS_41d48caa377759cbe469d39f96b9f871].item; end elseif (__mode == "normal") then if (not BLDS_a737304a0a12acb060c26b9da12f857c) then if (self.root) then BLDS_a737304a0a12acb060c26b9da12f857c = self.root.item; else return; end end while (BLDS_a737304a0a12acb060c26b9da12f857c) do if (BLDS_969957dcac94cf80e3cc93a45baa32c0(BLDS_a737304a0a12acb060c26b9da12f857c, BLDS_41d48caa377759cbe469d39f96b9f871)) then return BLDS_a737304a0a12acb060c26b9da12f857c; end BLDS_a737304a0a12acb060c26b9da12f857c = self:Next(BLDS_a737304a0a12acb060c26b9da12f857c, "all"); end end end function BTree:Level(BLDS_dc0fe7e5cdedeee808957fa365a170d9) local BLDS_a4ae8f1b50c7593a1bada9f62d1883fb = self.items[BLDS_dc0fe7e5cdedeee808957fa365a170d9]; return BLDS_a4ae8f1b50c7593a1bada9f62d1883fb.level; end function BTree:Root() if (self.root) then return self.root.item; end end BLibrary:Register(BTree, "BTree", BLDS_1c3fb0a635a94e3001e1274cff993440, BLDS_b6a0481a2567ffc77d70559bcc5237d9); function BTree_Test() local BLDS_8b24e30f462053ef17f6393eba61c88e = BLibrary("BTree"); BLDS_8b24e30f462053ef17f6393eba61c88e.OnDeleted = function(self, item) BigFoot_Print("EVENT: item <"..item.text.."> is removed."); end BLDS_8b24e30f462053ef17f6393eba61c88e.HashKey = function(self, item) return item.text; end local BLDS_2e00ffac12aadb3a1fd865993ec505b9; local BLDS_3ea2d62b9ba79db5c422d98846ce41be, BLDS_4bc3e31513f8ee3d5cdc5304743faf4e, BLDS_9fab3bee72540a303a2614183ce35e0d, BLDS_2885318f3e849aec0d339f93fcd4d6f2, BLDS_6cd5aee624a3febf171a023f2b70c6b4, BLDS_c31a5982c3cd028c982776dc10652a4b, BLDS_4337947ec94e9abc757a17b7988fb2b5, BLDS_ab04c05d76c61e7c4b1f6b77d6706678, BLDS_a93685d541cf0d1a4f97c2ee289c794c; BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Build default structure"); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BLDS_3ea2d62b9ba79db5c422d98846ce41be = {} BLDS_3ea2d62b9ba79db5c422d98846ce41be.text = "Item1"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_3ea2d62b9ba79db5c422d98846ce41be); BLDS_4bc3e31513f8ee3d5cdc5304743faf4e = {}; BLDS_4bc3e31513f8ee3d5cdc5304743faf4e.text = "Item2"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_4bc3e31513f8ee3d5cdc5304743faf4e, BLDS_3ea2d62b9ba79db5c422d98846ce41be); BLDS_9fab3bee72540a303a2614183ce35e0d = {}; BLDS_9fab3bee72540a303a2614183ce35e0d.text = "Item3"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_9fab3bee72540a303a2614183ce35e0d, BLDS_4bc3e31513f8ee3d5cdc5304743faf4e); BLDS_2885318f3e849aec0d339f93fcd4d6f2 = {}; BLDS_2885318f3e849aec0d339f93fcd4d6f2.text = "Item4"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_2885318f3e849aec0d339f93fcd4d6f2, BLDS_3ea2d62b9ba79db5c422d98846ce41be, "child"); BLDS_6cd5aee624a3febf171a023f2b70c6b4 = {}; BLDS_6cd5aee624a3febf171a023f2b70c6b4.text = "Item5"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_6cd5aee624a3febf171a023f2b70c6b4, BLDS_4bc3e31513f8ee3d5cdc5304743faf4e, "child"); BLDS_c31a5982c3cd028c982776dc10652a4b = {}; BLDS_c31a5982c3cd028c982776dc10652a4b.text = "Item6"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_c31a5982c3cd028c982776dc10652a4b, BLDS_9fab3bee72540a303a2614183ce35e0d, "child"); BLDS_4337947ec94e9abc757a17b7988fb2b5 = {}; BLDS_4337947ec94e9abc757a17b7988fb2b5.text = "Item7"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_4337947ec94e9abc757a17b7988fb2b5, BLDS_c31a5982c3cd028c982776dc10652a4b); BLDS_ab04c05d76c61e7c4b1f6b77d6706678 = {}; BLDS_ab04c05d76c61e7c4b1f6b77d6706678.text = "Item8"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_ab04c05d76c61e7c4b1f6b77d6706678, BLDS_c31a5982c3cd028c982776dc10652a4b, "before"); BLDS_2e00ffac12aadb3a1fd865993ec505b9 = BLDS_8b24e30f462053ef17f6393eba61c88e:Root(); while (BLDS_2e00ffac12aadb3a1fd865993ec505b9) do local BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = ""; for BLDS_e914904fab9d05d3f54d52bfc31a0f3f = 1, BLDS_8b24e30f462053ef17f6393eba61c88e:Level(BLDS_2e00ffac12aadb3a1fd865993ec505b9), 1 do BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = BLDS_e6955c64cf39bdb23dc86de1a9ec2117 .. " "; end BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = BLDS_e6955c64cf39bdb23dc86de1a9ec2117 .. BLDS_2e00ffac12aadb3a1fd865993ec505b9.text; BigFoot_Print(BLDS_e6955c64cf39bdb23dc86de1a9ec2117); BLDS_2e00ffac12aadb3a1fd865993ec505b9 = BLDS_8b24e30f462053ef17f6393eba61c88e:Next(BLDS_2e00ffac12aadb3a1fd865993ec505b9, "all"); end BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Build Level-3 item"); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BLDS_a93685d541cf0d1a4f97c2ee289c794c = {}; BLDS_a93685d541cf0d1a4f97c2ee289c794c.text = "Item9"; BLDS_8b24e30f462053ef17f6393eba61c88e:Insert(BLDS_a93685d541cf0d1a4f97c2ee289c794c, BLDS_ab04c05d76c61e7c4b1f6b77d6706678, "child"); BLDS_2e00ffac12aadb3a1fd865993ec505b9 = BLDS_8b24e30f462053ef17f6393eba61c88e:Root(); while (BLDS_2e00ffac12aadb3a1fd865993ec505b9) do local BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = ""; for BLDS_e914904fab9d05d3f54d52bfc31a0f3f = 1, BLDS_8b24e30f462053ef17f6393eba61c88e:Level(BLDS_2e00ffac12aadb3a1fd865993ec505b9), 1 do BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = BLDS_e6955c64cf39bdb23dc86de1a9ec2117 .. " "; end BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = BLDS_e6955c64cf39bdb23dc86de1a9ec2117 .. BLDS_2e00ffac12aadb3a1fd865993ec505b9.text; BigFoot_Print(BLDS_e6955c64cf39bdb23dc86de1a9ec2117); BLDS_2e00ffac12aadb3a1fd865993ec505b9 = BLDS_8b24e30f462053ef17f6393eba61c88e:Next(BLDS_2e00ffac12aadb3a1fd865993ec505b9, "all"); end BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Print last item of item6 with <all> mode"); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); local BLDS_3704780e0cefed5ed0b36dd662516421 = BLDS_8b24e30f462053ef17f6393eba61c88e:Last(BLDS_c31a5982c3cd028c982776dc10652a4b, "all"); BigFoot_Print("Last item of item6 is: "..BLDS_3704780e0cefed5ed0b36dd662516421.text); BLDS_3704780e0cefed5ed0b36dd662516421 = BLDS_8b24e30f462053ef17f6393eba61c88e:Last(BLDS_3704780e0cefed5ed0b36dd662516421, "all"); BigFoot_Print("Last 2 item of item6 is: "..BLDS_3704780e0cefed5ed0b36dd662516421.text); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Check Find method"); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BLDS_3704780e0cefed5ed0b36dd662516421 = BLDS_8b24e30f462053ef17f6393eba61c88e:Find({text = "Item8"}); BigFoot_Print("Found "..BLDS_3704780e0cefed5ed0b36dd662516421.text.." with normal mode"); BLDS_3704780e0cefed5ed0b36dd662516421 = BLDS_8b24e30f462053ef17f6393eba61c88e:Find("Item6", "hash"); BigFoot_Print("Found "..BLDS_3704780e0cefed5ed0b36dd662516421.text.." with hash mode"); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Total "..BLDS_8b24e30f462053ef17f6393eba61c88e:Count().." items."); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Remove Last brother item of item6"); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Checking OnDeleted Event"); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BLDS_8b24e30f462053ef17f6393eba61c88e:Delete(BLDS_8b24e30f462053ef17f6393eba61c88e:Last(BLDS_c31a5982c3cd028c982776dc10652a4b)); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BLDS_2e00ffac12aadb3a1fd865993ec505b9 = BLDS_8b24e30f462053ef17f6393eba61c88e:Root(); while (BLDS_2e00ffac12aadb3a1fd865993ec505b9) do local BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = ""; for BLDS_e914904fab9d05d3f54d52bfc31a0f3f = 1, BLDS_8b24e30f462053ef17f6393eba61c88e:Level(BLDS_2e00ffac12aadb3a1fd865993ec505b9), 1 do BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = BLDS_e6955c64cf39bdb23dc86de1a9ec2117 .. " "; end BLDS_e6955c64cf39bdb23dc86de1a9ec2117 = BLDS_e6955c64cf39bdb23dc86de1a9ec2117 .. BLDS_2e00ffac12aadb3a1fd865993ec505b9.text; BigFoot_Print(BLDS_e6955c64cf39bdb23dc86de1a9ec2117); BLDS_2e00ffac12aadb3a1fd865993ec505b9 = BLDS_8b24e30f462053ef17f6393eba61c88e:Next(BLDS_2e00ffac12aadb3a1fd865993ec505b9, "all"); end BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); BigFoot_Print("Total "..BLDS_8b24e30f462053ef17f6393eba61c88e:Count().." items."); BigFoot_Print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); end 