CLib.Util.LoadServerScript(script)
    if CLIENT then return end
    return include(script)
end

CLib.Util.LoadClientScript(script)
    if SERVER then
        AddCSLuaFile(script)
        return
    end
    return include(script)
end

CLib.Util.LoadSharedScript(script)
    if SERVER then AddCSLuaFile(script) end
    return include(script)
end