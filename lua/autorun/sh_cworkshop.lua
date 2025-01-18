function Load() 
    CLib.Util.LoadClientScript("cworkshop/cl_gui.lua")
    CLib.Util.LoadClientScript("cworkshop/cl_trigger.lua")
    CLib.Util.LoadSharedScript("cworkshop_config.lua")
end

concommand.Add("cworkshop_reload", Load)
Load()