function ulx.build(caller)
    local time = CurTime()
  
    if caller.build.active then 
        CLib.Chat.ServerMessage("[&#fc4e4e]You are already in buildmode.", { target = caller })
    else
        if caller.build.nextChange > time then
            local time = tostring(math.ceil(caller.build.nextChange - time))
            CLib.Chat.ServerMessage("[&#fc4e4e]On cooldown. Please wait "..time.." seconds before trying again.", { target = caller })
        else
            caller.build.active = true
            caller.build.nextChange = time + 5
            caller:SetNWBool("buildmode", true)
            caller:GodEnable()
  
            ulx.fancyLogAdmin(caller, "#A enabled build mode")
        end
    end
end
  
function ulx.pvp(caller)
    local time = CurTime()
  
    if not caller.build.active then 
        CLib.Chat.ServerMessage("[&#fc4e4e]You are already in pvp mode.", { target = caller })
    else
        if caller.build.nextChange > time then
            local time = tostring(math.ceil(caller.build.nextChange - time))
            CLib.Chat.ServerMessage("[&#fc4e4e]On cooldown. Please wait "..time.." seconds before trying again.", { target = caller })
        else
            caller.build.active = false
            caller.build.nextChange = time + 5
            caller:SetNWBool("buildmode", false)
            caller:GodDisable()
            caller:SetMoveType(MOVETYPE_WALK)
            ULib.spawn(caller)
    
            ulx.fancyLogAdmin(caller, "#A disabled build mode")
        end
    end
end
  
local build = ulx.command("Utility", "ulx build", ulx.build, "!build")
build:defaultAccess(ULib.ACCESS_ALL)
build:help("Activate build mode")

local pvp = ulx.command("Utility", "ulx pvp", ulx.pvp, "!pvp")
pvp:defaultAccess(ULib.ACCESS_ALL)
pvp:help("Activate pvp mode")