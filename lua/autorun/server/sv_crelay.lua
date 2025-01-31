-- This endpoint is IP whitelisted, and shouldn't 
-- be accessible to any WAN address.

local CRELAY_API = "https://sbox.snep.lol/relay"
local POLLING_ACTIVE = false

local function failed(reason)
    print(reason)
end

local polling = coroutine.create(function()
    while wait() do
        if not POLLING_ACTIVE then coroutine.yield() end
        
        HTTP({ 
            url = CRELAY_API .. "/messages", 
            method = "GET",
            failed,
            success = function(code, body, headers) 
                print(body)
            end
        })
    end
end)

local function StartPolling()
    POLLING_ACTIVE = true 
    coroutine.resume(polling)
end

local function PausePolling()
    POLLING_ACTIVE = false
end

HTTP({ url = CRELAY_API .. "/startup", method = "POST", failed })

hook.Add("PlayerAuthed", "CRELAY_PLAYERAUTHED", function(ply, steamid, uniqueid)
    HTTP({
        url = CRELAY_API .. "/connect",
        method = "POST",
        failed,
        paramaters = { ["steamId"] = ply:SteamID64() }
    })
end)

hook.Add("PlayerInitialSpawn", "CRELAY_PLAYERINITIALSPAWN", function(ply)
    HTTP({
        url = CRELAY_API .. "/spawn",
        method = "POST",
        failed,
        paramaters = { ["steamId"] = ply:SteamID64() }
    })
end)

hook.Add("PlayerDisconnected", "CRELAY_PLAYERDISCONNECTED", function(ply)
    HTTP({
        url = CRELAY_API .. "/disconnect",
        method = "POST",
        failed,
        paramaters = { ["steamId"] = ply:SteamID64() }
    })
end)

hook.Add("PlayerSay", "CRELAY_PLAYERSAY", function(ply, text, teamChat)
    if teamChat then return end

    HTTP({
        url = CRELAY_API .. "/chat",
        method = "POST",
        failed,
        paramaters = { ["steamId"] = ply:SteamID64(), text }
    })
end)

hook.Add("PlayerDeath", "CRELAY_PLAYERDEATH", function(victim, inflictor, attacker)
    local attackerName = nil 
    if attacker:IsPlayer() then attackerName = attacker:GetName() end

    HTTP({
        url = CRELAY_API .. "/death",
        method = "POST",
        failed,
        paramaters = { ["victim"] = victim:Name(), ["attacker"] = attackerName }
    })
end)

hook.Add("ShutDown", "CRELAY_SHUTDOWN", function()
    HTTP({ url = CRELAY_API .. "/shutdown", method = "POST", failed })
end)