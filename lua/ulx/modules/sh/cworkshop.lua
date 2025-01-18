if SERVER then
    util.AddNetworkString("CWORKSHOP_OPEN_MENU")
end

function ulx.cworkshop(calling_ply) 
    if SERVER then
        net.Start("CWORKSHOP_OPEN_MENU")
            net.WriteBool(true)
        net.Send(calling_ply)
    end
end

local cworkshop = ulx.command("Menus", "ulx cworkshop", ulx.cworkshop, "!cworkshop" )
cworkshop:defaultAccess( ULib.ACCESS_ALL )
cworkshop:help("Open CWorkshop's GUI to manage workshop content.")
