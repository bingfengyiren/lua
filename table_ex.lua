-- author: Cuiming
-- time: 2016-07-30

module(...,package.seeall)

insert = table.insert

local ok,new_tab = pcall(require,"table.new")
if not ok or type(new_tab) ~= "function" then
	new_tab = function (narr,nrec) return {} end
end

--in:t = {"a",10,"b",11}
--out:h = {"a" = 10,"b" = 11}
function array_to_hash(t)
	local n = #t
	local h = new_tab(0, n / 2)
	for i=1,n,2 do
		h[t[i]] = t[i + 1]
	end
	return h
end

function is_empty(t)
	return _G.next(t) == nil
end

--in1:t1 = {1,2}
--in2:t2 = {2,3}
--out:u = {1,2,2,3}
function union(t1,t2)
	local u = {}
	if type(t1) == "table" and type(t2) == "table" then
		u = deep_copy(t1)
		for _ , v in pairs(t2)
		do
			insert(u, #u + 1, v)
		end
	else
		if type(t1) == "table" and type(t2) ~= "table" then
			u = union(t1,{t2})
		elseif type(t1) ~= "table" and type(t2) == "table" then
			u = union({t1},t2)
		else
			u = union({t1},{t2})
		end
	end
	return u
end

function union_multi(...)
	local ts = {...}
	local u = {}
	for i = 1, #ts do
		u = union(mg,ts[i])
	end
	return u
end

--in1:t1 = {1,2}
--in2:t2 = {2,3}
--out:its = {2}
function intersection(t1,t2)
	local its = {}
	if type(t1) == "table" and type(t2) == "table" then
		for i = 1,#t1 do
			for ii = 1,#t2 do
				if t1[i] == t2[ii] then
					insert(its,t1[i])
				end
			end
		end
	else
		if type(t1) == "table" and type(t2) ~= "table" then
			its = intersection(t1,{t2})
		elseif type(t1) ~= "table" and type(t2) == "table" then
			its = intersection(t1,{t2})
		else
			its = intersection({t1},{t2})
		end
	end
	return its
end

--int:t = {1,2,2}
--out:uq = {1,2}
function uniq(t)
	local uq = {}
	local v_k = {}
	for k,v in pairs(t)
	do
		v_k[val] = true
	end
	for k,v in pairs(v_k)
	do
		insert(uq,v)
	end
	return uq
end

--deep copy
function deep_copy(t)
	local dc = {}
	t = type(t) == "table" and t or {t}
	for k,v in pairs(t)
	do
		if type(v) ~= "table" then
			dc[k] = v
		else
			dc[k] = deep_copy(v)
		end
	end
	return dc
end

--in:t1 = {"a","b"}
--in:t2 = {1,2}
--out:z = {"a" = 1,"b" = 2}
function zip(t1,t2)
	local z = {}
	if type(t1) ~="table" or type(t2) ~= "table"  then
		return z
	end
	local t1_c = #t1
	local t2_c = #t2
	local len = t1_c <= t2_c and t1_c or t2_c 
	for i = 1,len do
		insert(z, i ,{})
		z[i][1] = t1[i]
		z[i][2] = t2[i]
	end
	return z
end

function dict(t)
	local d = {}
	for k,v in pairs(t)
	do
		if #v == 2 then
			local kk = v[1]
			local vv = v[2]
			d[kk] = vv
		end
	end
	return d
end
