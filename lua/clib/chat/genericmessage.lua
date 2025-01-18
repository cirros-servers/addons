if SERVER then
    util.AddNetworkString("CLIB_CHAT_MESSAGE")
    CLib.Chat.GenericMessage = function (message, options)
        options = options or {}
        net.Start("CLIB_CHAT_MESSAGE")
            net.WriteBool(options.formatColor and true)
            net.WriteString(message)
        if options.target then net.Send(options.target)
        else net.Broadcast() end
    end
end

if CLIENT then
    net.Receive("CLIB_CHAT_MESSAGE", function()
        local format = net.ReadBool()
        local message = net.ReadString()
        if format then 
            message = CLib.Strings.ParseColored(message)
            chat.AddText(unpack(message))
        else
            chat.AddText(message)
        end
    end)
end