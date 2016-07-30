--author: cuiming
--date: 2016/07/30

module(...,package.seeall)

find = string.find
sub = string.sub
insert = table.insert

function split(str,sep)
	local tb = {}
	while true do
		local pos = find(str,sep)
		if not pos then
			insert(tb,#sub_tb + 1 , str)
			break
		else
			local sub_str = sub(str, 1 , pos - 1)
			insert(tb, #tb + 1,sub_str)
			str = sub(str,pos + 1, #str)
		end
	end
	return tb
end
