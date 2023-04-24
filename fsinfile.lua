-- idk who's base64 lib this is but it works for me
-- i fine tuned it a little for cc
local a = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
local b, c = {}, {}
local d = bit32.lshift
local e = bit32.rshift
local f = bit32.band
local g = bit32.bor
for h = 1, #a do
	local i = a:sub(h, h)
	b[h - 1] = i
	c[i] = h - 1
end
local function encode(k)
	local k = type(k) == "table" and k or { tostring(k):byte(1, -1) }
	local l = {}
	local m
	for h = 1, #k, 3 do
		m = e(f(k[h], 0xFC), 2)
		l[#l + 1] = b[m]
		m = d(f(k[h], 0x03), 4)
		if h + 0 < #k then
			m = g(m, e(f(k[h + 1], 0xF0), 4))
			l[#l + 1] = b[m]
			m = d(f(k[h + 1], 0x0F), 2)
			if h + 1 < #k then
				m = g(m, e(f(k[h + 2], 0xC0), 6))
				l[#l + 1] = b[m]
				m = f(k[h + 2], 0x3F)
				l[#l + 1] = b[m]
			else
				l[#l + 1] = b[m] .. "="
			end
		else
			l[#l + 1] = b[m] .. "=="
		end
	end
	return table.concat(l)
end
local function decode(k)
	local o = {}
	local p = {}
	for i in k:gmatch("%w") do
		p[#p + 1] = i
	end
	for h = 1, #p, 4 do
		local m = { c[p[h]], c[p[h + 1]], c[p[h + 2]], c[p[h + 3]] }
		o[#o + 1] = g(d(m[1], 2), e(m[2], 4)) % 256
		if m[3] < 64 then
			o[#o + 1] = g(d(m[2], 4), e(m[3], 2)) % 256
			if m[4] < 64 then
				o[#o + 1] = g(d(m[3], 6), m[4]) % 256
			end
		end
	end
	return o
end

return {encode,decode}