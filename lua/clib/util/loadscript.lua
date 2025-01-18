CLib.Util.LoadServerScript = function(script)
    if CLIENT then return end
    return include(script)
end

CLib.Util.LoadClientScript = function(script)
    if SERVER then
        AddCSLuaFile(script)
        return
    end
    return include(script)
end

CLib.Util.LoadSharedScript = function(script)
    if SERVER then AddCSLuaFile(script) end
    return include(script)
end