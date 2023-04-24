local function strtolist(str)
    local r = ""
    for i = 1,#str do
        r = r .. str:sub(i)
    end
    return r
end

exports = {strtolist}