concommand.Add("cworkshop_open", CreateCWorkshopGui, nil, "Open CWorkshop's GUI to manage workshop content.")

concommand.Add("cworkshop_download", function(ply, cmd, args, argStr)
    for i,v in pairs(args) do
        steamworks.DownloadUGC(v, function(path, file)
            if not path then return end
            game.MountGMA(path)
        end)
    end
end, nil, "Download a Workshop addon and mount it.")

concommand.Add("cworkshop_downloadall", function(ply, cmd, args, argStr)
    steamworks.FileInfo(CWorkshop.Collection, function(data) 
        for i,v in pairs(data.children) do
            RunConsoleCommand("cworkshop_download", v)
        end
    end)
end, nil, "Download and mount all of the addons for this server.")

net.Receive("CWORKSHOP_OPEN_MENU", function()
    CreateCWorkshopGui()
end)