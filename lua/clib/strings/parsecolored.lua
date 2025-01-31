local Matcher = "%[&#%x+%]"
local Extractor = "%[&#(%x+)%]"

-- wtf is this? why did i write this? this is actually fucking horrible
-- todo make this not stupid asf
CLib.Strings.ParseColored = function (str)
    local matches = {}
    local matchesIt = string.gmatch(str, Matcher)
    for match in matchesIt do table.insert(matches, match) end

    local parts = string.Explode(Matcher, str, true)

    local sortedOutput = table.Add(matches, parts)
    table.sort(sortedOutput, function(a,b)
        local startA = string.find(str, a, 0, true)
        local startB = string.find(str, b, 0, true)
        return startA < startB
    end)

    local output = {}
    for i,v in pairs(sortedOutput) do
        if v != "" then 
            if string.find(v, Matcher, 0) then 
                local hex = string.match(v, Extractor)
                local r = string.sub(hex, 1, 2)
                local g = string.sub(hex, 3, 4)
                local b = string.sub(hex, 5, 6)

                table.insert(output, Color(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)))
            else
                table.insert(output, v)
            end
        end
    end

    return output
end