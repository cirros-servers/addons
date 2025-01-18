CLib = CLib or {}
CLib.Version = "0.0.0"
_G.CLib = CLib

function Load()
    local Started = os.time()
    print("----------------------------------------")
    print("> Initializing CLib v" .. CLib.Version)
    print("> Powered by arcane snep technology...")
    print("----------------------------------------")

    print("[CLib] Setting up CLib.Util")
    CLib.Util = CLib.Util or {}
    if SERVER then AddCSLuaFile("clib/util/loadscript.lua") end
    include("clib/util/loadscript.lua")
    CLib.Util.LoadSharedScript("clib/util/colors.lua")

    print("[CLib] Setting up CLib.Logging")
    CLib.Logging = CLib.Logging or {}
    CLib.Util.LoadSharedScript("clib/logging/debug.lua")
    CLib.Util.LoadSharedScript("clib/logging/error.lua")
    CLib.Util.LoadSharedScript("clib/logging/normal.lua")
    CLib.Util.LoadSharedScript("clib/logging/debug.lua")

    print("[CLib] Setting up CLib.Strings")
    CLib.Strings = CLib.Strings or {}
    CLib.Util.LoadSharedScript("clib/strings/parsecolored.lua")

    print("[CLib] Setting up CLib.Chat")
    CLib.Chat = CLib.Chat or {}
    CLib.Util.LoadSharedScript("clib/chat/genericmessage.lua")
    CLib.Util.LoadServerScript("clib/chat/servermessage.lua")
    CLib.Util.LoadClientScript("clib/chat/disablejoinleave.lua")

    print("----------------------------------------")
end

concommand.Add("clib_reload", Load)
Load()