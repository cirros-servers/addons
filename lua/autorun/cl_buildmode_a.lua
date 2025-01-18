hook.Add('PreDrawHalos', "BuildMode_PreDrawHalos", function()
    local me = LocalPlayer()
    local mePos = me:GetPos()
  
    for k, v in pairs(player.GetHumans()) do
      if v:GetNWBool("buildmode") and v:Alive() and mePos:Distance(v:GetPos()) <= 800 then halo.Add({v}, Color(175, 0, 255)) end
    end
  end)
  
  net.Receive("BuildMode_MSG", function()
    local state = net.ReadBool()
    local id = net.ReadString()
    local name = net.ReadString()
  
    chat.AddText(
      Color(170, 170, 170), "[SERVER] ",
      Color(175, 0, 255), id == LocalPlayer():SteamID() and "You" or name,
      state and Color(50, 250, 50) or Color(255, 0, 0), state and " enabled" or " disabled",
      Color(235, 235, 235), " build mode!",
      unpack(
        id == LocalPlayer():SteamID() and
          {
            " Use",
            state and Color(255, 0, 0) or Color(50, 250, 50), state and " !pvp" or " !build",
            Color(235, 235, 235), " to switch back."
          }
        or {""}
      )
    )
  end)
  
  local function formatMSG(data)
    local tbl = {
      ["1"] = {"Already in ", data.state and Color(50, 250, 50) or Color(255, 0, 0), data.state and "build" or "pvp", Color(235, 235, 235), " mode! Use ", data.state and Color(255, 0, 0) or Color(50, 250, 50), data.state and "pvp" or "build", Color(235, 235, 235), " to disable."},
      ["2"] = {"On cooldown! Please wait ", Color(170, 170, 170), data.time, " seconds", Color(235, 235, 235), " before trying again"}
    }
  
    return tbl[data.err]
  end
  
  net.Receive("BuildMode_Err", function()
    local data = {}
    data.state = net.ReadBool()
    data.err = net.ReadString()
    data.time = net.ReadString()
  
    chat.AddText(Color(170, 170, 170), "[SERVER] ", Color(235, 235, 235), unpack(formatMSG(data)))
  end)
  