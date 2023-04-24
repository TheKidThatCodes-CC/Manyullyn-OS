local function hook(fun,hooked)
    _G[fun] = hooked
end
exports = {hook,}