hook.Add('PreDrawHalos', "BuildMode_PreDrawHalos", function()
    local me = LocalPlayer()
    local mePos = me:GetPos()
  
    for k, v in pairs(player.GetHumans()) do
        if v:GetNWBool("buildmode") and v:Alive() and mePos:Distance(v:GetPos()) <= 800 then 
            halo.Add({v}, CLib.Util.GetTeamColor(v:SteamID())) 
        end
    end
end)