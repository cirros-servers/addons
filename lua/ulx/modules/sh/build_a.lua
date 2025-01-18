local function broadcastToClients(ply)
  net.Start("BuildMode_MSG")
	net.WriteBool(ply.build.active)
	net.WriteString(ply:SteamID())
	net.WriteString(ply:Nick())
  net.Broadcast()
end

function ulx.build(caller)
  local time = CurTime()

  if caller.build.active then 
	net.Start("BuildMode_ERR")
	  net.WriteBool(true)
	  net.WriteString("1")
	net.Send(caller)
  else
	if caller.build.nextChange > time then
	  net.Start("BuildMode_ERR")
		net.WriteBool(false)
		net.WriteString("2")
		net.WriteString(math.ceil(caller.build.nextChange - time))
	  net.Send(caller)
	else
	  caller.build.active = true
	  caller.build.nextChange = time + 5
	  caller:SetNWBool("buildmode", true)
	  caller:GodEnable()
	  broadcastToClients(caller)

	  ulx.fancyLogAdmin(caller, true, "#A enabled build mode")
	end
  end
end

function ulx.pvp(caller)
  local time = CurTime()

  if not caller.build.active then 
	net.Start("BuildMode_ERR")
	  net.WriteBool(false)
	  net.WriteString("1")
	net.Send(caller)
  else
	if caller.build.nextChange > time then
	  net.Start("BuildMode_ERR")
		net.WriteBool(true)
		net.WriteString("2")
		net.WriteString(math.ceil(caller.build.nextChange - time))
	  net.Send(caller)
	else
	  caller.build.active = false
	  caller.build.nextChange = time + 5
	  caller:SetNWBool("buildmode", false)
	  caller:GodDisable()
	  caller:SetMoveType(MOVETYPE_WALK)
	  ULib.spawn(caller)
	  broadcastToClients(caller)

	  ulx.fancyLogAdmin(caller, true, "#A disabled build mode")
	end
  end
end

local build = ulx.command("Utility", "ulx build", ulx.build, "!build", true)
build:defaultAccess(ULib.ACCESS_ALL)
build:help("Activate build mode")

local pvp = ulx.command("Utility", "ulx pvp", ulx.pvp, "!pvp", true)
pvp:defaultAccess(ULib.ACCESS_ALL)
pvp:help("Activate pvp mode")