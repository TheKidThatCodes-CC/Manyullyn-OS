local function int_to_hex(int)
    return string.format("%x",int)
end
local function hex_to_int(hex)
    return tonumber(hex,16)
end
local function hex_to_str(hex)
    return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
 
local function str_to_hex(str)
    return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end

function check(path)
    
    if fs.exists(path) and not fs.isDir(path) then
        local f = io.open(path,"r+")
        if f == nil then
            error("hmmmmmmmmmm..... something is very wrong. file existed and then opened to nil")
        end
        if f:read() == "fsinfile_v1" then
            
        else
            error("file '"..path.."' is not a fsinfile v1")
        end
    else
        error("file '"..path.."' not found")
    end

end
