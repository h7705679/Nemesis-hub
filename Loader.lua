local scripts = {
    --[13704594433] = "",
    [14170731342]  = "https://raw.githubusercontent.com/h7705679/Nemesis-hub/refs/heads/main/Twisted.lua" -- changed to 14170731342
}

local scriptUrl = scripts[game.PlaceId]

if scriptUrl then
    local success, result = pcall(function()
        local code = game:HttpGet(scriptUrl)
        return loadstring(code)()
    end)

    if not success then
        warn("Error loading script: " .. tostring(result))
    end
end
