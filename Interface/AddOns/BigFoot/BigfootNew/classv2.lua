
local _classv2={}

function classv2(__super)
	local __class_type={}
	__class_type.ctor=false
	__class_type.super=__super
	__class_type.new=function(...) 
			local __obj={}
			setmetatable(__obj,{ __index=_classv2[__class_type]})
			do
				local __create
				__create = function(__c,...)
					if __c.super then
						__create(__c.super,...)
					end
					if __c.ctor then
						__c.ctor(__obj,...)
					end
				end
 
				__create(__class_type,...)
			end
			return __obj
		end
	local __vtbl={}
	_classv2[__class_type]=__vtbl
 
	setmetatable(__class_type,{__newindex=
		function(__t,__k,__v)
			__vtbl[__k]=__v
		end
	})
 
	if __super then
		setmetatable(__vtbl,{__index=
			function(__t,__k)
				local __ret=_classv2[__super][__k]
				__vtbl[__k]=__ret
				return __ret
			end
		})
	end
 
	return __class_type
end


