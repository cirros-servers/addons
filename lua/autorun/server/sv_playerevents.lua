gameevent.Listen("player_connect")
hook.Add("player_connect", "CLIB_PLAYER_CONNECT_ADVERT", function(data)
    if data.bot == 1 then return end
	local name = data.name
    local steamid = data.networkid
    local color = CLib.Util.GetTeamColor(steamid)

    CLib.Chat.ServerMessage("[&#".. CLib.Util.ToHex(color) .. "]" .. name .. " [&#bac2de]is connecting to the server.", { formatColor = true })
end)

gameevent.Listen("player_activate")
hook.Add("player_activate", "CLIB_PLAYER_ACTIVATE_ADVERT", function(data) 
	local id = data.userid
    local plr = Player(id)
    if (plr:IsBot()) then return end
    local name = plr:Nick()
    local steamid = plr:SteamID()
    local color = CLib.Util.GetTeamColor(steamid)

    CLib.Chat.ServerMessage("[&#".. CLib.Util.ToHex(color) .. "]" .. name .. " [&#bac2de]has fully connected.", { formatColor = true })
end)

gameevent.Listen("player_disconnect")
hook.Add( "player_disconnect", "CLIB_PLAYER_DISCONNECT_ADVERT", function( data )
    if data.bot == 1 then return end
	local name = data.name
    local steamid = data.networkid
    local reason = data.reason
    local color = CLib.Util.GetTeamColor(steamid)

    CLib.Chat.ServerMessage("[&#".. CLib.Util.ToHex(color) .. "]" .. name .. " [&#bac2de]has left the server. [&#7c7f93]("..reason..")", { formatColor = true })
end)

