CLib.Util.GetTeamColor(steamid) 
    local groupName = "user"
    local _, data = pcall(function() return ULib.ucl.getUserInfoFromID(steamid) end)
    if data and data.group then
        groupName = data.group
    end

    local color = Color(0, 0, 0)
    for i,v in pairs(team.GetAllTeams()) do 
        if team.GetName(i) == groupName then
            color = team.GetColor(i)
        end
    end

    return color
end

CLib.Util.ToHex(color)
    return string.format("%x%x%x", color.r, color.g, color.b)
end